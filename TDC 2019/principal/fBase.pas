unit fBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmBase = class(TForm)
  private
    { Private declarations }
  public
    class procedure CriarExecutarELiberar;
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

{ TfrmBase }

class procedure TfrmBase.CriarExecutarELiberar;
var
  lForm: TfrmBase;
begin
  lForm := Self.Create(nil);
  lForm.ShowModal;
  lForm.Free;
end;

end.
