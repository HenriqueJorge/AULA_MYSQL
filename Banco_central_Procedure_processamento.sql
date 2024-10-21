DELIMITER $$

create procedure processar_compras()
begin

	create TEMPORARY table compra_para_processar
	as select *,substring_index(parcelas,"/",1) as parcela_atual,substring_index(parcelas,"/",-1) as parcela_final 
    from compras where status_compra = 0;
    
	insert into compras_processadas(id,id_conta,id_cartao,valor,parcela)
	select id,id_conta,id_cartao,valor,parcelas from compra_para_processar where credito = 0;
    
    update compras 
    set status_compra = 2 
    where id in (select id from compra_para_processar where credito = 0);
    
    insert into compras_processadas(id,id_conta,id_cartao,valor,parcela)
    select id,id_conta,id_cartao,valor,parcelas from compra_para_processar where credito = 1;
    
    update compras as c 
    inner join compra_para_processar as cpp on c.id_ = cpp.id 
    set c.status_compra = 1, c.parcelas = concat((cpp.parcela_atual +1),"/",cpp.parcela_final)
    where c.id = cpp.id and cpp.credito = 1 and cpp.parcela_atual < cpp.parcela_final;
    
    update compras as c inner join compra_para_processar as cpp on c.id_ = cpp.id 
    set c.status_compra = 2
    where c.id = cpp.id and cpp.credito = 1 and cpp.parcela_atual = cpp.parcela_final;
    
end

$$ DELIMITER ;