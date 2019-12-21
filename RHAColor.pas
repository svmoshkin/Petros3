unit RHAColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus, ActnList, Printers, JvExStdCtrls, JvRichEdit;

type
  TfRHAColor = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    RE1: TJvRichEdit;
    procedure SaveFileExecute(Sender: TObject);
    procedure PrintExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MustFree : boolean;
  end;

var
  fRHAColor: TfRHAColor;

implementation
uses Main, RHAGlobs;
{$R *.DFM}

procedure TfRHAColor.SaveFileExecute(Sender: TObject);
begin
     if SaveDialog1.Execute then
        Re1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TfRHAColor.PrintExecute(Sender: TObject);
var orient : TPrinterOrientation;
begin
     orient:=printer.Orientation;
     printer.Orientation:=poLandscape;
     if PrinterSetupDialog1.Execute then
         Re1.Print(Caption);
     printer.Orientation:=orient;

end;

procedure TfRHAColor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if Mustfree then action := caFree;
end;

procedure TfRHAColor.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
