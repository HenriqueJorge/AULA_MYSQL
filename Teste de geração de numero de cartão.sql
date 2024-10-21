select concat(convert(floor(1 + rand() * 999999999999999), char), "0");

drop trigger trg_status_contas;
drop trigger trg_status_cartao;
drop trigger trg_status_compras;

delete from status_cartao;
delete from status_compras;
delete from status_conta;