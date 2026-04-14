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

-- procedure: Listar produtos de uma farmacia
DELIMITER $$

CREATE PROCEDURE listar_produtos_farmacia (IN cnpjFarm VARCHAR(14))
BEGIN
    SELECT codproduto, quantproduto, valorproduto
    FROM produto
    WHERE cnpj_farmacia = cnpjFarm;
END$$

DELIMITER ;

-- executando o procedure
CALL listar_produtos_farmacia('12345678000199')

-- Procedure: atualizar o valor do produto
DELIMITER $$
 
CREATE PROCEDURE atualizar_valor_produto(
    IN p_cod INT,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    UPDATE produto
    SET valorproduto = p_valor
    WHERE codproduto = p_cod;
END $$
 
DELIMITER ;
 
--  executando o procedure acima
CALL atualizar_valor_produto(1, 19.90);

-- Function: calcular o valor total em estoque
DELIMITER $$
CREATE FUNCTION valor_total_produto(p_cod INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN 
    DECLARE total DECIMAL(10,2);

    SELECT quantproduto * valorproduto
    INTO total
    FROM produto
    WHERE codproduto = p_cod;

    RETURN total;
END$$

DELIMITER ;

-- usando a função acima
SELECT valor_total_produto(1) AS total_em_estoque;

-- Function: quantidade de produtos por farmacia
DELIMITER $$
CREATE FUNCTION qtd_produtos_farmacia(p_cnpj VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM produto
    WHERE cnpj_farmacia = p_cnpj;

    RETURN total;
END$$

DELIMITER ;

-- Executando a função acima
SELECT qtd_produtos_farmacia('1234678000199');

-- Função de soma
DELIMITER $$
DROP FUNCTION IF EXISTS qtd_produtos_farmacia $$

CREATE FUNCTION qtd_produtos_farmacia(p_cnpj VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE total INT;

    SELECT SUM(quantproduto)
    INTO total
    FROM produto
    WHERE cnpj_farmacia = p_cnpj;

    RETURN total;
END$$

DELIMITER ;

-- Testando a função acima
SELECT qtd_produtos_farmacia('12345678000199') AS total_em_estoque;

-- trigger: impedir quantidade negativa (BEFORE INSERT)
DELIMITER $$

CREATE TRIGGER trg_before_insert_produto
BEFORE INSERT ON produto
FOR EACH ROW
BEGIN
   IF NEW.quantproduto < 0 THEN
       SET NEW.quantproduto = 0;
    END IF;
END$$

DELIMITER ;

-- Tentando inserir um valor negativo
INSERT INTO produto (quantproduto, valorproduto, cnpj_farmacia)
VALUES (-10, 20.00, '12345678000199');

-- Trigger: impedir valores negativos (BEFORE UPDATE)
DELIMITER $$

CREATE TRIGGER trg_before_update_produto
BEFORE UPDATE ON produto
FOR EACH ROW
BEGIN
   IF NEW.valorproduto < 0 THEN
       SET NEW.valorproduto = OLD.valorproduto;
    END IF;
END$$

DELIMITER ;

-- testando o codigo acima
UPDATE produto
SET valorproduto = -25.00
WHERE codproduto = 1;

-- View: farmacia + produto
CREATE VIEW vw_farmacia_produto AS
SELECT 
    f.nomefarmacia,
    f.cidade,
    p.codproduto,
    p.quantproduto,
    p.valorproduto
FROM farmacia f
INNER JOIN produto p
ON f.cnpj = p.cnpj_farmacia;

-- Testando o código acima
SELECT * FROM vw_farmacia_produto;

-- View: farmacia + farmacêutico
CREATE VIEW vw_farmaceutico_farmacia AS
SELECT 
    fa.nomefarmacia,
    fa.cidade,
    fm.nomefarmaceutico
FROM farmacia fa
INNER JOIN farmaceutico fm
ON fa.cnpj = fm.cnpj_farmacia;

-- Criando nova view
CREATE VIEW vw_produtos_caros AS
SELECT *
FROM produto
WHERE valorproduto > 30;


