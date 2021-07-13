Function ContarOcorrencias(AWord, AText: String): Integer;
Var
  APos     : Integer;
  AWordFind: String;
Begin
  Result := 0;

  // enquanto o texto tiver texto verifica
  While AText <> '' Do
  Begin
    // procuro espaços o próximo espaço " "
    APos := Pos(' ', AText);
    If (APos > 0) Then
    Begin
      // pego a palavra e apago-a da variável AText
      AWordFind := Trim(AnsiMidStr(AText, 1, APos - 1));
      Delete(AText, 1, APos);
    End
    // quando não encontramos mais " " então pegamos o resto do texto
    Else
      AWordFind := AText;

    If AWordFind = AWord Then
      Result := Result + 1;
  End;
End;

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


