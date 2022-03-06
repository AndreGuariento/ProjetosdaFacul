3)
create table vacina(
	codigo serial not null,
	nome varchar(35) not null,
	preco numeric(10,2) not null,
	data_criacao date not null,
	doenca varchar(40) not null
);
4)
insert into vacina(nome, preco, data_criacao, doenca)
values('Dupla Viral', '120', '23/08/2001', 'Sarampo');
insert into vacina(nome, preco, data_criacao, doenca)
values('Pfizer', '210', '27/11/2020', 'Covid-19');
insert into vacina(nome, preco, data_criacao, doenca)
values('Dengvaxia', '180', '12/05/2016', 'Dengue');
insert into vacina(nome, preco, data_criacao, doenca)
values('Influvac', '130', '14/09/1991', 'Gripe');

5)
select *
from vacina cl
where cl.preco < 250 and cl.doenca = 'Covid-19';

6)
select cl.nome, cl.preco, cl.data_criacao, cl.doenca
from vacina cl;

7)
select cl.nome
from vacina cl
where cl.doenca = 'Gripe';

8)
update vacina
set nome = 'Tríplice Viral', preco = preco * 1.25
where doenca = 'Sarampo';

9)
delete from vacina
where doenca = 'Covid-19';

10)
alter table vacina
rename column preco to preco_venda;




