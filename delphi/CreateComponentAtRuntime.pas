Var
  MyEdit: TEdit;
Begin
  MyEdit := TEdit.Create(Self);
  With MyEdit Do
  Begin
    Left       := 32;
    Top        := 64;
    Width      := 209;
    Height     := 21;
    Text       := 'EDIT CRIADO VIA RUNTIME';
    Color      := clYellow;
    Font.Name  := 'Segoe UI';
    Font.Size  := 10;
    Font.Style := [fsBold];
    Parent     := grp2;
  End;
  Application.ProcessMessages;
End;
