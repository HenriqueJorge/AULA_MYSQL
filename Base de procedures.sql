#Corpo de uma procedure
DELIMITER $$
CREATE PROCEDURE cadastro_notas 
(in id_aluno_in int,in id_professor_in int,in nota1_in double, in nota2_in double)
BEGIN
	insert into notas(id_aluno,id_disciplina,nota1,nota2)
    values (id_aluno_in,(select id_disciplina from professores where id = id_professor_in)
    ,nota1_in,nota2_in);
    
    update alunos 
    set resultado = if(((nota1_in + nota2_in)/2) > 7 , "Aprovado", "Reprovado" ) 
     where id = id_aluno_in;
END $$
DELIMITER ;