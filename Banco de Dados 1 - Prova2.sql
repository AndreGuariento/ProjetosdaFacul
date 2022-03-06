1)
CREATE TABLE tipo
(codigo serial NOT NULL,
 nome varchar(75) NOT NULL,
 idade_minima int,
 primary key (codigo));
 
CREATE TABLE jogador
(codigo serial NOT NULL,
 nome varchar(75) NOT NULL,
 cpf varchar(11) UNIQUE NOT NULL,
 salario numeric(10,2),
 data_cadastro date,
 primary key (codigo));
 
CREATE TABLE jogo
(codigo serial NOT NULL,
 nome varchar(75) NOT NULL,
 data_lancamento date,
 preco numeric(10,2),
 codigo_tipo int,
 primary key (codigo),
 foreign key (codigo_tipo) references tipo(codigo));
 
CREATE TABLE jogador_jogo
(codigo_jogador int,
 codigo_jogo int,
 nivel varchar(40) NOT NULL,
 primary key (codigo_jogador, codigo_jogo),
 foreign key (codigo_jogador) references jogador(codigo),
 foreign key (codigo_jogo) references jogo(codigo));
 
 2)
 insert into tipo(nome, idade_minima)
 values('Clássico', 3);
 insert into tipo(nome, idade_minima)
 values('Ação', 10);
 insert into tipo(nome, idade_minima)
 values('Aventura', 10);
 insert into tipo(nome, idade_minima)
 values('Tiro', 17);
 
 insert into jogador(nome, cpf, salario, data_cadastro)
 values('Bruno', '54546775895', 3000.00, '03/06/2020');
 insert into jogador(nome, cpf, salario, data_cadastro)
 values('Amanda','75634692159', 3700.00, '30/11/2019');
 insert into jogador(nome, cpf, salario, data_cadastro)
 values('Victor','76894137659', 1500.00, '10/07/2005');
 insert into jogador(nome, cpf, salario, data_cadastro)
 values('Bazi', '46578551978', 9000.00, '02/06/2017');
 
 insert into jogo(nome, data_lancamento, preco, codigo_tipo)
 values('Sonic The Hedgehog', '23/06/1991', 50.00, 1);
 insert into jogo(nome, data_lancamento, preco, codigo_tipo)
 values('Tetris', '06/06/1984', 45.00, 1);
 insert into jogo(nome, data_lancamento, preco, codigo_tipo)
 values('Team Fortress 2', '10/10/2007', 0.00, 4);
 insert into jogo(nome, data_lancamento, preco, codigo_tipo)
 values('Where in the World is Carmen Sandiego?', '23/04/1985', 30.00, 3);
 
 insert into jogador_jogo(codigo_jogador, codigo_jogo, nivel)
 values(1, 2, 10);
 insert into jogador_jogo(codigo_jogador, codigo_jogo, nivel)
 values(2, 2, 50);
 insert into jogador_jogo(codigo_jogador, codigo_jogo, nivel)
 values(3, 1, 70);
 insert into jogador_jogo(codigo_jogador, codigo_jogo, nivel)
 values(4, 3, 100);
 
 3)
 select joga.nome, joga.salario, jog.nome, jogjoga.nivel, tp.nome
 from jogador joga join jogador_jogo jogjoga on jogjoga.codigo_jogador = joga.codigo join jogo jog on jogjoga.codigo_jogo = jog.codigo join tipo tp on jog.codigo_tipo = tp.codigo
 where joga.nome like '%t%' and joga.salario between 1000.00 and 4000.00;
 
 4)
 select count(*) as jogadores_tetris
 from jogador_jogo jogjoga
 where jogjoga.codigo_jogo = '2';
 
 5)
 select trunc(AVG(tp.idade_minima), 2) as mediaJogos
 from tipo tp;
 
 6)
 select jog.nome
 from jogo jog join tipo tp on jog.codigo_tipo = tp.codigo
 where jog.nome like '_____s' and tp.codigo = 1;
 
 7)
 select SUM(tp.idade_minima) as somaidademinima
 from tipo tp
 where tp.nome = 'Clássico' or tp.nome = 'Ação' or tp.nome = 'Aventura';
 
 8)
 select joga.nome, joga.cpf, joga.data_cadastro, joga.salario
 from jogador joga join jogador_jogo jogjoga on jogjoga.codigo_jogador = joga.codigo join jogo jog on jogjoga.codigo_jogo = jog.codigo
 where joga.data_cadastro > '31/12/2018' and joga.salario < 4000 and jog.codigo = 2
 order by joga.data_cadastro;
 