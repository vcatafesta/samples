Var
  MyEdit: TEdit;
Begin
  MyEdit := TEdit.Create(Self);
  With MyEdit Do
  Begin
    Top    := 48;
    Left   := 296;
    Width  := 200;
    Height := 21;
    Text   := 'Teste ';
    Color  := clYellow;
    Parent := Form1;
  End;
  Application.ProcessMessages;
End;
