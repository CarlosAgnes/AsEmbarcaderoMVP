program TDC2019;

uses
  Vcl.Forms,
  fPrincipal in 'fPrincipal.pas' {frmPrincipal},
  dConexao in 'dConexao.pas' {dmdConexao: TDataModule},
  fBase in 'fBase.pas' {frmBase},
  fAdicionarProduto in 'fAdicionarProduto.pas' {frmAdicionarProduto},
  dBase in 'dBase.pas' {dmdBase: TDataModule},
  dMenuCustomizado in 'dMenuCustomizado.pas' {dmdMenuCustomizado: TDataModule},
  dNovidadesDoSistema in 'dNovidadesDoSistema.pas' {dmdNovidadesDoSistema: TDataModule},
  uLog in 'uLog.pas',
  dContaPagar in 'dContaPagar.pas' {dmdContaPagar: TDataModule},
  dCotacaoDolar in 'dCotacaoDolar.pas' {dmdCotacaoDolar: TDataModule},
  dEstoqueRede in 'dEstoqueRede.pas' {dmdEstoqueRede: TDataModule},
  fConsultaEstoqueProdutos in 'fConsultaEstoqueProdutos.pas' {frmConsultaEstoqueProdutos},
  fPedidos in 'fPedidos.pas' {frmPedidos},
  dServicoProtecaoCredito in 'dServicoProtecaoCredito.pas' {dmdServicoProtecaoCredito: TDataModule},
  dConsultaCredito in 'dConsultaCredito.pas' {dmdConsultaCredito: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmdConexao, dmdConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmPedidos, frmPedidos);
  Application.CreateForm(TdmdServicoProtecaoCredito, dmdServicoProtecaoCredito);
  Application.CreateForm(TdmdConsultaCredito, dmdConsultaCredito);
  Application.Run;
end.
