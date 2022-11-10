Create or replace Function CalcDobro (p1 in number) return number 
  as
    p2 number;
 BEGIN
    p2 := p1* 2;
    Return p2;
 END;

SELECT CODPRODUTO, CalcDobro(valor_unit) from tb_produto;

Create or replace Function  
          Fn_devolve_descricao(pcodprod  TB_produto.codproduto%type)
return varchar2
as
Vdesc TB_produto.descricao%type;
Begin
    Select descricao into vdesc
    From TB_produto
    Where TB_produto.codproduto = pcodprod;
    Return (vdesc);
End Fn_devolve_descricao;

Select numpedido, codproduto, Fn_devolve_descricao(codproduto) "Descrição"
From Tb_item_pedido;

variable resultado varchar2(20)

execute :resultado := fn_devolve_descricao (11);
print :resultado

select numpedido, codproduto,  substr(Fn_devolve_descricao(codproduto),1,15) as Descricao from Tb_item_pedido;

select * from TB_item_pedido



1-	Escreva uma função FN_verHora que receba como parâmetro uma data no formato dd/mm/yyyy e devolva-a no formato dd/mm/yyyy:HH24:mi:ss.

create or replace function FN_verHora (pdata date)
  return varchar2
  as
    V_data varchar2(30);
Begin
  select to_char(pdata, 'dd/mm/yyyy:HH24:mi:ss') into V_data from dual;
  return (V_data);
End FN_verHora;

variable resultado varchar2(30);

execute :resultado := FN_verHora ('10/11/2022')
print :resultado;

2-	Escreva uma função que receba como parâmetro um código de Paciente (modelo Paciente-consulta) e devolva “IDOSO” se o paciente tiver mais de 65 anos. Caso contrário devolva “NÃO IDOSO”.

create or replace function FN_faseVida (pcodPaciente number)
return varchar2
as 
  V_fase varchar2(30);
  V_idade number;
Begin
  select (sysdate - datanasc)/365 into V_idade from paciente
  where codpaciente = pcodpaciente;
  if V_idade > 65 then
    V_fase := 'Idoso';
  else
    V_fase := 'Não idoso';
  end if;
  return (V_fase);
End FN_faseVida;

select * from paciente;

variable retornaIdoso varchar2(30);

execute :retornaIdoso := Fn_FaseVida (4)
print :retornaIdoso;