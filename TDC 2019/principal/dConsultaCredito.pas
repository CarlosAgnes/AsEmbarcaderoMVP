unit dConsultaCredito;

interface

uses
  System.SysUtils, System.Classes;

type
  TdmdConsultaCredito = class(TDataModule)
  private
    { Private declarations }
  public
    function GetCreditoCliente(const pID: Integer): Currency;
  end;

var
  dmdConsultaCredito: TdmdConsultaCredito;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmdConsultaCredito }

function TdmdConsultaCredito.GetCreditoCliente(const pID: Integer): Currency;
begin
  Result := 3000;
  Sleep(1000);
end;

end.
