create database banco_central;

use banco_central;

create table pessoas(
id int auto_increment primary key,
nome varchar(255) not null,
CPF varchar(11) not null,
pessoa_fisica varchar(1) not null);

create table status_conta(
id int,
nome varchar(255) not null) ;

create table status_cartao(
id int,
nome varchar(255) not null);

create table status_compras(
id int,
nome varchar(255) not null);

create table contas(
id int auto_increment primary key,
id_pessoa int not null,
data_abertura datetime default now(),
status_conta int not null,
data_status datetime,
saldo double not null,
cheque_especial int not null,
constraint fk_pessoa_contas foreign key (id_pessoa) references pessoas(id));


create table cartoes(
id int auto_increment primary key,
id_conta int not null,
id_pessoa int not null,
numero_cartao varchar(16) not null,
status_cartao int not null,
data_status datetime,
credito double not null,
constraint fk_conta_cartao foreign key (id_conta) references contas(id),
constraint fk_pessoa_cartao foreign key (id_pessoa) references pessoas(id));

create table compras(
id int auto_increment primary key,
id_conta int not null,
id_cartao int not null,
valor double not null,
parcelas varchar(20) not null,
observacao varchar(255) not null,
status_compra int not null,
data_status datetime,
valor_total double not null,
constraint fk_conta_compra foreign key (id_conta) references contas(id),
constraint fk_cartao_compra foreign key (id_cartao) references cartoes(id));

create table compras_processadas(
id int not null,
id_conta int not null,
id_cartao int not null,
valor double not null,
parcela varchar(20) not null,
constraint fk_conta_compra_processada foreign key (id_conta) references contas(id),
constraint fk_cartao_compra_processada foreign key (id_cartao) references cartoes(id));

create table regras(
id int auto_increment primary key,
codigo varchar(255) not null,
descricao varchar(255),
valor double);

create table login(
id int auto_increment primary key,
login varchar(255),
senha varchar(255),
id_conta int,
constraint fk_login_contas foreign key (id_conta) references contas(id))