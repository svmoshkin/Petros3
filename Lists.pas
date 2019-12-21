unit Lists;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MROLLUP, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DBCtrls, Hintctrl;

type
  TListsRoll = class(TRollsUp)
    BitBtn1: TBitBtn;
    HDBGrid1: THDBGrid;
    DBNavigator1: TDBNavigator;
    SpeedButton3: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListsRoll: TListsRoll;
  SelectedList : Integer;



implementation

uses DMod1, ListBrows, RHAGlobs, TaskSQL, RollQuery;

{$R *.DFM}



procedure TListsRoll.FormCreate(Sender: TObject);
begin
  inherited;
  SelectedList:=-1;
end;

procedure TListsRoll.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if DM1.TabLists.RecordCount>0 then begin
  LBrowseForm.Caption:=DM1.TabLists['Name'];
   LBrowseForm.Show;
  end;
end;

procedure TListsRoll.FormActivate(Sender: TObject);
begin
  inherited;
  CurHelpContext := HelpContext;
end;

procedure TListsRoll.SpeedButton3Click(Sender: TObject);
begin
  inherited;
   TaskSQLForm.Edit1.Text := DM1.TabLists['Name'];
    TaskSQlForm.Memo1.Lines.Assign(TaskSQlForm.StrHolder2.Strings);
    TaskSQlForm.Memo1.Lines.Insert(TaskSQlForm.Memo1.Lines.Count - 1,
      'rhadata.AnId in (Select Anal from ListData where List='+IntToStr(DM1.TabLists['ID'])+')');
       QueryRolls.AddSql;
end;

end.
