-- DROP SCHEMA producaobd;

-- Criando o banco de dados PRODUCAOBD.
CREATE DATABASE producaobd;

use producaobd

-- Criando a tabela FABRICANTE.
CREATE TABLE  Fabricante (
codfabricante SMALLINT NOT NULL,
nomefabricante VARCHAR(30) NOT NULL,
PRIMARY KEY (codfabricante));

-- Criando a tabela PRODUTO.
CREATE TABLE  Produto (
codproduto INT NOT NULL,
nomeproduto VARCHAR(30) NOT NULL,
codfabricante SMALLINT NOT NULL,
PRIMARY KEY (codproduto),
CONSTRAINT fk_Produto_Fabricante
FOREIGN KEY (codfabricante)
REFERENCES Fabricante (codfabricante));

-- Criando a tabela LOTE.
CREATE TABLE Lote (
numlote INT NOT NULL,
datavalidade DATE NOT NULL,
precounitario DECIMAL(10,2),
quantidade SMALLINT NOT NULL DEFAULT 100,
valorlote DECIMAL(10,2),
codproduto INT NOT NULL,
PRIMARY KEY (numlote),
CONSTRAINT fk_Lote_Produto
FOREIGN KEY (codproduto)
REFERENCES Produto (codproduto));

-- Inserindo registros na tabela FABRICANTE.
INSERT INTO Fabricante VALUES (1, 'Clear');
INSERT INTO Fabricante VALUES (2, 'Rexona');
INSERT INTO Fabricante VALUES (3, 'Jhonson & Jhonson');
INSERT INTO Fabricante VALUES (4, 'Coleston');

-- Inserindo registros na tabela PRODUTO.
INSERT INTO Produto VALUES (10, 'Sabonete em Barra', 2);
INSERT INTO Produto VALUES (11, 'Shampoo Anticaspa', 1);
INSERT INTO Produto VALUES (12, 'Desodorante Aerosol Neutro', 2);
INSERT INTO Produto VALUES (13, 'Sabonete Liquido', 2);
INSERT INTO Produto VALUES (14, 'Protetor Solar 30', 3);
INSERT INTO Produto VALUES (15, 'Shampoo 2 em 1', 2);
INSERT INTO Produto VALUES (16, 'Desodorante Aerosol Morango', 2);
INSERT INTO Produto VALUES (17, 'Shampoo Anticaspa', 2);
INSERT INTO Produto VALUES (18, 'Protetor Solar 60', 3);
INSERT INTO Produto VALUES (19, 'Desodorante Rollon', 1);

-- Inserindo registros na tabela LOTE.
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (100, '2028-08-05', 9.90, 500, DEFAULT, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (101, '2027-05-01', 8.47, 500, DEFAULT, 10);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (102, '2028-06-02', 11.50, 750, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (103, '2026-02-01', 12.37, 383, DEFAULT, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (104, '2027-01-01', 10.00, 400, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (105, '2026-04-07', 11.50, DEFAULT, DEFAULT, 15);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (106, '2023-06-08', 10.30, 320, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (107, '2024-10-20', 13.90, 456, DEFAULT, 12);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (108, '2026-07-20', 7.53, 750, DEFAULT, 13);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (109, '2025-05-13', 8.00, 720, DEFAULT, 11);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (110, '2027-06-05', 9.50, 860, DEFAULT, 13);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (111, '2028-03-02', 14.50, 990, DEFAULT, 14);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (112, '2028-04-05', 11.40, 430, DEFAULT, 14);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (113, '2025-06-04', 11.30, 200, DEFAULT, 12);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (114, '2027-10-06', 12.76, 380, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (115, '2028-11-06', 8.30, 420, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (116, '2027-10-20', 8.99, 361, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (117, '2024-11-15', 10.09, 713, DEFAULT, 11);

update Lote
set valorlote = quantidade * precounitario
where numlote >=100;

-- 1 Questao // Quais os lotes com data de validade para o ano de 2024.

select 
numlote,datavalidade 
from Lote 
Where datavalidade 
between '2024/01/01' and '2024/12/31';

-- 2 Questao // Quantos lotes possuem data de validade para o ano de 2025.

select numlote,COUNT(numlote) 
as Contagem2025 
from Lote 
where datavalidade 
between '2025/01/01' and '2025/12/31'
group by numlote;

-- 3 Questao // Quantos lotes existem para cada produto.

select 
p.nomeproduto as NomeProduto,
count(l.codproduto)
as NumeroLotes
from Lote l
join 
Produto p on p.codproduto = l.codproduto
group by p.nomeproduto;

-- 4 Questao // Qual o valor total de lotes de um determinado produto.

select
p.nomeproduto as NomeProduto,
count(l.codproduto)
as NumeroLotes
from Lote l
join 
Produto p on p.codproduto = l.codproduto
where l.codproduto = 18
group by p.nomeproduto;

-- 5 Questao // Criar lista ordenada de lotes por data de validade.

select * from Lote
order by datavalidade asc;

-- 6 Questao// Selecionar lotes com validade entre fevereiro de 2024 e junho de 2026.

select numlote,datavalidade 
from Lote 
Where datavalidade between '01/02/2024' and '01/06/2026'
order by datavalidade asc;

-- 7 Questao// Listar os lotes com valor de lote 
-- acima da media entre todos os valores de lote do banco.

select * from Lote where valorlote > ( select avg(valorlote) from Lote);

-- a)

INSERT INTO Fabricante VALUES (5, 'Ancora');
INSERT INTO Produto VALUES (20, 'Sabonete de Glicerina', 5);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (118, '2028-12-29', 3.78, 1223, DEFAULT, 20);

-- 8 Questao// Alterar o preco do Sabonete de Glicerina 
-- com uma reducao de 15% no preco cadastrado.

update Lote
set precounitario = 3.78 - (0.15*3.78) 
where numlote = 118;

update Lote
set valorlote = precounitario * quantidade
where numlote >= 100;

select * from Lote;

-- 9 Questao// Excluir o Shampoo Anticaspa da Rexona.

delete from Lote 
where codproduto = 17;

select * from Lote;

delete from Produto
where nomeproduto = 'Shampoo Anticaspa' 
and 
codfabricante = 2;

select * from Produto;

-- 11 Questao // Altere a tabela para inserir a coluna statuslote

ALTER TABLE Lote
ADD statuslote VARCHAR(9) NOT NULL DEFAULT 'Analise';

-- 12 Questao // Alterar o status dos lotes de acordo com a tabela informada

update Lote
set statuslote = 'Recall'
where numlote = 107 
or numlote = 108 
or numlote = 116;

update Lote
set statuslote = 'Liberado'
where numlote = 113 
or numlote =117 
or numlote =112 
or numlote = 109 
or numlote = 114;

select * from Lote
where numlote = 113 
or numlote =117 
or numlote =112 
or numlote = 109 
or numlote = 114 
or numlote = 107 
or numlote = 108 
or numlote = 116;

-- 13 Questao // Criar uma lista com a quantidade de lots que estão classificados com cada um dos status diferentes

select 
statuslote as Nome_Status, 
count(statuslote) as Quantidade 
from Lote
group by statuslote;

-- 14 Questao // Apresentar uma Lista com as quantidades de produtos fornecidos por cada fabricante

select
f.nomefabricante as NomeFabricante,
sum(l.quantidade) as TotalQuantidade
from
Fabricante f
join
Produto p on p.codfabricante = f.codfabricante
join
Lote l on l.codproduto = p.codproduto
group by
f.nomefabricante;

-- Inserindo mais 10 registros na tabela Fabricante
INSERT INTO Fabricante VALUES (6, 'Olay');
INSERT INTO Fabricante VALUES (7, 'Maybelline');
INSERT INTO Fabricante VALUES (8, 'Avène');
INSERT INTO Fabricante VALUES (9, 'Garnier');
INSERT INTO Fabricante VALUES (10, 'Vichy');
INSERT INTO Fabricante VALUES (11, 'Pantene');
INSERT INTO Fabricante VALUES (12, 'Nívea');
INSERT INTO Fabricante VALUES (13, 'Lancôme');
INSERT INTO Fabricante VALUES (14, 'Neutrogena');
INSERT INTO Fabricante VALUES (15, 'Dove');
INSERT INTO Fabricante VALUES (16, 'Head & Shoulders');

select * from Fabricante

-- Inserindo mais 10 registros na tabela Produto
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (21, 'Loção Hidratante', 6);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (22, 'Delineador', 6);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (23, 'Perfume Feminino', 7);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (24, 'Máscara de Cílios', 8);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (25, 'Creme Facial Noturno', 9);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (26, 'Shampoo Anti-queda', 10);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (27, 'Gloss Labial', 11);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (28, 'Desodorante Roll-On Masculino', 12);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (29, 'Enxaguante Bucal Branqueador', 13);
INSERT INTO Produto (codproduto, nomeproduto, codfabricante) 
VALUES (30, 'Creme Dental Infantil', 14);

select * from Produto

-- Inserindo mais 10 registros na tabela Lote
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (119, '2025-05-20', 15.99, 200, DEFAULT, 21);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (120, '2026-08-15', 12.50, 300, DEFAULT, 22);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (121, '2027-11-10', 45.80, 150, DEFAULT, 23);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (122, '2028-03-28', 18.75, 400, DEFAULT, 24);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (123, '2024-09-05', 25.00, 250, DEFAULT, 25);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (124, '2026-06-12', 30.50, 180, DEFAULT, 26);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (125, '2027-10-25', 8.99, 500, DEFAULT, 27);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (126, '2028-02-20', 10.75, 350, DEFAULT, 28);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (127, '2025-04-15', 5.80, 600, DEFAULT, 29);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) 
VALUES (128, '2026-11-30', 7.25, 800, DEFAULT, 30);

update Lote
set valorlote = precounitario * quantidade
where numlote >= 100;

select * from Lote


