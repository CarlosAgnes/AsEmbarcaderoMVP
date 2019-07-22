unit fConsultaEstoqueProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, Datasnap.DBClient, Datasnap.Provider, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmConsultaEstoqueProdutos = class(TfrmBase)
    qryProdutos: TFDQuery;
    dspProdutos: TDataSetProvider;
    cdsProdutos: TClientDataSet;
    qryProdutosid: TFDAutoIncField;
    qryProdutosestoque_local: TFloatField;
    qryProdutosnome: TWideMemoField;
    cdsProdutosid: TAutoIncField;
    cdsProdutosestoque_local: TFloatField;
    cdsProdutosnome: TWideMemoField;
    dbgProdutos: TDBGrid;
    dtsProdutos: TDataSource;
    cdsProdutosestoque_rede: TFloatField;
    cdsClone: TClientDataSet;
    btnAtualizar: TButton;
    procedure cdsProdutosnomeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnAtualizarClick(Sender: TObject);
  strict private
    FThreadAtualizacao: TThread;

    procedure Atualizar;
    procedure LiberarThread;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmConsultaEstoqueProdutos: TfrmConsultaEstoqueProdutos;

implementation

{$R *.dfm}

uses dConexao, dEstoqueRede;

procedure TfrmConsultaEstoqueProdutos.Atualizar;
begin
  LiberarThread;

  cdsProdutos.Close;
  cdsProdutos.Open;

  cdsClone.Close;
  cdsClone.CloneCursor(cdsProdutos, True);
  cdsClone.First;

  FThreadAtualizacao := TThread.CreateAnonymousThread(
    procedure
    var
      lDMEstoqueRede: TdmdEstoqueRede;
      lID: Integer;
      lEstoque: Double;
    begin
      lDMEstoqueRede := TdmdEstoqueRede.Create(nil);

      try
        lID := cdsClone.FieldByName(cdsProdutosid.FieldName).AsInteger;
        while not TThread.CheckTerminated and not cdsClone.Eof do
        begin
          if lDMEstoqueRede.GetEstoqueProduto(lID, lEstoque) then
          begin
            if not TThread.CheckTerminated then
            begin
              TThread.Synchronize(nil,
                procedure
                begin
                  cdsClone.Edit;
                  cdsClone.FieldByName(cdsProdutosestoque_rede.FieldName).AsFloat := lEstoque;
                  cdsClone.Post;
                  cdsClone.Next;
                  lID := cdsClone.FieldByName(cdsProdutosid.FieldName).AsInteger;
                end);
            end;
          end else
          begin
            cdsClone.Next;
          end;
        end;
      finally
        TThread.Queue(nil,
          procedure
          begin
            lDMEstoqueRede.Free;
          end);
      end;
    end);
  FThreadAtualizacao.FreeOnTerminate := False;
  FThreadAtualizacao.Start;
end;

procedure TfrmConsultaEstoqueProdutos.btnAtualizarClick(Sender: TObject);
begin
  inherited;

  Atualizar;
end;

procedure TfrmConsultaEstoqueProdutos.cdsProdutosnomeGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;

  Text := Sender.AsString;
end;

constructor TfrmConsultaEstoqueProdutos.Create(AOwner: TComponent);
begin
  inherited;

  Atualizar;
end;

destructor TfrmConsultaEstoqueProdutos.Destroy;
begin
  LiberarThread;

  inherited;
end;

procedure TfrmConsultaEstoqueProdutos.LiberarThread;
begin
  if Assigned(FThreadAtualizacao) then
  begin
    FThreadAtualizacao.Terminate;
//    Application.ProcessMessages;
    FThreadAtualizacao.WaitFor;
    FreeAndNil(FThreadAtualizacao);
  end;
end;

end.
