
create database exercicio2 ;


use exercicio2;

 
create table alunos(
id int auto_increment primary key,      
nome varchar(255),
data_matricula datetime default now(),    
cpf varchar(11));

create table disciplinas(
id int auto_increment primary key,
nome varchar(255));
drop table notas;
create table notas(
id int auto_increment primary key,
id_disciplina int,
id_aluno int,
nota1 double,
nota2 double,
constraint fk_disciplina foreign key (id_disciplina) references disciplinas(id),
constraint fk_aluno foreign key (id_aluno) references alunos(id));

insert into alunos(nome,cpf) 
values ("teste","92573826058")
,("luiz","14622434016")
,("sara","14622434016")
,("matheus","68269310018")
,("paulo","68269310018"),
("lucas","84423726017");

insert into disciplinas(nome) 
values ("Portugues"),("Matematica"),("Ciencias"),("Geografia"),("Historia");

insert into notas(id_disciplina,id_aluno,nota1,nota2)
values (1,1,5.0,8.0),(1,2,8.0,8.0),(1,3,9.0,8.5),(1,4,6.0,7.0),(1,5,5.0,4.3);
select * from alunos inner join notas on alunos.id = notas.id;
#select * from notas;
#select * from alunos;
#select * from disciplinas;

#select * from alunos inner join notas on alunos.id = notas.id_aluno;
#select * from alunos left join notas on alunos.id = notas.id_aluno;
#select * from alunos right join notas on alunos.id = notas.id;
SELECT alunos.nome,disciplinas.nome,notas.nota1,notas.nota2,(notas.nota1 + notas.nota2) / 2 as media 
FROM alunos 
INNER JOIN notas
ON alunos.id = notas.id_aluno
INNER JOIN disciplinas 
ON disciplinas.id = notas.id_disciplina;

#drop table professores;
create table professores(id int ,
nome int,
disciplina int,
teste int);

describe professores;



select * from information_schema.referential_constraints
where constraint_schema = 'exercicio2';



alter table professores add cpf varchar(11);

alter table professores modify id int auto_increment primary key;

alter table professores rename column disciplina to id_disciplina;

alter table professores modify nome varchar(255);

alter table professores add constraint fk_disciplina_professores 
foreign key (id_disciplina) references disciplinas(id);

alter table professores drop column teste;


alter table alunos add resultado varchar(255);

alter table alunos modify resultado varchar(255) default "Aguardando";
update alunos set resultado = "Aguardando" where id in (1,2,3,4,5,6);

update professores set id_disciplina = 4 where id = 1;
select * from professores;
insert into professores(nome, id_disciplina, cpf)
values ("Antonio",1,"77777777777"),("Roberto",2,"88888888899");

call cadastro_notas(6,1,8,9);
call insere_pagamentos(1,50);
select * from notas;
select * from alunos;
select * from pagamentos


call aprovado_aluno(@resultado,6);
select @resultado;

set @numero = 5;
call eleva_ao_quadrado(@numero);
select @numero;

create table log_aluno(id_aluno int);
select * from log_aluno;
