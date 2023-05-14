create table if not exists types_of_music
(
type_id SERIAL primary key,
name VARCHAR(40) not null UNIQUE
 );
 
create table if not exists music_artist
(
artist_id serial primary key,
name varchar(40) not null
); 


create table if not exists types_artist
(
type_id integer references types_of_music(type_id),
artist_id integer references music_artist(artist_id),
constraint ta primary key (type_id, artist_id)
);

create table if not exists album
(
album_id serial primary key,
name varchar(40) not null,
year integer not null CHECK (year > 1900)
);

create table if not exists artist_album
(
artist_id integer references music_artist(artist_id),
album_id integer references album(album_id),
constraint al primary key (artist_id, album_id)
);

create table if not exists song
(
song_id serial primary key,
album_id integer not null references album(album_id),
name varchar(40) not null,
duration integer not null
);

create table if not exists collection
(collection_id serial primary key,
name varchar(40) not null,
year date not null
);

create table if not exists collection_song
(collection_id integer references collection(collection_id),
song_id integer references song(song_id),
constraint sc primary key(collection_id, song_id)
);

ALTER TABLE types_of_music 
RENAME COLUMN name TO typename;

ALTER TABLE album  
RENAME COLUMN name TO album_name;

ALTER TABLE song  
RENAME COLUMN name TO song_name;

ALTER TABLE collection 
RENAME COLUMN name TO collection_name;