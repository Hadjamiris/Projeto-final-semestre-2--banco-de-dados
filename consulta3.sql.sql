--- Consulta 3: Participação dos alunos nas aulas coletivas
--- Lista TODOS os alunos, inclusive os que nunca agendaram aula,
--- com a quantidade de agendamentos ativos e a data da última aula agendada.
--- Quem não tem agendamento aparece com 0 e com o texto "Nenhuma aula agendada".
--- Recursos: LEFT JOIN com 3 tabelas, COUNT, tratamento de nulos (COALESCE),
---           GROUP BY, ORDER BY DESC e ASC

SELECT
    al.nome                                              AS aluno,
    COUNT(ag.id_agendamento)                             AS qtd_aulas_agendadas,
    COALESCE(MAX(au.data_hora), 'Nenhuma aula agendada') AS ultima_aula_agendada
FROM Aluno al
LEFT JOIN Agendamento ag ON ag.id_aluno = al.id_aluno
                        AND ag.status   = 'Ativo'
LEFT JOIN Aula au        ON au.id_aula  = ag.id_aula
GROUP BY al.id_aluno, al.nome
ORDER BY qtd_aulas_agendadas DESC, al.nome ASC;
