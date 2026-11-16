--- Consulta 5: Alunos que mais investiram na academia
--- Mostra os alunos cujo total pago é MAIOR que a média do total pago por aluno.
--- A média é calculada por uma subconsulta escalar (retorna um único valor).
--- Recursos: subconsulta escalar, INNER JOIN com 3 tabelas, COUNT, SUM, AVG,
---           HAVING, ORDER BY DESC

SELECT
    al.nome               AS aluno,
    COUNT(p.id_pagamento) AS qtd_pagamentos,
    ROUND(SUM(p.valor), 2) AS total_pago
FROM Aluno al
INNER JOIN Contrato_Aluno ca ON ca.id_aluno    = al.id_aluno
INNER JOIN Pagamento p       ON p.id_contrato  = ca.id_contrato
GROUP BY al.id_aluno, al.nome
HAVING SUM(p.valor) > (
    SELECT AVG(total_por_aluno)
    FROM (
        SELECT SUM(p2.valor) AS total_por_aluno
        FROM Pagamento p2
        INNER JOIN Contrato_Aluno c2 ON c2.id_contrato = p2.id_contrato
        GROUP BY c2.id_aluno
    )
)
ORDER BY total_pago DESC;
