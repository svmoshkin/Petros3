unit Dictionar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, DBCtrls, Hintctrl, Variants,
  DB, ADODB, ADOUtilsS;

type
  TSinonimForm = class(TForm)
    DBGrid1: TDBGrid;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    DBNavigator1: TDBNavigator;
    DBGrid2: THDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure ADOQuery1AfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SinonimForm: TSinonimForm;
  FieldID : integer;
  const IsEdit:Boolean=False;

implementation

uses DMod1, RHAGlobs;

{$R *.DFM}

procedure TSinonimForm.FormShow(Sender: TObject);
begin
    // DM1.Diction.MasterSource:=nil;
     ListBox1.ItemIndex:=0;
     ListBox1Click(Sender);
     IsEdit:=True;
end;

procedure TSinonimForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  { DM1.Diction.Close;
   DM1.Diction.MasterSource:=DM1.DSimpF;
   DM1.Diction.Filtered:=False;}
   IsEdit:=False;
end;

procedure TSinonimForm.ListBox1Click(Sender: TObject);
begin
     Case ListBox1.ItemIndex of
          0 : begin DBGrid1.DataSource:=DM1.DSGBod;
              FieldID:=9;
              end;
          1 : begin DBGrid1.DataSource:=DM1.DSGId;
              FieldID:=8;
              end;
          2 : begin DBGrid1.DataSource:=DM1.DSReg;
              FieldID:=7;
              end;
          3 : begin DBGrid1.DataSource:=DM1.DSRoc;
              FieldID:=6;
              end;
     end;
     DBGrid1.DataSource.DataSet.First;
     DBGrid1CellClick(nil);
end;

procedure TSinonimForm.DBGrid1CellClick(Column: TColumn);
begin
  if DBGrid1.DataSource.DataSet['ID']<>Null then begin
  openQR('Select * from Dictionar where FieldID='+IntToStr(FieldId)+' and [Desc]='+
       IntToStr(DBGrid1.DataSource.DataSet['ID']), ADOQuery1);
     {DM1.Diction.Close;
     DM1.Diction.Filter:='(FieldID='+IntToStr(FieldId)+')and(Desc='+
       IntToStr(DBGrid1.DataSource.DataSet['ID'])+')';
     DM1.Diction.Filtered:=True;
     DM1.Diction.Open;}
  end;
end;

procedure TSinonimForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

procedure TSinonimForm.ADOQuery1AfterInsert(DataSet: TDataSet);
begin
    DataSet['Desc']:=DBGrid1.DataSource.DataSet['ID'];
    DataSet['FieldID']:=FieldId;
end;

end.
