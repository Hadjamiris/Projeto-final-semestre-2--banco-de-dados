--- Consulta 6: Alunos que já compareceram a alguma aula
--- Lista os alunos que possuem pelo menos um check-in registrado
--- (presença confirmada pelo professor em alguma aula).
--- Recursos: subconsulta com EXISTS, ORDER BY ASC

SELECT
    al.nome  AS aluno,
    al.email
FROM Aluno al
WHERE EXISTS (
    SELECT 1
    FROM Agendamento ag
    WHERE ag.id_aluno          = al.id_aluno
      AND ag.checkin_realizado = 1
)
ORDER BY al.nome ASC;
