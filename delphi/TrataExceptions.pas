Unit uTrataExceptions;

Interface

Uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Dialogs;

Type
  TException = Class
  Private
    FLogFile: String;
  Public
    Constructor Create;
    Procedure TrataException(Sender: TObject; E: Exception);
    Procedure GravarLog(Value: String);
  End;

Implementation


{ TException }

Constructor TException.Create;
Begin
  FLogFile                := ChangeFileExt(ParamStr(0), '.log');
  Application.OnException := TrataException;
End;

Procedure TException.GravarLog(Value: String);
Var
  txtLog: TextFile;
Begin
  AssignFile(txtLog, FLogFile);
  If FileExists(FLogFile) Then
    Append(txtLog)
  Else
    Rewrite(txtLog);
  Writeln(txtLog, FormatDateTime('dd/mm/YY hh:nn:ss - ', Now) + Value);
  Close(txtLog);
End;

Procedure TException.TrataException(Sender: TObject; E: Exception);
Begin
  GravarLog('===========================================================================');
  If TComponent(Sender) Is TForm Then
    Begin
      GravarLog('Form   : ' + TForm(Sender).Name);
      GravarLog('Caption: ' + TForm(Sender).Caption);
      GravarLog('Erro   : ' + E.ClassName);
      GravarLog('Erro   : ' + E.Message);
    End
  Else
    Begin
      GravarLog('Form   : ' + TForm(TComponent(Sender).Owner).Name);
      GravarLog('Caption: ' + TForm(TComponent(Sender).Owner).Caption);
      GravarLog('Erro   : ' + E.ClassName);
      GravarLog('Erro   : ' + E.Message);
    End;
  GravarLog('===========================================================================');
  ShowMessage(E.Message);
End;

Var
  MyException: TException;

Initialization

MyException := TException.Create;

Finalization

MyException.Free;

End.
