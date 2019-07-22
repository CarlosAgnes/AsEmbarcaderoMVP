unit dBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmdBase = class(TDataModule)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  dmdBase: TdmdBase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  dConexao;

{ TdmdBase }

constructor TdmdBase.Create(AOwner: TComponent);
var
  lConexao: TdmdConexao;
  lComponente: TComponent;
begin
  inherited;

  if TThread.Current.ThreadID <> dmdConexao.ThreadID then
  begin
    lConexao := TdmdConexao.Create(Self);

    for lComponente in Self do
    begin
      if lComponente is TFDQuery then
      begin
        TFDQuery(lComponente).Connection := lConexao.FDConnection;
      end;
    end;
  end;
end;

end.
