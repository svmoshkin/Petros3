unit Options;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Spin, registry, Dialogs, {Apples,} DMod1, ComCtrls,
  ADODB, IniFiles, StrHlder, Grids, DBGrids, RXDBCtrl, NumInp, RXCtrls,
  Db, RxCombos, Variants, ADOUtilsS, DBCtrls, TntDBGrids;

type
  TConfigDlg = class(TForm)
    PageControl1: TPageControl;
    SQlBak: TStrHolder;
    SQL0: TStrHolder;
    StrAx: TStrHolder;
    StrTit: TStrHolder;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    TabSheet1: TTabSheet;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    SpinEdit2: TSpinEdit;
    Label2: TLabel;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox3: TGroupBox;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    BitBtn4: TBitBtn;
    SQL2: TStrHolder;
    SQlBac2: TStrHolder;
    StrAx2: TStrHolder;
    StrTit2: TStrHolder;
    TabSheet4: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    NumInp1: TNumInp;
    NumInp2: TNumInp;
    NumInp3: TNumInp;
    GroupBox5: TGroupBox;
    CheckBox7: TCheckBox;
    SpinEdit3: TSpinEdit;
    GroupBox6: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    ListBox1: TListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    ListBox2: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label11: TLabel;
    Label12: TLabel;
    TabSheet5: TTabSheet;
    GroupBox7: TGroupBox;
    Label13: TLabel;
    CLBox1: TRxCheckListBox;
    GroupBox8: TGroupBox;
    CLBox2: TRxCheckListBox;
    Label14: TLabel;
    GroupBox9: TGroupBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    DataSource1: TDataSource;
    GroupBox10: TGroupBox;
    DBGrid1: TDBGrid;
    Button6: TButton;
    GroupBox11: TGroupBox;
    Label15: TLabel;
    OrdLB: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Button7: TButton;
    Button8: TButton;
    GroupBox12: TGroupBox;
    ListBox3: TListBox;
    Label16: TLabel;
    Button9: TButton;
    Button10: TButton;
    TabSheet6: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    TabSheet7: TTabSheet;
    GroupBox13: TGroupBox;
    DataSource2: TDataSource;
    Label19: TLabel;
    SpinEdit4: TSpinEdit;
    Label20: TLabel;
    DBNavigator1: TDBNavigator;
    ColorDialog1: TColorDialog;
    GroupBox14: TGroupBox;
    CheckBox14: TCheckBox;
    Label21: TLabel;
    SpinEdit5: TSpinEdit;
    Label22: TLabel;
    Label23: TLabel;
    Button11: TButton;
    Button12: TButton;
    SpinEdit6: TSpinEdit;
    TntDBGrid1: TTntDBGrid;
    RadioGroup1: TRadioGroup;
    CheckBox15: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CLBox1Click(Sender: TObject);
    procedure TabSheet1Enter(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure TabSheet5Enter(Sender: TObject);
    procedure TabSheet4Enter(Sender: TObject);
    procedure TabSheet3Enter(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure OrdLBClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetOrdList;
  public
    { Public declarations }
  end;

  TProject = class
    Alias: string[12];
    DataDes: string[255];
      Name: string[80];
    TableId: Longint;
    ProjectID: string[12];
  public
    function SetProject(Id: Longint): boolean;
    procedure LoadProject(Id: Integer);
    procedure SaveProject;
  end;

var CurProject: TProject;
  ConfigDlg: TConfigDlg;
  Reg: TRegistry;
  Ini: TIniFile;




function ReadReg: boolean;
procedure ReadIni;

implementation

uses Main, Analise, RollQuery, Chemist, RHAGlobs, Registrat, ImpAlphabet;

{$R *.DFM}

function ReadReg: boolean;
var CurBool: Boolean;
begin
  Reg := TRegistry.Create;
  result := ReadRI(Reg);
  if not Result then
    Exit;
  Reg.RootKey := HKEY_CURRENT_USER;
  Reg.OpenKey('Software', true);
  Reg.OpenKey('Microsoft', True);
  if not Reg.KeyExists('MSW') then begin

    if protect then begin
      ShowMessage(stReinst);
      Result := false;
      exit;
    end;
    Reg.CreateKey('MSW');
    Reg.OpenKey('MSW', true);
    Reg.WriteInteger('VBX', $DD0147AF);
  end;
  Reg.CloseKey;
  Reg.OpenKey('Software', true);
  Reg.OPenKey('PETROS', True);
  if Reg.ValueExists('NDist') then
    NDist := Reg.ReadInteger('NDist');
  if Reg.ValueExists('UseNDist') then
    UseNDist := Reg.ReadBool('UseNDist');
  if Reg.ValueExists('MaxHALen') then
    maxHALen := Reg.ReadInteger('MaxHALen')
  else Reg.WriteInteger('MaxHALen', MaxHALen);
  if Reg.ValueExists('ElSymLen') then
    ElSymLen := Reg.ReadInteger('ElSymLen')
  else Reg.WriteInteger('ElSymLen', ElSymLen);
  if Reg.ValueExists('MinCompCount') then
    MinCompCount := Reg.ReadInteger('MinCompCount')
  else Reg.WriteInteger('MinCompCount', MinCompCount);
  if Reg.ValueExists('OMax') then
    OMax := Reg.ReadBool('Omax')
  else Reg.WriteBool('OMax', OMax);
  if Reg.ValueExists('OSub') then
    OSub := Reg.ReadBool('OSub')
  else Reg.WriteBool('OSub', OSub);
  if Reg.ValueExists('SubF') then
    SubF := Reg.ReadBool('SubF')
  else Reg.WriteBool('SubF', SubF);
  if Reg.ValueExists('SubCl') then
    SubCl := Reg.ReadBool('SubCl')
  else Reg.WriteBool('SubCl', SubCl);
  if Reg.ValueExists('SubS') then
    SubS := Reg.ReadBool('SubS')
  else Reg.WriteBool('SubS', SubS);
  if Reg.ValueExists('SubC') then
    SubC := Reg.ReadBool('SubC')
  else Reg.WriteBool('SubC', SubC);
  if Reg.ValueExists('MinCorrCount') then
    MinCorrCount := Reg.ReadInteger('MinCorrCount')
  else
    Reg.WriteInteger('MinCorrCount', MinCorrCount);
  if Reg.ValueExists('EnFormat') then
    EnFormat := Reg.ReadString('EnFormat')
  else
    Reg.WriteString('EnFormat', EnFormat);
  if Reg.ValueExists('rBold') then
    rBold := Reg.ReadFloat('rBold')
  else
    Reg.WriteFloat('rBold', rBold);
  if Reg.ValueExists('rRed') then
    rRed := Reg.ReadFloat('rRed')
  else
    Reg.WriteFloat('rRed', rRed);
  if Reg.ValueExists('StBarAuto') then
    StBarAuto := Reg.ReadBool('StBarAuto')
  else begin
    StBarAuto := true;
    Reg.WriteBool('StBarAuto', StBarAuto);
  end;
  if Reg.ValueExists('StatChartBars') then
    StatChartBars := Reg.ReadInteger('StatChartBars')
  else
    Reg.WriteInteger('StatChartBars', StatChartBars);
  UsedFields := [];
  CurBool := True;
  if Reg.ValueExists('SID') then
    CurBool := Reg.ReadBool('SID')
  else Reg.WriteBool('SID', True);
  if CurBool then
    UsedFields := UsedFields + [SID];
  CurBool := True;
  if Reg.ValueExists('GID') then
    CurBool := Reg.ReadBool('GID')
  else Reg.WriteBool('GID', True);
  if CurBool then
    UsedFields := UsedFields + [GID];
  CurBool := True;
  if Reg.ValueExists('RGN') then
    CurBool := Reg.ReadBool('RGN')
  else Reg.WriteBool('RGN', True);
  if CurBool then
    UsedFields := UsedFields + [RGN];
  CurBool := True;
  if Reg.ValueExists('ROC') then
    CurBool := Reg.ReadBool('ROC')
  else Reg.WriteBool('ROC', True);
  if CurBool then
    UsedFields := UsedFields + [ROC];
  CurBool := True;
  if Reg.ValueExists('GBD') then
    CurBool := Reg.ReadBool('GBD')
  else Reg.WriteBool('GBD', True);
  if CurBool then
    UsedFields := UsedFields + [GBD];
  if Reg.ValueExists('CRD') then
    CurBool := Reg.ReadBool('CRD')
  else Reg.WriteBool('CRD', True);
  if CurBool then
    UsedFields := UsedFields + [CRD];

  if Reg.ValueExists('FavDiagram') then
    FavDiagram := Reg.ReadInteger('FavDiagram')
  else
    Reg.WriteInteger('FavDiagram', FavDiagram);
  if Reg.ValueExists('DefaultOrdField') then
    DefaultOrdField := Reg.ReadString('DefaultOrdField')
  else
    Reg.WriteString('DefaultOrdField', DefaultOrdField);
  if Reg.ValueExists('GeolIDTit') then
    GeolIDTit := Reg.ReadString('GeolIDTit')
  else
    Reg.WriteString('GeolIDTit', GeolIDTit);
  if Reg.ValueExists('RockTit') then
    RockTit := Reg.ReadString('RockTit')
  else
    Reg.WriteString('RockTit', RockTit);
  if Reg.ValueExists('RegionTit') then
    RegionTit := Reg.ReadString('RegionTit')
  else
    Reg.WriteString('RegionTit', RegionTit);
  if Reg.ValueExists('GBodyTit') then
    GBodyTit := Reg.ReadString('GBodyTit')
  else
    Reg.WriteString('GBodyTit', GBodyTit);
     {if Reg.ValueExists('MaxH') then
        MaxH:=Reg.ReadFloat('MaxH')
     else Reg.WriteFloat('MaxH',MaxH);
     if Reg.ValueExists('MinH') then
        MinH:=Reg.ReadFloat('MinH')
     else Reg.WriteFloat('MinH',MinH);
     if Reg.ValueExists('MaxAn') then
        MaxAn:=Reg.ReadFloat('MaxAn')
     else Reg.WriteFloat('MaxAn',MaxAn);
     if Reg.ValueExists('MinAn') then
        MinAn:=Reg.ReadFloat('MinAn')
     else Reg.WriteFloat('MinAn',MinAn); }
  Reg.CloseKey;
end;

procedure ReadIni;
begin
  CurProject.LoadProject(CurProjectN);
end;




procedure TConfigDlg.FormShow(Sender: TObject);
begin
  SpinEdit1.Value := MaxHALen;
  SpinEdit2.Value := MinCompCount;
  SpinEdit4.Value := ElSymLen;
  CheckBox1.Checked := OMax;
  CheckBox2.Checked := OSub;
  CheckBox3.Checked := SubF;
  CheckBox4.Checked := SubCl;
  CheckBox5.Checked := SubS;
  CheckBox6.Checked := SubC;
  CheckBox14.Checked := UseNDist;
  CheckBox15.Checked:=not Silent;
  SpinEdit5.Value := NDist;
  Edit3.Text := GEOLIDTit;
  Edit4.Text := RockTit;
  Edit5.Text := RegionTit;
  Edit6.Text := GBodyTit;
  GroupBox2.Enabled := CheckBox2.Checked;
  NumInp1.Value := MinCorrCount;
  NumInp2.Value := rBold;
  NumInp3.Value := rRed;
  DM1.ImpFields.Open;
  DM1.Sinonims.Open;
  Fe2Changed := False;
  Fe3Changed := False;
  SpinEdit5.Enabled := CheckBox14.Checked;
  CheckBox8.Checked := SID in UsedFields;
  CheckBox9.Checked := GID in UsedFields;
  CheckBox10.Checked := ROC in UsedFields;
  CheckBox11.Checked := RGN in UsedFields;
  CheckBox12.Checked := GBD in UsedFields;
  CheckBox13.Checked := CRD in UsedFields;
  if EnFormat = '0.###' then
    RadioGroup1.ItemIndex := 0
  else
    RadioGroup1.ItemIndex := 1
end;

procedure TConfigDlg.BitBtn1Click(Sender: TObject);
var i: integer;
  F: TextFile;
  FO: file;
begin
  if DM1.tabElem.State <> dsBrowse then
    DM1.tabElem.Post;
  MaxHALen := SpinEdit1.Value;
  MinCompCount := SpinEdit2.Value;
  ElSymLen := SpinEdit4.Value;
  OMax := CheckBox1.Checked;
  OSub := CheckBox2.Checked;
  SubF := CheckBox3.Checked;
  SubCl := CheckBox4.Checked;
  SubS := CheckBox5.Checked;
  SubC := CheckBox6.Checked;
  MinCorrCount := Round(NumInp1.Value);
  rBold := NumInp2.Value;
  rRed := NumInp3.Value;
  StatChartBars := SpinEdit3.Value;
  StBarAuto := CheckBox7.Checked;
  UsedFields := [];
  GEOLIDTit := Edit3.Text;
  RockTit := Edit4.Text;
  RegionTit := Edit5.Text;
  GBodyTit := Edit6.Text;
  UseNDist := CheckBox14.Checked;
  NDist := SpinEdit5.Value;
  Reg.OpenKey('Software', true);
  Reg.OpenKey('PETROS', True);
  Silent := not CheckBox15.Checked;
  if CheckBox8.Checked then begin
    UsedFields := UsedFields + [SID];
    Reg.WriteBool('SID', True);
  end else
    Reg.WriteBool('SID', False);
  if CheckBox9.Checked then begin
    UsedFields := UsedFields + [GID];
    Reg.WriteBool('GID', True);
  end else
    Reg.WriteBool('GID', False);
  if CheckBox10.Checked then begin
    UsedFields := UsedFields + [RGN];
    Reg.WriteBool('RGN', True);
  end else
    Reg.WriteBool('RGN', False);
  if CheckBox11.Checked then begin
    UsedFields := UsedFields + [ROC];
    Reg.WriteBool('ROC', True);
  end else
    Reg.WriteBool('ROC', False);
  if CheckBox12.Checked then begin
    UsedFields := UsedFields + [GBD];
    Reg.WriteBool('GBD', True);
  end else
    Reg.WriteBool('GBD', False);
  if CheckBox13.Checked then begin
    UsedFields := UsedFields + [CRD];
    Reg.WriteBool('CRD', True);
  end else
    Reg.WriteBool('CRD', False);
  Reg.WriteBool('UseNDist', UseNDist);
  Reg.WriteInteger('NDist', NDist);
  Reg.WriteInteger('MaxHALen', MaxHALen);
  Reg.WriteInteger('ElSymLen', ElSymLen);
  Reg.WriteInteger('MinCompCount', MinCompCount);
  Reg.WriteBool('OMax', OMax);
  Reg.WriteBool('OSub', OSub);
  Reg.WriteBool('SubF', SubF);
  Reg.WriteBool('SubCl', SubCl);
  Reg.WriteBool('SubS', SubS);
  Reg.WriteBool('SubC', SubC);
  Reg.WriteBool('StBarAuto', StBarAuto);
  Reg.WriteInteger('StatChartBars', StatChartBars);
  Reg.WriteInteger('MinCorrCount', MinCorrCount);
  Reg.WriteFloat('rBold', rBold);
  Reg.WriteFloat('rRed', rRed);
  Reg.WriteString('GEOLIDTit', GEOLIDTit);
  Reg.WriteString('RockTit', RockTit);
  Reg.WriteString('RegionTit', RegionTit);
  Reg.WriteString('GBodyTit', GBodyTit);
  Reg.WriteString('EnFormat', EnFormat);
  Reg.WriteString('DefaultOrdField', DefaultOrdField);
  Reg.CloseKey;
  if Fe2Changed then begin
    Fe2.Assign(ListBox1.Items);
    Fe2.SaveToFile('Fe2.txt');
  end;
  if Fe3Changed then begin
    Fe3.Assign(ListBox2.Items);
    Fe3.SaveToFile('Fe3.txt');
  end;
  for i := 1 to MendCount do
    if CLBox1.Checked[i - 1] then
      MMol[i] := 1
    else
      MMol[i] := 0;
  AssignFile(F, 'Moleculars.pti');
  Rewrite(F);
  for i := 1 to MendCount do
    write(F, MMol[i], ' ');
  CloseFile(F);
  for i := 1 to MendCount do begin
    if CLBox2.Checked[i - 1] then
      MOx[i] := 1
    else
      MOx[i] := 0;
    MendTab.MustOx[i] := mox[i];
  end;
  AssignFile(F, 'Oxides.pti');
  Rewrite(F);
  for i := 1 to MendCount do
    write(F, MOx[i], ' ');
  CloseFile(F);
  AssignFile(FO, 'ElSeq.pti');
  rewrite(FO);
  for i := 1 to MendCount do begin
    Ordr[i] := MendTab.GetNumber(OrdLb.Items[i - 1]);
    BlockWrite(FO, Ordr[i], SizeOf(Byte));
    MendTab.Order[i] := Ordr[i];
  end;
  CloseFile(FO);
end;

procedure TConfigDlg.CheckBox2Click(Sender: TObject);
begin
  GroupBox2.Enabled := CheckBox2.Checked;
end;

procedure TConfigDlg.Button1Click(Sender: TObject);
var
  s: string;
  an: TAnalis;
  i, k, l, Step, Id, n: integer;
begin
  BitBtn1Click(Sender);
  try
    Enabled := False;
   { DM1.TabD1.AutoCalcFields:=False;}
    //DM1.TabD1.Open;
    Screen.Cursor := crHourGlass;
    ProgressBar1.Visible := true;
    Label11.Visible := True;
    Label12.Visible := True;
    n := GetRecordCount('RHADATA', DM1.q1Time);
    with DM1.TabM1 do begin
      First;
      L := 1;
      while not EOF do begin
        try
          Label11.Caption := DM1.TabM1['ArrayName'];
          S := DM1.TabM1['Title1'];
          AnalisTitle.Free;
          AnalisTitle := TAnalisTitle.Create(S, DM1.TabM1['Type'] = 'nc');
          k := 0;
          Step := 0;
          openQr('Select * from RHADATA where ArrID=' + IntToStr(DM1.TabM1['ID']), DM1.TabD1);
          while not DM1.TabD1.EOF do begin
            try
              DM1.TabD1.Edit;
              an := TAnalis.CreateT(DM1.TabD1, DM1.TabM1);
              CalcFirst := True;
              an.Recalc(AnalisTitle);
              for I := 1 to MendCount do
                if An.Atom[i] > 0 then
                  DM1.TabD1['A' + IntToStr(I)] := an.ATOM[I]
                else DM1.TabD1['A' + IntToStr(I)] := null;
              CalcFirst := False;
              an.Recalc(AnalisTitle);
              DM1.TabD1['R'] := an.Rang;
              if (an.H > 0) and (an.A > 0) then begin
                DM1.TabD1['H'] := an.H;
                DM1.TabD1['A'] := an.A;
                DM1.TabD1['AN'] := an.an;
              end;
              DM1.TabD1['Eq'] := an.Eq;
              DM1.TabD1['Ox'] := An.Ox;
              DM1.TabD1['Aw'] := An.Aw;
              DM1.TabD1['AWA'] := An.AWA;
              DM1.TabD1['Summa'] := An.Summa;
              DM1.TabD1['MolFact'] := An.MolFactor;
              DM1.TabD1['MolFactAW'] := An.MolFactorAW;
              if (DM1.TabD1['Rock'] = null) and (Roc0 > 0) then
                DM1.TabD1['Rock'] := Roc0;
              if (DM1.TabD1['Region'] = null) and (Reg0 > 0) then
                DM1.TabD1['Region'] := Reg0;
              if (DM1.TabD1['GBody'] = null) and (GBod0 > 0) then
                DM1.TabD1['GBody'] := GBod0;
              if (DM1.TabD1['GeolId'] = null) and (Gid0 > 0) then
                DM1.TabD1['GeolId'] := Gid0;

              DM1.TabD1.Post;
              an.Free;
            except
              DM1.TabD1.Cancel;
              an.Free;
            end;
            inc(k);
            Inc(l);
            Inc(Step);
            ProgressBar1.Position := Round(100 * l / n);
            DM1.TabD1.Next;
            Label12.Caption := IntToStr(k);
            Application.ProcessMessages;

          end;
          Edit;
          DM1.TabM1['NAnal'] := k;
          DM1.TabM1['MAxHA'] := MaxHALen;
          Post;

        except
          ShowMessage('Recalculate error!');
          exit;
        end;
        Next;
      end;
    end;
  finally
    ProgressBar1.Visible := false;
    Label11.Visible := False;
    Label12.Visible := False;
    Screen.Cursor := crDefault;
    DM1.TabD1.Close;
    {DM1.TabD1.AutoCalcFields:=True;}
    Enabled := True;
  end;
end;

procedure TConfigDlg.BitBtn3Click(Sender: TObject);
begin
  Application.HelpContext(CurHelpContext);
end;



{ TProject }

procedure TProject.LoadProject(Id: Integer);
var i, j, n, m: integer;
  F: Textfile;
  S: string;
  Sq: TAdoQuery;
begin
  if not Assigned(QueryRolls) then begin
    QueryRolls := TQueryRolls.Create(Application);
{$IFDEF DEBUG}
    ShowMessage('QueryRolls Created');
{$ENDIF}
  end;
  if SetProject(ID) then begin
    QueryRolls.QueryChLBox.Items.Clear;
    for i := 0 to LQueries.Count - 1 do
      TAdoQuery(LQueries.Items[i]).Free;
    LQueries.Clear;
   // if FileExists(CurPath + 'Queries.ptr') then begin
     // try
      //  AssignFile(F, CurPath + 'Queries.ptr');
      //  Reset(F);
       // ReadLn(F, N);
    OpenQr('Select * from Queries order by Name', DM1.q1Time);
        //for i := 1 to n do begin
    while not DM1.q1Time.Eof do begin
          //ReadLn(F, S);
      QueryRolls.QueryChLBox.Items.Add(DM1.q1Time['Name']);
      Sq := TAdoQuery.Create(QueryRolls);
      Sq.Connection := DM1.ADOConnection1;
          {Readln(F, m);
          for j := 1 to m do begin
            ReadLn(F, S);
            Sq.SQL.Add(S);
          end; }
      Sq.SQL.Text := DM1.q1Time['SQL'];
      LQueries.Add(Sq);
      Application.ProcessMessages;
      DM1.q1Time.Next;
          {Sq.Open;}
    end;
    if QueryRolls.QueryChLBox.Items.Count > 0 then begin
      QueryRolls.QueryChLBox.ItemIndex := 0;
      QueryRolls.QueryChLBoxClick(nil);
    end;
     // finally
        //CloseFile(F);
     // end;
  end;
  execQr('delete from MainRHA  where not exists(Select * from RHADATA where ArrID=MainRHA.Id)',DM1.q1Time);
  //end;
end;

procedure TProject.SaveProject;
var F: Textfile;
  i, j, n: integer;
begin
  try
    {AssignFile(F, CurPath + 'Queries.ptr');
    Rewrite(F);
    WriteLn(F, LQueries.Count); }
    DM1.ADOConnection1.BeginTrans;
    ExecQr('Delete from Queries', DM1.q1Time);
    OpenQR('Select * from Queries', DM1.q1Time);
    for i := 0 to LQueries.Count - 1 do begin
      DM1.q1Time.Insert;
      DM1.q1Time['Name'] := QueryRolls.QueryChLBox.Items[i];
      DM1.q1Time['SQL'] := TAdoQuery(LQueries.Items[i]).SQL.Text;
      DM1.q1Time.Post;
     { Writeln(F, QueryRolls.QueryChLBox.Items[i]);
      n := TAdoQuery(LQueries.Items[i]).SQL.Count;
      Writeln(F, n);
      for j := 0 to n - 1 do
        WriteLn(F, TAdoQuery(LQueries.Items[i]).SQL[j]); }
    end;
    DM1.ADOConnection1.CommitTrans;
  except
    DM1.ADOConnection1.RollbackTrans;
    ShowMessage('Fail to save new and changed queries');
  end;
end;

function TProject.SetProject(Id: Integer): boolean;
begin
  Result := False;
  DM1.TTasks.Active := True;
  if DM1.TTasks.Locate('ID', ID, []) then begin
    MainForm.CloseAll;
    Alias := DM1.TTasks['Alias'];
    DataDes := DM1.TTasks['DataDes'];
    Name := DM1.TTasks['Name'];
    ProjectID := DM1.TTasks['PrId'];
    TableId := ID;
    CurPath := MainPath;
   {
    DM1.TabM1.Close;
    Dm1.TabLists.Close; }
   // ChangeAlias(Alias);

    Result := true;
    MainForm.Caption := 'PETROS 3.2.0: ' + Name;
    CurProjectN := ID;
  end;
end;

procedure TConfigDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM1.ImpFields.Close;
  DM1.Sinonims.Close;
end;

procedure TConfigDlg.BitBtn4Click(Sender: TObject);
begin
  DM1.Sinonims.Delete;
end;

procedure TConfigDlg.CheckBox7Click(Sender: TObject);
begin
  SpinEdit3.Enabled := not CheckBox7.Checked;
end;

procedure TConfigDlg.FormCreate(Sender: TObject);
var i: integer;
  F: TextFile;
begin
  MendTab.AlfaN := 0;
  Fe2.LoadFromFile('Fe2.txt');
  Fe3.LoadFromFile('Fe3.txt');
  ListBox1.Items.Assign(Fe2);
  ListBox2.Items.Assign(Fe3);
  ListBox1.ItemIndex := 0;
  ListBox2.ItemIndex := 0;
  if FileExists('Moleculars.pti') then begin
    AssignFile(F, 'Moleculars.pti');
    Reset(F);
    for i := 1 to MendCount do
      read(F, MMol[i]);
    CloseFile(F);
  end;
  for i := 1 to MendCount do begin
    CLBox1.Items.Add(MendTab.GetFieldTitle(i));
    CLBox1.Checked[i - 1] := MendTab.MustMol(i);
  end;
  if FileExists('Oxides.pti') then begin
    AssignFile(F, 'Oxides.pti');
    Reset(F);
    for i := 1 to MendCount do
      read(F, MOx[i]);
    CloseFile(F);
  end;
  for i := 1 to MendCount do begin
    MendTab.MustOx[i] := MOx[i];
    CLBox2.Items.Add(MendTab.GetFieldTitle(i));
    CLBox2.Checked[i - 1] := MOx[i] = 1;
  end;
  SetOrdList;
  ListBox3.Items.Add(DM1.TabD1.FieldByName('Descript').DisplayLabel);
  ListBox3.Items.Add(DM1.TabD1.FieldByName('Sample').DisplayLabel);
  ListBox3.Items.Add(DM1.TabD1.FieldByName('Num').DisplayLabel);
  ListBox3.Items.Add(DM1.TabD1.FieldByName('R').DisplayLabel);
  ListBox3.Items.Add(DM1.TabD1.FieldByName('H').DisplayLabel);
  ListBox3.Items.Add(DM1.TabD1.FieldByName('AN').DisplayLabel);
  ListBox3.Items.Add('SourceNum + Num');
  if DefaultOrdField = 'Descript' then
    ListBox3.ItemIndex := 0
  else if DefaultOrdField = 'Sample' then
    ListBox3.ItemIndex := 1
  else if DefaultOrdField = 'Num' then
    ListBox3.ItemIndex := 2
  else if DefaultOrdField = 'R' then
    ListBox3.ItemIndex := 3
  else if DefaultOrdField = 'H' then
    ListBox3.ItemIndex := 4
  else if DefaultOrdField = 'AN' then
    ListBox3.ItemIndex := 5
  else if DefaultOrdField = 'ArrNum, rhadata.Num' then
    ListBox3.ItemIndex := 6
  else
    ListBox3.ItemIndex := -1;
end;

procedure TConfigDlg.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex >= 0 then
    Edit1.Text := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TConfigDlg.ListBox2Click(Sender: TObject);
begin
  if ListBox2.ItemIndex >= 0 then
    Edit2.Text := ListBox2.Items[ListBox2.ItemIndex];
end;

procedure TConfigDlg.Button2Click(Sender: TObject);
begin
  ListBox1.Items.Add(Edit1.Text);
  Fe2Changed := True;
end;

procedure TConfigDlg.Button5Click(Sender: TObject);
begin
  ListBox2.Items.Add(Edit2.Text);
  Fe3Changed := True;
end;

procedure TConfigDlg.Button3Click(Sender: TObject);
var i: integer;
begin
  i := ListBox1.ItemIndex;
  if Edit1.Text = '' then begin
    ListBox1.Items.Delete(i);
    ListBox1.ItemIndex := i - 1;
  end else
    ListBox1.Items[i] := Edit1.Text;
  Fe2Changed := True;
end;

procedure TConfigDlg.Button4Click(Sender: TObject);
var i: integer;
begin
  i := ListBox2.ItemIndex;
  if Edit2.Text = '' then begin
    ListBox2.Items.Delete(i);
    ListBox2.ItemIndex := i - 1;
  end else
    ListBox2.Items[i] := Edit2.Text;
  Fe3Changed := True;
end;


procedure TConfigDlg.CLBox1Click(Sender: TObject);
begin
  if CLBox1.Checked[CLBox1.ItemIndex] <> (MendTab.MustMol(CLBox1.ItemIndex + 1)) then
    ShowMessage(stMustRecalk);
end;

procedure TConfigDlg.TabSheet1Enter(Sender: TObject);
begin
  CurHelpContext := TabSheet1.HelpContext;
end;

procedure TConfigDlg.TabSheet2Enter(Sender: TObject);
begin
  CurHelpContext := TabSheet2.HelpContext;
end;

procedure TConfigDlg.TabSheet5Enter(Sender: TObject);
begin
  CurHelpContext := TabSheet5.HelpContext;
end;

procedure TConfigDlg.TabSheet4Enter(Sender: TObject);
begin
  CurHelpContext := TabSheet4.HelpContext;
end;

procedure TConfigDlg.TabSheet3Enter(Sender: TObject);
begin
  CurHelpContext := TabSheet3.HelpContext;
end;

procedure TConfigDlg.PageControl1Change(Sender: TObject);
begin
  CurHelpContext := PageControl1.ActivePage.HelpContext;
end;

procedure TConfigDlg.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  PageControl1.ActivePage.SetFocus;
end;

procedure TConfigDlg.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DBGrid1.Canvas.Font.Color := clBlack;
  if DM1.tabElem['Color'] > 0 then
    DBGrid1.Canvas.Brush.Color := DM1.tabElem['Color'];
  DBGrid1.Canvas.Rectangle(Rect);
  DBgrid1.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, DM1.tabElem['Elem']);
  DBGrid1.Canvas.Brush.Color := clWhite;
end;

procedure TConfigDlg.Button6Click(Sender: TObject);
begin
  ColorDialog1.Color := DM1.tabElem['Color'];
  if ColorDialog1.Execute then begin
    DM1.tabElem.Edit;
    DM1.tabElem['Color'] := ColorDialog1.Color;
    DM1.tabElem.Post;
    DBGrid1.Invalidate;
  end;
end;

procedure TConfigDlg.SpeedButton1Click(Sender: TObject);
begin
  OrdLB.Items.Exchange(OrdLB.ItemIndex, OrdLB.ItemIndex - 1);
     {OrdLB.ItemIndex:=OrdLB.ItemIndex-1;}
  if OrdLB.ItemIndex = 0 then
    SpeedButton1.Enabled := False;
  SpeedButton2.Enabled := True;
end;

procedure TConfigDlg.SpeedButton2Click(Sender: TObject);
begin
  OrdLB.Items.Exchange(OrdLB.ItemIndex, OrdLB.ItemIndex + 1);
     {OrdLB.ItemIndex:=OrdLB.ItemIndex+1;}
  if OrdLB.ItemIndex = OrdLB.Items.Count - 1 then
    SpeedButton2.Enabled := False;
  SpeedButton1.Enabled := True;
end;

procedure TConfigDlg.OrdLBClick(Sender: TObject);
begin
  if OrdLB.ItemIndex < OrdLB.Items.Count then
    SpeedButton2.Enabled := True
  else
    SpeedButton2.Enabled := False;
  if OrdLB.ItemIndex > 0 then
    SpeedButton1.Enabled := True
  else
    SpeedButton1.Enabled := False;
end;

procedure TConfigDlg.Button7Click(Sender: TObject);
var i: Integer;
begin
  for i := 1 to MendCount do
    MendTab.Order[i] := Ordr[i];
  SetOrdList;
end;

procedure TConfigDlg.Button8Click(Sender: TObject);
var i: Integer;
begin
  for i := 1 to MendCount do
    MendTab.Order[i] := i;
  SetOrdList;
end;

procedure TConfigDlg.SetOrdList;
var i: Integer;
begin
  OrdLb.Items.Clear;
  for i := 1 to MendCount do begin
    OrdLb.Items.Add(MendTab.GetInterSymb(MendTab.Order[I]));
  end;
  OrdLb.ItemIndex := 0;
  SpeedButton1.Enabled := False;
  SpeedButton2.Enabled := True;
end;

procedure TConfigDlg.ListBox3Click(Sender: TObject);
begin
  if Visible then
    case ListBox3.ItemIndex of
      0: DefaultOrdField := 'Descript';
      1: DefaultOrdField := 'Sample';
      2: DefaultOrdField := 'Num';
      3: DefaultOrdField := 'R';
      4: DefaultOrdField := 'H';
      5: DefaultOrdField := 'AN';
      6: DefaultOrdField := 'ArrNum, rhadata.Num';
    end;
end;

procedure TConfigDlg.Button9Click(Sender: TObject);
var i: Integer;
begin
  for i := 1 to ClBox2.Items.Count do
    ClBox2.Checked[i - 1] := MOxD[i] = 1;
end;

procedure TConfigDlg.Button10Click(Sender: TObject);
var i: Integer;
begin
  for i := 1 to ClBox1.Items.Count do
    ClBox1.Checked[i - 1] := MMolD[i] = 1;
end;

procedure TConfigDlg.CheckBox14Click(Sender: TObject);
begin
  SpinEdit5.Enabled := CheckBox14.Checked;
end;

procedure TConfigDlg.Button11Click(Sender: TObject);
begin
  fimpAlpha.ShowModal;
end;

procedure TConfigDlg.Button12Click(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to remove alphabet No.' + intToStr(SpinEdit6.Value) + '?',
    mtWarning, [mbYes, mbNo], 0) = mrYes then begin
    ExecQr('delete from Elements where num between ' + intToStr(SpinEdit6.Value * 100 + 1) +
      ' and ' + intToStr((SpinEdit6.Value + 1) * 100), DM1.q1Time);
    DM1.tabElem.Refresh;
  end;
end;

procedure TConfigDlg.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    EnFormat := '0.###'
  else
    EnFormat := '0.###E+00'
end;

end.

