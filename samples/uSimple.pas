unit uSimple;

interface

uses
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
  Vcl.ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    edtEmail: TEdit;
    edtSenha: TEdit;
    edtKey: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnAuth: TButton;
    edtToken: TEdit;
    Label4: TLabel;
    edtResource: TEdit;
    Label5: TLabel;
    btnExec: TButton;
    Button1: TButton;
    btnNewAccount: TButton;
    edtBaseURL: TEdit;
    Button2: TButton;
    Panel1: TPanel;
    mmData: TMemo;
    Panel2: TPanel;
    mmResult: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    procedure btnAuthClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnNewAccountClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function RaiseError(Msg: String): Boolean;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  System.JSON,
  RealT4D.Types,
  RealT4D.Auth,
  RealT4D.CORE;

{$R *.dfm}

procedure TFrmPrincipal.btnAuthClick(Sender: TObject);
var
  Result: String;
  jv: TJSONValue;
begin
  Result := TRealT4DAuth.New
              .SignInWithEmail(edtKey.Text, edtEmail.Text, edtSenha.Text)
                .ContentString;

  mmResult.Lines.Clear;
  mmResult.Lines.Add(Result);

  jv := TJSONObject.ParseJSONValue(Result) as TJSONObject;
  try
    if not RaiseError(result) then
      edtToken.Text := jv.GetValue<String>('idToken');
  finally
    jv.DisposeOf;
  end;
end;

procedure TFrmPrincipal.btnExecClick(Sender: TObject);
begin
  mmResult.Lines.Clear;
  mmResult.Lines.Add(
    TRealT4D.New(edtBaseURL.Text)
      .Token(edtToken.Text)
      .Resource(edtResource.Text)
      .Method(rtmGet)
      .Execute
        .Response
          .ContentString
  );
end;

procedure TFrmPrincipal.btnNewAccountClick(Sender: TObject);
var
  Result: String;
  jv: TJSONValue;
begin
  Result := TRealT4DAuth.New
              .CreateNewAccount(edtKey.Text, edtEmail.Text, edtSenha.Text)
                .ContentString;

  mmResult.Lines.Clear;
  mmResult.Lines.Add(Result);

  jv := TJSONObject.ParseJSONValue(Result) as TJSONObject;
  try
    if not RaiseError(result) then
      edtToken.Text := jv.GetValue<String>('idToken');
  finally
    jv.DisposeOf;
  end;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
  mmResult.Lines.Clear;
  mmResult.Lines.Add(
    TRealT4D.New(edtBaseURL.text)
      .Token(edtToken.Text)
      .Resource(edtResource.Text)
      .Method(rtmPost)
      .Data(mmData.Lines.Text)
      .Execute
        .Response
          .ContentString
  );
end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
  mmResult.Lines.Clear;
  mmResult.Lines.Add(
    TRealT4D.New(edtBaseURL.text)
      .Token(edtToken.Text)
      .Resource(edtResource.Text)
      .Method(rtmPatch)
      .Data(mmData.Lines.Text)
      .Execute
        .Response
          .ContentString
  );
end;

function TFrmPrincipal.RaiseError(Msg: String): Boolean;
var
  jv: TJSONValue;
  str: String;
begin
  Result := False;

  jv := TJSONObject.ParseJSONValue(Msg);
  try
    if not jv.TryGetValue('error', jv) then
      Exit;

    str := jv.GetValue<String>('message');

    if str = 'INVALID_PASSWORD' then
      raise Exception.Create('Senha inválida');

    if str = 'EMAIL_EXISTS' then
      raise Exception.Create('E-mail já cadastrado');

    Result := True;
  finally
    jv.DisposeOf;
  end;
end;

end.
