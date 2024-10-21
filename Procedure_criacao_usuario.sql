DELIMITER $$

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
end

$$ DELIMITER ;