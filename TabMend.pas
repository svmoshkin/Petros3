unit TabMend;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, 
  Chemist, Boxes, Mend_C;

type
  TMendForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    MendTabl1: TMendTabl;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Comma : boolean;
  end;

var
  MendForm: TMendForm;

implementation

uses RHAGlobs;

{$R *.DFM}






procedure TMendForm.BitBtn3Click(Sender: TObject);
begin
     Application.HelpFile := 'PETROS.HLP';
     Application.HelpCommand(HELP_CONTEXT ,160);
end;

procedure TMendForm.FormCreate(Sender: TObject);
begin
     MendTabl1.Comma:=True;
end;

procedure TMendForm.FormShow(Sender: TObject);
begin
     MendTabl1.MEdit1.SetFocus;
end;

procedure TMendForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
