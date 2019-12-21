unit Grouping;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Grids, DBGrids, Hintctrl;

type
  TGroupForm = class(TForm)
    RadioGroup1: TRadioGroup;
    Label23: TLabel;
    HLB1: THListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure HLB1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GroupForm: TGroupForm;

const
     giNone=0;
     giGid=1;
     giGBod=2;
     giReg=3;
     giRoc=4;
     giDiag=5;

implementation

uses StDiagrams, DMod1, RHAGlobs;

{$R *.DFM}

procedure TGroupForm.FormShow(Sender: TObject);
var i : integer;
begin
     HLB1.Clear;
     for i:=0 to StDiaForm.HListBox2.Items.Count-1 do
      if TDiagram(StDiaForm.HListBox2.Items.Objects[i]).Classification then
         HLB1.Items.AddObject(StDiaForm.HListBox2.Items[i],StDiaForm.HListBox2.Items.Objects[i]);
end;

procedure TGroupForm.RadioGroup1Click(Sender: TObject);
begin
     if RadioGroup1.ItemIndex=5 then begin
        Label23.Enabled:=True;
        {Label24.Enabled:=True;}
        HLB1.Enabled:=True;
        {ClassGrid.Enabled:=True;}
        HLB1.ItemIndex:=0;
        {HLB1Click(Sender);}
     end else begin
        Label23.Enabled:=False;
        {Label24.Enabled:=False;}
        HLB1.Enabled:=False;
        {ClassGrid.Enabled:=False;}
     end;
end;

procedure TGroupForm.HLB1Click(Sender: TObject);
var Id : integer;
begin
    {Id:=TDiagram(HLB1.Items.Objects[HLB1.ItemIndex]).ID;
    DM1.TbDiagr.Locate('Id',Id,[]); }
end;

procedure TGroupForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
