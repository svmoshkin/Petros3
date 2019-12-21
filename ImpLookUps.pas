unit ImpLookUps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids,Db,ADODB;

type
  TImpLookUpForm = class(TForm)
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn3: TBitBtn;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Tabl : TADOTable;
    Field : TStringField;
    Id: integer;
  end;

var
  ImpLookUpForm: TImpLookUpForm;

implementation

uses RHAGlobs;

{$R *.DFM}

procedure TImpLookUpForm.SpeedButton2Click(Sender: TObject);
begin
     Tabl.Insert;
     Field.Value:=Edit1.Text;
     Tabl.Post;
     BitBtn3.Enabled:=True;
     Id:=Tabl['ID'];
end;

procedure TImpLookUpForm.SpeedButton1Click(Sender: TObject);
begin
     Edit1.Text:=Field.Value;
end;

procedure TImpLookUpForm.FormShow(Sender: TObject);
begin
     BitBtn3.Enabled:=False;
end;

procedure TImpLookUpForm.BitBtn3Click(Sender: TObject);
begin
     Tabl.Locate('ID',ID,[]);
     Tabl.Delete;
     BitBtn3.Enabled:=False;
end;

procedure TImpLookUpForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
