unit dConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TdmdConexao = class(TDataModule)
    FDConnection: TFDConnection;
  strict private
    FThreadID: TThreadID;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;

    property ThreadID: TThreadID read FThreadID;

    class procedure RegistrarPool;
  end;

var
  dmdConexao: TdmdConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmdConexao }

constructor TdmdConexao.Create(AOwner: TComponent);
begin
  inherited;

  FThreadID := TThread.Current.ThreadID;

  FDConnection.Params.Clear;
  FDConnection.ConnectionDefName := 'TDC2019';
  FDConnection.Open;

  FDConnection.ExecSQL(
    'create table if not exists produto (' +
    '  id integer primary key autoincrement,' +
    '  nome text,' +
    '  valor_unitario real,' +
    '  estoque_local real)');

  FDConnection.ExecSQL(
    'create table if not exists menu_customizado (' +
    '  id integer primary key autoincrement,' +
    '  caption text)');

  FDConnection.ExecSQL(
    'create table if not exists conta_pagar (' +
    '  id integer primary key autoincrement,' +
    '  id_fornecedor integer,' +
    '  valor real,' +
    '  data_vencimento real,' +
    '  situacao integer,' +
    '  data_pagamento real)');
end;

class procedure TdmdConexao.RegistrarPool;
var
  lConnectionString: TStringList;
begin
  lConnectionString := TStringList.Create;

  try
    lConnectionString.Values['Database'] := '..\..\dados\TDC2019.sqlite3';
    lConnectionString.Values['OpenMode'] := 'CreateUTF8';
    lConnectionString.Values['Pooled'] := 'True';

    FDManager.AddConnectionDef('TDC2019', 'SQLite', lConnectionString);
  finally
    lConnectionString.Free;
  end;
end;

initialization
  TdmdConexao.RegistrarPool;

end.
