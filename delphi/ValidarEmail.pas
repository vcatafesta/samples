Function ValidarEmail(Email: String): Boolean;
Function CountInText(Find, Text: String): Integer;
Function QtdeCaracter(cLetra, Texto: String): Integer;
Function Ocorrencias(TextoProcurado, Texto: String): integer;

Implementation

{$R *.dfm}

Function Ocorrencias(TextoProcurado, Texto: String): integer;
Var
  posicao: integer;
Begin
  result  := 0;
  posicao := PosEx(TextoProcurado, Texto, 1);
  While posicao > 0 Do
  Begin
    inc(result);
    posicao := PosEx(TextoProcurado, Texto, posicao + length(TextoProcurado));
  End;
End;

Function QtdeCaracter(cLetra, Texto: String): Integer;
Var
  i: Integer;
Begin
  Result := 0;
  Texto  := Trim(Texto);
  For i  := 1 To Length(Texto) Do
  Begin
    If Texto[i] = cLetra Then
      Result := Result + 1;
  End;
End;

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
