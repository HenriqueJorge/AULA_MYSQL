insert into status_conta(id,nome)
values (0,"Bloqueio"),(1,"Normal"),(2,"Cancelado");

insert into status_cartao(id,nome)
values (0,"Emitido"),(1,"Normal"),(2,"Bloqueio"),(3,"Cancelado");

insert into status_compras(id,nome)
values (0,"Aguardando"),(1,"Em processamento"),(2,"Processado"),(3,"Cancelado");


insert into regras(codigo,descricao,valor)
values ("CHEQUE_COD","Defini valor do cheque especial",500);


