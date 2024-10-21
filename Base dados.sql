create schema aula;

use aula;

create table alunos(id int auto_increment primary key,
nome varchar(255),
data_nascimento date);

insert into alunos(nome,data_nascimento)
values ("Bia","2024-01-01"),
("Maria","2008-01-01"),
("Lucas","2007-01-01"),
("Mateus","2015-01-01"),
("Luiza","2008-01-01"),
("Paulo","2009-01-01"),
("Pablo","2010-01-01"),
("Matias","2010-01-01"),
("Mario","2006-01-01"),
("Felipe","2001-01-01");

create table notas (id int auto_increment primary key,
id_aluno int,
nota_1 double,
nota_2 double,
foreign key(id_aluno) references alunos(id));

insert into notas(id_aluno,nota_1,nota_2)
values (1,8.0,9.0),
(2,5.0,7.0),
(3,3.0,3.0),
(4,6.0,9.0);

select * from alunos;
select * from notas;
drop table alunos;

drop schema aula;