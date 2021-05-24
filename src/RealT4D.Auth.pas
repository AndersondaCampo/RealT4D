unit RealT4D.Auth;

interface

uses
  RealT4D.Auth.Intf,
  RealT4D.Response.Intf;

type
  TRealT4DAuth = Class(TInterfacedObject, IRealT4DAuth)
  private
  public
    function SignInWithEmail(const ApiKey, Email, Password: String): IResponse;
    function CreateNewAccount(const ApiKey, Email, Password: String): IResponse;

    class Function New: IRealT4DAuth;
  End;

const
  GOOGLE_REFRESH_AUTH_URL = 'https://securetoken.googleapis.com/v1/token';
  GOOGLE_CUSTOM_AUTH_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken';
  GOOGLE_GET_USER_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo';
  GOOGLE_IDENTITY_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyAssertion';
  GOOGLE_SIGNUP_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser';
  GOOGLE_PASSWORD_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword';
  GOOGLE_GET_CONFIRMATION_CODE_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/getOobConfirmationCode';
  GOOGLE_SET_ACCOUNT_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo';
  GOOGLE_CREATE_AUTH_URL = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/createAuthUri';

implementation

uses
  System.SysUtils,
  RealT4D.Response,
  RealT4D.CORE,
  RealT4D.Types;

{ TRealT4DAuth }

function TRealT4DAuth.CreateNewAccount(const ApiKey, Email, Password: String): IResponse;
begin
  Result := TRealT4D.New(GOOGLE_SIGNUP_URL)
              .Data('{"email":"'+ Email +'", "password":"'+ Password +'", "returnSecureToken": "true"}')
              .AddQueryParam('key', ApiKey)
              .OnRaisedException(
                procedure(E: Exception)
                begin
                  raise Exception.Create(E.Message);
                end)
              .Method(rtmPost)
              .Execute
              .Response;
end;

class function TRealT4DAuth.New: IRealT4DAuth;
begin
  Result := TRealT4DAuth.Create;
end;

function TRealT4DAuth.SignInWithEmail(const ApiKey, Email, Password: String): IResponse;
begin
  Result := TRealT4D.New(GOOGLE_PASSWORD_URL)
              .Data('{"email":"'+ Email +'", "password":"'+ Password +'", "returnSecureToken": "true"}')
              .AddQueryParam('key', ApiKey)
              .OnRaisedException(
                procedure(E: Exception)
                begin
                  raise Exception.Create(E.Message);
                end)
              .Method(rtmPost)
              .Execute
              .Response;
end;

end.
