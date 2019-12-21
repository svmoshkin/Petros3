unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, About,
  DMod1, ActnList, ImgList, ToolWin, BDE, DB, ADODB,
  RHAGlobs, Tasks, Koeff, Wait,
  Chemist, DisableSecondCopy, Variants;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    WindowTileItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    Task1: TMenuItem;
    New: TMenuItem;
    Edit1: TMenuItem;
    Load1: TMenuItem;
    ControlBar1: TControlBar;
    Exit1: TMenuItem;
    N1: TMenuItem;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ImageList2: TImageList;
    AExit: TAction;
    NewTask: TAction;
    LoadTask: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    Delete1: TMenuItem;
    DeleteTask: TAction;
    DataToolBar: TToolBar;
    ToolButton7: TToolButton;
    View1: TMenuItem;
    RollUps1: TMenuItem;
    Queries1: TMenuItem;
    ShowQueryes: TAction;
    ToolBar2: TToolBar;
    ToolButton8: TToolButton;
    AtProc: TAction;
    N2: TMenuItem;
    Atomicconcentration1: TMenuItem;
    ToolButton9: TToolButton;
    Anwateratomnproc1: TMenuItem;
    AWA: TAction;
    AWWeight: TAction;
    ToolButton10: TToolButton;
    Anwateratomnproc2: TMenuItem;
    WProc: TAction;
    Weigtconcentration1: TMenuItem;
    ToolButton11: TToolButton;
    StKoefs: TAction;
    N4: TMenuItem;
    StKoefs1: TMenuItem;
    ToolButton13: TToolButton;
    ResultBar: TToolBar;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    GraphXY: TAction;
    GraphTrio: TAction;
    ToolButton15: TToolButton;
    XYGraph1: TMenuItem;
    Trianglediagram1: TMenuItem;
    RHAShow: TAction;
    RHA1: TMenuItem;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ActBook: TAction;
    Bibliography1: TMenuItem;
    InputBar: TToolBar;
    ToolButton18: TToolButton;
    InputIns: TAction;
    Newdataarray1: TMenuItem;
    ToolButton19: TToolButton;
    ShowArrays: TAction;
    Dataarraylist1: TMenuItem;
    DataImport: TAction;
    ToolButton20: TToolButton;
    Importdata1: TMenuItem;
    ToolButton21: TToolButton;
    EditAnal: TAction;
    Editdata1: TMenuItem;
    ToolButton22: TToolButton;
    ViewAnal: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    Viewanaliticaldata1: TMenuItem;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ASpid: TAction;
    ToolButton26: TToolButton;
    Spiderdiagram1: TMenuItem;
    StatusLine: TStatusBar;
    ToolButton27: TToolButton;
    AClass: TAction;
    Classification1: TMenuItem;
    AOption: TAction;
    Option1: TMenuItem;
    ToolButton30: TToolButton;
    ALists: TAction;
    Lists1: TMenuItem;
    Cadd: TMenuItem;
    AW100: TAction;
    ToolButton31: TToolButton;
    Weigtconcentrationto1001: TMenuItem;
    AedGid: TAction;
    Edit2: TMenuItem;
    Geolidentificators1: TMenuItem;
    Data2: TMenuItem;
    AEdRock: TAction;
    AERock1: TMenuItem;
    AEdReg: TAction;
    AEdGB: TAction;
    A1: TMenuItem;
    AEdGB1: TMenuItem;
    AStDiag: TAction;
    ToolButton32: TToolButton;
    Standartdiagrams1: TMenuItem;
    ToolButton33: TToolButton;
    AStat: TAction;
    Statistics1: TMenuItem;
    ACorr: TAction;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    AMol: TAction;
    AMolAW: TAction;
    Molwithoutwater1: TMenuItem;
    Molecular1: TMenuItem;
    ACorr1: TMenuItem;
    ABand: TAction;
    ToolButton2: TToolButton;
    Averageconcentratons1: TMenuItem;
    N8: TMenuItem;
    Sinonims1: TMenuItem;
    ToolButton3: TToolButton;
    AStRecalc: TAction;
    Results1: TMenuItem;
    Normativerecalculations1: TMenuItem;
    CurHelp: TAction;
    ToolButton34: TToolButton;
    AFavor: TAction;
    Favoritediagram1: TMenuItem;
    ADist: TAction;
    Distances1: TMenuItem;
    ToolButton28: TToolButton;
    Convertolddatabase1: TMenuItem;
    N7: TMenuItem;
    ExecuteSQL1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure WindowTile(Sender: TObject);
    procedure WindowCascade(Sender: TObject);
    procedure WindowArrange(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NewTaskExecute(Sender: TObject);
    procedure LoadTaskExecute(Sender: TObject);
    procedure DeleteTaskExecute(Sender: TObject);
    procedure ShowQueryesExecute(Sender: TObject);
    procedure AtProcExecute(Sender: TObject);
    procedure AWAExecute(Sender: TObject);
    procedure AWWeightExecute(Sender: TObject);
    procedure WProcExecute(Sender: TObject);
    procedure StKoefsExecute(Sender: TObject);
    procedure GraphXYExecute(Sender: TObject);
    procedure GraphTrioExecute(Sender: TObject);
    procedure RHAShowExecute(Sender: TObject);
    procedure ActBookExecute(Sender: TObject);
    procedure InputInsExecute(Sender: TObject);
    procedure ShowArraysExecute(Sender: TObject);
    procedure DataImportExecute(Sender: TObject);
    procedure EditAnalExecute(Sender: TObject);
    procedure ViewAnalExecute(Sender: TObject);
    procedure ASpidExecute(Sender: TObject);
    procedure AClassExecute(Sender: TObject);
    procedure AOptionExecute(Sender: TObject);
    procedure AListsExecute(Sender: TObject);
    procedure AClickExecute(Sender: TObject);
    procedure AW100Execute(Sender: TObject);
    procedure AedGidExecute(Sender: TObject);
    procedure AEdRockExecute(Sender: TObject);
    procedure AEdRegExecute(Sender: TObject);
    procedure AEdGBExecute(Sender: TObject);
    procedure AStDiagExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AStatExecute(Sender: TObject);
    procedure ACorrExecute(Sender: TObject);
    procedure AMolExecute(Sender: TObject);
    procedure AMolAWExecute(Sender: TObject);
    procedure ABandExecute(Sender: TObject);
    procedure Sinonims1Click(Sender: TObject);
    procedure AStRecalcExecute(Sender: TObject);
    procedure CurHelpExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AFavorExecute(Sender: TObject);
    procedure ADistExecute(Sender: TObject);
    procedure Convertolddatabase1Click(Sender: TObject);
    procedure ExecuteSQL1Click(Sender: TObject);

  public
    AnType: TDatType;
    procedure CloseAll;
    procedure StDiagrShow;
  end;

var
  MainForm: TMainForm;
  CurQR: string;

resourcestring
  stNewArray = 'New data set';
  stAnalData = 'Analytical data.  ';
  stDelPr = 'Delete project';
  stLoadPr = 'Load project';
  stEditDArray = 'Data set editing';
  stNotFav = 'Favorite diagram is undefined';
  stNoQuerCheck = 'There are not checked queries!';

implementation

uses LoadPr, RollQuery, MRollUp, AtProc, TrioGraph, RHABrows, Biblio,
  NewArr, Analise, ArrayRolls, ImportAn, Spaider, Devid, Classif,
  ImpWiz, Lists, LookUps, StDiagrams, Stat, Correlat, BandGr, Dictionar,
  StRecalc, Options, ImpLookUps, AnalInput, Registrat, Distance, DBConvert,
  ADOUtilsS, ExecSQL;


{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  {Application.OnHint := ShowHint;}

  Titles := TStringList.Create;
  Titles.Sorted := True;
  Titles.Duplicates := dupIgnore;
  if openQr('Select distinct Title1,Type from MainRHA', DM1.q1Time)
    then begin
    while not DM1.q1Time.Eof do begin
      if DM1.q1Time['Type'] = 'nc' then
        Titles.AddObject(DM1.q1Time['Title1'], Pointer(1))
      else
        Titles.AddObject(DM1.q1Time['Title1'], Pointer(0));
      DM1.q1Time.Next;
    end;
    if Titles.Count > 0 then
      AnalisTitle := TAnalisTitle.Create(Titles[0], Integer(Titles.Objects[0]) = 1);
  end;
  if not ReadReg then
    Application.Terminate;
  MainPath := ExtractFilePath(Application.ExeName);
 // DM1.TTasks.Open;
  DM1.TabRec.Open;
  DM1.TabVars.Open;
  CurProject := TProject.Create;
  StAx := TStringList.Create;
  StAx.Sorted := True;
  StAx.LoadFromFile('Stax.rhi');
  StForm := TStringList.Create;
  StForm.Sorted := false;
  StForm.LoadFromFile('StForm.rhi');

end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.SimpleText := Application.Hint;
end;

procedure TMainForm.WindowTile(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowCascade(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowArrange(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TMainForm.HelpSearch(Sender: TObject);
const
  EmptyString: PChar = '';
begin
  Application.HelpCommand(HELP_PARTIALKEY, Longint(EmptyString));
end;

procedure TMainForm.HelpHowToUse(Sender: TObject);
begin
  Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  About1 := TAbout1.Create(Self);
  About1.ShowModal;
  About1.Free;
  About1 := nil;
end;



procedure TMainForm.AExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i, j: integer;
  Path, Fn, DD, CurD: string;
  sr: TSearchRec;
  DList: TStringList;
  CD: TDateTime;
  MustBackUp: Boolean;
begin
  try
    CloseAll;
  except
  end;
  StAx.Free;
  StForm.Free;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('Software\Petros\Petros 3', False);
    {Reg.OPenKey('Petros', True);
    Reg.OPenKey('Petros 3', True); }
    Path := Reg.ReadString('BackUpDir');


    if Path = '' then
      ShowMessage('Fail to back up database. Error in registry key. You must to reinstall Petros!')
    else begin
      DateTimeToString(CurD, 'yyyymmdd', Date);
      Application.UpdateFormatSettings := False;
      DateSeparator := '/';
      ShortDateFormat := 'yyyy/mm/dd';
      i := Pos('"', Path);
      while i > 0 do begin
        Delete(Path, i, 1);
        i := Pos('"', Path);
      end;
      Path := Trim(Path);
      if Path[Length(Path)] <> '\' then
        Path := Path + '\';
      FN := Path + '*.bak';
{$IFDEF DEBUG}
      ShowMessage(Path);
{$ENDIF}
      try
        DList := TStringList.Create;
        MustBackUp := True;
        if FindFirst(FN, faAnyFile, sr) = 0 then begin
          repeat
            if pos('pb', sr.Name) = 1 then
            begin
              DD := Copy(sr.Name, 3, 4) + '/' + Copy(sr.Name, 7, 2) + '/' + Copy(sr.Name, 9, 2);
              CD := STrToDate(DD);
              if Date - CD > 30 then
                DList.Add(Sr.Name);
              if Date - CD < 5 then
                MustBackUp := False;
            end;
          until FindNext(sr) <> 0;
          SysUtils.FindClose(sr);
        end;
        if MustBackUp then begin
          try

            Screen.Cursor := crHourGlass;
            try
              ExecQr('BACKUP DATABASE PetrosBase ' +
                'TO DISK=''' + Path + 'pb' + CurD + '.bak''', DM1.q1Time);
              ShowMessage('BACKUP DATABASE successfully processed');
            except on E: Exception do
                ShowMessage('Back up failed. ' + E.Message);
            end;
          finally
            Screen.Cursor := crDefault;
          end;
        end;
        for i := 0 to DList.Count - 1 do
          SysUtils.DeleteFile(Path + 'BackUp\' + DList[i]);
      finally
        DList.Free;
      end;
    end;
  {
  Reg.WriteInteger('QuCount', TrioForm.SQLs.Count);
  Reg.WriteString('FontName', TrioForm.GeoChart1.Legend.Font.Name);
  Reg.WriteInteger('FontCharSet', TrioForm.GeoChart1.Legend.Font.Charset);
  Reg.WriteString('TitX', TitX);
  Reg.WriteString('TitY', TitY);
  Reg.WriteString('TitZ', TitZ);
  Reg.WriteString('XTitul', XTitul);
  Reg.WriteString('YTitul', YTitul);
  Reg.WriteString('ZTitul', ZTitul);
  Reg.WriteBool('Trio', TrioForm.GeoChart1.Trio);
  Reg.WriteBool('Standart',TrioForm.Standart);
  Reg.WriteInteger('Diagram',STDiaForm.HListBox2.ItemIndex);
  Reg.WriteString('LFontName',TrioForm.GeoChart1.Legend.Font.Name);
  Reg.WriteInteger('LFontCharSet',TrioForm.GeoChart1.Legend.Font.Charset);
  Reg.WriteInteger('LFontSize',TrioForm.GeoChart1.Legend.Font.Size);
  Reg.WriteFloat('Norma',TrioForm.GeoChart1.Norma);
  Reg.WriteString('Title',TrioForm.GeoChart1.Title.Text);
  Reg.WriteBool('TitVis', TrioForm.GeoChart1.Title.Visible);
  Reg.WriteString('TFontName',TrioForm.GeoChart1.Title.Font.Name);
  Reg.WriteInteger('TFontCharSet',TrioForm.GeoChart1.Title.Font.Charset);
  Reg.WriteInteger('TFontSize',TrioForm.GeoChart1.Title.Font.Size);

  Reg.WriteBool('LegInCh',TrioForm.GeoChart1.Legend.InChart);
  Reg.WriteBool('LegVis',TrioForm.GeoChart1.Legend.Visible);
  Reg.WriteBool('LegFrame',TrioForm.GeoChart1.Legend.Frame);
  Reg.WriteBool('LegTran',TrioForm.GeoChart1.Legend.Transparent); }



    CurProject.SaveProject;
  {AssignFile(FF, 'Graphs.cfg');
  try
  Rewrite(FF,1);
  for i:=0 to TrioForm.GeoChart1.Series.Count-1 do
     TrioForm.GeoChart1.Series[i].SaveProp(FF);
  finally
  CloseFile(FF);
  end;}
    CurProject.Free;
  //DM1.TTasks.Close;

    DM1.TabRec.Close;
    DM1.TabVars.Close;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;


procedure TMainForm.NewTaskExecute(Sender: TObject);
begin
 { NewProject := TNewProject.Create(Self);
  NewProject.ShowModal;
  NewProject.Free;
  NewProject := nil; }
end;



procedure TMainForm.LoadTaskExecute(Sender: TObject);
begin
  {LoadPrForm := TLoadPrForm.Create(Self);
  LoadPrForm.Action := aLoad;
  LoadPrForm.Caption := stLoadPr;
  LoadPrForm.ShowModal;
  LoadPrForm.Free;
  LoadPrForm := nil; }
end;

procedure TMainForm.DeleteTaskExecute(Sender: TObject);
begin
  {LoadPrForm := TLoadPrForm.Create(Self);
  LoadPrForm.Action := aDelete;
  LoadPrForm.Caption := stDelPr;
  LoadPrForm.ShowModal;
  LoadPrForm.Free;
  LoadPrForm := nil; }
end;


procedure TMainForm.ShowQueryesExecute(Sender: TObject);
begin
  QueryRolls.Show;
  QueryRolls.State := rsUp;
end;

procedure TMainForm.AtProcExecute(Sender: TObject);
begin
      {AtForm.Caption:='Atomic concentrations: ';}
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    AnType := dtAtomn;
    TAtForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.AWAExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    AnType := dtAtomnAW;
    TAtForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.AWWeightExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    AnType := dtWeightAW;
    TAtForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.WProcExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    AnType := dtWeight;
    TAtForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.StKoefsExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    TKoefForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.GraphXYExecute(Sender: TObject);
var i: integer;
  Check: Boolean;
begin
  if QueryRolls.QueryChLBox.Items.Count > 0 then begin
    Check := False;
    for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
      if QueryRolls.QueryChLBox.Checked[i] then begin
        Check := True;
        break;
      end;
    if Check then begin
      WForm.Show;
      MustDiag := false;
      CurTrio := False;
      TTrioForm.Create(Self);
      WForm.Close;
    end else
      ShowMessage(stNoQuerCheck);
  end;
end;

procedure TMainForm.GraphTrioExecute(Sender: TObject);
var i: integer;
  Check: Boolean;
begin
  if QueryRolls.QueryChLBox.Items.Count > 0 then begin
    Check := False;
    for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
      if QueryRolls.QueryChLBox.Checked[i] then begin
        Check := True;
        break;
      end;
    if Check then begin
      WForm.Show;
      MustDiag := false;
      CurTrio := True;
      TTrioForm.Create(Self);
      WForm.Close;
    end else
      ShowMessage(stNoQuerCheck); ;
  end;
end;

procedure TMainForm.RHAShowExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    TFBrows.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.ActBookExecute(Sender: TObject);
begin
  Books := TBooks.Create(Self);
  Books.ShowModal;
  Books.Free;
  Books := nil;
end;

procedure TMainForm.InputInsExecute(Sender: TObject);
begin
  NewAnalises := True;
     {DlNew.Table2.Insert;}
  DLNew.Caption := stNewArray;
  DLNew.TitleCombo.Text := '';
    { DM1.TabM1.Open;}
  DM1.TabEdBook.Open;
  if DlNew.ShowModal = mrOK then begin
       { DM1.TabM1['NComp']:=AnalisTitle.Count;}
    {ANDlg.Close;}
    AnDlg.DelBtn.Enabled := True;
    OpenQr('Select * from RHADATA where ArrId=' + IntToStr(DM1.TabM1['ID']), AnDlg.Table1);
   // AnDlg.Table1.Open;
    AnDlg.Caption := stAnalData + DM1.TabM1['ArrayName'];
    ANDlg.SG1.ReadOnly := False;
    if AnDlg.ShowModal <> mrOK then begin
      DM1.TabM1.Delete
    end else begin
      DM1.TabM1.Edit;
      DM1.TabM1['MaxNum'] := LastNum;
      DM1.TabM1['NAnal'] := AnDlg.Table1.RecordCount;
      DM1.TabM1.Post;
    end;
    AnDlg.Table1.Close;
  end else begin
    DM1.TabM1.Cancel;
    DM1.TabEdBook.Cancel;
  end;

  DM1.TabEdBook.Close;
     {DM1.TabM1.Close;}
  ArrayRollsUp.HDBEdit1Change(Sender);
end;

procedure TMainForm.ShowArraysExecute(Sender: TObject);
begin
  ArrayRollsUp.Show;
  ArrayRollsUp.State := rsUp;
end;

procedure TMainForm.CloseAll;
var i: integer;
begin
  for i := MdiChildCount - 1 downto 0 do
  try
    MdiChildren[i].Close;
  except
  end;
end;

procedure TMainForm.DataImportExecute(Sender: TObject);
begin
  try
    if ImportDialog.ShowModal = mrOK then begin
     {if ImportType=5 then begin
         DBEdit1Change(Sender);
         exit;
     end; }
      NewAnalises := True;
    {DM1.TabM1.Insert;}

      DM1.TabEdBook.Open;
    {DM1.TabEdBook.Last;}
      DLNew.Caption := stNewArray;
      DLNew.TitleCombo.Text := '';
      if ImportType = 3 then begin
    {EXCEL}// DM1.TabD1.Open;
        ImpLookUpForm := TImpLookUpForm.Create(Self);
        if not Assigned(WizForm) then
          WizForm := TWizForm.Create(Self);
        WizForm.ShowModal;
        if WizForm.ModalResult = mrOK then begin
          NewAnalises := false;
        {ANDlg.Close;}
          OpenQr('Select * from RHADATA where ArrId=' + IntToStr(DM1.TabM1['ID']), AnDlg.Table1);
          //AnDlg.Table1.Open;
          ChangedTitle := false;
          AnDlg.Caption := stAnalData + DM1.TabM1['ArrayName'];
          ANDlg.SG1.ReadOnly := False;
          AnDlg.DelBtn.Enabled := True;
          if AnDlg.ShowModal <> mrOK then begin
            DM1.TabM1.Delete
          end else begin
            DM1.TabM1.Edit;
            DM1.TabM1['MaxNum'] := LastNum;
            DM1.TabM1['NAnal'] := AnDlg.Table1.RecordCount;
            DM1.TabM1.Post;
          end
        end else begin
          if WizForm.WasPost then
            DM1.TabM1.Delete
          else
            DM1.TabM1.Cancel;
          if (DM1.TabEdBook.Active) then
            DM1.TabEdBook.Cancel;
        end;
        {WizForm.Free;
        WizForm := nil; }
        ImpLookUpForm.Free;
        ImpLookUpForm := nil;
      end else begin
        if DlNew.ShowModal = mrOK then begin
          NewAnalises := false;
          //DM1.TabD1.Open;

         // AnDlg.Table1.Open;
      {if ImportType = 3 then
        ExcForm.ShowModal;}
          if ImportAnalise('') then begin
            OpenQr('Select * from RHADATA where ArrId=' + IntToStr(DM1.TabM1['ID']), AnDlg.Table1);
            AnDlg.Caption := stAnalData + DM1.TabM1['ArrayName'];
            ANDlg.SG1.ReadOnly := False;
            AnDlg.DelBtn.Enabled := True;
            if AnDlg.ShowModal <> mrOK then begin
              DM1.TabM1.Delete
            end else begin
              DM1.TabM1.Edit;
              DM1.TabM1['MaxNum'] := LastNum;
              DM1.TabM1['NAnal'] := AnDlg.Table1.RecordCount;
              DM1.TabM1.Post;
            end
          end else DM1.TabM1.Delete
        {else DM1.TabM1.Delete}
        end else begin
          DM1.TabM1.Cancel;
          DM1.TabEdBook.Cancel;
        end;
      end;
      ArrayRollsUp.HDBEdit1Change(Sender);
     // DM1.TabD1.Close;
      AnDlg.Table1.Close;
      DM1.TabEdBook.Close;
    end;
  except
    on Exception do begin
     // DM1.TabD1.Close;
      AnDlg.Table1.Close;
      DM1.TabEdBook.Close;
    end;
  end;
end;


procedure TMainForm.EditAnalExecute(Sender: TObject);
begin
  NewAnalises := false;
  ChangedTitle := false;
  if {not DM1.TabM1.EOF} DM1.TabM1.RecordCount > 0 then begin
    DLNew.Caption := stEditDArray;
    DM1.TabEdBook.Open;
    if DlNew.ShowModal = mrOK then begin
      {ANDlg.Close;}
      OpenQr('Select * from RHADATA where ArrId=' + IntToStr(DM1.TabM1['ID']) + ' order by Num', AnDlg.Table1);
      //AnDlg.Table1.Open;
      AnDlg.Caption := stAnalData + DM1.TabM1['ArrayName'];
      ANDlg.SG1.ReadOnly := False;
      AnDlg.DelBtn.Enabled := True;
      if AnDlg.ShowModal = mrOK then begin
        DM1.TabM1.Edit;
        DM1.TabM1['MaxNum'] := LastNum;
        DM1.TabM1['NAnal'] := AnDlg.Table1.RecordCount;
        DM1.TabM1.Post;
      end;

      DM1.TabM1.Refresh;
      AnDlg.Table1.Close;
    end else begin
      DM1.TabM1.Cancel;
      DM1.TabEdBook.Cancel;
    end;
    DM1.TabEdBook.Close;
  end;
end;

procedure TMainForm.ViewAnalExecute(Sender: TObject);
begin
  ANDlg.SG1.ReadOnly := True;
  AnDlg.DelBtn.Enabled := false;
  OpenQr('Select * from RHADATA where ArrId=' + IntToStr(DM1.TabM1['ID']) + ' order by Num', AnDlg.Table1);
  //AnDlg.Table1.Open;
  AnDlg.Caption := stAnalData + DM1.TabM1['ArrayName'];
  NewAnalises := false;
  ChangedTitle := false;
  AnDlg.ShowModal;
  AnDlg.Table1.Close;
end;

procedure TMainForm.ASpidExecute(Sender: TObject);
begin

  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    if DevForm.ShowModal = mrOK then begin
      WForm.Show;
      MustDiag := false;
      TSPForm.Create(Self);
      WForm.Close;
    end;
  end;
end;

procedure TMainForm.AClassExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    TFClass.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.AOptionExecute(Sender: TObject);
begin
  ConfigDlg.ShowModal;
end;

procedure TMainForm.AListsExecute(Sender: TObject);
begin
  ListsRoll.Show;
  ListsRoll.State := rsUp;
end;

procedure TMainForm.AClickExecute(Sender: TObject);
var s: string;
begin
  S := Cadd.Caption;
  Cadd.Checked := not Cadd.Checked;
  if Cadd.Checked then
    Cadd.Caption := Copy(S, 1, Length(S) - 1)
  else
    Cadd.Caption := S + ' ';
end;

procedure TMainForm.AW100Execute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    AnType := dtWeight100;
    TAtForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.AedGidExecute(Sender: TObject);
begin
  LookUpForm := TLookUpForm.Create(Self);
  LookUpForm.Caption := stFullGID;
  LookUpForm.DBGrid1.DataSource := DM1.DSGId;
  LookUpForm.DBNavigator.DataSource := DM1.DSGId;
  LookUpForm.ShowModal;
  LookUpForm.Free;
  LookUpForm := nil;
end;

procedure TMainForm.AEdRockExecute(Sender: TObject);
begin
  LookUpForm := TLookUpForm.Create(Self);
  LookUpForm.Caption := DM1.Rocks.FieldByName('Rock').DisplayLabel;
  LookUpForm.DBGrid1.DataSource := DM1.DSRoc;
  LookUpForm.DBNavigator.DataSource := DM1.DSRoc;
  LookUpForm.ShowModal;
  LookUpForm.Free;
  LookUpForm := nil;
end;

procedure TMainForm.AEdRegExecute(Sender: TObject);
begin
  LookUpForm := TLookUpForm.Create(Self);
  LookUpForm.Caption := DM1.Regions.FieldByName('Region').DisplayLabel;
  LookUpForm.DBGrid1.DataSource := DM1.DSReg;
  LookUpForm.DBNavigator.DataSource := DM1.DSReg;
  LookUpForm.ShowModal;
  LookUpForm.Free;
  LookUpForm := nil;
end;

procedure TMainForm.AEdGBExecute(Sender: TObject);
begin
  LookUpForm := TLookUpForm.Create(Self);
  LookUpForm.Caption := DM1.GBodies.FieldByName('GBody').DisplayLabel;
  LookUpForm.DBGrid1.DataSource := DM1.DSGBod;
  LookUpForm.DBNavigator.DataSource := DM1.DSGBod;
  LookUpForm.ShowModal;
  LookUpForm.Free;
  LookUpForm := nil;
end;

procedure TMainForm.AStDiagExecute(Sender: TObject);
begin
  StDiaForm.ShowModal;
  if (StDiaForm.ModalResult = mrOK) and (STDiaForm.HListBox2.ItemIndex >= 0)
    then begin
    StDiagrShow;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
{var i : integer;}
begin
  AnalisTitle.Free;
  Titles.Clear;
  Titles.Free;
end;

procedure TMainForm.AStatExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    TStatForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.ACorrExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    if QueryRolls.CurQCount > 0 then begin
      WForm.Show;
      TCorrForm.Create(Self);
      WForm.Close;
    end else
      showMessage('Query is empty');
  end;
end;

procedure TMainForm.AMolExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin

    WForm.Show;
    AnType := dtMol;
    TAtForm.Create(Self);
    WForm.Close;

  end;
end;

procedure TMainForm.AMolAWExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    WForm.Show;
    AnType := dtMolAW;
    TAtForm.Create(Self);
    WForm.Close;
  end;
end;

procedure TMainForm.ABandExecute(Sender: TObject);
var i: integer;
  Check: Boolean;
begin
  if QueryRolls.QueryChLBox.Items.Count > 0 then begin
    Check := False;
    for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
      if QueryRolls.QueryChLBox.Checked[i] then begin
        Check := True;
        break;
      end;
    if Check then begin
      WForm.Show;
      TBandForm.Create(Self);
      WForm.Close;
    end;
  end;

end;

procedure TMainForm.Sinonims1Click(Sender: TObject);
begin
  SinonimForm := TSinonimForm.Create(Self);
  SinonimForm.ShowModal;
  SinonimForm.Free;
  SinonimForm := nil;
end;

procedure TMainForm.AStRecalcExecute(Sender: TObject);
begin
  RecForm.ShowModal;
end;

procedure TMainForm.CurHelpExecute(Sender: TObject);
begin
  Application.HelpContext(CurHelpContext);
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DecimalSeparator := '.';
  if openQr('Select Id From Rocks where Rock=''?''', DM1.q1Time) then
    Roc0 := DM1.q1Time['id'];
  if openQr('Select Id From Regions where Region=''?''', DM1.q1Time) then
    Reg0 := DM1.q1Time['id'];
  if openQr('Select Id From GeolIDs where Geolid=''?''', DM1.q1Time) then
    Gid0 := DM1.q1Time['id'];
  if openQr('Select Id From GBodies where GBody=''?''', DM1.q1Time) then
    GBod0 := DM1.q1Time['id'];
  if not protect or Registered then Exit;
  if REGD.TwoTimes and (DayFromFirst > 25) then
    ShowMessage('До крайнего срока заключения договора с разработчиками осталось ' +
      IntToStr(30 - DayFromFirst) + ' дней');
  if (DayFromFirst > RegD.Days - 10) then
    ShowMessage('До истечения срока работы незарегистрированной версии PETROS осталось ' +
      IntToStr(RegD.Days - DayFromFirst) + ' дней. Свяжитесь с разработчиками для регистрации');
  if DayOff then begin
    RegistrForm := TRegistrForm.Create(Self);
    RegistrForm.ShowModal;
    RegistrForm.Free;
    if DayOff then
      Application.Terminate;
  end;
end;

procedure TMainForm.StDiagrShow;
var i: integer;
  Check: Boolean;
begin
  if QueryRolls.QueryChLBox.Items.Count > 0 then begin
    Check := False;
    for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
      if QueryRolls.QueryChLBox.Checked[i] then begin
        Check := True;
        break;
      end;
    if Check then begin
      WForm.Show;
      MustDiag := true;
      CurDiag := TDiagram(Diagrams.Objects[STDiaForm.HListBox2.ItemIndex]);
      TTrioForm.Create(Self);
      WForm.Close;
    end else
      ShowMessage(stNoQuerCheck);
  end;
end;

procedure TMainForm.AFavorExecute(Sender: TObject);
begin
  if DM1.TbDiagr.Locate('Id', FavDiagram, []) then begin
    StDiaForm.HListBox2.ItemIndex := StDiaForm.HListBox2.Items.IndexOf
      (DM1.TbDiagr['Name']);
    if StDiaForm.HListBox2.ItemIndex >= 0 then
      StDiagrShow
    else
      FavDiagram := 0;
  end else
    FavDiagram := 0;
  if FavDiagram = 0 then
    ShowMessage(stNotFav);
end;

procedure TMainForm.ADistExecute(Sender: TObject);
begin
  if QueryRolls.QueryChLBox.ItemIndex >= 0 then begin
    TfDistance.Create(Self);
  end;
end;

procedure TMainForm.Convertolddatabase1Click(Sender: TObject);
begin
  fDBConvert := TfDBConvert.Create(Application);
  if (fDBConvert.ShowModal = mrOk) and fDBConvert.ItWas then
    Halt;
    {FreeAndNil(fDBConvert);
    Close; }
end;

procedure TMainForm.ExecuteSQL1Click(Sender: TObject);
begin
  fExecSQL.ShowModal;
end;

end.

