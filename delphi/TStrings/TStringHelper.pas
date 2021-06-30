Type
  TStringsHelper = Class
    Class Function SetArray(Strings: TStrings; Items: Array Of String): TStrings;
    Class Function AddArray(Strings: TStrings; Items: Array Of String): TStrings;
  End;

Var
  aMeses: Array [0 .. 11] Of String = (
    'JANEIRO',
    'FEVEREIRO',
    'MARÇO',
    'ABRIL',
    'MAIO',
    'JUNHO',
    'JULHO',
    'AGOSTO',
    'SETEMBRO',
    'OUTUBRO',
    'NOVEMBRO',
    'DEZEMBRO'
  );
  sListMeses: TStrings;
  List      : TStrings;

Procedure TForm1.FormDestroy(Sender: TObject);
Begin
  sListMeses.Free;
End;

Procedure TForm1.AddComboBox;
Var
  s: String;
Begin
  sListMeses := TStringList.Create;
  For s In aMeses Do
    sListMeses.Add(s);
  cmbMeses.Items     := sListMeses;
  cmbMeses.ItemIndex := 0;
End;

Procedure TForm1.AddComboBoxSample1;
Begin
  TStringsHelper.SetArray(cmbMeses.Items, aMeses);
  TStringsHelper.AddArray(cmbMeses.Items, aMeses);
End;

Procedure TForm1.AddComboBoxSample2;
Begin
  TStringsHelper.SetArray(cmbMeses.Items, ['JAN', 'FEV']);
  TStringsHelper.AddArray(cmbMeses.Items, ['JAN', 'FEV']);
End;

{ TStringsHelper }

Class Function TStringsHelper.AddArray(Strings: TStrings; Items: Array Of String): TStrings;
Var
  I: Integer;
Begin
  { Strings.Clear; }
  For I := 0 To Length(Items) - 1 Do
    Strings.Add(Items[I]);
  Result := Strings;
End;

Class Function TStringsHelper.SetArray(Strings: TStrings; Items: Array Of String): TStrings;
Var
  I: Integer;
Begin
  Strings.Clear;
  For I := 0 To Length(Items) - 1 Do
    Strings.Add(Items[I]);
  Result := Strings;
End;
