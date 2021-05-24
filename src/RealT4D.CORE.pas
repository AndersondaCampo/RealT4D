unit RealT4D.CORE;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  System.Generics.Collections,
  System.Net.HttpClient,

  RealT4D.CORE.Intf,
  RealT4D.Response.Intf,
  RealT4D.Types;

type
  TRealT4D = Class(TInterfacedObject, IRealT4D)
  private
    FBaseURI            : String;
    FToken              : String;
    FResources          : TList<String>;
    FQueryParam         : TDictionary<String, String>;
    FDoAfterExecute     : TProc;
    FDoAfterExecute_Resp: TProc<IResponse>;
    FDoRaiseException   : TProc<Exception>;
    FResponse           : IResponse;
    FMethods            : TRealT4DMethods;
    FSource             : TStringStream;

    function ConstructURL: String;
  public
    function BaseURI(const AValue: String): IRealT4D;
    function Token(const AValue: String): IRealT4D;
    function Resource(const AValue: String): IRealT4D;
    function AddQueryParam(const AKey, AValue: String): IRealT4D;
    function OnAfterExecute(AValue: TProc): IRealT4D; overload;
    function OnAfterExecute(AValue: TProc<IResponse>): IRealT4D; overload;
    function OnRaisedException(AValue: TProc<Exception>): IRealT4D;
    function Method(AValue: TRealT4DMethods): IRealT4D;
    function Data(const JSON: String): IRealT4D; overload;
    function Data(const JSON: TJSONValue): IRealT4D; overload;
    function Response: IResponse;
    function Execute(): IRealT4D;

    class function New(BaseURI: String = ''): IRealT4D;
    constructor Create(BaseURI: String = '');
    destructor Destroy; override;
  End;

implementation

uses
  System.StrUtils,
  System.Net.URLClient,
  System.NetConsts,
  System.NetEncoding,
  RealT4D.Response;

{ TRealT4D }

function TRealT4D.AddQueryParam(const AKey, AValue: String): IRealT4D;
begin
  Result := Self;
  FQueryParam.Add(AKey, AValue);
end;

function TRealT4D.BaseURI(const AValue: String): IRealT4D;
begin
  Result   := Self;
  FBaseURI := AValue;
end;

function TRealT4D.ConstructURL: String;

  function Resources: String;
  var
    I: Integer;
  begin
    Result := '';

    for I    := 0 to FResources.Count - 1 do
      Result := Result + '/' + TNetEncoding.URL.Encode(FResources[I]);
  end;

  function GetToken: String;
  begin
    Result := '';

    if not FToken.IsEmpty then
      Result := '?auth=' + TNetEncoding.URL.Encode(FToken);
  end;

  function QueryParams: String;
  var
    Param: TPair<string, string>;
  begin
    if FQueryParam.Count = 0 then
      exit('');

    Result := IfThen(FToken.IsEmpty, '?', '');

    for Param in FQueryParam do
    begin
      if Result <> '?' then
        Result := Result + '&';

      Result := Result + TNetEncoding.URL.Encode(Param.Key) + '=' + TNetEncoding.URL.Encode(Param.Value);
    end;
  end;

begin
  Result := FBaseURI + Resources + GetToken + QueryParams;
end;

constructor TRealT4D.Create(BaseURI: String = '');
begin
  FBaseURI    := BaseURI;
  FResources  := TList<String>.Create;
  FQueryParam := TDictionary<String, String>.Create;
end;

function TRealT4D.Data(const JSON: String): IRealT4D;
begin
  Result  := Self;
  FSource := TStringStream.Create(JSON);
end;

function TRealT4D.Data(const JSON: TJSONValue): IRealT4D;
begin
  Result  := Self;
  FSource := TStringStream.Create(JSON.ToJSON);
end;

destructor TRealT4D.Destroy;
begin
  FResources.DisposeOf;
  FQueryParam.DisposeOf;
  FSource.DisposeOf;
end;

function TRealT4D.Execute: IRealT4D;
var
  Client: THTTPClient;
begin
  Result := Self;

  Client := THTTPClient.Create;
  try
    try
      Client.ContentType := 'application/json';
      case FMethods of
        rtmPut:
          FResponse := TResponse.New(Client.Put(ConstructURL, FSource));
        rtmPost:
          FResponse := TResponse.New(Client.Post(ConstructURL, FSource));
        rtmPatch:
          FResponse := TResponse.New(Client.Patch(ConstructURL, FSource));
        rtmGet:
          FResponse := TResponse.New(Client.Get(ConstructURL, FSource));
        rtmDelete:
          FResponse := TResponse.New(Client.Delete(ConstructURL, FSource));
      end;

      if Assigned(FDoAfterExecute) then
        FDoAfterExecute;

      if Assigned(FDoAfterExecute_Resp) then
        FDoAfterExecute_Resp(FResponse);
    Except
      on E: Exception do
      begin
        if Assigned(FDoRaiseException) then
          FDoRaiseException(E);
      end;
    end;
  finally
    Client.DisposeOf
  end;
end;

function TRealT4D.Method(AValue: TRealT4DMethods): IRealT4D;
begin
  Result   := Self;
  FMethods := AValue;
end;

class function TRealT4D.New(BaseURI: String = ''): IRealT4D;
begin
  Result := Self.Create(BaseURI);
end;

function TRealT4D.OnAfterExecute(AValue: TProc<IResponse>): IRealT4D;
begin
  Result               := Self;
  FDoAfterExecute_Resp := AValue;
end;

function TRealT4D.OnAfterExecute(AValue: TProc): IRealT4D;
begin
  Result          := Self;
  FDoAfterExecute := AValue;
end;

function TRealT4D.OnRaisedException(AValue: TProc<Exception>): IRealT4D;
begin
  Result            := Self;
  FDoRaiseException := AValue;
end;

function TRealT4D.Resource(const AValue: String): IRealT4D;
begin
  Result := Self;
  FResources.Add(AValue);
end;

function TRealT4D.Response: IResponse;
begin
  Result := FResponse;
end;

function TRealT4D.Token(const AValue: String): IRealT4D;
begin
  Result := Self;
  FToken := AValue;
end;

end.
