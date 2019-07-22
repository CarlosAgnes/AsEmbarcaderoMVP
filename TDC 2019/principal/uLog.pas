unit uLog;

interface

uses
  System.Classes,
  System.SyncObjs,
  System.Generics.Collections;

type
  TLogPendente = class
  strict private
    FDataHora: TDateTime;
    FThreadID: TThreadID;
    FMensagem: string;
  public
    constructor Create(const pMensagem: string);

    property DataHora: TDateTime read FDataHora;
    property ThreadID: TThreadID read FThreadID;
    property Mensagem: string read FMensagem;
  end;

  TLog = class
  strict private
    FCriticalSection: TCriticalSection;
    FEvento: TEvent;
    FPendentes: TQueue<TLogPendente>;
    FThreadLog: TThread;

    class var FInstanciaDefault: TLog;
    class function GetInstanciaDefault: TLog; static;
  private
    class procedure InicializarInstanciaDefault;
    class procedure LiberarInstanciaDefault;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Logar(const pMensagem: string);

    class property InstanciaDefault: TLog read GetInstanciaDefault;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils;

{ TLog }

constructor TLog.Create;
begin
  FCriticalSection := TCriticalSection.Create;
  FEvento := TEvent.Create;
  FPendentes := TQueue<TLogPendente>.Create;
  FThreadLog := TThread.CreateAnonymousThread(
    procedure
    var
      lTemItemParaProcessar: Boolean;
      lItem: TLogPendente;
    begin
      while not TThread.CheckTerminated do
      begin
        lItem := nil;

        FCriticalSection.Enter;

        try
          lTemItemParaProcessar := FPendentes.Count > 0;
          if lTemItemParaProcessar then
          begin
            lItem := FPendentes.Extract;
          end;
        finally
          FCriticalSection.Leave;
        end;

        if lTemItemParaProcessar then
        begin
          try
            TFile.AppendAllText('TDC2019.log',
              FormatDateTime('yyyy.MM.dd hh:mm:ss.zzz', lItem.DataHora) + ';' +
              FormatFloat('000000', lItem.ThreadID) + ';' +
              lItem.Mensagem + sLineBreak, TEncoding.UTF8);
          finally
            lItem.Free;
          end;
        end else
        begin
          FEvento.WaitFor;
        end;
      end;
    end);
  FThreadLog.FreeOnTerminate := False;
  FThreadLog.Start;
end;

destructor TLog.Destroy;
begin
  FThreadLog.Terminate;
  FEvento.SetEvent;
  FThreadLog.WaitFor;
  FThreadLog.Free;

  while FPendentes.Count > 0 do
  begin
    FPendentes.Extract.Free;
  end;
  FPendentes.Free;

  FEvento.Free;
  FCriticalSection.Free;

  inherited;
end;

class function TLog.GetInstanciaDefault: TLog;
begin
  InicializarInstanciaDefault;

  Result := FInstanciaDefault;
end;

class procedure TLog.InicializarInstanciaDefault;
begin
  if not Assigned(FInstanciaDefault) then
  begin
    FInstanciaDefault := TLog.Create;
  end;
end;

class procedure TLog.LiberarInstanciaDefault;
begin
  FreeAndNil(FInstanciaDefault);
end;

procedure TLog.Logar(const pMensagem: string);
var
  lAcordarThread: Boolean;
begin
  FCriticalSection.Enter;

  try
    lAcordarThread := FPendentes.Count = 0;

    FPendentes.Enqueue(TLogPendente.Create(pMensagem));

    if lAcordarThread then
    begin
      FEvento.SetEvent;
    end;
  finally
    FCriticalSection.Leave;
  end;
end;

{ TLogPendente }

constructor TLogPendente.Create(const pMensagem: string);
begin
  FDataHora := Now;
  FThreadID := TThread.Current.ThreadID;
  FMensagem := pMensagem;
end;

initialization
  TLog.InicializarInstanciaDefault;

finalization
  TLog.LiberarInstanciaDefault;

end.
