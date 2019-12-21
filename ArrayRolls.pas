unit ArrayRolls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MROLLUP, StdCtrls, DBCtrls, Grids, DBGrids, Hintctrl, Mask, ExtCtrls, DB,
  Buttons, Variants, ADODB;

type
  TArrayRollsUp = class(TRollsUp)
    HDBGrid1: THDBGrid;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBNavigator1: TDBNavigator;
    HDBEdit1: THDBEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    HDBEdit2: THDBEdit;
    HDBEdit3: THDBEdit;
    HDBEdit4: THDBEdit;
    HDBEdit5: THDBEdit;
    SpeedButton3: TSpeedButton;
    Edit1: THDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
   { procedure Button1Click(Sender: TObject);}
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator1BeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure HDBEdit1Change(Sender: TObject);
    procedure HDBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ArrayRollsUp: TArrayRollsUp;

implementation

uses DMod1, Chemist, RollQuery, TaskSQL, Analise, Main, RHAGlobs;

{$R *.DFM}





procedure TArrayRollsUp.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  inherited;
  {if Button = nbDelete then begin
  AnDlg.Table1.Close;
  end; }

end;

procedure TArrayRollsUp.DBNavigator1BeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
     {if Button = nbDelete then begin
     AnDlg.Table1.Open;
     end; }
  inherited;

end;

procedure TArrayRollsUp.HDBEdit1Change(Sender: TObject);
begin
  inherited;
   if assigned(Titles)and DM1.TabM1.Active and(DM1.TabM1.State<>dsInsert)
        and (not VarIsNull(DM1.TabM1['Title1'])and (DM1.TabM1['Title1']<>'')) then begin
            AnalisTitle.Free;
            AnalisTitle:=TAnalisTitle.Create(Edit1.Text,DM1.TabM1['Type']='nc');
        MainForm.StatusLine.Panels[2].Text:=stCurArray+DM1.TabM1['ArrayName'];
     end;
end;

procedure TArrayRollsUp.HDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  TaskSQLForm.Edit1.Text:=DM1.TabM1['ArrayName'];
  TaskSQlForm.Memo1.Lines.Assign(TaskSQlForm.StrHolder2.Strings);
  TaskSQlForm.Memo1.Lines.Insert(TaskSQlForm.Memo1.Lines.Count - 1,
   '(rhadata.ArrId = '+IntToStr(DM1.TabM1['ID']) +')');
  QueryRolls.AddSql;
end;

procedure TArrayRollsUp.FormCreate(Sender: TObject);
begin
  inherited;
   HDBEdit1Change(Sender);
   HDBGrid1.DataSource.DataSet.Active:=True;
   //HDBEdit4.DataSource.DataSet.Active:=True;
end;

procedure TArrayRollsUp.FormActivate(Sender: TObject);
begin
  inherited;
  CurHelpContext := HelpContext;
end;

end.
