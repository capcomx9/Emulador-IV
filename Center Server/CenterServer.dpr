 program CenterServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SimpleShareMem,
  System.SysUtils,
  System.SyncObjs,
  Windows,
  System.DateUtils,
  GlobalDefs in 'Data\GlobalDefs.pas',
  Log in 'Functions\Log.pas',
  Misc in 'Functions\Misc.pas',
  ServerSocket in 'Connection\ServerSocket.pas',
  Player in 'Functions\Player.pas',
  CryptLib in 'Connection\CryptLib.pas',
  Loading in 'Functions\Loading.pas',
  ServerList in 'Functions\ServerList.pas',
  Unknown in 'Functions\Unknown.pas',
  DBCon in 'Connection\DBCon.pas',
  Shop in 'Functions\Shop.pas';

var
  Msg: TMsg;
  bRet: LongBool;
  UpTime: TDateTime;
  TimeInit: Integer;

begin
  try
    SetConsoleTitle('Center Server');
    MainCS:=TCriticalSection.Create;
    Randomize;
    UpTime:=Now;
    Logger:=TLog.Create;
    Logger.Write('                         EMULADOR SEASON IV ',ServerStatus);
    Logger.Write('                          ',ServerStatus);
    Logger.Write('                          ',ServerStatus);
    Logger.Write('  IV: C7 D8 C4 BF B5 E9 C0 FD',ServerStatus);
    Logger.Write('  IV2: C0 D3 BD C3 B7 CE B8 B8',ServerStatus);
    try
      Server:=TServer.Create(9501);
      if Server.Socket.Active = True then begin
        TimeInit:=MilliSecondsBetween(Now, UpTime);
      end;
    except
      on E : Exception do
        Logger.Write(E.ClassName,Errors);
    end;
    while Server.Socket.Active do begin
      bRet:=GetMessage(Msg,0,0,0);
      if Integer(bRet) = -1 then begin
        Break;
      end
      else begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
