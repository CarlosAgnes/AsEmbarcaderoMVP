unit dCotacaoDolar;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmdCotacaoDolar = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    function GetCotacaoDolar(out pCotacao: Currency): Boolean;
  end;

var
  dmdCotacaoDolar: TdmdCotacaoDolar;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  System.JSON,
  uLog;

{$R *.dfm}

{ TdmdCotacaoDolar }

function TdmdCotacaoDolar.GetCotacaoDolar(out pCotacao: Currency): Boolean;
var
  lResposta: TJSONValue;
begin
  try
    RESTRequest1.Execute;

    lResposta := TJSONObject.ParseJSONValue(RESTResponse1.Content);

    try
      Result := lResposta is TJSONNumber;

      if Result then
      begin
        pCotacao := TJSONNumber(lResposta).AsDouble;
        TLog.InstanciaDefault.Logar('Dólar: ' + FormatCurr('R$ 0,.00', pCotacao));
      end;
    finally
      lResposta.Free;
    end;
  except
    on E: Exception do
    begin
      TLog.InstanciaDefault.Logar('Erro ao buscar cotação do dólar: ' + E.Message);
      Result := False;
    end;
  end;
end;

end.
