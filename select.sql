-- 2.1 Название и продолжительность самого длительного трека.
select song_name, duration from song
order by duration desc 
limit 1;

-- 2.2 Название треков, продолжительность которых не менее 3,5 минут.
select song_name from song
where duration > 210;

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
select count(s.song_name), a.year
from album as a
left join song as s on s.album_id = a.album_id
where a.year >= 2019 and a.year <= 2020
group by a.year;

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
select album_name
from album a
left join artist_album aa on aa.album_id  = a.album_id 
left join music_artist ma on ma.artist_id  = aa.artist_id 
left join types_artist ta on ta.artist_id = ma.artist_id 
left join types_of_music tom  on tom.type_id = ta.type_id 
group by album_name
having count(distinct tom.typename) > 1

--4.2 Наименования треков, которые не входят в сборники.
select song_name from song s 
left join collection_song cs on cs.song_id = s.song_id 
left join collection c on c.collection_id = cs.collection_id 
where c.collection_name is null

--4.3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
select name, s.duration from music_artist ma 
left join artist_album aa on aa.artist_id = ma.artist_id 
left join album a on a.album_id = aa.album_id 
left join song s on s.album_id = a.album_id
group by name, s.duration
having s.duration = (select min(duration) from song) 

--4.4 Названия альбомов, содержащих наименьшее количество треков.
select album_name, s.song_name  from album a 
left join song s on a.album_id = s.album_id  
where s.album_id in (
    select album_id from song 
    group by album_id
    having count(song_id) = (
        select count(song_id) from song 
        group by album_id
        order by count
        limit 1))






