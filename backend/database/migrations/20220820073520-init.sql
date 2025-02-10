-- +migrate Up
create table sentences (
    id BINARY(16) primary key,
    sentence text not null
);

insert into sentences (id,sentence) values (1,'Hi');
insert into sentences (id,sentence) values (2,'Hola');
insert into sentences (id,sentence) values (3,'アンニョン');
insert into sentences (id,sentence) values (4,'Bonjour');

-- +migrate Down
delete from sentences;
DROP TABLE IF EXISTS sentences;
