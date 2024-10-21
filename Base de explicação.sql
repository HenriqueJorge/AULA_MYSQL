#Uma database basicamente é um agrupamento de tabelas em que cada tabela se relaciona uma com a outra
#Para criar uma database é utilizado o comando seguinte :

create database explicacao;

#Para acessar a base de dados é utilizado o comando use

use explicacao;

#Uma tebela possui colunas que são os atributos conforme o exemplo abaixo
#Para criar uma tabela é utilizado o comando create

create table exemplo(
id int auto_increment primary key,
nome varchar(255),
valor double,
data_nascimento datetime);

#Cada registro em uma tabela é inserido com o seguinte comando

insert into exemplo(nome,valor,data_nascimento)
values ("Caracteres",1.50,"2024-01-01");

#OBS: como pode ver não inseri o id pq eu defini como auto_increment , isso faz com que a tabela coloque o id automaticamente

#Agora que foi inserido o registro na tabela, para visualizar o registro é utilizado o comando select 

select id,nome,valor,data_nascimento from exemplo;
#ou
select * from exemplo;

#Para atualizar os registros na tabela é utilizado o comando update

update exemplo set nome = "Nome" where id = 1;

#OBS: o update normalmente é seguida de where para especificar o registro que quero alterar

#Para excluir um registro é utilizando o comando de delete 

delete from exemplo where id = 1



