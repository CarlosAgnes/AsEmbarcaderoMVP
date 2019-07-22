unit dWebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP, System.JSON, Data.DBXCommon;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure DSHTTPWebDispatcher1FormatResult(Sender: TObject; var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  uServerMethods,
  Web.WebReq,
  System.Generics.Collections;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>TDC 2019</title></head>' +
    '<body>Novidades do sistema...</body>' +
    '</html>';
end;

procedure TWebModule1.DSHTTPWebDispatcher1FormatResult(Sender: TObject; var ResultVal: TJSONValue;
  const Command: TDBXCommand; var Handled: Boolean);
var
  lResultadoAnterior: TJSONValue;
  lArray: TJSONArray;
begin
  lResultadoAnterior := ResultVal;

  try
    lArray := TJSONArray(lResultadoAnterior);
    ResultVal := lArray.Items[0];
    lArray.Remove(0);
  finally
    lResultadoAnterior.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uServerMethods.api;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

