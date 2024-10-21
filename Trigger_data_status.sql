DELIMITER $$
create trigger trg_status_contas before update
on contas
for each row
begin
	if(NEW.status_conta != OLD.status_conta) then
		update contas set data_status = now() where id = NEW.id;
	end if;
end;

create trigger trg_status_cartao before update
on cartoes
for each row
begin
	if(NEW.status_cartao != OLD.status_cartao) then
		update cartoes set data_status = now() where id = NEW.id;
	end if;
end;

create trigger trg_status_compras before update
on compras
for each row
begin
	if(NEW.status_compra != OLD.status_compra) then
		update compras set data_status = now() where id = NEW.id;
	end if;
end;

$$ DELIMITER ;