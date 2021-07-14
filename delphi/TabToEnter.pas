{
no OnCreate do form principal: opcao 1
Application.OnMessage := InsereEnter;

no OnCreate do form principal: opcao 2
Application.OnMessage := Execute;
}

Unit QDSTabToEnter;

Interface

Uses
  messages,
  System.SysUtils,
  System.Classes,
  Controls,
  StdCtrls,
  Mask,
  DbCtrls,
  Graphics,
  Forms,
  Winapi.Windows,
  Vcl.Grids,
  Vcl.Tabs,
  Vcl.Buttons;

Type
  TTabToEnter = Class(TComponent)
  Private
    FAtivo        : Boolean;
    FFormPrincipal: TComponentName;
    Procedure SetFormPrincipal(Const Value: TComponentName);
    { Private Declarations }
  Protected
    { Protected Declarations }
    Procedure CMDialogKey(Var Message: TCMDialogKey); Message CM_DIALOGKEY;
  Public
    { Public Declarations }
    Constructor Create(AOWner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure Execute(Var Msg: TMsg; Var Handled: Boolean);
    Procedure InsereEnter(Var Msg: TMsg; Var Handler: Boolean);
  Published
    { Published declarations }
    Property Ativo        : Boolean Read FAtivo Write FAtivo;
    Property FormPrincipal: TComponentName Read FFormPrincipal Write SetFormPrincipal;
  End;

Procedure Register;

Implementation

Procedure Register;
Begin
  RegisterComponents('Quantum', [TTabToEnter]);
End;

{ TTabToEnter }

Procedure TTabToEnter.CMDialogKey(Var Message: TCMDialogKey);
Begin
  If FAtivo Then
  Begin
    If (Message.CharCode = VK_RETURN) And Not (Screen.ActiveControl Is TButton) Then
      Message.CharCode := VK_TAB;
  End;
  Inherited;
End;

Constructor TTabToEnter.Create(AOWner: TComponent);
Begin
  Inherited;
End;

Destructor TTabToEnter.Destroy;
Begin
  Inherited;
End;

Procedure TTabToEnter.Execute;
Begin
  If (FAtivo) Or Not (csDesigning In ComponentState) Then
  Begin
    If Not ((Screen.ActiveControl Is TCustomMemo) Or
      (Screen.ActiveControl Is TCustomGrid) Or
      (Screen.ActiveControl Is TButton) Or
      (Screen.ActiveControl Is TBitBtn) Or
      (Screen.ActiveForm.ClassName = 'TMessageForm')) Then
      If (Msg.message = WM_KEYDOWN) Then
        Case Msg.wParam Of
          VK_RETURN, VK_DOWN:
            Screen.ActiveForm.Perform(WM_NextDlgCtl, 0, 0);
          VK_UP:
            Screen.ActiveForm.Perform(WM_NextDlgCtl, 1, 0);
        End;
  End
  Else
    Application.OnMessage := Nil;
  Inherited;
End;

Procedure TTabToEnter.InsereEnter(Var Msg: TMsg; Var Handler: Boolean);
Begin
  If (Msg.message = WM_KEYDOWN) Then
    If Not (Screen.ActiveControl Is TCustomMemo) And Not (Screen.ActiveControl Is TButtonControl) Then
    Begin
      If Not (Screen.ActiveControl Is TCustomControl) Then
      Begin
        If (Msg.wParam = VK_Down) And
          Not (Screen.ActiveControl Is TListBox) And Not (Screen.ActiveControl Is TComboBox) Then
          Msg.wParam := VK_Tab;
        If (Msg.wParam = VK_UP) And Not (Screen.ActiveControl Is TListBox) And Not (Screen.ActiveControl Is TComboBox) Then
        Begin
          Msg.wParam := VK_CLEAR;
          Screen.ActiveForm.Perform(WM_NextDlgCtl, 1, 0);
        End;
        If (Msg.wParam = VK_Escape) And Not (Screen.ActiveForm = Application.MainForm) Then
          Screen.ActiveForm.Close;
      End;
      If (Msg.wParam = VK_Return) Then
        Msg.wParam := VK_Tab;
    End;
End;

Procedure TTabToEnter.SetFormPrincipal(Const Value: TComponentName);
Begin
  FFormPrincipal := Value;
End;

End.
