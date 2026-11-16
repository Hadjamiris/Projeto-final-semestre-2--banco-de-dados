--- Consulta 10: Cancelamento de agendamento e reajuste desistido (transação)
--- A Mariana cancela a aula de Pilates lotada (aula 10), liberando uma vaga.
--- Em seguida, o gerente testa um reajuste de 10% em todos os planos,
--- mas desiste: o reajuste é desfeito com ROLLBACK TO SAVEPOINT,
--- enquanto o cancelamento é mantido e confirmado com COMMIT.
--- No final, mostra as vagas da aula 10 e os valores dos planos (sem reajuste).
--- Recursos: BEGIN TRANSACTION, SAVEPOINT, ROLLBACK TO, COMMIT, COUNT

BEGIN TRANSACTION;

--- Mariana cancela o agendamento 27 (libera a vaga)
UPDATE Agendamento
SET status = 'Cancelado'
WHERE id_agendamento = 27;

SAVEPOINT antes_do_reajuste;

--- Reajuste de 10% nos planos (que será desfeito)
UPDATE Plano
SET valor_mensal = ROUND(valor_mensal * 1.10, 2);

--- O gerente desistiu do reajuste
ROLLBACK TO SAVEPOINT antes_do_reajuste;

COMMIT;

--- Resultado 1: vagas da aula 10 depois do cancelamento
SELECT
    au.id_aula,
    au.vagas_totais,
    COUNT(ag.id_agendamento)                   AS vagas_ocupadas,
    au.vagas_totais - COUNT(ag.id_agendamento) AS vagas_disponiveis
FROM Aula au
LEFT JOIN Agendamento ag ON ag.id_aula = au.id_aula
                        AND ag.status  = 'Ativo'
WHERE au.id_aula = 10
GROUP BY au.id_aula, au.vagas_totais;

--- Resultado 2: valores dos planos continuam sem reajuste
SELECT nome, valor_mensal
FROM Plano
ORDER BY valor_mensal ASC;
