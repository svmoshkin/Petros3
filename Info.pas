unit Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Printers, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TfInfo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    RE1: TRichEdit;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fInfo: TfInfo;

procedure ShowInfo(S : String);

implementation

{$R *.dfm}

procedure ShowInfo(S : String);
begin
    if not Assigned(fInfo) then
      fInfo:=TfInfo.Create(Application);
   fInfo.RE1.Lines.Clear;
   fInfo.RE1.Text:=S;
   fInfo.ShowModal;
end;

procedure TfInfo.Button2Click(Sender: TObject);
var orient : TPrinterOrientation;
begin
     orient:=printer.Orientation;
     printer.Orientation:=poPortrait;
     if PrinterSetupDialog1.Execute then
         Re1.Print(Caption);
     printer.Orientation:=orient;

end;

procedure TfInfo.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
        Re1.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
