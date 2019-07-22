unit fPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  Vcl.ExtCtrls;

type
  TfrmPedidos = class(TfrmBase)
    cdsPedido: TClientDataSet;
    cdsPedidoid_produto: TIntegerField;
    cdsPedidovalor_item: TCurrencyField;
    dbgPedido: TDBGrid;
    dtsPedido: TDataSource;
    btnEmitir: TButton;
    GridPanel1: TGridPanel;
    lblCodigoCliente: TLabel;
    edtCodigoCliente: TEdit;
    mmoLog: TMemo;
    procedure btnEmitirClick(Sender: TObject);
  strict private
    function GetCPFCliente(const pIDCLiente: Int32): Int64;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.dfm}

uses
  System.Threading, dConsultaCredito, dServicoProtecaoCredito, System.Diagnostics;

procedure TfrmPedidos.btnEmitirClick(Sender: TObject);
var
  lCreditoCliente: IFuture<Currency>;
  lIDCliente: Int32;
  lFatorRisco: IFuture<Double>;
  lTotalItens: Currency;
  lCreditoReal: Currency;
  lSW: TStopwatch;
begin
  inherited;

  { formula para aceitar o pedido :
    total dos itens < credito do cliente * fator de risco }

{$region 'implementacao'}
  lSW := TStopwatch.StartNew;

  lIDCliente := StrToInt(edtCodigoCliente.Text);

  lCreditoCliente := TTask.Future<Currency>(
    function: Currency
    var
      lDMConsultaCredito: TdmdConsultaCredito;
    begin
      lDMConsultaCredito := TdmdConsultaCredito.Create(nil);

      try
        Result := lDMConsultaCredito.GetCreditoCliente(lIDCliente);
      finally
        lDMConsultaCredito.Free;
      end;
    end).Start;

  lFatorRisco := TTask.Future<Double>(
    function: Double
    var
      lDMServicoProtecaoCredito: TdmdServicoProtecaoCredito;
    begin
      lDMServicoProtecaoCredito := TdmdServicoProtecaoCredito.Create(nil);

      try
        Result := lDMServicoProtecaoCredito.GetFatorRiscoCliente(GetCPFCliente(lIDCliente));
      finally
        lDMServicoProtecaoCredito.Free;
      end;
    end).Start;

  lTotalItens := 0;

  cdsPedido.First;

  while not cdsPedido.Eof do
  begin
    lTotalItens := lTotalItens + cdsPedidovalor_item.AsCurrency;
    cdsPedido.Next;
  end;

  lCreditoReal := lCreditoCliente.Value * lFatorRisco.Value;

  lSW.Stop;

  mmoLog.Lines.Add('tempo: ' + lSW.ElapsedMilliseconds.ToString);

  if lTotalItens < lCreditoReal then
  begin
    mmoLog.Lines.Add('Cliente tem crédito! Vende logo!!');
  end else
  begin
    mmoLog.Lines.Add('Deu ruim!!!');
  end;
{$endregion}
end;

function TfrmPedidos.GetCPFCliente(const pIDCLiente: Int32): Int64;
begin
  Result := pIDCliente * 123;
end;

end.
