--- Consulta 1: Faturamento mensal por forma de pagamento
--- Mostra, para cada mês de referência e cada forma de pagamento,
--- quantos pagamentos foram feitos e quanto foi arrecadado.
--- Recursos: COUNT, SUM, GROUP BY com duas colunas, ORDER BY ASC e DESC

SELECT
    mes_referencia,
    forma_pagamento,
    COUNT(*)   AS qtd_pagamentos,
    ROUND(SUM(valor), 2) AS total_arrecadado
FROM Pagamento
GROUP BY mes_referencia, forma_pagamento
ORDER BY mes_referencia ASC, total_arrecadado DESC;
