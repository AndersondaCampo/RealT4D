unit RealT4D.Response;

interface

uses
  System.Net.HttpClient,
  System.Generics.Collections,
  RealT4D.Response.Intf;

type
  TResponse = Class(TInterfacedObject, IResponse)
  private
    FHeaders      : TDictionary<String, String>;
    FStatusCode   : Integer;
    FContentString: String;

    procedure LoadResponse(Value: IHTTPResponse);
  public
    function Headers: TDictionary<String, String>;
    function StatusCode: Integer;
    function StatusText: String;
    function ContentString: String;

    class function New(Value: IHTTPResponse): IResponse;
    constructor Create(Value: IHTTPResponse);
    destructor Destroy; Override;
  End;

implementation

uses
  System.Net.URLClient,
  System.SysUtils;

{ TResponse }

function TResponse.ContentString: String;
begin
  Result := FContentString;
end;

constructor TResponse.Create(Value: IHTTPResponse);
begin
  FHeaders := TDictionary<String, String>.Create;
  LoadResponse(Value);
end;

destructor TResponse.Destroy;
begin
  FHeaders.DisposeOf;
end;

function TResponse.Headers: TDictionary<String, String>;
begin
  Result := FHeaders;
end;

procedure TResponse.LoadResponse(Value: IHTTPResponse);
var
  Header: TNameValuePair;
begin
  if not Assigned(Value) then
    Exit;

  for Header in Value.Headers do
    FHeaders.Add(Header.Name, Header.Value);

  FStatusCode    := Value.StatusCode;
  FContentString := Value.ContentAsString();
end;

class function TResponse.New(Value: IHTTPResponse): IResponse;
begin
  Result := TResponse.Create(Value);
end;

function TResponse.StatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TResponse.StatusText: String;
begin
  Result := FStatusCode.ToString;
end;

end.
