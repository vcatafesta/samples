procedure TForm1.dadosMemoria1;
var
  qryTemp: TQuery; //declara a classe TQuery para o objeto qryTemp.
  vSNomeCliente: String;
begin
  //cria o objeto TQuery.
  qryTemp := TQuery.Create(nil);
  with qryTemp do
  begin
    //Nome da conexão.
    DatabaseName := ''''nomeConexao'''';
    Close;
    Sql.Clear;
    //Consulta simples no banco de dados que retorna o cliente de código 1.
    Sql.Add(''''Select *'''');
    Sql.Add(''''From clientes'''');
    Sql.Add(''''Where cliCodigo = :codigo'''');
    ParamByName(''''codigo'''').AsInteger := 1;
    if not Prepared then
      Prepare;
    Open;
  end;
  //A variável do tipo string recebe o campo nome do banco de dados.
  vSNomeCliente := qryTemp.FieldByName(''''cliNome'''').AsString;
  //Limpa a query que estava em memória.
  qryTemp.Free;
end;

Update no Banco de Dados com Query em Memória
(O exemplo está sendo baseado em conexão via BDE):

procedure TForm1.dadosMemoria2;
var
  qryTemp: TQuery; //declara a classe TQuery para o objeto qryTemp.
begin
  //cria o objeto TQuery.
  qryTemp := TQuery.Create(nil);
  with qryTemp do
  begin
    //Nome da conexão.
    DatabaseName := ''''nomeConexao'''';
    Close;
    Sql.Clear;
    //Update simples no banco de dados que define o nome Teste para o cliente de código 1.
    Sql.Add(''''Update clientes'''');
    Sql.Add(''''Set cliNome = :nome'''');
    Sql.Add(''''Where cliCodigo = :codigo'''');
    ParamByName(''''nome'''').AsString := ''''Teste'''';
    ParamByName(''''codigo'''').AsInteger := 1;
    ExecSql;
  end;
  //Limpa a query que estava em memória.
  qryTemp.Free;
end;
