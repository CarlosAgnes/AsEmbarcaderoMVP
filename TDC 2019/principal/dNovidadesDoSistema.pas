unit dNovidadesDoSistema;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmdNovidadesDoSistema = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    function VerificarSeTemNovidades: Boolean;
  end;

var
  dmdNovidadesDoSistema: TdmdNovidadesDoSistema;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.JSON,
  uLog;

{ TdmdNovidadesDoSistema }

function TdmdNovidadesDoSistema.VerificarSeTemNovidades: Boolean;
var
  lTentativas: Int8;
  lSucesso: Boolean;
  lResposta: TJSONValue;
begin
  Result := False;
  lTentativas := 3;
  lSucesso := False;
  repeat
    try
      RESTRequest1.Execute;

      lResposta := TJSONObject.ParseJSONValue(RESTResponse1.Content);

      try
        Result := lResposta is TJSONTrue;
      finally
        lResposta.Free;
      end;

      if Result then
      begin
        TLog.InstanciaDefault.Logar('Temos novidades!');
      end else
      begin
        TLog.InstanciaDefault.Logar('Sem novidades...');
      end;

      lSucesso := True;
    except
      on E: Exception do
      begin
        TLog.InstanciaDefault.Logar('Erro ao tentar buscar novidades: ' + E.Message);
      end;
    end;

    Dec(lTentativas);
  until lSucesso or (lTentativas <= 0);
end;

end.
