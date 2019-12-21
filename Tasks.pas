unit Tasks;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Dialogs,DBTables, RHAGlobs, ArtLabel, DModOld,
  TaskSQL, ComCtrls, VCLUnZip, VCLZip;

type
  TNewProject = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Label1: TLabel;
    IDLab: TArtLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    ProgressBar1: TProgressBar;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  end;

  {TaskDesk=Class
     Alias : string[12];
     DD : string[255];
  end;}

var
  NewProject: TNewProject;
  Id: string;
  DataDess: TStringList;
  OldAlias: string;
  SourceSql: TStringList;
  MainSql: TStringList;
  AddFiles: TStringList;

resourcestring
  stNewCopy = 'Wish You to create new copy of data set?';
  stNotDef = 'Data set is not defined!';
  stMustName = 'Project must have a name!';
  stNewData = 'New data set';
  stDefData = 'Data set description';

var
  SourceDir: string;

implementation

uses MyUtils, PetDBUtils, Options, DBConvert;

{$R *.DFM}

procedure TNewProject.Button1Click(Sender: TObject);
var
  dir: string;
  MustCopy, HaveSQL: Boolean;
  i: integer;
begin
 if Edit1.Text = '' then begin
    MessageDlg(stMustName, mtError, [mbOK], 0);
    Edit1.SetFocus;
    Exit;
  end;
  if (Memo1.Lines.Count < 3) and (Alias = '') then begin
    MessageDlg(stNotDef, mtError, [mbOK], 0);
    Button4.SetFocus;
    Exit;
  end;

  MustCopy := False;
  if Alias <> '' then begin
  HaveSQL := DMOld.TTasks.FieldByName('HaveSQL').AsBoolean;
    if MessageDlg(stNewCopy,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then begin
      MustCopy := True;
      DataDes := InputBox(stNewData, stDefData, 'Copy of '+DataDes);
    end;
    end;
  if (Alias = '') or MustCopy then begin
    Dir := MainPath + Id;
    CreateDir(Dir);
    try
      if MustCopy then begin
        GroupBox2.Visible := True;
        
       // DMOld.Database1.Close;
        DMOld.TTables.First;
        while not DMOld.TTables.EOF do begin
          Label5.Caption := DMOld.TTables['Name'];
          CopyFiles(SourceDir + DMOld.TTables['Name'] + '.*', Dir, ProgressBar1);
          DMOld.TTables.Next;
          Application.ProcessMessages;
        end;
        ProgressBar1.Max := 100;
        if HaveSQL then
          CopyFiles(SourceDir + Alias+'.SQT', Dir+'A'+ID+'.SQT', ProgressBar1);
        SourceDir := Alias;
      end;
      Alias :='A'+ ID;
      Session.AddStandardAlias(Alias, Dir, 'PARADOX');
      Session.SaveConfigFile;

      RHAAliases.Add(Alias);
      RHAAliases.SaveToFile(MainPath + 'Petros.als');
      AddFiles := TStringList.Create;
      try
        AddFiles.LoadFromFile(MainPath + 'AddFiles.TXT');
        for i := 0 to AddFiles.Count - 1 do begin
          Label5.Caption := AddFiles[i];
          CopyFiles(MainPath + AddFiles[i], Dir, ProgressBar1);
        end;
        ProgressBar1.Max := 100;
      finally
        AddFiles.Free;
      end;
      if not MustCopy and (Memo1.Lines.Count > 2) then begin

        RestoreBase(MainPath + 'Structure.zip', Dir, nil);
        SourceSql := TStringList.Create;
        MainSql := TStringList.Create;
        MainSQl.Add(
          'Select * From MainRHA Where ID IN (');
        MainSQl.Add(
          'Select DISTINCT ArrID From RHAData  Where (');
        SourceSQl.Add(
          'Select * From Source source Where Source.ID IN (');
        SourceSQl.Add(
          'Select DISTINCT Source From MainRHA Where ID IN (');
        SourceSQl.Add(MainSQL[1]);
        for i := 1 to Memo1.Lines.Count - 2 do begin
          SourceSQL.Add(Memo1.Lines[i]);
          MainSQL.Add(Memo1.Lines[i]);
        end;
        SourceSql.Add('))');
        MainSQl.Add(') ORDER BY MainRHA.Source');
        with DMOld do begin
         { if Database2.AliasName <> 'PetrosBase' then begin
            Database2.Close;
            Database2.AliasName := 'PetrosBase';
          end; }
          if not Database2.Connected then Database2.Open;
          //AdoConnection2.Connected:=True;
          QuData.Sql.Clear;
          QuData.SQL.Assign(Memo1.Lines);
          QuMain.Sql.Clear;
          QuMain.SQL.Assign(MainSQL);
          QuSource.Sql.Clear;
          QuSource.SQL.Assign(SourceSql);
          CurPath := GetAliasDir(Alias);
          ChangeAlias(Alias);
          OldAlias := Alias;
          ProgressBar1.Position := 0;
          Screen.Cursor := crHourglass;
          GroupBox2.Visible := True;
          Label5.Caption := 'Execute SQL';
          try
            Application.ProcessMessages;
            ProgressBar1.Position := 10;
            QuData.Open;
            ProgressBar1.Position := 30;
            QuMain.Open;
            ProgressBar1.Position := 60;
            QuSource.Open;
            ProgressBar1.Position := 80;
            {DSData.DataSet:=QuData;
            TClassif.MasterSource:=DSData;
            TClassif.MasterFields:='AnId';}
            TClassif.Open;

            UpdateBase(QuData, QuMain, QuSource,TClassif, True, Label5,
              ProgressBar1);
            Memo1.Lines.SaveToFile(CurPath + Alias + '.SQT');
            HaveSQL := true;
          finally
            GroupBox2.Visible := False;
            Screen.Cursor := crDefault;
             TClassif.Close;
            QuData.Close;
            QuMain.Close;
            QuSource.Close;
          end;
        end;
        SourceSql.Free;
        MainSql.Free;
      end;
    finally
      GroupBox2.Visible := false;
    end;
  end;

  with DMOld do begin
    TTasks.Insert;
    TTasks['Name'] := Edit1.Text;
    TTasks['Alias'] := Alias;
    TTasks['DataDes'] := DataDes;
    TTasks['PrId']:=ID;
    if MustCopy then
      TTasks['CopyOf'] := SourceDir;
    TTasks.FieldByName('HaveSQL').AsBoolean := HaveSQL;
    TTasks.Post;
    CurProject.LoadProject(TTasks['ID']);
  end;
  Inc(LastProjectN);
  ModalResult := mrOK;
end;

procedure TNewProject.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Id := 'Petr$' + IntToStr(LastProjectN + 1);
  IdLab.Caption := Id;
  OldAlias := CurProject.Alias;
  Alias := '';
  Memo1.Lines.Clear;
  Edit1.Text := '';
  ComboBox1.Clear;
  DataDess := TStringList.Create;
  DataDess.Sorted := True;
  DataDess.Duplicates := dupIgnore;
  DMOld.TTables.Open;
  with DMOld.TTasks do begin
    First;
    while not Eof do begin
      DataDess.Add(DMOld.TTasks['DataDes'] + '=' + DMOld.TTasks['Alias']);
      Next;
    end;
    for i := 0 to DataDess.Count - 1 do
      ComboBox1.Items.Add(DataDess.Names[i]);
  end;
  ComboBox1.ItemIndex := 0;
end;

procedure TNewProject.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Alias = '' then Alias := OldAlias;
  DataDess.Free;
  DMOld.TTables.Close;
end;

procedure TNewProject.ComboBox1Change(Sender: TObject);
begin
  Alias := DataDess.Values[ComboBox1.Text];
  DataDes := ComboBox1.Text;
  Label4.Caption := DataDes;
  SourceDir := GetAliasDir(Alias);
  Memo1.Lines.Clear;
  DMOld.TTasks.Locate('Alias', Alias, []);
  if DMOld.TTasks.FieldByName('HaveSQL').AsBoolean then
    Memo1.Lines.LoadFromFile(SourceDir + Alias + '.SQT');
end;

procedure TNewProject.Button4Click(Sender: TObject);
begin
  Alias := '';
  if not InputQuery(stNewData, stDefData, DataDes) then exit;
  TaskSQLForm.ForProject := True;
  TaskSQLForm.Edit1.Text:=DataDes;
  if TaskSQLForm.ShowModal = mrOK then begin
    if TaskSQLForm.AllBase then begin
      DMOld.TTasks.First;
      Alias := DMOld.TTasks['Alias'];
      DataDes := DMOld.TTasks['DataDes'];
      Memo1.Lines.Clear;
      SourceDir := GetAliasDir(Alias);
    end else begin
      Memo1.Lines.Assign(TaskSQLForm.Memo1.Lines);
      Memo1.Lines.Add('ORDER BY rhadata.ArrID, rhadata.Num');
    end;
    Label4.Caption := DataDes;
  end;
end;

procedure TNewProject.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.

