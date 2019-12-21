unit Biblio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids, Db, ADODB, Buttons,
  StrUtils,  BSQL, DBTables , ADOUtilsS;

type
  TBooks = class(TForm)
    DataSource1: TDataSource;
    DBCtrlGrid1: TDBCtrlGrid;
    Label6: TLabel;
    Label5: TLabel;
    ESourceN: TDBEdit;
    ESourceA: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label3: TLabel;
    Label7: TLabel;
    Table1: TADOTable;
    Table2: TADOTable;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    DBNavigator1: TDBNavigator;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BAuth: TBitBtn;
    BNum: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Table1UpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure FormShow(Sender: TObject);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure BAuthClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Books: TBooks;

resourcestring
  stNoNum = 'Number of source is absent';
  stNoAuth = 'There are no data about authors of source';
  stNoTitle='Title of source is absent';
  stNoBibl= 'Bibliography data are absent';
  stDoublNum1= 'This number ';
  stDoublNum2=  'already present in the base';
  stRef = 'There is reference on ';
  stNotdel=' in analytical base and it can not be deleted';

implementation

uses BBrowse, RHAGlobs, DMod1;

{$R *.DFM}

 var  ValidData : boolean;



procedure TBooks.BitBtn1Click(Sender: TObject);
begin
     ValidData:=True;
     with Table1 do begin
     if State <>dsBrowse  then
            Post;
         (* try
             ApplyUpdates; {try to write the updates to the database};
             {Database1.Commit; }
          except
                {Database1.Rollback;} {on failure, undo the changes};
                raise; {raise the exception to prevent a call to CommitUpdates!}
          end;
          CommitUpdates; {on success, clear the cache}
          Close; *)
     end;
     Close;
end;

procedure TBooks.BitBtn2Click(Sender: TObject);
begin
     ValidData:=True;
     ///Table1.CancelUpdates;
end;

procedure TBooks.Table1BeforePost(DataSet: TDataSet);
var S : string;
begin
     ValidData:=True;
         S:=Trim(ESourceN.Text);
     if s='' then begin
        ESourceN.SetFocus;
        ValidData:=false;
        ShowMessage(stNoNum);
        Abort;
     end;
     S:=Trim(ESourceA.Text);
     if s='' then begin
        ESourceA.SetFocus;
        ValidData:=false;
        ShowMessage(stNoAuth);
        Abort;
     end;
     S:=Trim(DbEdit4.Text);
     if s='' then begin
        DbEdit4.SetFocus;
        ValidData:=false;
        ShowMessage(stNoTitle);
        Abort;
     end;
     S:=Trim(DbEdit5.Text);
     if s='' then begin
        DbEdit5.SetFocus;
        ValidData:=false;
        ShowMessage(stNoBibl);
        Abort;
     end;
     if ((Table1.State =dsInsert)or(Table1.State =dsEdit))
        and(Table2.Locate('Num',Table1['Num'],[]))and(Table1['Id']<>Table2['Id'])
             then begin
               ShowMessage(stDoublNum1+stDoublNum2);
               ValidData:=false;
               ESourceN.SetFocus;
               Abort;
            end;
end;

procedure TBooks.FormCreate(Sender: TObject);
begin
     {Table1.Open;
     Table2.Open;
     Table3.Open;}
end;

procedure TBooks.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     CanClose:=ValidData;
end;

procedure TBooks.Table1UpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin

 (*if ((UpdateKind = ukInsert)or(UpdateKind = ukModify))
    and(Table2.Locate('Num',DataSet.Fields[1].NewValue,[]))and
    (DataSet.Fields[0].NewValue<>Table2['Id'])
    then begin
               ShowMessage(stDoublNum1+'('+
               IntToStr(DataSet.Fields[1].NewValue)+') '+stDoublNum2);
               ValidData:=false;
               ESourceN.SetFocus;
               UpdateAction :=uaSkip;
               exit;
    end {else if (UpdateKind = ukDelete)and
        (Table3.FindKey([DataSet.Fields[0].NewValue]))
        then begin
               ShowMessage('Ќа источник '+
               IntToStr(DataSet['Num'])+
               ' имеетс€ ссылка, и он не может быть удален');
               ValidData:=false;
               ESourceN.SetFocus;
               UpdateAction :=uaSkip;
               exit;
        end};
        UpdateSQL1.Apply(UpdateKind);
        UpdateAction := uaApplied;   *)

 end;


procedure TBooks.FormShow(Sender: TObject);
begin
      Table1.Open;
      Table1.IndexFieldNames:='Num';
      Table2.Open;
     //Table3.Open;
     {Table2.Refresh;
     Table3.Refresh;}
end;

procedure TBooks.Table1BeforeDelete(DataSet: TDataSet);
begin
     if  OpenQr('Select top 1 * from MainRHA where Source='+IntToStr(DataSet['Id']),DM1.q1Time) or
     OpenQr('Select top 1 * from RHAData where Source='+IntToStr(DataSet['Id']),DM1.q1Time)
     then begin
               ShowMessage(stRef+
               IntToStr(DataSet['Num'])+
               stNotdel);
               ValidData:=false;
               ESourceN.SetFocus;
               Abort;
        end;
end;

procedure TBooks.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
     DBCtrlGrid1.SetFocus;
end;

procedure TBooks.BAuthClick(Sender: TObject);
begin
        ValidData:=True;
     with Table1 do begin
     if State <>dsBrowse  then
            Post;
          (*   ApplyUpdates; {try to write the updates to the database};
          CommitUpdates; {on success, clear the cache}   *)
     end;
     Table1.Close;
     If Sender=BAuth then begin
         Table1.IndexFieldNames:='Author';
         Label1.Caption:='Search by author';
         ESourceN.Color:=clWindow;
         ESourceA.Color:=$00E1D7FF;
     end else begin
         Table1.IndexFieldNames:='Num';
         Label1.Caption:='Search by num';
         ESourceN.Color:=$00E1D7FF;
         ESourceA.Color:=clWindow;
     end;
     Table1.Open;
end;

procedure TBooks.BitBtn3Click(Sender: TObject);
begin
       ValidData:=True;
     with Table1 do begin
     if State <>dsBrowse  then
            Post;
         (* try
             ApplyUpdates; {try to write the updates to the database};
             {Database1.Commit; }
          except
                {Database1.Rollback;} {on failure, undo the changes};
                raise; {raise the exception to prevent a call to CommitUpdates!}
          end;
          CommitUpdates; {on success, clear the cache} *)
     end;
     BiblBrouse:=TBiblBrouse.Create(Self);
     BiblSQL:=TBiblSQL.Create(Self);
     BiblSQL.ShowModal;
     BiblSQL.Free;
     BiblSQL:=nil;
     BiblBrouse.Free;
     BiblBrouse:=nil;
end;

procedure TBooks.Table1AfterInsert(DataSet: TDataSet);
begin
     ESourceN.SetFocus;
end;

procedure TBooks.BitBtn4Click(Sender: TObject);
begin
     Table1.Append;
end;

procedure TBooks.BitBtn5Click(Sender: TObject);
begin
     Application.HelpContext(CurHelpContext);
end;

procedure TBooks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Table1.Close;
     Table2.Close;
    // Table3.Close;
end;

procedure TBooks.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

procedure TBooks.FormResize(Sender: TObject);
begin
    DBCtrlGrid1.RowCount:= DBCtrlGrid1.ClientHeight div  111;
    DBCtrlGrid1.PanelHeight:= DBCtrlGrid1.ClientHeight div  DBCtrlGrid1.RowCount;
    DBCtrlGrid1.Height:=BitBtn1.Top-6;
end;

procedure TBooks.Edit1Change(Sender: TObject);
begin
   Table1.Locate(Table1.IndexFieldNames,Edit1.Text,[loPartialKey]);
end;

end.
