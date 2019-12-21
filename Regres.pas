unit Regres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls,Clipbrd;

type
  TRegrForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TRichEdit;
    SaveDialog1: TSaveDialog;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegrForm: TRegrForm;

implementation

uses RHAGlobs;

{$R *.DFM}

procedure TRegrForm.BitBtn1Click(Sender: TObject);
begin
     Close;
end;

procedure TRegrForm.BitBtn2Click(Sender: TObject);
begin
     Memo1.Print(Caption);
end;

procedure TRegrForm.BitBtn3Click(Sender: TObject);
begin
     if SaveDialog1.Execute then begin
        Memo1.Lines.SaveToFile(SaveDialog1.FileName);
     end;
end;

procedure TRegrForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     action := caFree;
end;

procedure TRegrForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
