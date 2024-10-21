DELIMITER $$

create procedure bloqueio_conta_cartao(in id_conta_in int)
begin

	update contas set status_conta = 0, data_status = now() where id = id_conta_in;
    update cartoes set status_cartao = 2, data_status = now() where id_conta = id_conta_in;

end
$$ DELIMITER ;