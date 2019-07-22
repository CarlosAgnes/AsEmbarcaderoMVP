unit dEstoqueRede;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmdEstoqueRede = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
  private
    { Private declarations }
  public
    function GetEstoqueProduto(const pIDProduto: Int32; out pEstoque: Double): Boolean;
  end;

var
  dmdEstoqueRede: TdmdEstoqueRede;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.JSON;

{ TdmdEstoqueRede }

function TdmdEstoqueRede.GetEstoqueProduto(const pIDProduto: Int32; out pEstoque: Double): Boolean;
var
  lResposta: TJSONValue;
begin
  try
    RESTRequest1.Params.Clear;
    RESTRequest1.Params.AddUrlSegment('pIDProduto', pIDProduto.ToString);
    RESTRequest1.Execute;

    lResposta := TJSONObject.ParseJSONValue(RESTResponse1.Content);

    try
      Result := lResposta is TJSONNumber;

      if Result then
      begin
        pEstoque := TJSONNumber(lResposta).AsDouble;
      end;
    finally
      lResposta.Free;
    end;
  except
    Result := False;
  end;
end;

end.
