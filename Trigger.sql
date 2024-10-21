DELIMITER $

CREATE TRIGGER Tgr_alunos_Insert AFTER INSERT
ON alunos
FOR EACH ROW
BEGIN
	insert into log_aluno(id_aluno)
    values(NEW.id);
END

$ DELIMITER ;