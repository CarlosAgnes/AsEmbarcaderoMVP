unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, System.Notification, System.Threading, Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
    menPrincipal: TMainMenu;
    mniCadastro: TMenuItem;
    mniAdicionar: TMenuItem;
    mniAdicionarProduto: TMenuItem;
    btnProcessar2: TButton;
    btnProcessar: TButton;
    NotificationCenter: TNotificationCenter;
    StatusBar1: TStatusBar;
    mniEstoque: TMenuItem;
    mniEstoqueProdutos: TMenuItem;
    mniPedido: TMenuItem;
    mniFazerPedido: TMenuItem;
    procedure mniAdicionarProdutoClick(Sender: TObject);
    procedure btnProcessar2Click(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure mniEstoqueProdutosClick(Sender: TObject);
    procedure mniFazerPedidoClick(Sender: TObject);
  strict private
    FThreadDemoProcessamento: TThread;
//    FArrayTasks: array of ITask;

    procedure TerminarThreadDemoProcessamento;

    procedure CustomizarMenus;
    procedure CarregarNovidadesDoSistema;
    procedure VerificarAvisos;
    procedure CarregarCotacaoDoDolar;
    procedure InicializarSistema;

//    procedure RodarTask(const pMetodo: TProc);

    procedure CustomizarMenusOtimizado;
    procedure CarregarNovidadesDoSistemaOtimizado;
    procedure VerificarAvisosOtimizado;
    procedure CarregarCotacaoDoDolarOtimizado;
    procedure InicializarSistemaOtimizado;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  Winapi.ShellAPI,
  fAdicionarProduto,
  dMenuCustomizado, dNovidadesDoSistema, uLog, dContaPagar, dCotacaoDolar, dEstoqueRede, fConsultaEstoqueProdutos,
  fPedidos;

procedure TfrmPrincipal.btnProcessar2Click(Sender: TObject);
begin
  if Assigned(FThreadDemoProcessamento) then
  begin
    TerminarThreadDemoProcessamento;
    btnProcessar2.Caption := 'Processar';
  end else
  begin
    FThreadDemoProcessamento := TThread.CreateAnonymousThread(
      procedure
      begin
        while not TThread.CheckTerminated do
        begin

        end;
      end);
    FThreadDemoProcessamento.FreeOnTerminate := False;
    FThreadDemoProcessamento.Start;
    btnProcessar2.Caption := 'Parar';
  end;
end;

procedure TfrmPrincipal.btnProcessarClick(Sender: TObject);
var
  lFicarProcessandoAte: TDateTime;
begin
  lFicarProcessandoAte := IncSecond(Now, 10);

  while Now < lFicarProcessandoAte do
  begin

  end;
end;

procedure TfrmPrincipal.CarregarCotacaoDoDolar;
var
  lDMCotacaoDolar: TdmdCotacaoDolar;
  lCotacao: Currency;
begin
  lDMCotacaoDolar := TdmdCotacaoDolar.Create(nil);

  try
    if lDMCotacaoDolar.GetCotacaoDolar(lCotacao) then
    begin
      StatusBar1.Panels[0].Text := Format('Dólar = %m', [lCotacao]);
    end;
  finally
    lDMCotacaoDolar.Free;
  end;
end;

procedure TfrmPrincipal.CarregarCotacaoDoDolarOtimizado;
begin
  TTask.Run(
    procedure
    var
      lDMCotacaoDolar: TdmdCotacaoDolar;
      lCotacao: Currency;
    begin
      lDMCotacaoDolar := TdmdCotacaoDolar.Create(nil);

      try
        if lDMCotacaoDolar.GetCotacaoDolar(lCotacao) then
        begin
          TThread.Queue(nil,
            procedure
            begin
              StatusBar1.Panels[0].Text := Format('Dólar = %m', [lCotacao]);
            end);
        end;
      finally
        lDMCotacaoDolar.Free;
      end;
    end).Start;
end;

procedure TfrmPrincipal.CarregarNovidadesDoSistema;
var
  lDMNovidadesDoSistema: TdmdNovidadesDoSistema;
begin
  lDMNovidadesDoSistema := TdmdNovidadesDoSistema.Create(nil);

  try
    if lDMNovidadesDoSistema.VerificarSeTemNovidades then
    begin
      ShellExecute(Self.Handle, 'open', 'http://localhost:8080/', nil, nil, SW_SHOWNORMAL);
    end;
  finally
    lDMNovidadesDoSistema.Free;
  end;
end;

procedure TfrmPrincipal.CarregarNovidadesDoSistemaOtimizado;
begin
  TTask.Run(
    procedure
    var
      lDMNovidadesDoSistema: TdmdNovidadesDoSistema;
    begin
      lDMNovidadesDoSistema := TdmdNovidadesDoSistema.Create(nil);

      try
        if lDMNovidadesDoSistema.VerificarSeTemNovidades then
        begin
          TThread.Queue(nil,
            procedure
            begin
              ShellExecute(Self.Handle, 'open', 'http://localhost:8080/', nil, nil, SW_SHOWNORMAL);
            end);
        end;
      finally
        lDMNovidadesDoSistema.Free;
      end;
    end).Start;
end;

constructor TfrmPrincipal.Create(AOwner: TComponent);
begin
  inherited;

  ReportMemoryLeaksOnShutdown := True;

//  InicializarSistema;
  InicializarSistemaOtimizado;
end;

procedure TfrmPrincipal.CustomizarMenus;
var
  lDMMenuCustomizado: TdmdMenuCustomizado;
  lListaItens: TStringList;
  lMenuCustomizado: TMenuItem;
  lCaption: string;
  lSubItem: TMenuItem;
begin
  lMenuCustomizado := TMenuItem.Create(menPrincipal);
  menPrincipal.Items.Add(lMenuCustomizado);

  lMenuCustomizado.Caption := 'Opções customizadas';

  lDMMenuCustomizado := TdmdMenuCustomizado.Create(nil);

  try
    lListaItens := lDMMenuCustomizado.GetMenusCustomizados;

    try
      for lCaption in lListaItens do
      begin
        lSubItem := TMenuItem.Create(menPrincipal);
        lSubItem.Caption := lCaption;
        lMenuCustomizado.Add(lSubItem);
      end;
    finally
      lListaItens.Free;
    end;
  finally
    lDMMenuCustomizado.Free;
  end;

  TLog.InstanciaDefault.Logar('Menu customizado');
end;

procedure TfrmPrincipal.CustomizarMenusOtimizado;
var
  lMenuCustomizado: TMenuItem;
begin
  lMenuCustomizado := TMenuItem.Create(menPrincipal);
  menPrincipal.Items.Add(lMenuCustomizado);

  lMenuCustomizado.Caption := 'Opções customizadas';

  TTask.Run(
    procedure
    var
      lDMMenuCustomizado: TdmdMenuCustomizado;
      lListaItens: TStringList;
    begin
      lDMMenuCustomizado := TdmdMenuCustomizado.Create(nil);

      try
        lListaItens := lDMMenuCustomizado.GetMenusCustomizados;

        TThread.Queue(nil,
          procedure
          var
            lCaption: string;
            lSubItem: TMenuItem;
          begin
            try
              for lCaption in lListaItens do
              begin
                lSubItem := TMenuItem.Create(menPrincipal);
                lSubItem.Caption := lCaption;
                lMenuCustomizado.Add(lSubItem);
              end;
            finally
              lListaItens.Free;
            end;
            TLog.InstanciaDefault.Logar('Menu customizado');
          end);
      finally
        lDMMenuCustomizado.Free;
      end;
    end).Start;
end;

destructor TfrmPrincipal.Destroy;
begin
  TerminarThreadDemoProcessamento;

  inherited;
end;

procedure TfrmPrincipal.TerminarThreadDemoProcessamento;
begin
  if Assigned(FThreadDemoProcessamento) then
  begin
    FThreadDemoProcessamento.Terminate;
    FThreadDemoProcessamento.WaitFor;
    FreeAndNil(FThreadDemoProcessamento);
  end;
end;

procedure TfrmPrincipal.VerificarAvisos;
var
  lDMContaPagar: TdmdContaPagar;
  lQuantidadeContasVencendo: Int32;
  lNotificacao: TNotification;
begin
  lDMContaPagar := TdmdContaPagar.Create(nil);

  try
    lQuantidadeContasVencendo := lDMContaPagar.ChecarQuantidadeContasPagarVencendo;

    if lQuantidadeContasVencendo > 0 then
    begin
      lNotificacao := NotificationCenter.CreateNotification;

      try
        lNotificacao.Title := 'Aviso!';
        lNotificacao.AlertBody :=
          Format('Você tem %d conta(s) vencida(s) ou vencendo hoje.', [lQuantidadeContasVencendo]);
        NotificationCenter.PresentNotification(lNotificacao);
      finally
        lNotificacao.Free;
      end;
    end;
  finally
    lDMContaPagar.Free;
  end;
end;

procedure TfrmPrincipal.VerificarAvisosOtimizado;
begin
  TTask.Run(
    procedure
    var
      lDMContaPagar: TdmdContaPagar;
      lQuantidadeContasVencendo: Int32;
      lNotificacao: TNotification;
    begin
      lDMContaPagar := TdmdContaPagar.Create(nil);

      try
        lQuantidadeContasVencendo := lDMContaPagar.ChecarQuantidadeContasPagarVencendo;

        if lQuantidadeContasVencendo > 0 then
        begin
          TThread.Queue(nil,
            procedure
            begin
              lNotificacao := NotificationCenter.CreateNotification;

              try
                lNotificacao.Title := 'Aviso!';
                lNotificacao.AlertBody :=
                  Format('Você tem %d conta(s) vencidas ou vencendo hoje.', [lQuantidadeContasVencendo]);
                NotificationCenter.PresentNotification(lNotificacao);
              finally
                lNotificacao.Free;
              end;
            end);
        end;
      finally
        lDMContaPagar.Free;
      end;
    end).Start;
end;

procedure TfrmPrincipal.InicializarSistema;
begin
  CustomizarMenus;
  CarregarNovidadesDoSistema;
  VerificarAvisos;
  CarregarCotacaoDoDolar;
end;

procedure TfrmPrincipal.InicializarSistemaOtimizado;
begin
  CustomizarMenusOtimizado;
  CarregarNovidadesDoSistemaOtimizado;
  VerificarAvisosOtimizado;
  CarregarCotacaoDoDolarOtimizado;
end;

procedure TfrmPrincipal.mniAdicionarProdutoClick(Sender: TObject);
begin
  TfrmAdicionarProduto.CriarExecutarELiberar;
end;

procedure TfrmPrincipal.mniEstoqueProdutosClick(Sender: TObject);
begin
  TfrmConsultaEstoqueProdutos.CriarExecutarELiberar;
end;

procedure TfrmPrincipal.mniFazerPedidoClick(Sender: TObject);
begin
  TfrmPedidos.CriarExecutarELiberar;
end;

//procedure TfrmPrincipal.RodarTask(const pMetodo: TProc);
//var
//  lTamanhoArray: Int32;
//begin
//  lTamanhoArray := Length(FArrayTasks);
//  SetLength(FArrayTasks, lTamanhoArray + 1);
//  FArrayTasks[lTamanhoArray] := TTask.Run(pMetodo).Start;
//end;

end.
