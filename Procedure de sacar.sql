DELIMITER $$ 
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
    
end

$$ DELIMITER ;