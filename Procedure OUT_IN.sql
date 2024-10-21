#Corpo de uma procedure
DELIMITER $$
CREATE PROCEDURE aprovado_aluno (OUT ISPASSOU varchar(255),IN id_aluno int)
BEGIN
	select resultado into ISPASSOU from alunos where id = id_aluno;
END $$
DELIMITER ;