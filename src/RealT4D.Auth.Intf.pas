unit RealT4D.Auth.Intf;

interface

uses
  RealT4D.Response.Intf;

type
  IRealT4DAuth = Interface
    ['{6194705C-CA09-4B48-9800-81512B6B77B8}']

    function SignInWithEmail(const ApiKey, Email, Password: String): IResponse;
    function CreateNewAccount(const ApiKey, Email, Password: String): IResponse;
  End;

implementation

end.
