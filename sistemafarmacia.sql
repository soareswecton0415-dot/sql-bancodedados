-- criar um banco de dados
CREATE DATABASE farmacianova;

--criando a primeira tabela
CREATE TABLE farmacia (
cnpj VARCHAR(14) PRIMARY KEY,
telefone VARCHAR(11) NOT NULL,
nomefarmacia VARCHAR(255) NOT NULL,
rua VARCHAR(255) NOT NULL,
numero CHAR(8) NOT NULL,
complemento VARCHAR(200),
bairro VARCHAR(100) NOT NULL,
cidade VARCHAR(100) NOT NULL,
estado CHAR(2) NOT NULL,
CEP VARCHAR(8) NOT NULL
);

-- criando a segunda tabela
CREATE TABLE farmaceutico (
    rg INT PRIMARY KEY,
    nomefarmaceutico VARCHAR(255) NOT NULL,
    cnpj_farmacia VARCHAR(14),
    FOREIGN KEY (cnpj_farmacia)
    REFERENCES farmacia(cnpj)
);

-- criando a terceira tabela
CREATE TABLE produto (
    codproduto INT AUTO_INCREMENT PRIMARY KEY,
    quantproduto INT NOT NULL,
    valorproduto DECIMAL(10,2) NOT NULL,
    cnpj_farmacia VARCHAR(14),
    FOREIGN KEY (cnpj_farmacia)
        REFERENCES farmacia(cnpj)
);

-- alterando o nome de uma coluna existente
ALTER TABLE farmacia
CHANGE estado UF CHAR(2) NOT NULL;

--Inserindo um dado na primeira tabela
INSERT INTO farmacia (
  cnpj, telefone, nomefarmacia, rua, numero, complemento,
  bairro, cidade, UF, CEP
) VALUES (
  '12345678000199',
  '11987654321',
  'Farmácia Saúde Total',
  'Rua das Flores',
  '120',
  'Próximo ao hospital',
  'Centro',
  'São Paulo',
  'SP',
  '01001000'
);
 
--Inserindo vários dados ao mesmo tempo na primeira tabela
INSERT INTO farmacia (
  cnpj, telefone, nomefarmacia, rua, numero, complemento,
  bairro, cidade, UF, CEP
) VALUES
(
  '98765432000188',
  '11991234567',
  'Farmácia Bem Viver',
  'Avenida Paulista',
  '1500',
  'Loja 12',
  'Bela Vista',
  'São Paulo',
  'SP',
  '01310000'
),
(
  '45678912000177',
  '1133445566',
  'Farmácia Popular',
  'Rua Independência',
  '350',
  NULL,
  'Jardim América',
  'Campinas',
  'SP',
  '13020010'
),
(
  '32165498000166',
  '1140098877',
  'Farmácia Vida e Saúde',
  'Rua Rio Branco',
  '890',
  'Esquina com a praça',
  'Centro',
  'Santos',
  'SP',
  '11013001'
);

-- Inserindo dois dados na segunda tabela
INSERT INTO farmaceutico(
    rg,
    nomefarmaceutico,
    cnpj_farmacia
) VALUES
(
    123456789,
    'Carlos Henrique Almeida',
    '12345678000199'
),
(
    987654321,
    'Fernanda Souza Lima',
    '98765432000188'
);

-- Inserindo quatro dados na terceira tabela
INSERT INTO produto (
    codproduto,
    quantproduto,
    valorproduto,
    cnpj_farmacia
) VALUES
(
    1,
    50,
    12.90,
    '12345678000199'
),
(
    2,
    30,
    25.50,
    '98765432000188'
    
),
(
    3,
    100,
    8.75,
    '45678912000177'
),
(
    4,
    20,
    45.00,
    '32165498000166'
);

-- inserindo dado sem passar o código pois é auto increment
INSERT INTO produto (
    quantproduto,
    valorproduto,
    cnpj_farmacia
) VALUES
(
    25,
    45.40,
    '32165498000166'
);

-- Alterando um dado na tabela farmacia
UPDATE farmacia
SET telefone = '11999998888'
WHERE cnpj = '12345678000199';

-- Alterando dois dados ao mesmo tempo, na tabela de produto
UPDATE produto
SET quantproduto = 80,
    valorproduto = 14.50
WHERE codproduto = 1;

-- selecionando todos os dados de todas as colunas
SELECT * FROM farmacia; 

-- selecionando dados de uma coluna
SELECT nomefarmacia
FROM farmacia;

--  selecionando todos os dados de duas colunas
SELECT nomefarmacia, cidade
FROM farmacia;

-- selecionando com filtro
SELECT * FROM farmacia
WHERE cidade = 'São Paulo';

-- selecionando com WHERE e AND 
SELECT * FROM farmacia
WHERE cidade = 'São Paulo' AND UF = 'SP';

-- selecionando com WHERE e OR
SELECT * FROM farmacia
WHERE cidade = 'São Paulo' OR cidade = 'Campinas';

SELECT telefone
FROM farmacia 
WHERE cidade = 'São Paulo' OR cidade = 'Campinas';

-- selecionando com BETWEEN (entre) e AND 
SELECT * FROM produto
WHERE valorproduto BETWEEN 10.00 AND 30.00;

-- select com maior que (>)
SELECT * FROM produto
WHERE valorproduto > 20.00;

-- select com igual a (=)
SELECT * FROM produto
WHERE valorproduto = 45.40;

-- select menor ou igual a (<=)
SELECT * FROM produto
WHERE quantproduto <= 50;

-- select combinando > AND <=
SELECT * FROM produto
WHERE valorproduto > 10.00 AND valorproduto <= 30.00;

-- select com WHERE e LIKE
SELECT * FROM farmacia
WHERE nomefarmacia LIKE 'Farmacia%';

SELECT * FROM farmacia
WHERE nomefarmacia LIKE '%Vida%';

SELECT * FROM farmacia
WHERE nomefarmacia LIKE '%a%';

-- selecionando com ordem ascendente/crescente
SELECT * FROM farmacia
ORDER BY nomefarmacia ASC;

-- selecionando com ordem descendente/decrescente
SELECT * FROM produto
ORDER BY valorproduto DESC;

-- selecionando com limite
SELECT * FROM produto 
LIMIT 2;

-- selecionando com WHERE, ORDER BY e LIMIT juntos
SELECT * FROM produto
WHERE valorproduto > 20.00
ORDER BY valorproduto DESC 
LIMIT 1;

-- select JOIN ON
SELECT * FROM farmacia
JOIN produto
ON farmacia.cnpj = produto.cnpj_farmacia;

-- select INNER JOIN ON
SELECT * FROM farmacia 
INNER JOIN farmaceutico
ON farmacia.cnpj = farmaceutico.cnpj_farmacia

-- select INNER JOIN com WHERE
SELECT nomefarmacia, nomefarmaceutico
FROM farmacia
INNER JOIN farmaceutico
ON farmacia.cnpj = farmaceutico.cnpj_farmacia
WHERE farmacia.cidade = 'São Paulo';

-- select INNER JOIN com ORDER BY ASC
SELECT nomefarmacia, valorproduto
FROM farmacia
INNER JOIN produto
ON farmacia.cnpj = produto.cnpj_farmacia
ORDER BY valorproduto ASC;

-- Deletando um dado de uma tabela
DELETE FROM produto
WHERE codproduto = 4;

-- Deletando as tabelas
DROP TABLE farmacia;
DROP TABLE farmaceutico;
DROP TABLE produto;

-- Deletar banco de dados
DROP DATABASE farmacianova;

-- criando novo usuario no banco de dados
CREATE USER 'usuario_farmacia'@'localhost'
IDENTIFIED BY 'senha123';

-- concedendo permissões - total
GRANT ALL PRIVILEGES
ON farmacianova.*
TO 'usuario_farmacia'@'localhost';

-- concedendo permissões - apenas de leitura
GRANT SELECT
ON farmacianova.*
TO 'usuario_farmacia'@'localhost';

-- concedendo permissões especificas
GRANT SELECT, INSERT
ON farmacianova.*
TO 'usuario_farmacia'@'localhost';

-- revogando permissões de um usuario
REVOKE INSERT
ON farmacianova.*
FROM 'usuario_farmacia'@'localhost';

-- Revogando todas as permissões do usuário
REVOKE ALL PRIVILEGES
ON farmacianova.*
FROM 'usuario_farmacia'@'localhost';

-- Excluindo usuario
DROP USER 'usuario_farmacia'@'localhost';