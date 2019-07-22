unit dContaPagar;

interface

uses
  System.SysUtils, System.Classes, dBase, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmdContaPagar = class(TdmdBase)
    qryChecarContasPagarVencendo: TFDQuery;
    qryChecarContasPagarVencendoresultado: TLargeintField;
  private
    { Private declarations }
  public
    function ChecarQuantidadeContasPagarVencendo: Int32;
  end;

var
  dmdContaPagar: TdmdContaPagar;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dConexao, uLog;

{$R *.dfm}

{ TdmdBase1 }

function TdmdContaPagar.ChecarQuantidadeContasPagarVencendo: Int32;
begin
  qryChecarContasPagarVencendo.Close;
  qryChecarContasPagarVencendo.ParamByName('data_vencimento').AsDateTime := Date;
  qryChecarContasPagarVencendo.Open;

  Result := qryChecarContasPagarVencendoresultado.AsInteger;

  Sleep(1000);

  TLog.InstanciaDefault.Logar('Contas vencendo: ' + Result.ToString);
end;

end.
