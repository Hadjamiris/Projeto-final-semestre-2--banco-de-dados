--- Consulta 9: Registro de check-in com correção de erro (transação)
--- Simula o professor registrando presenças na aula de Spinning (aula 1).
--- Ele confirma a Maria, depois marca por engano a Mariana (que ainda não chegou).
--- O erro é desfeito com ROLLBACK TO SAVEPOINT, a Larissa é registrada
--- e tudo é confirmado com COMMIT. No final, mostra as presenças da aula.
--- Recursos: BEGIN TRANSACTION, SAVEPOINT, ROLLBACK TO, COMMIT

BEGIN TRANSACTION;

--- Check-in da Maria (agendamento 7)
UPDATE Agendamento
SET checkin_realizado = 1, data_hora_checkin = '2026-11-17 06:50'
WHERE id_agendamento = 7;

SAVEPOINT antes_do_erro;

--- Check-in marcado por ENGANO na Mariana (agendamento 9)
UPDATE Agendamento
SET checkin_realizado = 1, data_hora_checkin = '2026-11-17 06:52'
WHERE id_agendamento = 9;

--- Desfaz apenas o erro, mantendo o check-in da Maria
ROLLBACK TO SAVEPOINT antes_do_erro;

--- Check-in correto: Larissa (agendamento 8)
UPDATE Agendamento
SET checkin_realizado = 1, data_hora_checkin = '2026-11-17 06:53'
WHERE id_agendamento = 8;

COMMIT;

--- Resultado: presenças da aula 1
SELECT
    al.nome                                    AS aluno,
    ag.checkin_realizado,
    IFNULL(ag.data_hora_checkin, 'Sem check-in') AS horario_checkin
FROM Agendamento ag
INNER JOIN Aluno al ON al.id_aluno = ag.id_aluno
WHERE ag.id_aula = 1
ORDER BY al.nome ASC;
