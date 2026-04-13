-- criando banco de dados
CREATE DATABASE escola;

-- criando primeira tabela
CREATE TABLE instrutora (
codigo INT PRIMARY KEY,
telefone VARCHAR(11) NOT NULL,
nomeinstrutora VARCHAR(255) NOT NULL,
rua VARCHAR(255) NOT NULL,
numero CHAR(8) NOT NULL,
complemento VARCHAR(200),
bairro VARCHAR(100) NOT NULL,
cidade VARCHAR(100) NOT NULL,
estado CHAR(2) NOT NULL,
CEP VARCHAR(8) NOT NULL
);

-- criando segunda tabela
CREATE TABLE disciplina (
    codigodisciplina INT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    codigoinstrutora INT,
    FOREIGN KEY (codigoinstrutora)
    REFERENCES instrutora(codigo)
);

-- criando terceira tabela
CREATE TABLE estudante (
    codigoestudante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    rua VARCHAR(255) NOT NULL,
    numero CHAR(8) NOT NULL,
    complemento VARCHAR(200),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    codigoinstrutora INT,
    FOREIGN KEY (codigoinstrutora)
    REFERENCES instrutora(codigo)
);

-- Alterando nome das colunas
ALTER TABLE instrutora
CHANGE nomeinstrutora nomepessoainstrutora VARCHAR(200) NOT NULL;

ALTER TABLE disciplina
CHANGE nome nomedisciplina VARCHAR(200) NOT NULL;

ALTER TABLE estudante
CHANGE nome nomeestudante VARCHAR(200) NOT NULL;

-- inserindo dois dados em cada tabela
INSERT INTO instrutora(
    nomepessoainstrutora, codigo, telefone, rua, numero,
    complemento, bairro, cidade, estado, CEP
) VALUES
(
    'Ana Santos Silva',
    '12345',
     '96532458756',
    'Rua dos cafezais',
    '400',
    NULL,
    'jardim quadrado',
    'São Paulo',
    'São Paulo',
    '25348762'
),
(
    
    'Maicon Souza Lima',
    '54321',
    '94573268914',
    'Rua de pedra',
    '715',
    NULL,
    'jardim redondo',
    'São Paulo',
    'São Paulo',
    '63598642'
);

INSERT INTO disciplina (nomedisciplina, codigoinstrutora)
VALUES ('Matemática', 12345);

INSERT INTO disciplina (codigodisciplina, nomedisciplina, codigoinstrutora)
VALUES (2, 'Português', 54321);

INSERT INTO estudante(
    nomeestudante, codigoestudante, telefone, rua, numero,
    complemento, bairro, cidade, estado, CEP
) VALUES
(
    'Carol Macedo Diaz',
    '45678',
     '96547852365',
    'Rua do Mar',
    '500',
    NULL,
    'jardim retangulo',
    'São Paulo',
    'São Paulo',
    '56345879'
),
(
    
    'André Almeida Prado',
    '65432',
    '96542359875',
    'Rua de Barro',
    '600',
    NULL,
    'jardim triangulo',
    'São Paulo',
    'São Paulo',
    '32654785'
);

-- Alterando telefone
UPDATE estudante
SET telefone = '11999998888'
WHERE codigoestudante = '96547852365'

-- Deletando um dado da tabela
DELETE FROM instrutora
WHERE cidade = 12345;

-- Deletando as tabelas
DROP TABLE instrutora;
DROP TABLE disciplina;
DROP TABLE estudante;

-- Deletar banco de dados
DROP DATABASE escola;

