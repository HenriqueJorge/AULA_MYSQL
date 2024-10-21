DELIMITER $$ 

create procedure realizar_login(in login_in varchar(255), in senha_in varchar(255))
begin
	
    select login into @login from login where login = login_in;
    select senha into @senha from login where login = login_in;
    select id_conta into @id_conta from login where login = login_in;
    
	if (@login = login_in, @senha = md5(senha_in)) then
		if ((select status_conta from contas where id = @id_conta) = 1) then
			select 1;
		else 
			select 2;
        end if;
    else 
		select 3;
    end if;
	
end

$$ DELIMITER ;