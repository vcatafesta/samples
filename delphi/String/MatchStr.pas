 Uses
 System.Strutils;

Procedure TForm1.txtMesExit(Sender: TObject);
Var
  Txt: String;
Begin
  Txt := TxtMes.Text;
  If Not MatchStr(txt, aMeses) Then
  Begin
    ShowMessage('Mês inválido.');
    TxtMes.SetFocus;
  End;
End;
