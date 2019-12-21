unit ORF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Printers, ActnList, Menus,
  JvExStdCtrls, JvRichEdit;

type
  TORFForm = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    RE1: TJvRichEdit;
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MustFree : Boolean;
  end;

var
  ORFForm: TORFForm;
  Ranges : array[1..100,1..100]of smallint;

implementation

uses Main, RHAGlobs;

{$R *.DFM}



procedure TORFForm.BitBtn5Click(Sender: TObject);
var orient : TPrinterOrientation;
begin
     orient:=printer.Orientation;
     printer.Orientation:=poLandscape;
     if PrinterSetupDialog1.Execute then
         Re1.Print(Caption);
     printer.Orientation:=orient;
end;

procedure TORFForm.BitBtn2Click(Sender: TObject);
begin
     if SaveDialog1.Execute then
        Re1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TORFForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if Mustfree then action := caFree;
end;

procedure TORFForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
