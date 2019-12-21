unit NewArr;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DB, ADODB, Mask, Dialogs, Clipbrd,
  CheckLst,
  Chemist, Analise, StrUtils,  DMod1, Biblio, TabMend, {RHAExcel,}
  ESBRtns, Variants, NumInp;

type
  TDlNew = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    TitleCombo: TComboBox;
    Label4: TLabel;
    Bevel2: TBevel;
    AnType: TDBRadioGroup;
    EName: TDBEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ESourceN: TDBEdit;
    ESourceA: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBNavigator1: TDBNavigator;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    CheckListBox1: TCheckListBox;
    Label8: TLabel;
    BitBtn8: TBitBtn;
    Label9: TLabel;
    DBEdit2: TDBEdit;
    Label10: TLabel;
    NumInp1: TNumInp;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    eNumSearch: TEdit;
    EAuthSearch: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CancelBtnClick(Sender: TObject);
    procedure TitleComboChange(Sender: TObject);
    {procedure Table1BeforeDelete(DataSet: TDataSet);}
    procedure TabEdBookBeforePost(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure TabEdBookAfterCancel(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
   { procedure BExcelClick(Sender: TObject);}
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure AnTypeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure DBEdit2Change(Sender: TObject);
    procedure EAuthSearchChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlNew: TDlNew;

resourcestring
stMendInput='Set sequence of components';

implementation

uses RHAGlobs, Main, ADOUtilsS;

var ValidData: boolean;

{$R *.DFM}

procedure TDlNew.FormCreate(Sender: TObject);
var i: integer;
begin
  AnType.ItemIndex := 0;
  for i := 0 to Titles.Count - 1 do
    TitleCombo.Items.Add(Titles[i]);
end;

procedure TDlNew.OKBtnClick(Sender: TObject);
var i: integer;
  S: string;
begin
  S := Trim(EName.Text);
  if s = '' then begin
    EName.SetFocus;
    ValidData := false;
    ShowMessage(stNoArrayName);
    exit;
  end;
  S := Trim(ESourceN.Text);
  if s = '' then begin
    ESourceN.SetFocus;
    ValidData := false;
    ShowMessage(stNoSourceNumber);
    exit;
  end;
  S := Trim(ESourceA.Text);
  if s = '' then begin
    ESourceA.SetFocus;
    ValidData := false;
    ShowMessage(stNoAuthor);
    exit;
  end;
  S := Trim(DbEdit4.Text);
  if s = '' then begin
    DbEdit4.SetFocus;
    ValidData := false;
    ShowMessage(stNoSourceTitle);
    exit;
  end;
  S := Trim(DbEdit5.Text);
  if s = '' then begin
    DbEdit5.SetFocus;
    ValidData := false;
    ShowMessage(stNoBibliography);
    exit;
  end;
  S := Trim(TitleCombo.Text);
  if s = '' then begin
    TitleCombo.SetFocus;
    ValidData := false;
    ShowMessage(stNoCompList);
    exit;
  end;
  if S[Length(s)] = ',' then System.delete(s, Length(s), 1);
  ValidData := true;
  if not TitleIsValid(S, TitleCombo,AnType.ItemIndex=2) then begin
    ValidData := false;
    exit;
  end;
  DM1.TabM1['Title1'] := S;
  AnalisTitle.Free;
  AnalisTitle := TAnalisTitle.Create(S,AnType.ItemIndex=2);
  TitleCombo.Items.Add(S);
  Titles.Add(S);
  i := DM1.TabEdBook['Id'];
  DM1.TabM1['Source'] := DM1.TabEdBook['Id'];
  DM1.TabM1['NComp'] := AnalisTitle.Count;
  DM1.TabM1['Alfa'] :=Round(NumInp1.Value); 
  DM1.TabM1.Post;
  if DM1.TabEdBook.State <> dsBrowse then
    DM1.TabEdBook.Post;

  if (NewAnalises or ChangedTitle)and(AnType.ItemIndex=0) then begin
      CheckListBox1.Items.Clear;
    for i := 0 to AnalisTitle.Count - 1 do
      CheckListBox1.Items.Add(TFormula(AnalisTitle[I]).Symbol);
    GroupBox2.Enabled := true;
    GroupBox2.Visible := true;
    BitBtn1.Enabled := false;
    BitBtn2.Enabled := false;
  end else ModalResult := mrOK;
end;


procedure TDlNew.FormShow(Sender: TObject);
var S: string;
begin
  ENumSearch.Text:='';
  EAuthSearch.Text:='';
  BookEdits := Self;
  if NewAnalises then
    DM1.TabM1.Insert;
  S := Ename.Text;
  EName.SetFocus;
  EName.Text := s;
  if DM1.TabM1['MaxHA']=Null then begin
      if DM1.TabM1.State=dsBrowse then
         DM1.TabM1.Edit;
      DM1.TabM1['MaxHA']:=MaxHALen;
  end;
  if NewAnalises then begin
    ChangedTitle := false;
    DM1.TabEdBook.Last;
    DM1.TabEdBook.Edit;
  end else begin
    DM1.TabM1.Edit;
    DM1.TabEdBook.Locate('ID',DM1.TabM1['Source'],[]);
    DM1.TabEdBook.Edit;
    TitleCombo.Text := (DM1.TabM1['Title1']);
    NumInp1.Value:=DM1.TabM1['Alfa'];
  end;
end;

procedure TDlNew.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := ValidData;
end;

procedure TDlNew.CancelBtnClick(Sender: TObject);
begin
  ValidData := true;
  DM1.TabEdBook.Cancel;
  DM1.TabM1.Cancel;
end;

procedure TDlNew.TitleComboChange(Sender: TObject);
begin
  if not NewAnalises then ChangedTitle := True;
end;

{procedure TDlNew.Table1BeforeDelete(DataSet: TDataSet);
begin
     AnDlg.Table2.GoToCurrent(DM1.TabM1);
     With AnDlg.Table1 do begin
          While not EOF do begin
                First;
                Delete;
          end;
          ApplyUpdates;
          CommitUpdates;
     end;
end; }



procedure TDlNew.TabEdBookBeforePost(DataSet: TDataSet);
begin
  if (DataSet.State = dsInsert) and OpenQr('Select * from Source where Num='+
  InttoStr(DataSet['Num']),DM1.q1Time) then begin
    ShowMessage(stDoubleSourceNumber);
    ValidData := false;
    ESourceN.SetFocus;
    Abort;
  end;
  ESourceN.ReadOnly := true;
  ESourceA.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
end;

procedure TDlNew.BitBtn4Click(Sender: TObject);
begin
  DM1.TabEdBook.Insert;
  ESourceN.SetFocus;
  ESourceN.ReadOnly := false;
  ESourceA.ReadOnly := false;
  DBEdit4.ReadOnly := false;
  DBEdit5.ReadOnly := false;
end;

procedure TDlNew.TabEdBookAfterCancel(DataSet: TDataSet);
begin
  ESourceN.ReadOnly := true;
  ESourceA.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;

end;

procedure TDlNew.BitBtn3Click(Sender: TObject);
begin
  try
    MendForm.MendTabl1.EnableType := True;
    MendForm.MendTabl1.Oxide := True;
    MendForm.MendTabl1.Comma := True;
    MendForm.MendTabl1.EnableMath := False;
    MendForm.MendTabl1.Text := TitleCombo.Text;
    MendForm.Caption := stMendInput;
    if MendForm.ShowModal = mrOK then
      TitleCombo.Text := MendForm.MendTabl1.Text;
  except
    on Exception do
      BitBtn3Click(Sender);
  end;
end;

procedure TDlNew.BitBtn5Click(Sender: TObject);
begin
     Application.HelpContext(CurHelpContext);
end;



procedure TDlNew.BitBtn7Click(Sender: TObject);
var i: integer;
begin
  GroupBox2.Enabled := false;
  GroupBox2.Visible := false;
  BitBtn1.Enabled := True;
  BitBtn2.Enabled := true;
  for i := 0 to AnalisTitle.Count - 1 do
    if CheckListBox1.Checked[i] then begin
      TFormula(AnalisTitle[i]).Delit := 10000;
      ChangedTitle := True;
    end;
end;

procedure TDlNew.BitBtn8Click(Sender: TObject);
var i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := false;
end;

procedure TDlNew.AnTypeChange(Sender: TObject);
begin
  if not NewAnalises then ChangedTitle := True;
  BitBtn3.Enabled:=AnType.ItemIndex<2;
  NumInp1.Enabled:=AnType.ItemIndex=2;
  if (AnType.ItemIndex=2)and (NumInp1.Value=0) then
    NumInp1.Value:=1
  else
   NumInp1.Value:=0;
end;

procedure TDlNew.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {DM1.TabEdBook.Close;}
  
end;

procedure TDlNew.FormActivate(Sender: TObject);
begin
     CurHelpContext:=HelpContext;
end;

procedure TDlNew.BitBtn6Click(Sender: TObject);
var i: integer;
begin
     for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := true;
end;

procedure TDlNew.DBEdit2Change(Sender: TObject);
begin
     if not NewAnalises then ChangedTitle := True;
end;

procedure TDlNew.EAuthSearchChange(Sender: TObject);
begin
  if TEdit(Sender).Text<>'' then begin
   if Sender=ENumSearch then
      DbNavigator1.DataSource.DataSet.Locate('Num',ENumSearch.Text,[loPartialKey])
   else
     DbNavigator1.DataSource.DataSet.Locate('Author',EAuthSearch.Text,[loPartialKey])
     end; 
end;

end.

