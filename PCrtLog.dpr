program PCrtLog;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UStart in 'uStart.pas',
  uLog in 'uLog.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    uStart.PStart();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
