-- +migrate Up
create table sentences (
    id serial primary key,  
    sentence text not null
);

insert into sentences (sentence) values ('Hi');
insert into sentences (sentence) values ('Hola');
insert into sentences (sentence) values ('アンニョン');
insert into sentences (sentence) values ('Bonjour');

-- +migrate Down
DROP TABLE IF EXISTS sentences;
