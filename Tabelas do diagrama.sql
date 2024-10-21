create database aula;
#drop database aula;

use aula;
create table itens(
id int auto_increment primary key,
nome varchar(255),
qnt int,
preco double);

create table vendas(
id int ,
id_cliente int ,
id_item int ,
qnt double, 
data_compra date,
constraint pk_composta primary key(id,id_cliente,id_item));

create table clientes(
id int auto_increment primary key,
nome varchar(255),
data_nascimento date,
cpf varchar(11));

create table pagamentos(
id int auto_increment primary key,
id_venda int,
id_cliente int,
total double,
status_pagamento int default 0);

create table status_pagamento(
id int,
nome varchar(255));

#População de bancos, tabela de itens
insert into itens(nome,qnt,preco)
values ("Maça",8,2.50);
insert into itens(nome,qnt,preco)
values ("Feijão",16,7.50);
insert into itens(nome,qnt,preco)
values ("Arroz",20,5.50);
insert into itens(nome,qnt,preco)
values ("Uva",60,4.50);
insert into itens(nome,qnt,preco)
values ("Limão",9,5.7);

#População do banco , tabela de clientes 
insert into clientes(nome,data_nascimento,cpf)
values ("Lucas","1998-05-12","95056471070");
insert into clientes(nome,data_nascimento,cpf)
values ("Mateus","1999-01-25","88768337060");
insert into clientes(nome,data_nascimento,cpf)
values ("Pedro","1998-09-10","16382011029");
insert into clientes(nome,data_nascimento,cpf)
values ("Marcos","1996-07-08","89737459059");
insert into clientes(nome,data_nascimento,cpf)
values ("Joao","2000-03-06","19576434041");


#População do banco, tabela de status_pagamento
insert into status_pagamento(id,nome)
values (1,"Aguardando processamento");
insert into status_pagamento(id,nome)
values (2,"Processado");
insert into status_pagamento(id,nome)
values (3,"Cancelado");

select * from status_pagamento