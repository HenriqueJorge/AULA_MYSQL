select * from contas
select * from pessoas
select * from cartoes

update contas set saldo = 100 where id = 1

select saldo into @saldo from contas where id = 1;
select @saldo


call criacao_usuario("Maria","03876807050","J",1,0,0)

