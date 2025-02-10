-- +migrate Up
create table sentences (
    id BINARY(16) primary key,
    sentence text not null
);

create table users(
    id VARCHAR(50) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- バイナリ型のIDをUUIDを使って挿入
insert into sentences (id, sentence) values (UUID_TO_BIN(UUID()), 'Hi');
insert into sentences (id, sentence) values (UUID_TO_BIN(UUID()), 'Hola');
insert into sentences (id, sentence) values (UUID_TO_BIN(UUID()), 'アンニョン');
insert into sentences (id, sentence) values (UUID_TO_BIN(UUID()), 'Bonjour');

-- +migrate Down
delete from sentences;
DROP TABLE IF EXISTS sentences;
DROP TABLE IF EXISTS users;
