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
