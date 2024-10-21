alter table pessoas modify nome varchar(255) not null;
alter table pessoas modify CPF varchar(11) not null;
alter table pessoas modify pessoa_fisica varchar(1) not null;
#SHOW create table pessoas

alter table status_conta modify nome varchar(255) not null;
alter table status_cartao modify nome varchar(255) not null;
alter table status_compras modify nome varchar(255) not null;

alter table contas modify id_pessoa int not null;
alter table contas modify status_conta int not null;
alter table contas modify data_status datetime not null;
alter table contas modify saldo double not null;
alter table contas modify cheque_especial int not null;