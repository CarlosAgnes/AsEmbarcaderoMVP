unit uServerMethods;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Datasnap.DSServer,
  Datasnap.DSAuth;

type
{$METHODINFO ON}
  api = class(TComponent)
  private
    { Private declarations }
  public
    function NovidadesDoSistema: TJSONValue;
    function DataHora: TDateTime;
    function CotacaoDolar: TJSONNumber;

    function EstoqueTotal(const pIDProduto: Int32): TJSONNumber;
  end;
{$METHODINFO OFF}

implementation

{ api }

function api.DataHora: TDateTime;
begin
  Result := Now;
end;

function api.EstoqueTotal(const pIDProduto: Int32): TJSONNumber;
begin
  Sleep(200);
  Result := TJSONNumber.Create(Random(40000) + 10000);
end;

function api.CotacaoDolar: TJSONNumber;
begin
  Sleep(500);
  Result := TJSONNumber.Create(3.9);
end;

function api.NovidadesDoSistema: TJSONValue;
begin
  Sleep(2000);

//  if Random(3) > 0 then
//  begin
    Result := TJSONTrue.Create;
//  end else
//  begin
//    Result := TJSONFalse.Create;
//  end;
end;

end.

