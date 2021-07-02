procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = vkReturn) or (Key = vkDown) then
    SelectNext(Screen.ActiveControl, true, true);
  if (Key = vkUp) then
    SelectNext(Screen.ActiveControl, false, true);
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Enter(#13);
end;

procedure TForm1.Enter(tecla: Char);
begin
  if tecla = #13 then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    tecla := #0;
  end;
end;
