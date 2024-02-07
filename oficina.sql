-- CRIAÇÃO DO BANCO DE DADOS 
create database oficina;
use oficina;  

create table cliente(
	idCliente int primary key,
    idServico int,
    nomeCliente varchar(45),
    idadeCliente int,
    cpfCliente varchar(15),
    idProduto int
);


create table servico(
	idServico int primary key,
    tipo varchar(45),
    valor int
);
alter table cliente add constraint fk_idServico foreign key (idServico) references servico(idServico);

create table produto(
	idProduto int primary key,
    nomeProduto varchar(45),
    valorProduto float,
    quantidade varchar(45)
);

 alter table cliente add constraint fk_idProduto foreign key (idProduto) references produto(idProduto);
 
 create table veiculo(
	idVeiculo int primary key,
    ano int,
    modelo varchar(20),
    marca varchar(20),
    placa varchar(15),
    cor varchar(15),
    idCliente int
 );
  alter table veiculo add constraint fk_idCliente foreign key (idCliente) references cliente (idCliente);
  
  create table funcionario(
	idFuncionario int primary key,
    idServico int,
    nomeFuncionario varchar(45),
    idadeFuncionario int,
    cpfFuncionario varchar(15),
    funcao_funcionario varchar(45)
  );
  
  alter table funcionario add constraint fk_idServicoFunc foreign key (idServico) references servico(idServico);
  
--                              INSERÇÃO DE DADOS

-- INSERÇÃO DOS DADOS DA TABELA SERVICO
insert into servico(idServico, tipo, valor) values (0,'Nenhum',0);
insert into servico(idServico, tipo, valor) values (1,'Troca de óleo',200.00);
insert into servico(idServico, tipo, valor) values (2,'Revisão',300.00);
insert into servico(idServico, tipo, valor) values (3,'Troca de filtro de ar',230.00);

-- INSERÇÃO DOS DADOS DA TABELA PRODUTO
insert into produto(idProduto, nomeProduto, valorProduto,quantidade) values (0,'Nenhum',0,0);
insert into produto(idProduto, nomeProduto, valorProduto,quantidade) values (1,'Óleo de carro',35.00,12);
insert into produto(idProduto, nomeProduto, valorProduto,quantidade) values (2,'Disco de freio dianteiro',450.00,7);
insert into produto(idProduto, nomeProduto, valorProduto,quantidade) values (3,'Lubrificante 0W20',72.00,10);

-- INSERÇÃO DOS DADOS DA TABELA CLIENTE
insert into cliente(idCliente, nomeCliente, idadeCliente, cpfCliente, idProduto, idServico) values (1, 'Silmara Silva',52,'123.456.789-00',0,1);
insert into cliente(idCliente, nomeCliente, idadeCliente, cpfCliente, idProduto, idServico) values (2, 'Edvaldo Gomes',27,'123.456.789-01',1,0);
insert into cliente(idCliente, nomeCliente, idadeCliente, cpfCliente, idProduto, idServico) values (3, 'Francisco de Oliveira',78,'123.456.789-03',0,2);
insert into cliente(idCliente, nomeCliente, idadeCliente, cpfCliente, idProduto, idServico) values (4, 'Neide de Souza',49,'123.456.789-04',3,0);
insert into cliente(idCliente, nomeCliente, idadeCliente, cpfCliente, idProduto, idServico) values (5, 'Maria Clara Ferreira',24,'123.456.789-05',0,3);

-- INSERÇÃO DE DADOS DA TABELA FUNCIONÁRIO
insert into funcionario(idFuncionario, idServico,nomeFuncionario, idadeFuncionario, cpfFuncionario, funcao_funcionario) values (1, 0,'Ricardo Menezes',36,'987.654.321-00','Gerente');
insert into funcionario(idFuncionario, idServico,nomeFuncionario, idadeFuncionario, cpfFuncionario, funcao_funcionario) values (2, 0,'Fernanda de Souza',26,'987.654.321-01','Atendente');
insert into funcionario(idFuncionario, idServico,nomeFuncionario, idadeFuncionario, cpfFuncionario, funcao_funcionario) values (3, 2,'George Lima',45,'987.654.321-02','Mecânico');
insert into funcionario(idFuncionario, idServico,nomeFuncionario, idadeFuncionario, cpfFuncionario, funcao_funcionario) values (4, 3,'Mateus Lamonato',39,'987.654.321-03','Mecânico');
insert into funcionario(idFuncionario, idServico,nomeFuncionario, idadeFuncionario, cpfFuncionario, funcao_funcionario) values (5, 1,'Bruno Faria',41,'987.654.321-04','Mecânico');

-- INSERÇÃO DE DADOS DA TABELA VEICULO
insert into veiculo(idVeiculo, ano, modelo, marca, placa, cor, idCliente) values (1,2009,'Civic','Honda','HON-2220','Azul escuro',5);
insert into veiculo(idVeiculo, ano, modelo, marca, placa, cor, idCliente) values (2,2021,'Toro','Fiat','FRG-2365','Cinza',1);
insert into veiculo(idVeiculo, ano, modelo, marca, placa, cor, idCliente) values (3,2015,'Celta','Chevrolet','CKE-2911','Branco',3);

--                 CONSULTAS

-- 1) Recuperações simples com SELECT Statement
-- Consulta dos dados pessoais dos clientes
select nomeCliente, idadeCliente, cpfCliente
from cliente;

-- 2)Filtros com WHERE Statement;
-- Selecionar apenas clientes que requisitaram algum serviço na oficina
select *
from cliente
where idServico <> 0 and idServico IS NOT NULL;

-- 3)Crie expressões para gerar atributos derivados;
-- Total do faturamento dos serviços
select SUM(valor) as soma_total_vendas
from servico; 

-- 4)Defina ordenações dos dados com ORDER BY;
-- Ordenar o nome dos clientes por ondem alfabetica
select nomeCliente
from cliente
ORDER BY nomeCliente;
 
-- 5)Condições de filtros aos grupos – HAVING Statement;
--  Conulta do valor dos produtos que custam mais de 200 reais
select produto.valorProduto as faturamento_produtos, nomeProduto
from produto
having valorProduto > 200;

-- 6)Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
-- Criação da nova tabela onde apresentara o nome do cliente, o id do servico(mecanico) que ele pediu e o funcionario que o atendeu.
select cliente.nomeCliente as nome_cliente, cliente.idServico, 
		funcionario.nomeFuncionario as nome_funcionario_vinculado
from cliente 
inner join funcionario on cliente.idServico = funcionario.idServico and cliente.idServico <> 0;

