--- Consulta 7: Alunos que podem agendar aulas de Yoga
--- Lista os alunos com contrato ativo cujo plano permite a modalidade Yoga.
--- (Regra de negócio: o aluno só pode agendar aulas das modalidades do seu plano)
--- Recursos: subconsulta com IN, INNER JOIN, ORDER BY ASC

SELECT
    al.nome  AS aluno,
    pl.nome  AS plano
FROM Aluno al
INNER JOIN Contrato_Aluno ca ON ca.id_aluno = al.id_aluno
                            AND ca.status   = 'Ativo'
INNER JOIN Plano pl          ON pl.id_plano = ca.id_plano
WHERE ca.id_plano IN (
    SELECT pm.id_plano
    FROM Plano_Modalidade pm
    INNER JOIN Modalidade m ON m.id_modalidade = pm.id_modalidade
    WHERE m.nome = 'Yoga'
)
ORDER BY al.nome ASC;
