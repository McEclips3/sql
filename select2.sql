-- 2.1 Название и продолжительность самого длительного трека.
select song_name, duration from song
order by duration desc 
limit 1;

-- 2.2 Название треков, продолжительность которых не менее 3,5 минут.
select song_name from song
where duration >= 210;

--2.3 Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select collection_name from collection
where extract(year from year) >= 2018 and extract(year from year) <= 2020;

--2.4 Исполнители, чьё имя состоит из одного слова.
select name from music_artist
where name not like '% %';

--2.5 Название треков, которые содержат слово «мой» или «my».
select song_name from song
where string_to_array(lower(song_name), ' ') && array['my'];

--3.1 Количество исполнителей в каждом жанре.
select typename, count(name) from types_of_music t
left join types_artist ta on  t.type_id = ta.type_id 
left join music_artist ma on ma.artist_id = ta.artist_id 
group by typename; 

--3.2 Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(song_id) FROM song s  /* Количество айди треков из таблицы треков */
JOIN album a  ON s.album_id  = a.album_id  /* Делаем объединение от таблицы треков к альбомам */
WHERE a.year  BETWEEN 2019 and 2020; /* Где год альбома находится в требуемом промежутке */

--3.3 Средняя продолжительность треков по каждому альбому.
select album_name, avg(duration) from album as a
left join song as s on s.album_id = a.album_id 
group by a.album_name 

--3.4 Все исполнители, которые не выпустили альбомы в 2020 году.
select name from music_artist ma 
where name not in (
select name from music_artist ma
left join artist_album aa on aa.artist_id = ma.artist_id 
left join album a on a.album_id = aa.album_id 
where a.year = 2020 
)
 
--3.5 Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
select distinct(collection_name) from music_artist ma 
left join artist_album aa on aa.artist_id = ma.artist_id 
left join album a on a.album_id = aa.album_id 
left join song s on s.album_id = a.album_id 
left join collection_song cs on cs.song_id = s.song_id 
left join collection c on c.collection_id = cs.collection_id 
where name like '%Nomy%' and c.collection_name is not null 

--4.1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
select distinct  album_name  /* Получаем ТОЛЬКО уникальные имена альбомов. Другие данные в выводе не нужны */
FROM album a  /* Из таблицы альбомов */
JOIN artist_album aa ON a.album_id  = aa.album_id  /* Объединяем альбомы с промежуточной таблицей между альбомами и исполнителями */
JOIN types_artist ta ON ta.artist_id  = aa.artist_id  /* Объединяем промежуточную таблицу выше с промежуточной таблицей между исполнителями и жанрами */
GROUP BY a.album_id,  ta.artist_id  /* Группируем по айди альбомов и айди исполнителей из промежуточной таблицы между исполнителями и жанрами */
HAVING COUNT(ta.type_id) > 1; /* Где количество id жанров из промежуточной таблицы больше 1 */

select distinct album_name  /* Получаем ТОЛЬКО уникальные имена альбомов. Другие данные в выводе не нужны */
FROM album a  /* Из таблицы альбомов */
JOIN artist_album aa ON a.album_id  = aa.album_id  /* Объединяем альбомы с промежуточной таблицей между альбомами и исполнителями */
JOIN music_artist ma ON ma.artist_id = aa.artist_id
JOIN types_artist ta ON ta.artist_id  = ma.artist_id  /* Объединяем промежуточную таблицу выше с промежуточной таблицей между исполнителями и жанрами */
left join types_of_music tom  on tom.type_id = ta.type_id 
GROUP BY a.album_id, ma.artist_id  /* Группируем по айди альбомов и айди исполнителей из промежуточной таблицы между исполнителями и жанрами */
HAVING COUNT(tom.type_id) > 1; /* Где количество id жанров из промежуточной таблицы больше 1 */

--4.2 Наименования треков, которые не входят в сборники.
select song_name from song s 
left join collection_song cs on cs.song_id = s.song_id 
left join collection c on c.collection_id = cs.collection_id 
where c.collection_name is null

--4.3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT name /* Имена исполнителей */
FROM music_artist ma  /* Из таблицы исполнителей */
left join artist_album aa on aa.artist_id = ma.artist_id 
left join album a on a.album_id = aa.album_id 
left join song s on s.album_id = a.album_id
WHERE s.duration  = ( /* Где длительность трека равна вложенному запросу */
SELECT MIN(duration) FROM song s2 /* Получаем минимальную длительность из таблицы треков */
JOIN artist_album aa2 ON aa2.album_id = s2.album_id  /* Объединяем с промежуточной таблицей между альбомами и исполнителями на основе айди альбомов */
);

--4.4 Названия альбомов, содержащих наименьшее количество треков.      
SELECT album_name  /* Названия альбомов */
FROM album a 
JOIN song s ON a.album_id  = s.album_id  /* Объединяем альбомы и треки */
GROUP BY a.album_id  /* Группируем по айди альбомов */
HAVING COUNT(s.song_id) = ( /* Где количество треков равно вложенному запросу, в котором получаем наименьшее количество треков в одном альбоме */
SELECT COUNT(song_id) FROM song s2/* Получаем поличество айди треков из таблицы треков*/
GROUP BY s2.album_id /* Группируем по айди альбомов */
ORDER BY 1 /* Сортируем по первому столбцу */
LIMIT 1 /* Получаем первую запись */
);


select distinct  album_name  /* Получаем ТОЛЬКО уникальные имена альбомов. Другие данные в выводе не нужны */
FROM album a  /* Из таблицы альбомов */
JOIN artist_album aa ON a.album_id  = aa.album_id  /* Объединяем альбомы с промежуточной таблицей между альбомами и исполнителями */
JOIN music_artist ma ON ma.artist_id = aa.artist_id /* ВОТ ТУТ */
JOIN types_artist ta ON ta.artist_id  = ma.artist_id  /* ТУТ ОБРАЩАЮСЬ К ma Объединяем промежуточную таблицу выше с промежуточной таблицей между исполнителями и жанрами */
GROUP BY a.album_id,  ma.artist_id  /* ТУТ ОБРАЩАЮСЬ К ma Группируем по айди альбомов и айди исполнителей из промежуточной таблицы между исполнителями и жанрами */
HAVING COUNT(ta.type_id) > 1;



