unit RealT4D.Response.Intf;

interface

uses
  System.Generics.Collections,
  System.Net.HttpClient;

type
  IResponse = Interface
    ['{01816721-FB31-4DD9-AF9F-2FB07C3FBBE2}']

    function Headers: TDictionary<String, String>;
    function StatusCode: Integer;
    function StatusText: String;
    function ContentString: String;
  End;

implementation

end.
