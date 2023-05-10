insert into types_of_music 
(typename)
values ('rock');

insert into music_artist 
(name)
values ('Nomy');

insert into types_artist 
(type_id, artist_id)
values (1 , 1);

insert into types_of_music 
(typename)
values ('classic rock');

insert into types_of_music 
(typename)
values ('rap');

insert into music_artist 
(name)
values ('Linkin Park');

insert into music_artist 
(name)
values ('Queen');

insert into music_artist 
(name)
values ('Eminem');

insert into types_artist 
(type_id, artist_id)
values (1 , 2);

insert into types_artist 
(type_id, artist_id)
values (2 , 3);

insert into types_artist 
(type_id, artist_id)
values (3 , 4);

insert into album 
(album_name, year)
values ('Meteora', 2003);

insert into album 
(album_name, year)
values ('The end of the world', 2019);

insert into album 
(album_name, year)
values ('Good Fake', 2020);

insert into album 
(album_name, year)
values ('Innuendo', 1991);

insert into album 
(album_name, year)
values ('Music to Be Murdered By', 2020);

insert into artist_album 
(artist_id, album_id)
values (1, 2);

insert into artist_album 
(artist_id, album_id)
values (2, 1);

insert into artist_album 
(artist_id, album_id)
values (3, 3);

insert into artist_album 
(artist_id, album_id)
values (4, 4);

insert into artist_album 
(artist_id, album_id)
values (4, 5);

insert into artist_album 
(artist_id, album_id)
values (1, 5);

insert into song 
(album_id, song_name, duration)
values (4, 'Never Love Again', 237);

insert into song 
(album_id, song_name, duration)
values (3, 'The Show Must Go On', 264);

insert into song 
(album_id, song_name, duration)
values (3, 'Innuendo', 406);

insert into song 
(album_id, song_name, duration)
values (1, 'Numb', 188);

insert into song 
(album_id, song_name, duration)
values (1, 'Somewhere I Belong', 213);

insert into song 
(album_id, song_name, duration)
values (2, 'Night train', 286);

insert into collection 
(collection_name, year)
values ('2018 collection', '09.05.2018');

insert into collection 
(collection_name, year)
values ('2019 collection', '09.05.2019');

insert into collection 
(collection_name, year)
values ('2020 collection', '09.05.2020');

insert into collection 
(collection_name, year)
values ('2021 collection', '09.05.2021');

insert into collection_song 
(collection_id, song_id)
values (1, 1)

insert into collection_song 
(collection_id, song_id)
values (1, 2)

insert into collection_song 
(collection_id, song_id)
values (1, 3)

insert into collection_song 
(collection_id, song_id)
values (2, 2)

insert into collection_song 
(collection_id, song_id)
values (2, 3)

insert into collection_song 
(collection_id, song_id)
values (2, 4)

insert into collection_song 
(collection_id, song_id)
values (3, 3)

insert into collection_song 
(collection_id, song_id)
values (3, 4)

insert into collection_song 
(collection_id, song_id)
values (3, 5)

insert into collection_song 
(collection_id, song_id)
values (4, 4)

insert into collection_song 
(collection_id, song_id)
values (4, 5)

insert into collection_song 
(collection_id, song_id)
values (4, 6)

insert into song 
(album_id, song_name, duration)
values (2, 'Wasting My Time', 256);

insert into song 
(album_id, song_name, duration)
values (2, 'fake myself song', 256);





