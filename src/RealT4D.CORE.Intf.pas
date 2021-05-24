unit RealT4D.CORE.Intf;

interface

uses
  System.SysUtils,
  System.JSON,
  RealT4D.Response.Intf,
  RealT4D.Types;

type
  IRealT4D = Interface
    ['{B9BEEA7E-7F0A-4E3C-B691-EF5661EC84E6}']

    function BaseURI(const AValue: String): IRealT4D;
    function Token(const AValue: String): IRealT4D;
    function Resource(const AValue: String): IRealT4D;
    function AddQueryParam(const AKey, AValue: String): IRealT4D;
    function OnAfterExecute(AValue: TProc): IRealT4D; overload;
    function OnAfterExecute(AValue: TProc<IResponse>): IRealT4D; overload;
    function OnRaisedException(AValue: TProc<Exception>): IRealT4D;
    function Method(AValue: TRealT4DMethods): IRealT4D;
    function Data(const Json: String): IRealT4D; overload;
    function Data(const Json: TJSONValue): IRealT4D; overload;
    function Response: IResponse;
    function Execute(): IRealT4D;
  End;

implementation

end.
