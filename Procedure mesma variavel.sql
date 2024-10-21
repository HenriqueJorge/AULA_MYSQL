DELIMITER $$
create procedure eleva_ao_quadrado(INOUT numero int)
begin
	set numero = numero * numero;
end $$
DELIMITER ;