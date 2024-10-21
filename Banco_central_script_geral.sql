start transaction;

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
credito int,
constraint fk_conta_compra foreign key (id_conta) references contas(id));

create table compras_processadas(
id int not null,
id_conta int not null,
id_cartao int not null,
valor double not null,
parcela varchar(20) not null,
constraint fk_conta_compra_processada foreign key (id_conta) references contas(id));

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
constraint fk_login_contas foreign key (id_conta) references contas(id));

DELIMITER $$

create procedure criacao_cartao(in id_conta_in int, in id_pessoa_in int,in credito_in double)
begin
	insert into cartoes(id_conta,id_pessoa,numero_cartao,status_cartao,data_status,credito)
        values (id_conta_in,
                    id_pessoa_in,
                    (concat(convert(floor(1 + rand() * 999999999999999), char), "0")),
                    0,
                    now(),
                    credito_in);
end;

create procedure criacao_usuario(in nome_in varchar(255), in CPF_in varchar(11),in pessoa_fisica_in varchar(1),in cheque_especial_in int,in criacao_cartao_in int, 
in credito_in double)
begin

	insert into pessoas(nome,cpf,pessoa_fisica)
    values(nome_in,cpf_in,pessoa_fisica_in);
    
    insert into contas(id_pessoa,status_conta,data_status,saldo,cheque_especial)
    values ((select id from pessoas where cpf = cpf_in),1,now(),0,cheque_especial_in);
    
    if(criacao_cartao_in = 1) then                
		call criacao_cartao((select contas.id from contas 
					inner join pessoas
                    on contas.id_pessoa = pessoas.id
                    where pessoas.cpf = cpf_in),
                    (select id from pessoas where cpf = cpf_in),
                    credito_in);
	end if;
    
    select "Conta criada";
end;

create procedure insere_compras(
in id_conta_in int,
in id_cartao_in int,
in valor_in double,
in parcelas_in varchar(20),
in observacao_in varchar(255),
in valor_total_in double,
in credito_in int)
begin
	
	if(credito_in = 1) then
		select credito into @credito from cartoes where id = id_cartao_in;
        
        if(@credito >= valor_total_in)then
			insert into compras(id_conta,id_cartao,valor,parcelas,observacao,status_compra,data_status,valor_total,credito)
			values (id_conta_in,id_cartao_in,valor_in,parcelas_in,observacao_in,0,now(),valor_total_in,credito_in);
			select "Compra inserida";
		else 
			select "Compra recusada";
        end if;
 	else 
		 select cheque_especial into @cheque_especial from contas where id = id_conta_in;
         select saldo into @saldo from contas where id = id_conta_in;
		if(@cheque_especial = 1) then
 			
             if ( ((select valor from regras where codigo = "CHEQUE_COD") + @saldo) >= valor_total_in) then
 				insert into compras(id_conta,id_cartao,valor,parcelas,observacao,status_compra,data_status,valor_total,credito)
				values (id_conta_in,0,valor_in,"0/0",observacao_in,0,now(),valor_total_in,credito_in);
                select "Compra inserida";
 			else
 				select "Compra recusada";
 			end if;
                 
 		else
         
 			if (@saldo >= valor_total_in) then
 				insert into compras(id_conta,id_cartao,valor,parcelas,observacao,status_compra,data_status,valor_total,credito)
				values (id_conta_in,0,valor_in,"0/0",observacao_in,0,now(),valor_total_in,credito_in);
                select "Compra inserida";
 			else
 				select "Compra recusada";
 			end if;
             
 		end if;
 	end if;
end;

create trigger trg_compras_inseridas after insert
on compras
for each row
begin

	select saldo into @saldo from contas where id = new.id_conta;
    select credito into @credito from cartoes where id = new.id_cartao;
    
	 if(new.credito = 1 ) then
		update cartoes 
		set credito = @credito - new.valor_total
		where id = new.id_cartao;
	else 
		update contas set saldo = @saldo - new.valor_total
        where id = new.id_conta;
	end if;
end;

create procedure sacar(in id_conta_in int, in valor_in double)
begin
	select saldo into @saldo from contas where id = id_conta_in;
    select cheque_especial into @cheque_especial from contas where id = id_conta_in;
    
    if ((select status_conta from contas where id = id_conta_in) in (1)) then
    
		if(@cheque_especial = 1) then
			
            if ( ((select valor from regras where codigo = "CHEQUE_COD") + @saldo) >= valor_in) then
				update contas set saldo = (@saldo - valor_in) where id = id_conta_in;
                select 'Saque realizado';
			else
				select "Saldo insuficiente";
			end if;
                
		else
        
			if (@saldo >= valor_in) then
				update contas set saldo = (@saldo - valor_in) where id = id_conta_in;
                select 'Saque realizado';
			else
				select "Saldo insuficiente";
			end if;
            
		end if;
			
    else 
		select 'Status conta não autorizado';
	end if;
end;

create procedure bloqueio_conta_cartao(in id_conta_in int)
begin

	update contas set status_conta = 0, data_status = now() where id = id_conta_in;
    update cartoes set status_cartao = 2, data_status = now() where id_conta = id_conta_in;

end;

create procedure normalizacao_conta_cartao(in id_conta_in int)
begin

	update contas set status_conta = 1, data_status = now() where id = id_conta_in;
    update cartoes set status_cartao = 1, data_status = now() where id_conta = id_conta_in;

end;

create procedure processar_compras()
begin

	create TEMPORARY table compra_para_processar
	as select *,substring_index(parcelas,"/",1) as parcela_atual,substring_index(parcelas,"/",-1) as parcela_final 
    from compras where status_compra = 0;
    
	insert into compras_processadas(id,id_conta,id_cartao,valor,parcela)
	select id,id_conta,id_cartao,valor,parcelas from compra_para_processar where credito = 0;
    
    update compras 
    set status_compra = 2 
    where id in (select id from compra_para_processar where credito = 0);
    
    insert into compras_processadas(id,id_conta,id_cartao,valor,parcela)
    select id,id_conta,id_cartao,valor,parcelas from compra_para_processar where credito = 1;
    
    update compras as c 
    inner join compra_para_processar as cpp on c.id_ = cpp.id 
    set c.status_compra = 1, c.parcelas = concat((cpp.parcela_atual +1),"/",cpp.parcela_final)
    where c.id = cpp.id and cpp.credito = 1 and cpp.parcela_atual < cpp.parcela_final;
    
    update compras as c inner join compra_para_processar as cpp on c.id_ = cpp.id 
    set c.status_compra = 2
    where c.id = cpp.id and cpp.credito = 1 and cpp.parcela_atual = cpp.parcela_final;
    
end;

create procedure realizar_login(in login_in varchar(255), in senha_in varchar(255))
begin
	
    select login into @login from login where login = login_in;
    select senha into @senha from login where login = login_in;
    select id_conta into @id_conta from login where login = login_in;
    
	if (@login = login_in, @senha = md5(senha_in)) then
		if ((select status_conta from contas where id = @id_conta) = 1) then
			select 1;
		else 
			select 2;
        end if;
    else 
		select 3;
    end if;
	
end;

$$ DELIMITER ;

insert into status_conta(id,nome)
values (0,"Bloqueio"),(1,"Normal"),(2,"Cancelado");

insert into status_cartao(id,nome)
values (0,"Emitido"),(1,"Normal"),(2,"Bloqueio"),(3,"Cancelado");

insert into status_compras(id,nome)
values (0,"Aguardando"),(1,"Em processamento"),(2,"Processado"),(3,"Cancelado");

insert into regras(codigo,descricao,valor)
values ("CHEQUE_COD","Defini valor do cheque especial",500);

commit;
