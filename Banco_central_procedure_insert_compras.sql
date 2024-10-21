DELIMITER $$

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
end

$$ DELIMITER ;
