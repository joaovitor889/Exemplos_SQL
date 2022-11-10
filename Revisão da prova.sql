drop table TB_Depto;
drop table tb_projeo;
drop table tb_funcionario;
drop table tb_funcproj;

Create table TB_Depto
( codDepto   number(3) primary key,
   nomeDepto varchar2(30));

Create Table TB_Projeto
( codProjeto number(3) primary key,
  Descricao  varchar2(30));

Create table TB_Funcionario
(  codFunc   number(5)   primary key,
   nomeFunc varchar2(30),
   sexo     char(1),
   dataAdmissao date,
   codDepto number(3) references TB_Depto,
   salario   number(7,2),
   cidade    varchar2(25)
   );

Create table tb_Funcproj
   (CodFunc    number(5),
    Codprojeto number(3),
    Tempoalocacao  number(3),               
    Bonus_sal number(7,2));

insert into TB_Depto values (500,'Depto TI');
insert into TB_Depto values (510,'Depto de RH');
insert into TB_Depto values (520,'Depto de Logistica');

insert into TB_Projeto values(100,'App de Compras');
insert into TB_Projeto values(110,'Sistema de Logística');
insert into TB_Projeto values(120,'App de Recrutamento');

insert into TB_Funcionario values (1111,'Maria Silva','F','03/05/2010',510, 6000.00, 'Sorocaba');
insert into TB_Funcionario values(2222,'Antonio Paulo','M','02/09/2021',500, 2000.00, 'Sorocaba');
insert into TB_Funcionario values (3333,'Carolina Pereira','F','01/05/2016',520, 850.00, 'Itu');
insert into TB_Funcionario values (4444,'Felipe Moura','M','01/09/2021',500, 5200.00, 'Campinas');
insert into TB_Funcionario values(5555,'Carlos Augusto','M','08/05/2011',510, 4000.00, 'Sorocaba');



select * from tb_depto;
select * from tb_projeto;
select * from tb_funcionario;


1-	Chaves e inserts							
      a- A tabela TB_FuncProj possui  chaves estrangeiras e uma chave primária composta crie estas restrições usando o comando  alter table.								(0,9)
    
      alter table tb_funcproj add constraint pk_funcproj primary key (codfunc, codprojeto);
      alter table tb_funcproj add constraint fk_funcproj_codfunc foreign key (codfunc) references tb_funcionario;
      alter table tb_funcproj add constraint fk_funcproj_codprojeto foreign key (codprojeto) references tb_projeto;
      
      b-  Insira 4 registros na tabela  TB_FuncProj (insira um funcionário com 2 projetos).  	(1,0)

      insert into tb_funcproj values (1111,100,3,100.00);
      insert into tb_funcproj values (1111,120,3,100.00);
      insert into tb_funcproj values (2222,120,3,100.00);
      insert into tb_funcproj values (2222,100,3,100.00);
      insert into tb_funcproj values (5555,100,3,100.00);
      insert into tb_funcproj values (2222,110,3,100.00);

select F.codfunc, F.nomefunc, count(*)
from tb_funcionario F inner join tb_funcproj FF
on F.codfunc = FF.codfunc
group by F.codfunc, F.nomefunc
having count(*) > 2;

update tb_funcproj 
set bonus_sal = 200.00
where codprojeto = (select codprojeto from tb_projeto where descricao = 'App de Compras');

select * from tb_funcproj



insert into tb_projeto values (130,'Hacaton');

select codprojeto from tb_projeto
where not exists (select codprojeto from tb_funcproj
                  where tb_funcproj.codprojeto = tb_projeto.codprojeto);
                  
                  
select codprojeto from tb_projeto
minus
select codprojeto from tb_funcproj;