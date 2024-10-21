DELIMITER $$ 

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
end

$$ DELIMITER ;