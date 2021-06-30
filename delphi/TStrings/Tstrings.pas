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

Procedure TForm1.AddComboBox;
Var
  s: String;
Begin
  sListMeses          := TStringList.Create;
  ComboBox1.Items     := sListMeses;
  ComboBox1.ItemIndex := 0;
End;

Procedure TForm1.FormDestroy(Sender: TObject);
Begin
  sListMeses.Free;
End;
