--- Consulta 4: Vagas disponíveis nas próximas aulas
--- Para cada aula a partir de 17/11/2026, mostra a modalidade, o professor,
--- o total de vagas, quantas estão ocupadas e quantas ainda estão livres.
--- (Regra de negócio: vagas disponíveis = total de vagas - agendamentos ativos)
--- Recursos: CTE (WITH), INNER JOIN, LEFT JOIN, COUNT,
---           tratamento de nulos (COALESCE), ORDER BY ASC

WITH ocupacao AS (
    SELECT id_aula, COUNT(*) AS vagas_ocupadas
    FROM Agendamento
    WHERE status = 'Ativo'
    GROUP BY id_aula
)
SELECT
    au.id_aula,
    m.nome                                        AS modalidade,
    f.nome                                        AS professor,
    au.data_hora,
    au.sala,
    au.vagas_totais,
    COALESCE(o.vagas_ocupadas, 0)                 AS vagas_ocupadas,
    au.vagas_totais - COALESCE(o.vagas_ocupadas, 0) AS vagas_disponiveis
FROM Aula au
INNER JOIN Modalidade m  ON m.id_modalidade  = au.id_modalidade
INNER JOIN Funcionario f ON f.id_funcionario = au.id_professor
LEFT JOIN ocupacao o     ON o.id_aula        = au.id_aula
WHERE au.data_hora >= '2026-11-17'
ORDER BY au.data_hora ASC;
