unit dMenuCustomizado;

interface

uses
  System.SysUtils, System.Classes, dBase, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmdMenuCustomizado = class(TdmdBase)
    qryMenuCustomizado: TFDQuery;
    qryMenuCustomizadoid: TFDAutoIncField;
    qryMenuCustomizadocaption: TWideMemoField;
  private
    { Private declarations }
  public
    function GetMenusCustomizados: TStringList;
  end;

var
  dmdMenuCustomizado: TdmdMenuCustomizado;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dConexao;

{$R *.dfm}

{ TdmdMenuCustomizado }

function TdmdMenuCustomizado.GetMenusCustomizados: TStringList;
begin
  qryMenuCustomizado.Close;
  qryMenuCustomizado.Open;

  Result := TStringList.Create;

  try
    while not qryMenuCustomizado.Eof do
    begin
      Sleep(300);
      Result.Add(qryMenuCustomizadocaption.AsString);
      qryMenuCustomizado.Next;
    end;
  except
    Result.Free;
    raise;
  end;
end;

end.
