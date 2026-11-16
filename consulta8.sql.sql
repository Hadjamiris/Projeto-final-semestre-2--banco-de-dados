--- Consulta 8: Histórico de avaliações físicas dos alunos
--- Mostra cada avaliação com o aluno, o personal responsável, peso, altura,
--- IMC calculado e percentual de gordura. Quando o percentual ou as
--- observações não foram registrados (NULL), exibe um texto no lugar.
--- Recursos: tratamento de nulos (COALESCE e IFNULL), INNER JOIN com 3 tabelas,
---           ORDER BY ASC e DESC

SELECT
    al.nome                                        AS aluno,
    f.nome                                         AS personal,
    av.data_avaliacao,
    av.peso,
    av.altura,
    ROUND(av.peso / (av.altura * av.altura), 1)    AS imc,
    COALESCE(av.percentual_gordura, 'Não medido')  AS percentual_gordura,
    IFNULL(av.observacoes, 'Sem observações')      AS observacoes
FROM Avaliacao_Fisica av
INNER JOIN Aluno al      ON al.id_aluno       = av.id_aluno
INNER JOIN Funcionario f ON f.id_funcionario  = av.id_personal
ORDER BY al.nome ASC, av.data_avaliacao DESC;
