--- =====================================================================
--- SISTEMA DE ACADEMIA - SCRIPT DDL (script_ddl.sql)
--- CIN 8003 - Bancos de Dados e Aplicações - Projeto Final
--- SGBD: SQLite
---
--- Cria as 12 tabelas do modelo lógico com:
--- PK, FK, NOT NULL, UNIQUE, CHECK, DEFAULT e ações referenciais
--- =====================================================================

--- No SQLite, as chaves estrangeiras só são verificadas com esta opção ligada
PRAGMA foreign_keys = ON;

--- ---------------------------------------------------------------------
--- 1. ALUNO
--- ---------------------------------------------------------------------
CREATE TABLE Aluno(
  id_aluno integer PRIMARY KEY,
  nome text not NULL,
  cpf varchar(14) not null unique,
  data_nascimento date not null,
  telefone text not null,
  email text not null UNIQUE,
  data_cadastro date not null DEFAULT CURRENT_DATE
);

--- ---------------------------------------------------------------------
--- 2. FUNCIONARIO
--- ---------------------------------------------------------------------
CREATE TABLE Funcionario(
  id_funcionario integer PRIMARY KEY,
  nome text not NULL,
  cpf varchar(14) not null,
  cargo text not NULL,
  telefone text,
  email text not null unique,
  ativo boolean
);

--- ---------------------------------------------------------------------
--- 3. PLANO
--- ---------------------------------------------------------------------
CREATE TABLE plano(
  id_plano integer PRIMARY key,
  nome text not null,
  valor_mensal decimal not null check (valor_mensal > 0),
  duracao_meses integer not null,
  descricao text
);

--- ---------------------------------------------------------------------
--- 4. MODALIDADE
--- ---------------------------------------------------------------------
CREATE TABLE modalidade(
  id_modalidade integer PRIMARY key,
  nome text not null,
  descricao text
);

--- ---------------------------------------------------------------------
--- 5. PLANO_MODALIDADE (tabela do relacionamento N:N "permite", PK composta)
--- ---------------------------------------------------------------------
CREATE TABLE Plano_Modalidade (
  id_plano integer not null,
  id_modalidade integer not null,
  PRIMARY KEY (id_plano, id_modalidade),
  FOREIGN KEY (id_plano) REFERENCES Plano (id_plano)
      ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_modalidade) REFERENCES Modalidade (id_modalidade)
      ON DELETE CASCADE ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 6. CONTRATO_ALUNO
--- ---------------------------------------------------------------------
CREATE TABLE Contrato_Aluno (
  id_contrato integer PRIMARY KEY,
  data_inicio date not null DEFAULT CURRENT_DATE,
  data_fim date,
  status text not null DEFAULT 'Ativo' check (status in ('Ativo', 'Encerrado', 'Cancelado')),
  id_aluno integer not null,
  id_plano integer not null,
  FOREIGN KEY (id_aluno) REFERENCES Aluno (id_aluno)
      ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_plano) REFERENCES Plano (id_plano)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 7. CONTRATO_FUNCIONARIO
--- ---------------------------------------------------------------------
CREATE TABLE Contrato_Funcionario (
  id_contrato integer PRIMARY KEY,
  data_admissao date not null,
  salario decimal not null check (salario > 0),
  carga_horaria integer not null check (carga_horaria between 1 and 44),
  status text not null DEFAULT 'Ativo' check (status in ('Ativo', 'Encerrado')),
  id_funcionario integer not null,
  FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 8. PAGAMENTO
--- ---------------------------------------------------------------------
CREATE TABLE Pagamento (
  id_pagamento integer PRIMARY KEY,
  data_pagamento date not null DEFAULT CURRENT_DATE,
  valor decimal not null check (valor > 0),
  forma_pagamento text not null check (forma_pagamento in ('Dinheiro', 'Pix', 'Cartao de Credito', 'Cartao de Debito', 'Boleto')),
  mes_referencia text not null,
  id_contrato integer not null,
  UNIQUE (id_contrato, mes_referencia),
  FOREIGN KEY (id_contrato) REFERENCES Contrato_Aluno (id_contrato)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 9. TREINO
--- ---------------------------------------------------------------------
CREATE TABLE Treino (
  id_treino integer PRIMARY KEY,
  data_criacao date not null DEFAULT CURRENT_DATE,
  objetivo text not null,
  descricao_exercicios text not null,
  id_aluno integer not null,
  id_personal integer not null,
  FOREIGN KEY (id_aluno) REFERENCES Aluno (id_aluno)
      ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_personal) REFERENCES Funcionario (id_funcionario)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 10. AVALIACAO_FISICA
--- ---------------------------------------------------------------------
CREATE TABLE Avaliacao_Fisica (
  id_avaliacao integer PRIMARY KEY,
  data_avaliacao date not null DEFAULT CURRENT_DATE,
  peso decimal not null check (peso > 0),
  altura decimal not null check (altura > 0),
  percentual_gordura decimal check (percentual_gordura between 0 and 100),
  observacoes text,
  id_aluno integer not null,
  id_personal integer not null,
  FOREIGN KEY (id_aluno) REFERENCES Aluno (id_aluno)
      ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_personal) REFERENCES Funcionario (id_funcionario)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 11. AULA
--- ---------------------------------------------------------------------
CREATE TABLE Aula (
  id_aula integer PRIMARY KEY,
  data_hora datetime not null,
  sala text not null,
  vagas_totais integer not null DEFAULT 20 check (vagas_totais > 0),
  id_modalidade integer not null,
  id_professor integer not null,
  FOREIGN KEY (id_modalidade) REFERENCES Modalidade (id_modalidade)
      ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (id_professor) REFERENCES Funcionario (id_funcionario)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

--- ---------------------------------------------------------------------
--- 12. AGENDAMENTO
--- ---------------------------------------------------------------------
CREATE TABLE Agendamento (
  id_agendamento integer PRIMARY KEY,
  data_agendamento date not null DEFAULT CURRENT_DATE,
  status text not null DEFAULT 'Ativo' check (status in ('Ativo', 'Cancelado')),
  checkin_realizado integer not null DEFAULT 0 check (checkin_realizado in (0, 1)),
  data_hora_checkin datetime,
  id_aluno integer not null,
  id_aula integer not null,
  UNIQUE (id_aluno, id_aula),
  CHECK (checkin_realizado = 0 OR status = 'Ativo'),
  FOREIGN KEY (id_aluno) REFERENCES Aluno (id_aluno)
      ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_aula) REFERENCES Aula (id_aula)
      ON DELETE CASCADE ON UPDATE CASCADE
);
