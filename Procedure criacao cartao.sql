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
end

$$ DELIMITER ;