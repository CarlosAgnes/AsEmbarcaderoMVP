unit dServicoProtecaoCredito;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmdServicoProtecaoCredito = class(TDataModule)
  private
    { Private declarations }
  public
    function GetFatorRiscoCliente(const pCPF: Int64): Double;
  end;

var
  dmdServicoProtecaoCredito: TdmdServicoProtecaoCredito;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmdServicoProtecaoCredito }

function TdmdServicoProtecaoCredito.GetFatorRiscoCliente(const pCPF: Int64): Double;
begin
  Result := 0.9;
  Sleep(2000);
end;

end.
