unit ListBrows;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MROLLUP, Grids, DBGrids, Buttons, Variants, ADOUtilsS, DB, ADODb;

type
  TLBrowseForm = class(TRollsUp)
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LBrowseForm: TLBrowseForm;

procedure AddToList(Sample:string);

resourcestring
   stNoList='List of lists is empty!';
   stDouble='This analysis already exist in the list';
   stEmptyList='List is empty!';

implementation

uses DMod1, RollQuery, TaskSQL, Main, AnData, RHAGlobs;

{$R *.DFM}

procedure AddToList(Sample:string);
var id : integer;
begin
    if (DM1.TabLists.RecordCount>0)then  begin
    ID:=Get1IntVal('Select AnID from RHADATA where Sample='''+Sample+'''','AnID',DM1.q1Time);
    if not OpenQr('Select * from ListData where List='+IntToStr(DM1.TabLists['ID'])+
    ' and Anal='+IntToStr(ID),DM1.q1Time) then begin
       DM1.q1Time.Insert;
       DM1.q1Time['List']:=DM1.TabLists['ID'];
       DM1.q1Time['Anal']:=ID;
       DM1.q1Time.Post;
       LBrowseForm.SpeedButton1.Enabled:=true;
       if LBrowseForm.Visible then
          LBrowseForm.SpeedButton4Click(nil);
    end else
        ShowMessage(stDouble);
    end else
         ShowMessage(stNoList);
end;

procedure TLBrowseForm.SpeedButton3Click(Sender: TObject);
var S,S1: string;
begin
  inherited;
  if DM1.qLongTime1.RecordCount > 0 then begin
    TaskSQLForm.Edit1.Text := DM1.TabLists['Name'];
    TaskSQlForm.Memo1.Lines.Assign(TaskSQlForm.StrHolder2.Strings);
    TaskSQlForm.Memo1.Lines.Insert(TaskSQlForm.Memo1.Lines.Count - 1,
      'rhadata.AnId in (Select Anal from ListData where List='+IntToStr(DM1.TabLists['ID'])+')');
   { S := '';
    try
      DM1.qLongTime1.DisableControls;
      DM1.qLongTime1.First;
      while not DM1.qLongTime1.EOF do begin
        if S <> '' then
          S := S + ',';
            S := S + IntToStr(DM1.qLongTime1['Anal']);
            if Length(S) > 100 then begin
              TaskSQlForm.Memo1.Lines.Insert(TaskSQlForm.Memo1.Lines.Count - 1, S+',');
              S := '';
            end;
            DM1.qLongTime1.Next;
      end;
     if S='' then  begin
           S1:=TaskSQlForm.Memo1.Lines[TaskSQlForm.Memo1.Lines.Count - 2];
          Delete(S1,Length(S1),1);
          TaskSQlForm.Memo1.Lines[TaskSQlForm.Memo1.Lines.Count - 2]:=S1;
      end;
      TaskSQlForm.Memo1.Lines.Insert(TaskSQlForm.Memo1.Lines.Count - 1, S + ')');}
      QueryRolls.AddSql;
  {  finally
      DM1.qLongTime1.EnableControls;
    end; }
  end else
      ShowMessage(stEmptyList);
end;

procedure TLBrowseForm.SpeedButton2Click(Sender: TObject);
var F : TextFile;
begin
  inherited;
  if DM1.qLongTime1.RecordCount > 0 then begin
     if  SaveDialog1.Execute then begin
        AssignFile(F,SaveDialog1.FileName);
        Rewrite(F);
     writeLn(F,DM1.TabLists['Name']+' - '+DM1.TabLists['Comment']);
     WriteLn(F);
     try
      DM1.qLongTime1.DisableControls;
      DM1.qLongTime1.First;
      while not DM1.qLongTime1.EOF do begin
       writeLn(F,DM1.qLongTime1['Sample']);
       DM1.qLongTime1.Next;
      end;
      finally
      CloseFile(F);
      DM1.qLongTime1.EnableControls;
    end;
     end;
  end else
      ShowMessage(stEmptyList);
end;

procedure TLBrowseForm.SpeedButton1Click(Sender: TObject);
begin
  inherited;
   DM1.qLongTime1.Delete;
   if DM1.qLongTime1.RecordCount=0 then
      SpeedButton1.Enabled:=False;
end;

procedure TLBrowseForm.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  CurID := DM1.qLongTime1['Anal'];
  TAnalForm.Create(MainForm);
end;

procedure TLBrowseForm.FormShow(Sender: TObject);
begin
  inherited;
  OpenQr('Select *,(Select Descript from RHADATA where ANID=Anal) as Descr,'+
  ' (Select Sample from RHADATA where ANID=Anal) as Sample From ListData where List='+
  IntToStr(DM1.TabLists['ID']),DM1.qLongTime1);
  if DM1.qLongTime1.RecordCount=0 then
      SpeedButton1.Enabled:=False
  else
      SpeedButton1.Enabled:=True;
  DataSource1.DataSet:=DM1.qLongTime1;
  if SID in UsedFields then begin
     DBGrid1.Columns[0].FieldName:='Sample';
  end else begin
     DBGrid1.Columns[0].FieldName:='Descr';
  end;
end;

procedure TLBrowseForm.FormActivate(Sender: TObject);
begin
  inherited;
  CurHelpContext := HelpContext;
end;

procedure TLBrowseForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataSource1.DataSet:=nil;
end;

procedure TLBrowseForm.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  TAdoQuery(DataSource1.DataSet).Requery();
end;

end.

