Unit Unit1;

Interface

Uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.StrUtils,
  QDSTabToEnter;

Type
  TForm1 = Class(TForm)
    TabToEnter1: TTabToEnter;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    grp1: TGroupBox;
    grp2: TGroupBox;
    Memo1: TMemo;
    Button4: TButton;
    Edit2: TEdit;
    Procedure Button1Click(Sender: TObject);
    Procedure Button2Click(Sender: TObject);
    Procedure Button3Click(Sender: TObject);
    Procedure Button4Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  Form1: TForm1;

Function ValidarEmail(Email: String): Boolean;
Function CountInText(Find, Text: String): Integer;
Function QtdeCaracter(cLetra, Texto: String): Integer;
Function Ocorrencias(TextoProcurado, Texto: String): integer;
Function ContarOcorrencias(AWord, AText: String): Integer;

Implementation

{$R *.dfm}


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

Function ValidarEmail(Email: String): Boolean;
Begin
  If (Pos(' ', Email) > 0) Or (Pos('.', Email) = 0) Or (CountInText('@', Email) <> 1) Then
    ValidarEmail := False
  Else
    ValidarEmail := True;
End;

Procedure TForm1.Button1Click(Sender: TObject);
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

Procedure TForm1.Button2Click(Sender: TObject);
Begin
  If ValidarEmail(Edit1.Text) Then
    showmessage('Válido')
  Else
    showmessage('Inválido');
End;

Procedure TForm1.Button3Click(Sender: TObject);
Var
  NewString: String;
  ClickedOK: Boolean;
Begin
  NewString := '';
  ClickedOK := InputQuery('Find', 'Letra à procurar no Edit2', NewString);
  If ClickedOK Then
  Begin
    Memo1.Lines.Add('Ocorrencias: ' + IntToStr(Ocorrencias(NewString, Edit2.Text)));
    showmessage(
      'Texto Procurado: ' +
      NewString + #13#10 + 'Ocorrencia: ' +
      IntToStr(Ocorrencias(NewString, Edit2.Text))
      );
  End;
End;

Procedure TForm1.Button4Click(Sender: TObject);
Var
  AWord, AText: String;
Begin
  AText := 'Na Quantum prioriza-se a qualidade, por isso a Quantum é a melhor.';
  AWord := 'Quantum';
  Memo1.Lines.Add('Ocorrencias: ' + IntToStr(Ocorrencias(AWord, AText)));
End;

End.
