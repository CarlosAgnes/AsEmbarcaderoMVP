unit fAdicionarProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmAdicionarProduto = class(TfrmBase)
    GridPanel1: TGridPanel;
    lblNome: TLabel;
    edtNome: TEdit;
    GridPanel2: TGridPanel;
    lblValorInicial: TLabel;
    edtValorInicial: TEdit;
    GridPanel3: TGridPanel;
    lblValorFinal: TLabel;
    edtValorFinal: TEdit;
    GridPanel4: TGridPanel;
    lblEstoqueInicial: TLabel;
    edtEstoqueInicial: TEdit;
    GridPanel5: TGridPanel;
    lblEstoqueFinal: TLabel;
    edtEstoqueFinal: TEdit;
    btnAdicionar: TButton;
    qryAdicionarProduto: TFDQuery;
    mmoLog: TMemo;
    procedure btnAdicionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdicionarProduto: TfrmAdicionarProduto;

implementation

{$R *.dfm}

uses
  dConexao;

procedure TfrmAdicionarProduto.btnAdicionarClick(Sender: TObject);
var
  lValorInicial: Integer;
  lValorFInal: Integer;
  lEstoqueInicial: Integer;
  lEstoqueFinal: Integer;
  lValor: Integer;
  lEstoque: Integer;
begin
  inherited;

  lValorInicial := StrToIntDef(edtValorInicial.Text, 10);
  lValorFInal := StrToIntDef(edtValorFinal.Text, 50);
  lValor := Random(lValorFInal - lValorInicial + 1) + lValorInicial;

  lEstoqueInicial := StrToIntDef(edtEstoqueInicial.Text, 50);
  lEstoqueFinal := StrToIntDef(edtEstoqueFinal.Text, 500);
  lEstoque := Random(lEstoqueFinal - lEstoqueInicial + 1) + lEstoqueInicial;

  qryAdicionarProduto.ParamByName('nome').AsString := edtNome.Text;
  qryAdicionarProduto.ParamByName('valor_unitario').AsInteger := lValor;
  qryAdicionarProduto.ParamByName('estoque_local').AsInteger := lEstoque;
  qryAdicionarProduto.ExecSQL;

  mmoLog.Lines.Insert(0, edtNome.Text +
    ' adicionado a R$ ' + FormatCurr('0.,00', lValor) +
    ' com estoque de ' + lEstoque.ToString);

  edtNome.Clear;
  edtNome.SetFocus;
end;

end.
