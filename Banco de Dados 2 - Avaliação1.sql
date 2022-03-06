1)
CREATE TABLE cliente
(codigo serial not null,
nome varchar(50) not null,
cpf varchar(11) not null unique,
renda numeric(10,2),
email varchar(50) not null,
data_nascimento date,
data_cadastro timestamp,
ativo boolean,
primary key (codigo)
);

CREATE TABLE pedido
(codigo serial not null,
data date,
valor_total numeric(10,2) not null,
status varchar(50) not null,
codigo_cliente int,
primary key (codigo),
foreign key (codigo_cliente) references cliente(codigo)
);

CREATE TABLE categoria
(codigo serial not null,
nome varchar(50) not null,
primary key (codigo)
);
CREATE TABLE pizza
(codigo serial not null,
nome varchar(50) not null,
descricao varchar(50) not null,
valor numeric(10,2),
data_cadastro timestamp,
ativo boolean,
codigo_categoria int,
primary key (codigo),
foreign key (codigo_categoria) references categoria(codigo)
);

CREATE TABLE item
(codigo serial not null,
quantidade int,
codigo_pedido int,
codigo_pizza int,
primary key (codigo),
foreign key (codigo_pedido) references pedido(codigo),
foreign key (codigo_pizza) references pizza(codigo)
);

insert into cliente(nome, cpf, renda, email, data_nascimento, data_cadastro, ativo)
values ('Paulo', 25697888058, 7906.00, 'paulothebest1@gmail.com', '1998-12-23', '2006-07-16 12:40:00', '1');
insert into cliente(nome, cpf, renda, email, data_nascimento, data_cadastro, ativo)
values ('Gordon', 29545754095, 1605.00, 'theonefreeman@gmail.com', '1973-11-19', '2000-03-13 08:30:00', '0');
insert into cliente(nome, cpf, renda, email, data_nascimento, data_cadastro, ativo)
values ('Thiago', 98878990035, 2789.00, 'tiago1231@outlook.com', '2000-05-21', '2019-06-15 11:45:00', '1');

insert into pedido(data, valor_total, status, codigo_cliente)
values (current_date - 30, 90.00, 'Finalizado', 1);
insert into pedido(data, valor_total, status, codigo_cliente)
values (current_date - 17, 50.00, 'Endereço errado, não finalizado', 2);
insert into pedido(data, valor_total, status, codigo_cliente)
values (current_date - 45, 100.00, 'Finalizado', 3);

insert into categoria(nome)
values('Especialidades');
insert into categoria(nome)
values('Super Premium');
insert into categoria(nome)
values('Premium');

insert into pizza(nome, descricao, valor, data_cadastro, ativo, codigo_categoria)
values('Pepperoni', 'Uma de nossas especialidades', 30.00, '2003-11-12', '1', 1);
insert into pizza(nome, descricao, valor, data_cadastro, ativo, codigo_categoria)
values('Lombo', 'Uma das mais populares', 20.00, '2000-12-11', '1', 1);
insert into pizza(nome, descricao, valor, data_cadastro, ativo)
values('Larva de Antlion', 'Não sabemos porque vendemos isso', 25.00, '2007-10-10', '1');

insert into item(quantidade, codigo_pedido, codigo_pizza)
values(2, 2, 3);
insert into item(quantidade, codigo_pedido, codigo_pizza)
values(4, 1, 1);
insert into item(quantidade, codigo_pedido, codigo_pizza)
values(5, 3, 2);

drop table cliente, pedido, item, pizza, categoria

2)
select cli.nome as cliente_nome, extract(year from cli.data_nascimento) as ano_nascimento, ped.codigo as codigo_pedido, ped.valor_total as valor_total_pedido, to_char(ped.data,'DD/MM/YYYY') as data_pedido, piz.nome as nome_pizza, itm.quantidade as quantidade_items, cat.nome as nome_categoria
from pedido ped join cliente cli on ped.codigo_cliente = cli.codigo join item itm on itm.codigo_pedido = ped.codigo join pizza piz on itm.codigo_pizza = piz.codigo join categoria cat on piz.codigo_categoria = cat.codigo
where cli.renda not between 2500 and 3500
order by cli.nome
limit 6 offset 4;

3)
select coalesce(piz.nome, 'Sem Pizza') as pizzas, coalesce(cat.nome, 'Sem Categoria') as categorias
from pizza piz full join categoria cat on piz.codigo_categoria = cat.codigo; 

4)
select piz.nome as pizza_nome, trunc(avg(piz.valor), 2) as valor_pizza, cat.nome as nome_categoria, count(*)
from pizza piz join categoria cat on piz.codigo_categoria = cat.codigo
group by piz.nome, cat.nome
having count(*) > 2;

5)
select cli.nome as cliente_nome, ped.valor_total as valor_total_pedido
from cliente cli join pedido ped on ped.codigo_cliente = cli.codigo
where cli.renda > (select avg(cli.renda)
from cliente cli);

6)
create or replace view exercicio6(quantidade_pedidos_anuais, ano, soma_valores_totais) as
select count(*), extract(year from ped.data), trunc(sum(ped.valor_total), 2)
from pedido ped
group by extract(year from ped.data)
order by extract(year from ped.data);

select *
from exercicio6 ex6;

7)
create or replace view exercicio7(nome_cliente, renda_cliente, idade_cliente, data_cadastro_cliente, codigo_pedido, status_pedido) as
select cli.nome, cli.renda, extract(year from age(cli.data_nascimento)), to_char(cli.data_cadastro,'DD/MM/YYYY HH24:MI:SS'), ped.codigo, ped.status
from cliente cli join pedido ped on ped.codigo_cliente = cli.codigo
where extract (year from age(cli.data_nascimento)) = 21 and cli.renda < (select avg(cli.renda)
from cliente cli);

select *
from exercicio7 ex7;
