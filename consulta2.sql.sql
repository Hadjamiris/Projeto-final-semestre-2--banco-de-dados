--- Consulta 2: Desempenho financeiro de cada plano
--- Para cada plano, mostra a quantidade de pagamentos, o valor médio pago,
--- o total arrecadado e as datas do primeiro e do último pagamento.
--- Exibe apenas os planos com mais de 6 pagamentos.
--- Recursos: INNER JOIN com 3 tabelas, COUNT, AVG, SUM, MIN, MAX, HAVING

SELECT
    pl.nome                  AS plano,
    COUNT(p.id_pagamento)    AS qtd_pagamentos,
    ROUND(AVG(p.valor), 2)   AS valor_medio,
    ROUND(SUM(p.valor), 2)   AS total_arrecadado,
    MIN(p.data_pagamento)    AS primeiro_pagamento,
    MAX(p.data_pagamento)    AS ultimo_pagamento
FROM Pagamento p
INNER JOIN Contrato_Aluno ca ON ca.id_contrato = p.id_contrato
INNER JOIN Plano pl          ON pl.id_plano    = ca.id_plano
GROUP BY pl.id_plano, pl.nome
HAVING COUNT(p.id_pagamento) > 6
ORDER BY total_arrecadado DESC;
