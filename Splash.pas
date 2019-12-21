unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,  ComCtrls,  Gauges;

type
  TSForm = class(TForm)
    PB: TGauge;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SForm: TSForm;

implementation

{$R *.DFM}

end.
