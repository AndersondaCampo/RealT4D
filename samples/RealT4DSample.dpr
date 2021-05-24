program RealT4DSample;

uses
  Vcl.Forms,
  uSimple in 'uSimple.pas' {FrmPrincipal},
  RealT4D.Auth.Intf in '..\src\RealT4D.Auth.Intf.pas',
  RealT4D.Auth in '..\src\RealT4D.Auth.pas',
  RealT4D.CORE.Intf in '..\src\RealT4D.CORE.Intf.pas',
  RealT4D.CORE in '..\src\RealT4D.CORE.pas',
  RealT4D.Response.Intf in '..\src\RealT4D.Response.Intf.pas',
  RealT4D.Response in '..\src\RealT4D.Response.pas',
  RealT4D.Types in '..\src\RealT4D.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown   := True;

  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
