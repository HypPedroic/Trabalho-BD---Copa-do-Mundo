CREATE DATABASE IF NOT EXISTS COPA_DO_MUNDO;
USE COPA_DO_MUNDO;

CREATE TABLE IF NOT EXISTS TEAMS (
    team_id VARCHAR(5) PRIMARY KEY,
    team_name           VARCHAR(50)     NOT NULL,    -- Ex: Algeria
    team_code           CHAR(3)         UNIQUE,      -- Ex: DZA
    federation_name     VARCHAR(100),                -- Ex: Algerian Football Federation
    region_name         VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS TORNEIOS (
    tournament_id       VARCHAR(10)     PRIMARY KEY, -- Ex: WC-1930
    year                INT             UNIQUE,      -- Ex: 1930
    start_date          DATE,
    end_date            DATE,
    country_name        VARCHAR(50),                 -- Ex: Uruguay
    winner              VARCHAR(50)                  -- Ex: Uruguay (Melhor seria usar um FK aqui, mas os dados originais usam o nome do vencedor)
);

CREATE TABLE PARTIDAS (
    -- Chave Primária Composta para garantir unicidade
    tournament_id       VARCHAR(10)     NOT NULL,    -- Ex: WC-1930
    match_id            VARCHAR(15)     NOT NULL,    -- Ex: M-1930-01
    
    PRIMARY KEY (tournament_id, match_id),
    
    -- Colunas de dados da partida
    stage_name          VARCHAR(50),                 -- Ex: group stage, final
    group_name          VARCHAR(50),                 -- Ex: Group 1, Group 2 (NULL para fases eliminatórias)
    stadium_name        VARCHAR(100),
    match_date          VARCHAR(20),                 -- Mantendo como string devido ao formato complexo (e.g., 1930-07-13 S-1800)
    
    -- Chaves Estrangeiras para as equipes
    team_a_id           VARCHAR(5)      NOT NULL,
    team_b_id           VARCHAR(5)      NOT NULL,
    
    -- Gols/Score
    score_a             INT             NOT NULL,
    score_b             INT             NOT NULL,
    
    -- Colunas Derivadas (mantidas aqui para facilitar consultas simples, mas idealmente removíveis/calculáveis)
    team_a_win          TINYINT,
    team_b_win          TINYINT,
    draw                TINYINT
);

ALTER TABLE PARTIDAS
    ADD CONSTRAINT fk_team_a
    FOREIGN KEY (team_a_id) REFERENCES TEAMS(team_id);

ALTER TABLE PARTIDAS
    ADD CONSTRAINT fk_team_b
    FOREIGN KEY (team_b_id) REFERENCES TEAMS(team_id);

ALTER TABLE PARTIDAS
    ADD CONSTRAINT fk_tournament
    FOREIGN KEY (tournament_id) REFERENCES TORNEIOS(tournament_id);

