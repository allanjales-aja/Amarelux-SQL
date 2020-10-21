create database amarelux;

use amarelux;

create table produtos
(cod_produtos tinyint(5) auto_increment,
nome_prod varchar(50) not null,
descricao varchar(100) not null,
valor decimal(8,2),
valor_unit decimal(8,2),
nome_img varchar(100),
constraint valor_positivo check (valor > 0 and valor_unit > 0),
unique (nome_prod, nome_img, descricao),
primary key (cod_produtos));

insert into produtos (nome_prod, descricao, valor, valor_unit, nome_img)
values 
("geladeira TF39", "Geladeira Frost Free 310 Litros Branco Electrolux (TF39)", 2299.00, 1999.00, "imagens/produtos/Refrigerador_TF39.webp"),
("geladeira DC35A", "Geladeira Cycle Defrost 260L Branco Electrolux (DC35A)", 1869.00, 1799.00, "imagens/produtos/Refrigerador_DC35A.webp"),
("geladeira TF42S", "Geladeira Top Freezer cor Inox 382L Electrolux (TF42S)", 3129.00, 2699.00, "imagens/produtos/Refrigerador_TF42S.webp"),
("ar VI12F/VE12F", "Ar Condicionado Split 12.000 Btus Frio Linha Ecoturbo Electrolux (VI12F/VE12F)", null, null, "imagens/produtos/Ar_VI12F-VE12F.webp"),
("ar TI12R/TE12R", "Ar Condicionado Split 12.000 Btus Quente/Frio Electrolux (TI12R/TE12R)", 1709.00, 1709.00, "imagens/produtos/Ar_TI12R-TE12R.webp"),
("fogao 52LSV", "Fogão 4 Bocas Electrolux Prata Automático Mesa de Vidro e Porta Full Glass (52LSV)", 1599.00, 1499.00, "imagens/produtos/Fog%C3%A3o_52LBS.webp"),
("fogao 76LSU", "Fogão 5 Bocas Electrolux Prata Automático Ultra Chama e Vidro Removível (76LSU)", null, null, "imagens/produtos/Fog%C3%A3o_76LSU.webp"),
("lavaroupas LES09", "Lavadora de Roupas Electrolux Essential Care 8,5kg (LES09)", 1459.00, 1249.00, "imagens/produtos/LavRoupas_LES09.webp"),
("lavaroupas LES13", "Lavadora de Roupas Electrolux Essencial Care 13kg (LES13)", 1949.00, 1699.00, "imagens/produtos/LavRoupas_LES13.webp"),
("lavaloucas LV08B", "Lava-louças Electrolux Branca 8 Serviços (LV08B)", 2199.00, 2199.00, "imagens/produtos/LavLou%C3%A7as_LV08B.webp"),
("lavaloucas LE08S", "Lava-Louças Electrolux 8 Serviços Cinza (LE08S)", 2799.00, 2499.00, "imagens/produtos/LavLou%C3%A7as_LE08S.webp"),
("microondas MTD30", "Micro-Ondas Painel Seguro 20L Electrolux (MTD30)", 539.00, 499.00, "imagens/produtos/Microondas_MTD30.webp"),
("microondas MB37R", "Micro-Ondas Electrolux Branco 27L com 55 Receitas pré-programadas (MB37R)", 639.00, 589.00, "imagens/produtos/Microondas_MB37R.webp"),
("microondas MEF41", "Micro-Ondas Electrolux Meus Favoritos 31L (MEF41)", 699.00, 599.00, "imagens/produtos/Microondas_MEF41.webp");

create table clientes
(cod_clientes tinyint(5) auto_increment,
nome_cli varchar(50) not null,
endereco varchar(100) not null,
telefone bigint(12) not null,
primary key (cod_clientes, nome_cli, telefone));

insert into clientes (nome_cli, endereco, telefone)
values
("Aline", "Rua A, 01 - Recodópolis", 021111111111),
("Allan", "Rua A, 02 - Recodópolis", 021222222222),
("Jasmine", "Rua J, 01 - Recodópolis", 02133333333),
("Joellis", "Rua J, 02 - Recodópolis", 021444444444),
("Mayara", "Rua M, 01 - Recodópolis", 021555555555),
("Pablo", "Rua M, 02 - Recodópolis", 021666666666);

create table ped
(cod_pedidos tinyint(5) auto_increment,
cod_clientes tinyint(5) not null,
cod_produtos tinyint(5) not null,
quantidade tinyint(5) not null default 1,
primary key (cod_pedidos, cod_produtos),
foreign key (cod_produtos) 
references produtos (cod_produtos),
foreign key (cod_clientes) 
references clientes (cod_clientes));

insert into ped (cod_clientes, cod_produtos, quantidade)
values
(1, 3, 1),
(1, 2, 2),
(2, 5, 1),
(3, 8, 1),
(6, 12, 2),
(4, 14, 3),
(5, 1, 2);

create view pedidos as
select pe.cod_pedidos, c.nome_cli, c.endereco, c.telefone, pr.nome_prod, pr.valor_unit, pe.quantidade, (pr.valor_unit * pe.quantidade) as valor_total
from ped as pe, produtos as pr, clientes as c
where pe.cod_produtos = pr.cod_produtos and pe.cod_clientes = c.cod_clientes
order by pe.cod_pedidos;
 
