#Comando de criação da base de dados
create database exercicio ;

#Comando para acessar a base de dados
use exercicio;

#Comando para criar 
create table alunos(
id int auto_increment primary key,      #Criação do atributo id com auto incremento sendo uma chave primaria
nome varchar(255),
data_matricula datetime default now(),    #Criação do atibuto com valor default caso não seja informado no insert
nota1 double,
nota2 double);

#Comando para inserir dados para a tabela
insert into alunos(nome,nota1,nota2) values ("mario",8.6,7.0);
insert into alunos(nome,nota1,nota2) values ("luiz",5.3,7.0);
insert into alunos(nome,nota1,nota2) values ("sara",8.6,4.0);
insert into alunos(nome,nota1,nota2) values ("matheus",9.6,9.0);
insert into alunos(nome,nota1,nota2) values ("paulo",3.6,4.0);

#Função que retorna a data e hora atual da execução 
select now();

#Comando para atualizar um registro especifico
update alunos set nota2 = 8 where id = 2;

#Comando para deletar um registro na tabela
delete from  alunos where id = 4;

#Comando para consultar os dados da tabela
select * from alunos;

#Função para contar quantos registro tem na tabela
select count(*) from alunos;

#Função que retornar a menor valor
select min(nota1) from alunos;

#Função que retorna o maior valor
select max(nota1) from alunos;

#Função que retorna a media dos valores do atributo
select avg(nota1) from alunos;

#Função que retorna a somatoria 
select sum(nota1) from alunos;

#Consulta personalizada
select *,(nota1 + nota2)/2 as media from alunos