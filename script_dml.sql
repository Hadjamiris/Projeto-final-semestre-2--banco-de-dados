--- =====================================================================
--- SISTEMA DE ACADEMIA - SCRIPT DML (script_dml.sql)
--- CIN 8003 - Bancos de Dados e Aplicações - Projeto Final
---
--- Insere dados de exemplo em todas as 12 tabelas.
--- Rodar DEPOIS do script_ddl.sql, nesta ordem (por causa das FKs).
--- =====================================================================

PRAGMA foreign_keys = ON;

--- ---------------------------------------------------------------------
--- 1. ALUNO (10 alunos)
--- ---------------------------------------------------------------------
INSERT INTO Aluno (id_aluno, nome, cpf, data_nascimento, telefone, email, data_cadastro) VALUES
(1,  'Maria Silva',     '111.111.111-11', '1998-03-12', '(48) 99901-1111', 'maria.silva@email.com',     '2026-01-10'),
(2,  'João Souza',      '222.222.222-22', '2001-07-25', '(48) 99902-2222', 'joao.souza@email.com',      '2026-10-01'),
(3,  'Ana Oliveira',    '333.333.333-33', '1990-11-03', '(48) 99903-3333', 'ana.oliveira@email.com',    '2026-06-01'),
(4,  'Pedro Santos',    '444.444.444-44', '1995-01-30', '(48) 99904-4444', 'pedro.santos@email.com',    '2026-08-15'),
(5,  'Larissa Costa',   '555.555.555-55', '2000-05-18', '(48) 99905-5555', 'larissa.costa@email.com',   '2026-03-01'),
(6,  'Lucas Pereira',   '666.666.666-66', '1993-09-09', '(48) 99906-6666', 'lucas.pereira@email.com',   '2026-01-15'),
(7,  'Beatriz Lima',    '777.777.777-77', '1987-12-21', '(48) 99907-7777', 'beatriz.lima@email.com',    '2026-07-01'),
(8,  'Gabriel Alves',   '888.888.888-88', '2003-04-14', '(48) 99908-8888', 'gabriel.alves@email.com',   '2026-09-10'),
(9,  'Mariana Rocha',   '999.999.999-99', '1999-08-02', '(48) 99909-9999', 'mariana.rocha@email.com',   '2026-05-20'),
(10, 'Thiago Martins',  '101.010.101-01', '1985-02-27', '(48) 99910-1010', 'thiago.martins@email.com',  '2026-04-01');

--- ---------------------------------------------------------------------
--- 2. FUNCIONARIO (8 funcionários: 3 personais, 3 professores,
---    1 gerente, 1 recepcionista). Todos ativos (ativo = 1).
---    Camila está sem telefone (NULL), para testar tratamento de nulos.
--- ---------------------------------------------------------------------
INSERT INTO Funcionario (id_funcionario, nome, cpf, cargo, telefone, email, ativo) VALUES
(1, 'Carlos Mendes',    '121.212.121-21', 'Personal',      '(48) 98801-0001', 'carlos.mendes@academia.com', 1),
(2, 'Fernanda Ribeiro', '131.313.131-31', 'Personal',      '(48) 98801-0002', 'fernanda.ribeiro@academia.com', 1),
(3, 'Rafael Teixeira',  '141.414.141-41', 'Personal',      '(48) 98801-0003', 'rafael.teixeira@academia.com', 1),
(4, 'Juliana Freitas',  '151.515.151-51', 'Professor',     '(48) 98801-0004', 'juliana.freitas@academia.com', 1),
(5, 'Marcos Vieira',    '161.616.161-61', 'Professor',     '(48) 98801-0005', 'marcos.vieira@academia.com', 1),
(6, 'Patrícia Gomes',   '171.717.171-71', 'Professor',     '(48) 98801-0006', 'patricia.gomes@academia.com', 1),
(7, 'Roberto Nunes',    '181.818.181-81', 'Gerente',       '(48) 98801-0007', 'roberto.nunes@academia.com', 1),
(8, 'Camila Duarte',    '191.919.191-91', 'Recepcionista', NULL,              'camila.duarte@academia.com', 1);

--- ---------------------------------------------------------------------
--- 3. PLANO (4 planos)
--- ---------------------------------------------------------------------
INSERT INTO Plano (id_plano, nome, valor_mensal, duracao_meses, descricao) VALUES
(1, 'Básico',     89.90,  1,  'Acesso apenas à musculação.'),
(2, 'Fit',        129.90, 3,  'Musculação e aulas de funcional.'),
(3, 'Completo',   199.90, 12, 'Acesso a todas as modalidades.'),
(4, 'Bem-Estar',  149.90, 6,  NULL);

--- ---------------------------------------------------------------------
--- 4. MODALIDADE (5 modalidades)
--- ---------------------------------------------------------------------
INSERT INTO Modalidade (id_modalidade, nome, descricao) VALUES
(1, 'Musculação', 'Treino com pesos e aparelhos.'),
(2, 'Spinning',   'Aula de ciclismo indoor.'),
(3, 'Yoga',       'Posturas, respiração e alongamento.'),
(4, 'Funcional',  'Exercícios com o peso do corpo e acessórios.'),
(5, 'Pilates',    'Fortalecimento do core e postura.');

--- ---------------------------------------------------------------------
--- 5. PLANO_MODALIDADE (quais modalidades cada plano permite)
--- ---------------------------------------------------------------------
INSERT INTO Plano_Modalidade (id_plano, id_modalidade) VALUES
(1, 1),                                  -- Básico: Musculação
(2, 1), (2, 4),                          -- Fit: Musculação, Funcional
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),  -- Completo: todas
(4, 3), (4, 5);                          -- Bem-Estar: Yoga, Pilates

--- ---------------------------------------------------------------------
--- 6. CONTRATO_ALUNO (11 contratos)
--- Lucas tem um contrato encerrado e um ativo (renovou e trocou de plano).
--- Thiago cancelou o contrato, por isso não tem plano ativo.
--- Planos mensais (Básico) ficam com data_fim NULL.
--- ---------------------------------------------------------------------
INSERT INTO Contrato_Aluno (id_contrato, data_inicio, data_fim, status, id_aluno, id_plano) VALUES
(1,  '2026-01-10', '2027-01-10', 'Ativo',     1,  3),
(2,  '2026-10-01', NULL,         'Ativo',     2,  1),
(3,  '2026-06-01', '2026-12-01', 'Ativo',     3,  4),
(4,  '2026-08-15', '2026-11-15', 'Ativo',     4,  2),
(5,  '2026-03-01', '2027-03-01', 'Ativo',     5,  3),
(6,  '2026-01-15', '2026-07-15', 'Encerrado', 6,  1),
(7,  '2026-09-01', '2026-12-01', 'Ativo',     6,  2),
(8,  '2026-07-01', '2027-01-01', 'Ativo',     7,  4),
(9,  '2026-09-10', NULL,         'Ativo',     8,  1),
(10, '2026-05-20', '2027-05-20', 'Ativo',     9,  3),
(11, '2026-04-01', '2026-07-01', 'Cancelado', 10, 2);

--- ---------------------------------------------------------------------
--- 7. CONTRATO_FUNCIONARIO (9 contratos)
--- Juliana tem um contrato antigo encerrado e um atual.
--- ---------------------------------------------------------------------
INSERT INTO Contrato_Funcionario (id_contrato, data_admissao, salario, carga_horaria, status, id_funcionario) VALUES
(1, '2024-02-01', 3200.00, 40, 'Ativo',     1),
(2, '2025-03-10', 3000.00, 36, 'Ativo',     2),
(3, '2025-08-01', 3400.00, 40, 'Ativo',     3),
(4, '2023-05-02', 2400.00, 20, 'Encerrado', 4),
(5, '2025-01-06', 2800.00, 30, 'Ativo',     4),
(6, '2024-09-16', 2600.00, 30, 'Ativo',     5),
(7, '2025-06-02', 2900.00, 30, 'Ativo',     6),
(8, '2022-01-10', 5500.00, 44, 'Ativo',     7),
(9, '2024-04-01', 2100.00, 44, 'Ativo',     8);

--- ---------------------------------------------------------------------
--- 8. PAGAMENTO (27 pagamentos de mensalidades)
--- mes_referencia no formato AAAA-MM
--- ---------------------------------------------------------------------
INSERT INTO Pagamento (id_pagamento, data_pagamento, valor, forma_pagamento, mes_referencia, id_contrato) VALUES
(1,  '2026-09-05', 199.90, 'Cartao de Credito', '2026-09', 1),
(2,  '2026-10-05', 199.90, 'Cartao de Credito', '2026-10', 1),
(3,  '2026-11-05', 199.90, 'Cartao de Credito', '2026-11', 1),
(4,  '2026-10-01', 89.90,  'Pix',               '2026-10', 2),
(5,  '2026-11-03', 89.90,  'Pix',               '2026-11', 2),
(6,  '2026-09-02', 149.90, 'Boleto',            '2026-09', 3),
(7,  '2026-10-02', 149.90, 'Boleto',            '2026-10', 3),
(8,  '2026-11-04', 149.90, 'Boleto',            '2026-11', 3),
(9,  '2026-09-15', 129.90, 'Cartao de Debito',  '2026-09', 4),
(10, '2026-10-15', 129.90, 'Cartao de Debito',  '2026-10', 4),
(11, '2026-09-01', 199.90, 'Pix',               '2026-09', 5),
(12, '2026-10-01', 199.90, 'Pix',               '2026-10', 5),
(13, '2026-11-01', 199.90, 'Pix',               '2026-11', 5),
(14, '2026-06-15', 89.90,  'Dinheiro',          '2026-06', 6),
(15, '2026-07-15', 89.90,  'Dinheiro',          '2026-07', 6),
(16, '2026-09-01', 129.90, 'Cartao de Credito', '2026-09', 7),
(17, '2026-10-01', 129.90, 'Cartao de Credito', '2026-10', 7),
(18, '2026-11-02', 129.90, 'Cartao de Credito', '2026-11', 7),
(19, '2026-10-01', 149.90, 'Pix',               '2026-10', 8),
(20, '2026-11-01', 149.90, 'Pix',               '2026-11', 8),
(21, '2026-09-10', 89.90,  'Dinheiro',          '2026-09', 9),
(22, '2026-10-10', 89.90,  'Dinheiro',          '2026-10', 9),
(23, '2026-10-20', 199.90, 'Cartao de Debito',  '2026-10', 10),
(24, '2026-11-06', 199.90, 'Cartao de Debito',  '2026-11', 10),
(25, '2026-04-01', 129.90, 'Boleto',            '2026-04', 11),
(26, '2026-05-02', 129.90, 'Boleto',            '2026-05', 11),
(27, '2026-09-20', 199.90, 'Pix',               '2026-08', 10);

--- ---------------------------------------------------------------------
--- 9. TREINO (10 treinos)
--- Personais: Carlos (1), Fernanda (2), Rafael (3)
--- ---------------------------------------------------------------------
INSERT INTO Treino (id_treino, data_criacao, objetivo, descricao_exercicios, id_aluno, id_personal) VALUES
(1,  '2026-01-12', 'Condicionamento', 'Esteira 20min; agachamento 3x12; supino 3x12; remada 3x12.', 1, 1),
(2,  '2026-07-10', 'Hipertrofia',     'Treino ABC: peito/tríceps, costas/bíceps, pernas/ombros.',  1, 1),
(3,  '2026-10-02', 'Emagrecimento',   'Circuito: bicicleta, polichinelo, prancha, afundo.',         2, 1),
(4,  '2026-08-16', 'Hipertrofia',     'Treino AB: superiores e inferiores, 4x10.',                  4, 1),
(5,  '2026-06-03', 'Flexibilidade',   'Alongamento ativo; mobilidade de quadril e coluna.',         3, 2),
(6,  '2026-03-03', 'Condicionamento', 'Corrida intervalada; abdominais; funcional leve.',           5, 2),
(7,  '2026-07-02', 'Reabilitação',    'Fortalecimento de joelho com elástico; leg press leve.',     7, 2),
(8,  '2026-09-02', 'Hipertrofia',     'Treino ABCD com foco em membros inferiores.',                6, 3),
(9,  '2026-09-11', 'Emagrecimento',   'Esteira inclinada 30min; circuito de peso corporal.',        8, 3),
(10, '2026-05-22', 'Condicionamento', 'Remo 15min; agachamento livre; levantamento terra leve.',    9, 3);

--- ---------------------------------------------------------------------
--- 10. AVALIACAO_FISICA (12 avaliações)
--- Alguns percentuais de gordura e observações ficam NULL (não medidos).
--- ---------------------------------------------------------------------
INSERT INTO Avaliacao_Fisica (id_avaliacao, data_avaliacao, peso, altura, percentual_gordura, observacoes, id_aluno, id_personal) VALUES
(1,  '2026-01-12', 68.5, 1.65, 27.0, 'Avaliação inicial.',            1, 1),
(2,  '2026-04-12', 66.0, 1.65, 25.2, NULL,                            1, 1),
(3,  '2026-07-10', 64.8, 1.65, 23.9, 'Boa evolução.',                 1, 1),
(4,  '2026-10-02', 92.3, 1.80, NULL, 'Percentual não medido.',        2, 1),
(5,  '2026-08-16', 78.0, 1.75, 18.5, NULL,                            4, 1),
(6,  '2026-06-03', 59.2, 1.60, 24.0, 'Relatou dor lombar.',           3, 2),
(7,  '2026-03-03', 55.0, 1.62, 21.3, NULL,                            5, 2),
(8,  '2026-07-02', 72.4, 1.68, 30.1, 'Pós-cirurgia no joelho.',       7, 2),
(9,  '2026-01-16', 85.0, 1.78, 22.0, 'Avaliação inicial.',            6, 3),
(10, '2026-09-02', 82.1, 1.78, 19.8, NULL,                            6, 3),
(11, '2026-09-11', 101.5, 1.83, NULL, NULL,                           8, 3),
(12, '2026-05-22', 61.3, 1.70, 20.4, 'Avaliação inicial.',            9, 3);

--- ---------------------------------------------------------------------
--- 11. AULA (10 aulas coletivas)
--- Professores: Juliana (4), Marcos (5), Patrícia (6)
--- Aulas 8 e 9 já aconteceram (têm check-in). A aula 10 tem só 3 vagas.
--- ---------------------------------------------------------------------
INSERT INTO Aula (id_aula, data_hora, sala, vagas_totais, id_modalidade, id_professor) VALUES
(1,  '2026-11-17 07:00', 'Sala 1', 15, 2, 4),
(2,  '2026-11-17 18:00', 'Sala 2', 12, 3, 6),
(3,  '2026-11-18 19:00', 'Sala 3', 20, 4, 5),
(4,  '2026-11-18 08:00', 'Sala 2', 10, 5, 6),
(5,  '2026-11-19 18:30', 'Sala 1', 15, 2, 4),
(6,  '2026-11-20 07:00', 'Sala 3', 20, 4, 5),
(7,  '2026-11-21 09:00', 'Sala 2', 12, 3, 6),
(8,  '2026-11-14 07:00', 'Sala 1', 15, 2, 4),
(9,  '2026-11-13 19:00', 'Sala 3', 20, 4, 5),
(10, '2026-11-21 10:30', 'Sala 2', 3,  5, 6);

--- ---------------------------------------------------------------------
--- 12. AGENDAMENTO (27 agendamentos)
--- Todos respeitam as modalidades do plano de cada aluno.
--- João, Gabriel (plano Básico) e Thiago (sem plano ativo) não agendaram aulas.
--- ---------------------------------------------------------------------
INSERT INTO Agendamento (id_agendamento, data_agendamento, status, checkin_realizado, data_hora_checkin, id_aluno, id_aula) VALUES
--- Aula 8 (Spinning, 14/11 - já aconteceu)
(1,  '2026-11-10', 'Ativo',     1, '2026-11-14 06:55', 1, 8),
(2,  '2026-11-11', 'Ativo',     1, '2026-11-14 06:58', 5, 8),
(3,  '2026-11-12', 'Ativo',     0, NULL,               9, 8),
--- Aula 9 (Funcional, 13/11 - já aconteceu)
(4,  '2026-11-09', 'Ativo',     1, '2026-11-13 18:52', 4, 9),
(5,  '2026-11-10', 'Ativo',     1, '2026-11-13 18:57', 6, 9),
(6,  '2026-11-10', 'Cancelado', 0, NULL,               1, 9),
--- Aula 1 (Spinning, 17/11)
(7,  '2026-11-14', 'Ativo',     0, NULL,               1, 1),
(8,  '2026-11-14', 'Ativo',     0, NULL,               5, 1),
(9,  '2026-11-15', 'Ativo',     0, NULL,               9, 1),
--- Aula 2 (Yoga, 17/11)
(10, '2026-11-13', 'Ativo',     0, NULL,               3, 2),
(11, '2026-11-14', 'Ativo',     0, NULL,               7, 2),
(12, '2026-11-14', 'Cancelado', 0, NULL,               9, 2),
--- Aula 3 (Funcional, 18/11)
(13, '2026-11-15', 'Ativo',     0, NULL,               4, 3),
(14, '2026-11-15', 'Ativo',     0, NULL,               6, 3),
(15, '2026-11-16', 'Ativo',     0, NULL,               5, 3),
--- Aula 4 (Pilates, 18/11)
(16, '2026-11-12', 'Ativo',     0, NULL,               3, 4),
(17, '2026-11-13', 'Ativo',     0, NULL,               7, 4),
--- Aula 5 (Spinning, 19/11)
(18, '2026-11-16', 'Ativo',     0, NULL,               1, 5),
--- Aula 6 (Funcional, 20/11)
(19, '2026-11-15', 'Ativo',     0, NULL,               4, 6),
(20, '2026-11-16', 'Ativo',     0, NULL,               9, 6),
--- Aula 7 (Yoga, 21/11)
(21, '2026-11-14', 'Ativo',     0, NULL,               3, 7),
(22, '2026-11-15', 'Ativo',     0, NULL,               5, 7),
(23, '2026-11-15', 'Ativo',     0, NULL,               1, 7),
(24, '2026-11-16', 'Ativo',     0, NULL,               7, 7),
--- Aula 10 (Pilates, 21/11 - só 3 vagas, ficou lotada)
(25, '2026-11-12', 'Ativo',     0, NULL,               1, 10),
(26, '2026-11-13', 'Ativo',     0, NULL,               5, 10),
(27, '2026-11-14', 'Ativo',     0, NULL,               9, 10);
