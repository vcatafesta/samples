type
  TEdit = class(Vcl.StdCtrls.TEdit)
  private
    lbl         : TLabel;
    FOnlyNumbers: boolean;
    FColorFocus : TColor;
    procedure SetColorFocus(const Value: TColor);
    procedure SetOnlyNumbers(const Value: boolean);
    function IsEmpty: boolean;
    function reverse: string;
    function ToOnlyNumbers: String;
  Protected
    { Protected declarations }
    Procedure DoEnter; Override;
    Procedure DoExit; Override;
    Procedure KeyPress(Var Key: Char); Override;
    Procedure Clear; override;
  public
    Constructor Create(AOwner: TComponent); override;
  Published
    { Published declarations }
    Property ColorFocus : TColor read FColorFocus write SetColorFocus;
    Property OnlyNumbers: boolean read FOnlyNumbers write SetOnlyNumbers;
  end;
  
  { TEdit }

procedure TEdit.Clear;
begin
  begin
    if NumbersOnly then
      Text := StringOfChar('0', MaxLength)
    else
      Text := StringOfChar('X', MaxLength);
  end;
  inherited;
end;

constructor TEdit.Create(AOwner: TComponent);
begin
  inherited;
  lbl          := TLabel.Create(Self);
  lbl.parent   := Self;
  FColorFocus  := clInfoBk;
  FOnlyNumbers := true;
End;

procedure TEdit.DoEnter;
begin
  inherited;
  Color := FColorFocus;
end;

procedure TEdit.DoExit;
begin
  inherited;
  Color := clWindow;
end;

function TEdit.IsEmpty: boolean;
begin
  result := Trim(Self.Text) = EmptyStr;
end;

procedure TEdit.KeyPress(var Key: Char);
Var
  i: integer;
Begin
  If FOnlyNumbers Then
  Begin
    For i := Low(Keys) To High(Keys) Do
    Begin
      If Keys[i] = Key Then
        exit;
    End;
    Key := #0;
    Inherited;
  End;
End;

function TEdit.reverse: string;
var
  x: integer;
begin
  for x    := High(Self.Text) downto 1 do
    result := result + copy(Self.Text, x, 1);
end;

procedure TEdit.SetColorFocus(const Value: TColor);
begin
  FColorFocus := Value;
end;

procedure TEdit.SetOnlyNumbers(const Value: boolean);
begin
  FOnlyNumbers := Value;
end;

function TEdit.ToOnlyNumbers: String;
var
  x: integer;
begin
  for x := 1 to Length(Self.Text) do
    if (copy(Self.Text, x, 1) >= '0') and (copy(Self.Text, x, 1) <= '9') then
      result := result + copy(Self.Text, x, 1);
end;
