Function ValidarEmail(Email: String): Boolean;
Function CountInText(Find, Text: String): Integer;

Implementation

{$R *.dfm}


Function CountInText(Find, Text: String): Integer;
Begin
  Result := 0;
  While (Pos(Find, Text) > 0) Do
  Begin
    Text := Copy(Text, 1, Pos(Find, Text) - 1) + Copy(Text, Pos(Find, Text) + Length(Find), Length(Text));
    Inc(Result, 1);
  End;
End;

Function ValidarEmail(Email: String): Boolean;
Begin
  If (Pos(' ', Email) > 0) Or (Pos('.', Email) = 0) Or (CountInText('@', Email) <> 1) Then
    ValidarEmail := False
  Else
    ValidarEmail := True;
End;
