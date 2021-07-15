Unit interceptors;

Interface

Uses
  Vcl.StdCtrls,
  Vcl.DBCtrls,
  System.UITypes,
  System.Types,
  System.Classes,
  Vcl.Controls,
  Winapi.Windows,
  Winapi.Messages,
  Vcl.Graphics,
  Vcl.Forms,
  System.SysUtils,
  Dialogs,
  IniFiles,
  WinSock,
  Vcl.ExtCtrls,
  QDSEdit,
  QDSLabeledEdit,
  QDSMaskEdit,
  Vcl.Mask;

Type
  TDBEdit = Class(Vcl.DBCtrls.TDBEdit)
  Private
    lbl         : TLabel;
    FOnlyNumbers: boolean;
    FColorFocus : TColor;
    Procedure SetColorFocus(Const Value: TColor);
    Procedure SetOnlyNumbers(Const Value: boolean);
    Function reverse: String;
    Function ToOnlyNumbers: String;
    Function GetEmpty: boolean;
  Protected
    Procedure DoEnter; Override;
    Procedure DoExit; Override;
    Procedure KeyPress(Var Key: Char); Override;
    Procedure Loaded; Override;
  Public
    Constructor Create(AOwner: TComponent); Override;
    Procedure Clear; Override;
  Published
    Property ColorFocus : TColor Read FColorFocus Write SetColorFocus;
    Property OnlyNumbers: boolean Read FOnlyNumbers Write SetOnlyNumbers;
    Property IsEmpty    : boolean Read GetEmpty;
  End;

Type
  TEdit = Class(Vcl.StdCtrls.TEdit)
  Private
    lbl         : TLabel;
    FOnlyNumbers: boolean;
    FColorFocus : TColor;
    Procedure SetColorFocus(Const Value: TColor);
    Procedure SetOnlyNumbers(Const Value: boolean);
    Function IsEmpty: boolean;
    Function reverse: String;
    Function ToOnlyNumbers: String;
  Protected
    { Protected declarations }
    Procedure DoEnter; Override;
    Procedure DoExit; Override;
    Procedure KeyPress(Var Key: Char); Override;
    Procedure Loaded; Override;
  Public
    Constructor Create(AOwner: TComponent); Override;
    Procedure Clear; Override;
  Published
    { Published declarations }
    Property ColorFocus : TColor Read FColorFocus Write SetColorFocus;
    Property OnlyNumbers: boolean Read FOnlyNumbers Write SetOnlyNumbers;
  End;

Type
  TDoubleHelper = Record Helper For
    double
    Function ValorMonetario: String;
  End;

Var
  Keys: Array [0 .. 14] Of Char = (
    #08,
    #48,
    #49,
    #50,
    #51,
    #52,
    #53,
    #54,
    #55,
    #56,
    #57,
    #58,
    #59,
    #60,
    #61
  );
  Aano: Array [1 .. 12] Of String = (
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

Procedure InsereEnter(form: Tform; tecla: Char);
Procedure DrawControl(Control: TWinControl);
Procedure Erro(Text: String);
Procedure Info(Text: String);
Function ExtractName(Const Filename: String): String;
Function GetIpMachine: String;
Function LoginUsuario: boolean;
Function ValidateInput(Const Values: Array Of String): boolean;
Procedure ValidarCampos(Form: TForm);
Procedure ValidarCamposObrigatorios(Form: TForm);
Procedure ValidarFields(Form: TForm);

Implementation

Procedure ValidarFields(Form: TForm);
Var
  i           : Integer;
  Control     : TControl;
  ClassRef    : TClass;
  clColorAnt  : TColor;
  clColorAviso: TColor;
Begin
  clColorAviso := clRed;
  For i        := 0 To Form.ControlCount - 1 Do
    Begin
      Control := Form.Controls[i];
      Case Control.Tag Of
        5:
          Begin
            If (Control Is TEdit) And ((Control As TEdit).Text = EmptyStr) Then
              Begin
                clColorAnt                    := (Control As TEdit).ColorFocus;
                (Control As TEdit).ColorFocus := clColorAviso;
                (Control As TEdit).SetFocus;
                Erro('Campo obrigatório: ' + #13#10 + ((Control As TEdit).Hint));
                (Control As TEdit).ColorFocus := clColorAnt;
                Abort;
              End
            Else If (Control Is TQDSEdit) And ((Control As TQDSEdit).Text = EmptyStr) Then
              Begin
                clColorAnt                       := (Control As TQDSEdit).ColorFocus;
                (Control As TQDSEdit).ColorFocus := clColorAviso;
                (Control As TQDSEdit).SetFocus;
                Erro('Campo obrigatório: ' + #13#10 + ((Control As TQDSEdit).Hint));
                (Control As TQDSEdit).ColorFocus := clColorAnt;
                Abort;
              End
            Else If (Control Is TDBEdit) And ((Control As TDBEdit).Text = EmptyStr) Then
              Begin
                clColorAnt                      := (Control As TDBEdit).ColorFocus;
                (Control As TDBEdit).ColorFocus := clColorAviso;
                (Control As TDBEdit).SetFocus;
                Erro('Campo obrigatório: ' + #13#10 + ((Control As TDBEdit).Hint));
                (Control As TDBEdit).ColorFocus := clColorAnt;
                Abort;
              End
            Else If (Control Is TQDSMaskEdit) And ((Control As TQDSMaskEdit).Text = EmptyStr) Then
              Begin
                clColorAnt                           := (Control As TQDSMaskEdit).ColorFocus;
                (Control As TQDSMaskEdit).ColorFocus := clColorAviso;
                (Control As TQDSMaskEdit).SetFocus;
                Erro('Campo obrigatório: ' + #13#10 + ((Control As TQDSMaskEdit).Hint));
                (Control As TQDSMaskEdit).ColorFocus := clColorAnt;
                Abort;
              End
            Else If (Control Is TQDSLabeledEdit) And ((Control As TQDSLabeledEdit).Text = EmptyStr) Then
              Begin
                clColorAnt                              := (Control As TQDSLabeledEdit).ColorFocus;
                (Control As TQDSLabeledEdit).ColorFocus := clColorAviso;
                (Control As TQDSLabeledEdit).SetFocus;
                Erro('Campo obrigatório: ' + #13#10 + ((Control As TQDSLabeledEdit).Hint));
                (Control As TQDSLabeledEdit).ColorFocus := clColorAnt;
                Abort;
              End;
          End;
      End;
    End;
End;

Procedure ValidarCamposObrigatorios(Form: TForm);
Var
  List1  : Tlist; // controls list
  i      : Integer;
  Control: TWinControl;
Begin
  List1 := TList.Create;         // creates the list
  Form.GetTabControlList(List1); // adds the controls

  For i := 0 To List1.Count - 1 Do
    Begin
      Control := TWinControl(List1[i]);
      Case Control.Tag Of
        5:
          Begin
            If (Control Is TEdit) Then
              If ((Control As TEdit).Text = '') Then
                Begin
                  Erro('Falta preencheer o campo: ' + #13#10 + ((Control As TEdit).Hint));
                  (Control As TEdit).SetFocus;
                  Abort;
                End;
          End;
      End;
    End;
End;

Procedure ValidarCampos(Form: TForm);
Var
  i: Integer;
Begin
  For i := 0 To Form.ComponentCount - 1 Do
    Begin
      If Form.Components[i].Tag <> 0 Then
        Begin
          If Form.Components[i] Is TQDSLabeledEdit Then
            Begin
              // If ((Form.Components[i] As TQDSLabeledEdit).Hint <> '') Then
              If ((Form.Components[i] As TQDSLabeledEdit).Text = '') Then
                Begin
                  Erro('Falta preencheer o campo: ' + #13#10 + (Form.Components[i] As TQDSLabeledEdit).Hint);
                  (Form.Components[i] As TQDSLabeledEdit).SetFocus;
                  Abort;
                End;
            End
          Else If Form.Components[i] Is TEdit Then
            Begin
              // If ((Form.Components[i] As TEdit).Hint <> '') Then
              If ((Form.Components[i] As TEdit).Text = '') Then
                Begin
                  Erro('Falta preencheer o campo: ' + #13#10 + (Form.Components[i] As TEdit).Hint);
                  (Form.Components[i] As TEdit).SetFocus;
                  Abort;
                End;
            End;
        End;
    End;
End;

Function LoginUsuario: boolean;
Var
  Values: TArray<String>;
Begin
  SetLength(Values, 2);
  If InputQuery('Entre com usuario e senha', ['Usuario', #0'Senha'], Values, ValidateInput) Then
    result := True
  Else
    result := False;
End;

Function ValidateInput(
  Const
  Values:
  Array Of String): boolean;
Begin
  result := SameText(Values[0], 'admin') And SameStr(Values[1], 'admin');
  If Not result Then
    ShowMessage('Falha na autenticação.' + #13#10 + 'Usuario ou senha inválido');

End;

Function GetIpMachine: String;
Var
  wsaData: TWSAData;
Begin
  WSAStartup(257, wsaData);
  result := Trim(inet_ntoa(PInAddr(gethostbyname(Nil)^.h_addr_list^)^));
End;

Function ExtractName(
  Const
  Filename:
  String): String;
{ Retorna o nome do Arquivo sem extensão }
Var
  aExt: String;
  aPos: Integer;
Begin
  aExt   := ExtractFileExt(Filename);
  result := ExtractFileName(Filename);
  If aExt <> '' Then
    Begin
      aPos := Pos(aExt, result);
      If aPos > 0 Then
        Begin
          Delete(result, aPos, Length(aExt));
        End;
    End;
End;

Procedure Erro(Text: String);
Begin
  Application.MessageBox(Pchar(Text), ' Erro ', mb_OK + mb_iconHand);
End;

Procedure Info(Text: String);
Begin
  Application.MessageBox(Pchar(Text), ' Informação ', mb_OK + mb_iconinformation);
End;

Procedure InsereEnter(form: Tform;
  tecla:
  Char);
Begin
  If tecla = #13 Then
    Begin
      form.Perform(WM_NextDlgCtl, 0, 0);
      tecla := #0;
    End;
End;

Procedure DrawControl(Control: TWinControl);
Var
  R  : TRect;
  Rgn: HRGN;
Begin
  With Control Do
    Begin
      R   := ClientRect;
      Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 10, 10);
      Perform(EM_GETRECT, 0, lParam(@R));
      InflateRect(R, - 4, - 4);
      Perform(EM_SETRECTNP, 0, lParam(@R));
      SetWindowRgn(Handle, Rgn, True);
      Invalidate;
    End;
End;

{ TDBEdit }

Procedure TDBEdit.Clear;
Begin

  Begin
    If NumbersOnly Then
      Text := StringOfChar('0', MaxLength)
    Else
      Text := StringOfChar('X', MaxLength);
  End;
  Inherited;
End;

Constructor TDBEdit.Create(AOwner: TComponent);
Begin
  Inherited;
  lbl          := TLabel.Create(Self);
  lbl.parent   := Self;
  FColorFocus  := clInfoBk;
  FOnlyNumbers := False;
End;

Procedure TDBEdit.DoEnter;
Begin
  Inherited;
  Color := FColorFocus;
End;

Procedure TDBEdit.DoExit;
Begin
  Inherited;
  Color := clWindow;
End;

Function TDBEdit.GetEmpty: boolean;
Begin
  result := Text = '';
End;

Procedure TDBEdit.KeyPress(
  Var
  Key:
  Char);
Var
  i: Integer;
Begin
  If FOnlyNumbers Then
    Begin
      For i := Low(Keys) To High(Keys) Do
        Begin
          If Keys[i] = Key Then
            exit;
        End;
      Key := #0;
    End;
  Inherited;
End;

Procedure TDBEdit.Loaded;
Begin
  Inherited;
  Self.font.name  := 'Segoe UI';
  Self.font.Size  := 10;
  Self.font.Style := [fsBold];
End;

Function TDBEdit.reverse: String;
Var
  x: Integer;
Begin
  For x    := Length(Self.Text) Downto 1 Do
    result := result + copy(Self.Text, x, 1);
End;

Procedure TDBEdit.SetColorFocus(
  Const
  Value:
  TColor);
Begin
  FColorFocus := Value;
End;

Procedure TDBEdit.SetOnlyNumbers(
  Const
  Value:
  boolean);
Begin
  FOnlyNumbers := Value;
End;

Function TDBEdit.ToOnlyNumbers: String;
Var
  x: Integer;
Begin
  For x := 1 To Length(Self.Text) Do
    If (copy(Self.Text, x, 1) >= '0') And (copy(Self.Text, x, 1) <= '9') Then
      result := result + copy(Self.Text, x, 1);
End;

{ TEdit }

Procedure TEdit.Clear;
Begin

  Begin
    If NumbersOnly Then
      Text := StringOfChar('0', MaxLength)
    Else
      Text := StringOfChar('X', MaxLength);
  End;
  Inherited;
End;

Constructor TEdit.Create(AOwner: TComponent);
Begin
  Inherited;
  lbl          := TLabel.Create(Self);
  lbl.parent   := Self;
  FColorFocus  := clInfoBk;
  FOnlyNumbers := False;
End;

Procedure TEdit.Loaded;
Begin
  Inherited;
  Self.font.name  := 'Segoe UI';
  Self.font.Size  := 10;
  Self.font.Style := [fsBold];
End;

Procedure TEdit.DoEnter;
Begin
  Inherited;
  Color := FColorFocus;
End;

Procedure TEdit.DoExit;
Begin
  Inherited;
  Color := clWindow;
End;

Function TEdit.IsEmpty: boolean;
Begin
  result := Trim(Self.Text) = EmptyStr;
End;

Procedure TEdit.KeyPress(
  Var
  Key:
  Char);
Var
  i: Integer;
Begin
  If FOnlyNumbers Then
    Begin
      For i := Low(Keys) To High(Keys) Do
        Begin
          If Keys[i] = Key Then
            exit;
        End;
      Key := #0;
    End;
  Inherited;
End;

Function TEdit.reverse: String;
Var
  x: Integer;
Begin
  For x    := Length(Self.Text) Downto 1 Do
    result := result + copy(Self.Text, x, 1);
End;

Procedure TEdit.SetColorFocus(
  Const
  Value:
  TColor);
Begin
  FColorFocus := Value;
End;

Procedure TEdit.SetOnlyNumbers(
  Const
  Value:
  boolean);
Begin
  FOnlyNumbers := Value;
End;

Function TEdit.ToOnlyNumbers: String;
Var
  x: Integer;
Begin
  For x := 1 To Length(Self.Text) Do
    If (copy(Self.Text, x, 1) >= '0') And (copy(Self.Text, x, 1) <= '9') Then
      result := result + copy(Self.Text, x, 1);
End;

{ TDoubleHelper }

Function TDoubleHelper.ValorMonetario: String;
Begin
  result := FormatFloat('R$ ###,##0.00', Self);
End;

End.
