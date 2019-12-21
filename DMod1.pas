unit DMod1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, RHAGlobs, StrUtils, Variants, ADODB, AdoUtilsS, IniFiles, ESBRtns,
  ADOInt;

type
  TDM1 = class(TDataModule)
    DataSource4: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DSTasks: TDataSource;
    DSDiagr: TDataSource;
    DSField: TDataSource;
    DSLines: TDataSource;
    DSFPoint: TDataSource;
    DSLPoint: TDataSource;
    DSDiagrID: TDataSource;
    DSimpF: TDataSource;
    DSEdBook: TDataSource;
    DSSin: TDataSource;
    DsLists: TDataSource;
    DSGBod: TDataSource;
    DSGId: TDataSource;
    DSReg: TDataSource;
    DSRoc: TDataSource;
    DSDic: TDataSource;
    DSRec: TDataSource;
    DSVar: TDataSource;
    DSInterv: TDataSource;
    ADOConnection1: TADOConnection;
    TabM1: TADOTable;
    TTasks: TADOTable;
    TTables: TADOTable;
    TbDiagr: TADOTable;
    TbInterv: TADOTable;
    TbFields1: TADOTable;
    TbLines: TADOTable;
    TbFPoint1: TADOTable;
    TbLPoint: TADOTable;
    TbDiagrId: TADOTable;
    ImpFields: TADOTable;
    Sinonims: TADOTable;
    TabEdBook: TADOTable;
    TabLists: TADOTable;
    GeolIds: TADOTable;
    GBodies: TADOTable;
    Rocks: TADOTable;
    Regions: TADOTable;
    Diction: TADOTable;
    TabRec: TADOTable;
    TabVars: TADOTable;
    tabElem: TADOTable;
    TabM1Id2: TIntegerField;
    TabM1ArrayName2: TWideStringField;
    TabM1Source2: TIntegerField;
    TabM1Type2: TStringField;
    TabM1NAnal2: TIntegerField;
    TabM1NComp2: TIntegerField;
    TabM1Descript2: TStringField;
    TabM1MaxNum2: TIntegerField;
    TabM1MaxHA2: TIntegerField;
    GeolIdsID: TAutoIncField;
    GBodiesID: TAutoIncField;
    GBodiesDescript: TStringField;
    RocksId: TAutoIncField;
    RocksDescript: TStringField;
    RegionsID: TAutoIncField;
    RegionsDescript: TStringField;
    ImpFieldsId: TAutoIncField;
    ImpFieldsDName: TStringField;
    ImpFieldsFName: TStringField;
    ImpFieldsSize: TIntegerField;
    SinonimsId: TAutoIncField;
    SinonimsFieldId: TIntegerField;
    SinonimsText: TStringField;
    DictionId: TAutoIncField;
    DictionFieldId: TIntegerField;
    DictionWord: TStringField;
    DictionDesc: TIntegerField;
    TabListsID: TAutoIncField;
    TabListsName: TStringField;
    TabListsComment: TStringField;
    q1Time: TADOQuery;
    q2Time: TADOQuery;
    prClearData: TADOStoredProc;
    prClearAll: TADOStoredProc;
    qAnal: TADOQuery;
    qAnalLong: TADOQuery;
    qLongTime1: TADOQuery;
    qSource: TADOQuery;
    TabD1: TADOQuery;
    TabD1AnId: TAutoIncField;
    TabD1ArrId: TIntegerField;
    TabD1H: TFloatField;
    TabD1A: TFloatField;
    TabD1AN: TFloatField;
    TabD1R: TStringField;
    TabD1Eq: TStringField;
    TabD1Descript: TStringField;
    TabD1N1: TFloatField;
    TabD1N2: TFloatField;
    TabD1N3: TFloatField;
    TabD1N4: TFloatField;
    TabD1N5: TFloatField;
    TabD1N6: TFloatField;
    TabD1N7: TFloatField;
    TabD1N8: TFloatField;
    TabD1N9: TFloatField;
    TabD1N10: TFloatField;
    TabD1N11: TFloatField;
    TabD1N12: TFloatField;
    TabD1N13: TFloatField;
    TabD1N14: TFloatField;
    TabD1N15: TFloatField;
    TabD1N16: TFloatField;
    TabD1N17: TFloatField;
    TabD1N18: TFloatField;
    TabD1N19: TFloatField;
    TabD1N20: TFloatField;
    TabD1N21: TFloatField;
    TabD1N22: TFloatField;
    TabD1N23: TFloatField;
    TabD1N24: TFloatField;
    TabD1N25: TFloatField;
    TabD1N26: TFloatField;
    TabD1N27: TFloatField;
    TabD1N28: TFloatField;
    TabD1N29: TFloatField;
    TabD1N30: TFloatField;
    TabD1N31: TFloatField;
    TabD1N32: TFloatField;
    TabD1N33: TFloatField;
    TabD1N34: TFloatField;
    TabD1N35: TFloatField;
    TabD1N36: TFloatField;
    TabD1N37: TFloatField;
    TabD1N38: TFloatField;
    TabD1N39: TFloatField;
    TabD1N40: TFloatField;
    TabD1N41: TFloatField;
    TabD1N42: TFloatField;
    TabD1N43: TFloatField;
    TabD1N44: TFloatField;
    TabD1N45: TFloatField;
    TabD1N46: TFloatField;
    TabD1N47: TFloatField;
    TabD1N48: TFloatField;
    TabD1N49: TFloatField;
    TabD1N50: TFloatField;
    TabD1A1: TFloatField;
    TabD1A2: TFloatField;
    TabD1A3: TFloatField;
    TabD1A4: TFloatField;
    TabD1A5: TFloatField;
    TabD1A6: TFloatField;
    TabD1A7: TFloatField;
    TabD1A8: TFloatField;
    TabD1A9: TFloatField;
    TabD1A10: TFloatField;
    TabD1A11: TFloatField;
    TabD1A12: TFloatField;
    TabD1A13: TFloatField;
    TabD1A14: TFloatField;
    TabD1A15: TFloatField;
    TabD1A16: TFloatField;
    TabD1A17: TFloatField;
    TabD1A18: TFloatField;
    TabD1A19: TFloatField;
    TabD1A20: TFloatField;
    TabD1A21: TFloatField;
    TabD1A22: TFloatField;
    TabD1A23: TFloatField;
    TabD1A24: TFloatField;
    TabD1A25: TFloatField;
    TabD1A26: TFloatField;
    TabD1A27: TFloatField;
    TabD1A28: TFloatField;
    TabD1A29: TFloatField;
    TabD1A30: TFloatField;
    TabD1A31: TFloatField;
    TabD1A32: TFloatField;
    TabD1A33: TFloatField;
    TabD1A34: TFloatField;
    TabD1A35: TFloatField;
    TabD1A36: TFloatField;
    TabD1A37: TFloatField;
    TabD1A38: TFloatField;
    TabD1A39: TFloatField;
    TabD1A40: TFloatField;
    TabD1A41: TFloatField;
    TabD1A42: TFloatField;
    TabD1A43: TFloatField;
    TabD1A44: TFloatField;
    TabD1A45: TFloatField;
    TabD1A46: TFloatField;
    TabD1A47: TFloatField;
    TabD1A48: TFloatField;
    TabD1A49: TFloatField;
    TabD1A50: TFloatField;
    TabD1A51: TFloatField;
    TabD1A52: TFloatField;
    TabD1A53: TFloatField;
    TabD1A54: TFloatField;
    TabD1A55: TFloatField;
    TabD1A56: TFloatField;
    TabD1A57: TFloatField;
    TabD1A58: TFloatField;
    TabD1A59: TFloatField;
    TabD1A60: TFloatField;
    TabD1A61: TFloatField;
    TabD1A62: TFloatField;
    TabD1A63: TFloatField;
    TabD1A64: TFloatField;
    TabD1A65: TFloatField;
    TabD1A66: TFloatField;
    TabD1A67: TFloatField;
    TabD1A68: TFloatField;
    TabD1A69: TFloatField;
    TabD1A70: TFloatField;
    TabD1A71: TFloatField;
    TabD1A72: TFloatField;
    TabD1A73: TFloatField;
    TabD1A74: TFloatField;
    TabD1A75: TFloatField;
    TabD1A76: TFloatField;
    TabD1A77: TFloatField;
    TabD1A78: TFloatField;
    TabD1A79: TFloatField;
    TabD1A80: TFloatField;
    TabD1A81: TFloatField;
    TabD1A82: TFloatField;
    TabD1A83: TFloatField;
    TabD1A84: TFloatField;
    TabD1A85: TFloatField;
    TabD1A86: TFloatField;
    TabD1A87: TFloatField;
    TabD1A88: TFloatField;
    TabD1A89: TFloatField;
    TabD1A90: TFloatField;
    TabD1A91: TFloatField;
    TabD1A92: TFloatField;
    TabD1X: TStringField;
    TabD1Y: TStringField;
    TabD1Ox: TFloatField;
    TabD1AW: TFloatField;
    TabD1AWA: TFloatField;
    TabD1Num: TIntegerField;
    TabD1Sample: TStringField;
    TabD1Summa: TFloatField;
    TabD1Source: TIntegerField;
    TabD1GeolId: TIntegerField;
    TabD1Rock: TIntegerField;
    TabD1Region: TIntegerField;
    TabD1GBody: TIntegerField;
    TabD1LGId: TStringField;
    TabD1LRoc: TStringField;
    TabD1LReg: TStringField;
    TabD1LGBod: TStringField;
    TabD1LSource: TStringField;
    TabD1A93: TFloatField;
    TabD1A94: TFloatField;
    TabD1MolFact: TFloatField;
    TabD1MolFactAW: TFloatField;
    TabD1ArrNum: TStringField;
    TabM1Title1: TStringField;
    TabD1A95: TFloatField;
    TabD1A96: TFloatField;
    TabD1A97: TFloatField;
    TabD1A98: TFloatField;
    TabD1A99: TFloatField;
    TabD1A100: TFloatField;
    TabD1Alfa: TIntegerField;
    TabM1Alfa: TIntegerField;
    TabM2: TADOTable;
    IntegerField1: TIntegerField;
    WideStringField1: TWideStringField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField2: TStringField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    StringField3: TStringField;
    IntegerField7: TIntegerField;
    dsMain: TDataSource;
    TabM2ArrNum: TIntegerField;
    TabM1ArrNum: TIntegerField;
    TabD1E: TFloatField;
    TabD1t: TFloatField;
    TabD1Tn: TFloatField;
    qqCalcFields: TADOQuery;
    q3Time: TADOQuery;
    TabD1N51: TFloatField;
    TabD1N52: TFloatField;
    TabD1N53: TFloatField;
    TabD1N54: TFloatField;
    TabD1N55: TFloatField;
    TabD1N56: TFloatField;
    TabD1N57: TFloatField;
    TabD1N58: TFloatField;
    TabD1N59: TFloatField;
    TabD1N60: TFloatField;
    TbFields: TADOQuery;
    TbFPoint: TADOQuery;
    GeolIdsGeolId: TStringField;
    RocksRock: TStringField;
    RegionsRegion: TStringField;
    GBodiesGBody: TStringField;
    GeolIdsDescript: TStringField;
    procedure TabM1BeforeDelete(DataSet: TDataSet);
    procedure TabM1AfterDelete(DataSet: TDataSet);
    procedure TabEdBookAfterCancel(DataSet: TDataSet);
    procedure TabEdBookBeforePost(DataSet: TDataSet);
    procedure TabD2BeforePost(DataSet: TDataSet);
    procedure TabD2AfterInsert(DataSet: TDataSet);
    procedure TabM1AfterInsert(DataSet: TDataSet);
    procedure TabD2AfterPost(DataSet: TDataSet);
    procedure TabListsAfterScroll(DataSet: TDataSet);
    procedure TabD2CalcFields(DataSet: TDataSet);
    procedure TabListsBeforeDelete(DataSet: TDataSet);
    procedure TabD2BeforeDelete(DataSet: TDataSet);
    procedure GeolIdsBeforeDelete(DataSet: TDataSet);
    procedure GeolIdsBeforePost(DataSet: TDataSet);
    procedure DictionAfterInsert(DataSet: TDataSet);
    procedure TabRecBeforeDelete(DataSet: TDataSet);
    procedure TabVarsBeforePost(DataSet: TDataSet);
    procedure TabVarsAfterInsert(DataSet: TDataSet);
    procedure TbFields1AfterCancel(DataSet: TDataSet);
    procedure TbFields1AfterPost(DataSet: TDataSet);
    procedure TbFields1BeforeDelete(DataSet: TDataSet);
    procedure TbFPoint1AfterPost(DataSet: TDataSet);
    procedure TbFPoint1BeforePost(DataSet: TDataSet);
    procedure TbLinesBeforeDelete(DataSet: TDataSet);
    procedure TbLinesAfterCancel(DataSet: TDataSet);
    procedure TbLinesAfterPost(DataSet: TDataSet);
    procedure TbLPointAfterPost(DataSet: TDataSet);
    procedure TbLPointBeforePost(DataSet: TDataSet);
    procedure TbLinesBeforeScroll(DataSet: TDataSet);
    procedure TbFields1BeforeScroll(DataSet: TDataSet);
    procedure TbFields1BeforePost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure TabM1BeforePost(DataSet: TDataSet);
    procedure TabD1AfterOpen(DataSet: TDataSet);
    procedure TbFields1AfterOpen(DataSet: TDataSet);
    procedure tabElemBeforeDelete(DataSet: TDataSet);
    procedure DSDiagrDataChange(Sender: TObject; Field: TField);
    procedure TbFieldsAfterInsert(DataSet: TDataSet);
    procedure DSFieldDataChange(Sender: TObject; Field: TField);
    procedure TbFPointAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    SQLUserPassword: string[20];
    SQLUserName: string[20];
    SQLServer: string;
    SQLDataBase: string;
    WinLogon: Boolean;
    function GetAnal(IdAn: Integer): Boolean;
    function GetAnalLong(IdAn: Integer): Boolean;
    function GetFullAnal(IdAn: Integer): Boolean;
    procedure SaveConnectionInfo;
    procedure LoadConnectionInfo;
    procedure DataBaseChange;
    procedure CloseAll;
    procedure ConnectToTab;
    procedure AskforSettings;
  end;

var
  DM1: TDM1;
  BookEdits: TForm;
  LastNum: integer;
  NewFPoint: Boolean;
  NewLPoint: Boolean;
const
  stConnectionString = WideString('Provider=SQLOLEDB.1;Persist Security Info=False;' +
    'Use Procedure for Prepare=1;Auto Translate=True;' +
    'Packet Size=4096;Workstation ID=SQLSERVER;Use Encryption for Data=False;Tag with column collation when possible=False;');



function GetConcentration(Quer: TDataSet; Num: integer; Cod: TDatType): Double;
function GetConcValue(Quer: TDataSet; Num: integer; Cod: TDatType): Variant;
function GetDataTitle(Num: integer; AnType: TDatType; RecId: integer): string;
procedure GetPresents(Quer: TDataSet; var Pres: TPresents);
function GetDataValue(Quer: TDataSet; Num: integer; Cod: TDatType; RecId: integer): Double;
function PresentInData(Pres: TPresents; Num: integer; AnType: TDatType; RecId: integer): boolean;
function CanPresent(Num: Integer; AnType: TDatType; RecId: integer): boolean;
function NotNullValue(Quer: TDataSet; Num: integer; Cod: TDatType; RecId: integer): boolean;

resourcestring
  stNotDel1 = 'This item cannot be deleted';

implementation

uses Analise, ArrayRolls, NewArr, ImportAn, Chemist, ImpWiz, Main,
  EdBook, DeletDescr, Dictionar, StDiagProp, Options, SQLSettings;

{$R *.DFM}

procedure TDM1.TabM1BeforeDelete(DataSet: TDataSet);
var n, i, k: integer;
begin
  try
    Screen.Cursor := crHourGlass;
    try
      ExecQr('Delete from RHAData where ArrId=' + intToStr(DataSet['ID']), q1Time);
    except
      ShowMessage('Delete error!');
      Abort;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDM1.TabM1AfterDelete(DataSet: TDataSet);
begin
  if TabM1.EOF then
    ArrayRollsUp.Edit1.Text := '';
end;

procedure TDM1.TabEdBookAfterCancel(DataSet: TDataSet);
begin
  if BookEdits = DLNew then
    DlNew.TabEdBookAfterCancel(DataSet)
  else
    if BookEdits = WizForm then
      WizForm.TabEdBookAfterCancel(DataSet);
  if BookEdits = EdBookForm then
    EdBookForm.TabEdBookAfterCancel(DataSet);
end;

procedure TDM1.TabEdBookBeforePost(DataSet: TDataSet);
begin
  if BookEdits = DLNew then
    DlNew.TabEdBookBeforePost(DataSet)
  else
    if BookEdits = WizForm then
      WizForm.TabEdBookBeforePost(DataSet);
end;

procedure TDM1.TabD2BeforePost(DataSet: TDataSet);
var
  An: TAnalis;
  i: integer;
  Nul: boolean;
begin
  if DataSet['AnId'] = Null then
    i := 0
  else
    i := DataSet['AnId'];
  repeat
    if (DataSet['Sample'] <> null) then begin
      if OpenQr('Select * from RHADATA where Sample=''' +
      DataSet['Sample'] + ''' and ANID!=' + IntToStr(i), DM1.q3Time)
      then begin
      ShowMessage(stDoubleID + ' (' + DataSet['Sample'] + ')' + stMark);
      DataSet['Sample'] := DataSet['Sample'] + '!';
      end else
        Break;
    end else
      Break;
  until False;

  An := TAnalis.CreateT(DataSet, DM1.TabM1);
  CalcFirst := True;
  Nul := true;
  for i := 1 to AnalisTitle.Count do
    if TAComponent(An.Items[I - 1]).Value > 1E-20 then begin
      Nul := false;
      break;
    end;
  if Nul then begin
    ShowMessage(StAnal + DataSet['Descript'] + stNotel);
    Inc(DeletedAn);
    An.Free;
    Abort;
    exit;
  end;
  An.Recalc(AnalisTitle);
  if Nel < MinCompCount then begin
    if not Silent then
      ShowMessage(stAnNum + DataSet['Sample'] + stNotEnComp + IntToStr(MinCompCount)
        + ')' + stWillNotInput);
    an.Free;
    Inc(DeletedAn);
    Abort;
  end;
  Inc(LastNum);
  DataSet['Alfa'] := DM1.TabM1['Alfa'];
  for i := 1 to MendCount do
    if An.Atom[i] >= 0 then
      DataSet['A' + intToStr(i)] := An.Atom[i];
  CalcFirst := False;
  An.Recalc(AnalisTitle);
  DataSet['ArrId'] := DM1.TabM1['Id'];
  DataSet['R'] := An.Rang;
  if (an.A <> 0) or (an.E > 0) then begin
    DataSet['H'] := An.H;
    // Round(An.H * 1000) / 1000;
    DataSet['A'] := Round(An.A * 1000) / 1000;
    DataSet['AN'] := Round(An.AN * 1000) / 1000;
    DataSet['T'] := Round(An.TTT * 1000) / 1000;
    DataSet['Tn'] := Round(An.Tn * 1000) / 1000;
    if An.E<0.001 then
    DataSet['E'] :=An.E
    else
    DataSet['E'] := Round(An.E * 1000) / 1000;
  end;
  DataSet['Eq'] := An.EQ;
  DataSet['Ox'] := An.Ox;
  DataSet['Aw'] := An.Aw;
  DataSet['AWA'] := An.AWA;
  DataSet['Summa'] := An.Summa;
  DataSet['MolFact'] := An.MolFactor;
  DataSet['MolFactAW'] := An.MolFactorAW;
  An.Free;
end;

procedure TDM1.TabD2AfterInsert(DataSet: TDataSet);
begin
  DataSet['Num'] := LastNum + 1;
  DataSet['Descript'] := IntToStr(LastNum + 1) +
    '-' + DM1.TabM1['ArrayName'] + ' ';
  DataSet['Sample'] := IntToStr(DM1.TabM1['Id']) + '-' + IntToStr(LastNum + 1);
  DataSet['ArrId'] := DM1.TabM1['Id'];
  try
    DataSet.FieldByName('Source').value := DM1.TabM1['Source'];
  if Roc0 > 0 then
    DataSet['Rock'] := Roc0;
  if Reg0 > 0 then
    DataSet['Region'] := Reg0;
  if GBod0 > 0 then
    DataSet['GBody'] := GBod0;
  if Gid0 > 0 then
    DataSet['GeolId'] := Gid0;
  except
  end;
  openQr('Select Num from Source where Id=' + IntToStr(DM1.TabM1['Source']), q1Time);
  DataSet['ArrNum'] := PadChLeftStr(q1Time.FieldByName('Num').AsString, ' ', 5) + '-' + IntToStr(DM1.TabM1['Id']);
end;

procedure TDM1.TabM1AfterInsert(DataSet: TDataSet);
begin
  LastNum := 0;
  TabM1['MaxHA'] := MaxHALen;
  TabM1['Alfa'] := 0;
  TabM1['Type'] := 'cv';
end;

procedure TDM1.TabD2AfterPost(DataSet: TDataSet);
var id: integer;
begin
  Id := DataSet['Num'];
  if (DataSet['Sample'] <> null) and (DataSet.Locate('ArrId;Sample',
    VarArrayOf([DataSet['ArrId'], DataSet['Sample']]), [])) and
    (DataSet['Num'] <> ID) then begin
    ShowMessage(stDoubleID);
    Abort;
  end;
end;

procedure TDM1.TabListsAfterScroll(DataSet: TDataSet);
begin
  if Assigned(MainForm) then begin
    if (TabLists.State = dsBrowse) and (TabLists['Name'] <> null) then
      MainForm.StatusLine.Panels[0].Text := stCurList + TabLists['Name']
    else
      MainForm.StatusLine.Panels[0].Text := stCurList + stNone;
  end;
end;

procedure TDM1.TabD2CalcFields(DataSet: TDataSet);
var Sou: Variant;
begin

  if DataSet['Source'] <> Null then begin
    if openQr('Select Convert(varchar(6),Num) +IsNull('', ''+Author,'''')+ISNull('', ''+Title,'''')as S from Source where ID='
      + intToStr(DataSet['Source']), DM1.qqCalcFields) and
      (DM1.qqCalcFields['S'] <> Null) then
      DataSet['LSource'] := Copy(DM1.qqCalcFields['S'], 1, 255);
  end;
end;

procedure TDM1.TabListsBeforeDelete(DataSet: TDataSet);
begin
  ExecQr('Delete From ListData where List=' + IntToStr(DataSet['ID']), q1Time);
end;

function GetConcValue(Quer: TDataSet; Num: integer; Cod: TDatType): Variant;
var Val: Double;
begin
  Result := Null;
  if (Num < 1) or (Num > ShowCount) then abort;

  if Quer[GetFieldName(Num)] <> Null then begin
    Val := Quer[GetFieldName(Num)];
    if (Quer['Alfa'] = 0) and (Num <= 92) then
      case Cod of
            {Атомные проценты}
        dtAtomn: Result := Val;
              {Атомные проценты без H2O}
        dtAtomnAW: if Num > 1 then begin
            Result := Val * (Quer['AWA']);
            if (Num = 8) and (Quer['A1'] <> null) then
              Result := Result - 0.5 * Quer['A1'] * Quer['AWA'];
          end;
              {Molecular %}
        dtMol: if MendTab.MustMol(Num) then
            Result := Val * Quer['MolFact'] / MendTab.GetKatSteh(Num);
              {Molecular % без H2O}
        dtMolAW: if MendTab.MustMol(Num) and (Num > 1) then
            Result := Val * Quer['MolFactAW'] / MendTab.GetKatSteh(Num);
          {Весовые проценты}
        dtWeight: if (Num <> 8) then
            Result := Val * Quer['Summa'] * MendTab.GetPetroVes(Num) / (Quer['Ox'] * 100);
           {Весовые проценты на 100%}
        dtWeight100: if (Num <> 8) then
            Result := Val * MendTab.GetPetroVes(Num) / (Quer['Ox']);

            {Весовые проценты без H2O}
        dtWeightAW: if (Num > 1) and (Num <> 8) then
            Result := Val * MendTab.GetPetroVes(Num) / Quer['AW'];
      end else
      Result := Val;
  end;
end;

function GetConcentration(Quer: TDataSet; Num: integer; Cod: TDatType): Double;
var V: Variant;
begin
  if (Num < 1) or (Num > ShowCount) then abort;
  V := GetConcValue(Quer, Num, Cod);
  if V = null then
    Result := 0
  else
    Result := V;
end;

function GetDataTitle(Num: integer; AnType: TDatType; RecId: integer): string;
begin
  if MendTab.AlfaN > 0 then
    Result := MendTab.GetFieldTitle(Num)
  else begin
    Result := '';
    case AnType of
      dtAtomn: Result := MendTab.GetFieldTitle(Num);
      dtAtomnAW: if Num > 1 then Result := MendTab.GetFieldTitle(Num);
      dtMol: if MendTab.MustMol(Num) then
          Result := MendTab.GetPetroSym(Num);
      dtMolAw: if MendTab.MustMol(Num) and (Num > 1) then
          Result := MendTab.GetPetroSym(Num);
      dtWeight: Result := MendTab.GetPetroSym(Num);
      dtWeight100: Result := MendTab.GetPetroSym(Num);
      dtWeightAW: if Num > 1 then Result := MendTab.GetPetroSym(Num);
    end;
  end;
end;

procedure GetPresents(Quer: TDataSet; var Pres: TPresents);
var i, j: integer;
begin
  for j := 1 to ShowCount do
    Pres[j] := false;
  with Quer do begin
    try
      DisableControls;
      first;
      while not EOF do begin
        for i := 1 to MendCount do begin
          j := MendTab.Order[i] mod 100;
          if J = 0 then
            j := 100;
          if (Quer['A' + IntToStr(j)] <> null) and (Quer['A' + IntToStr(j)] >= 0)
          then
            Pres[j] := True;
        end;
        if Quer['H'] <> Null then Pres[101] := True;
        if Quer['An'] <> Null then Pres[102] := True;
        if Quer['Tn'] <> Null then Pres[103] := True;
        Next;
      end;
      First;
    finally
      Quer.EnableControls;
    end;
  end;
end;

function PresentInData(Pres: TPresents; Num: integer; AnType: TDatType; RecId: integer): boolean;
begin
  Result := Pres[Num] and CanPresent(Num, AnType, RecId);
end;

function NotNullValue(Quer: TDataSet; Num: integer; Cod: TDatType; RecId: integer): boolean;
begin
  if Cod in [dtAtomn..dtWeightAw] then
    Result := Quer['A' + IntToStr(Num)] <> Null
  else
    Result := False;
end;

function CanPresent(Num: Integer; AnType: TDatType; RecId: integer): boolean;
begin
  if (MendTab.AlfaN = 0) then
    case AnType of
      dtAtomn: Result := True;
      dtAtomnAW: Result := (Num > 1);
      dtMol: Result := MendTab.MustMol(Num);
      dtMolAw: Result := MendTab.MustMol(Num) and (Num > 1);
      dtWeight, dtWeight100: Result := (Num <> 8);
      dtWeightAW: Result := (Num <> 8) and (Num > 1);
    else
      Result := False;
    end else
    Result := True;
end;


function GetDataValue(Quer: TDataSet; Num: integer; Cod: TDatType; RecId: integer): Double;
begin
  if Cod in [dtAtomn, dtAtomnAW, dtMol, dtMolAw, dtWeight, dtWeight100, dtWeightAw] then
    Result := GetConcentration(Quer, Num, Cod);
end;

procedure TDM1.TabD2BeforeDelete(DataSet: TDataSet);
begin
  ExecQr('Delete From ListData where Anal=' + IntToStr(DataSet['AnID']), q1Time);
end;

procedure TDM1.GeolIdsBeforeDelete(DataSet: TDataSet);
var FieldName: string;
  FID: integer;
  WasOpen: Boolean;
  WasFilt: Boolean;
  Filt: string;
begin
  if DataSet.Fields[1].AsString = '?' then begin
    ShowMessage(stNotDel1);
    Abort;
  end;
  if DataSet = GeolIds then begin
    FieldName := 'GeolId';
    DeletDial.ListBox1.Items.Assign(Deletdial.LGeolId);
    FID := 8;
  end;
  if DataSet = Rocks then begin
    FieldName := 'Rock';
    DeletDial.ListBox1.Items.Assign(Deletdial.LRock);
    FID := 6;
  end;
  if DataSet = Regions then begin
    FieldName := 'Region';
    DeletDial.ListBox1.Items.Assign(Deletdial.LRegion);
    FID := 7;
  end;
  if DataSet = GBodies then begin
    FieldName := 'GBody';
    DeletDial.ListBox1.Items.Assign(Deletdial.LGBody);
    FID := 9;
  end;
  DeletDial.Label2.Caption := DataSet[FieldName];
  if openQr('Select * from RHADATA where ' + FieldName + '=' + IntToStr(DataSet['Id']), DM1.q1Time)
    then begin

    if DeletDial.ShowModal = mrOK then
      ExecQr('update RHADATA set ' +
        IntToStr(TInt(DeletDial.ListBox1.Items.Objects[DeletDial.ListBox1.ItemIndex]).N) +
        ' where ' + FieldName + '=' + IntToStr(DataSet['Id']), DM1.q1Time)
    else
      Abort;
  end;
  if DataSet = Rocks then begin
    DeletDial.LRock.Objects[DeletDial.LRock.IndexOf(DeletDial.Label2.Caption)].Free;
    DeletDial.LRock.Delete(DeletDial.LRock.IndexOf(DeletDial.Label2.Caption));
  end else
    if DataSet = GBodies then begin
      DeletDial.LGBody.Objects[DeletDial.LGBody.IndexOf(DeletDial.Label2.Caption)].Free;
      DeletDial.LGBody.Delete(DeletDial.LGBody.IndexOf(DeletDial.Label2.Caption));
    end else
      if DataSet = Regions then begin
        DeletDial.LRegion.Objects[DeletDial.LRegion.IndexOf(DeletDial.Label2.Caption)].Free;
        DeletDial.LRegion.Delete(DeletDial.LRegion.IndexOf(DeletDial.Label2.Caption));
      end else
        if DataSet = GeolIds then begin
          DeletDial.LGeolId.Objects[DeletDial.LGeolId.IndexOf(DeletDial.Label2.Caption)].Free;
          DeletDial.LGeolId.Delete(DeletDial.LGeolId.IndexOf(DeletDial.Label2.Caption));
        end;
  WasOpen := Diction.Active;
  WasFilt := Diction.Filtered;
  Filt := Diction.Filter;
  Diction.Close;
  Diction.Filter := '(FieldID=' + IntToStr(FId) + ')and(Desc=' +
    IntToStr(DataSet['ID']) + ')';
  Diction.Filtered := True;
  Diction.Active := True;
  while Diction.FindFirst do
    Diction.Delete;
  Diction.Close;
  Diction.Active := WasOpen;
  Diction.Filter := Filt;
  Diction.Filtered := WasFilt;
end;

procedure TDM1.GeolIdsBeforePost(DataSet: TDataSet);
var i: integer;
  MustAdd: Boolean;
  L: TStringList;
  FieldName: string;
begin
  MustAdd := True;
  if Dataset = GeolIds then begin
    FieldName := 'GeolId';
    L := DeletDial.LGeolId;
  end else
    if Dataset = GBodies then begin
      FieldName := 'GBody';
      L := DeletDial.LGBody;
    end else
      if Dataset = Rocks then begin
        FieldName := 'Rock';
        L := DeletDial.LRock;
      end else
        if Dataset = Regions then begin
          FieldName := 'Region';
          L := DeletDial.LRegion;
        end;
  for i := 0 to L.Count - 1 do
    if DataSet['Id'] = TInt(L.Objects[i]).N then begin
      L.Strings[i] := DataSet[FieldName];
      MustAdd := True;
      break;
    end;
  if MustAdd then begin
    L.Add(DataSet[FieldName]);
    L.Objects[L.Count - 1] := TInt.Create(DataSet['Id']);
  end;

end;

procedure TDM1.DictionAfterInsert(DataSet: TDataSet);
begin
  if IsEdit then begin
    Diction['FieldId'] := FieldId;
    Diction['Desc'] := Sinonimform.DBGrid1.DataSource.DataSet['Id'];
  end;
end;

procedure TDM1.TabRecBeforeDelete(DataSet: TDataSet);
begin
  with TabVars do begin
    First;
    while not eof do
      Delete;
  end;
end;

procedure TDM1.TabVarsBeforePost(DataSet: TDataSet);
begin
  if (TabVars['Pos'] = null) or (tabVars['Name'] = Null) then
    Abort;
end;

procedure TDM1.TabVarsAfterInsert(DataSet: TDataSet);
begin
  TabVars['Pos'] := TabVars.RecordCount + 1;
  TabVars['DFormat'] := '#0.##';
end;

procedure TDM1.TbFields1AfterCancel(DataSet: TDataSet);
begin
  TbFPoint.Cancel;
  if Newdiagr.Visible and (TbFields.State = dsInsert) then begin
    NewDiagr.Diag.Remove(NewDiagr.F);
    FreeandNil(NewDiagr.F);
  end;
end;

procedure TDM1.TbFields1AfterPost(DataSet: TDataSet);
begin
  if Newdiagr.Visible then begin
    MayChange := True;
    if TbFields['Name1'] <> Null then
      NewDiagr.F.Name1 := TbFields['Name1'];
    if TbFields['ClassID'] <> null then
      NewDiagr.F.ClId := TbFields['ClassID']
    else
      NewDiagr.F.ClId := '';
  end;
end;

procedure TDM1.TbFields1BeforeDelete(DataSet: TDataSet);
begin
  with TbFpoint do begin
    First;
    while not eof do
      Delete;
  end;
end;

procedure TDM1.TbFPoint1AfterPost(DataSet: TDataSet);
begin
  if NewDiagr.Visible and not NewDiagr.NotFPointPost then
    NewDiagr.AfterPointPost(NewFPoint);
end;

procedure TDM1.TbFPoint1BeforePost(DataSet: TDataSet);
begin
  if NewDiagr.Visible and not NewDiagr.NotFPointPost then begin
    if tbFPoint.State = dsInsert then begin
      NewFPoint := True;
      if not NewDiagr.InsertByButton then
        PointNum := NewDiagr.F.Count;
    end else
      NewFPoint := False;
    if tbFPoint['X'] = null then
      tbFPoint['X'] := 0;
    if tbFPoint['Y'] = null then
      tbFPoint['Y'] := 0;
    if TbFPoint['TypCod'] = Null then
      TbFPoint['TypCod'] := PointNum + 1;
    TbFPoint['Cod'] := NewDiagr.F.Cod;
  end;
end;

procedure TDM1.TbLinesBeforeDelete(DataSet: TDataSet);
begin
  with TbLpoint do begin
    First;
    while not eof do
      Delete;
  end;
end;

procedure TDM1.TbLinesAfterCancel(DataSet: TDataSet);
begin
  TbLPoint.Cancel;
  if Newdiagr.Visible and (TbLines.State = dsInsert) then begin
    NewDiagr.Diag.Lines.Remove(NewDiagr.Lin);
    FreeAndNil(NewDiagr.Lin);
  end;
end;

procedure TDM1.TbLinesAfterPost(DataSet: TDataSet);
begin
  if Newdiagr.Visible then begin
    if TbLines['Name1'] <> Null then
      NewDiagr.Lin.Name1 := TbLines['Name1'];
    if TbLines['ClassID'] <> null then
      NewDiagr.Lin.ClId := TbLines['ClassID']
    else
      NewDiagr.Lin.ClId := '';
  end;
end;

procedure TDM1.TbLPointAfterPost(DataSet: TDataSet);
begin
  if NewDiagr.Visible and not NewDiagr.NotLPointPost then
    NewDiagr.AfterLPointPost(NewLPoint);
end;

procedure TDM1.TbLPointBeforePost(DataSet: TDataSet);
begin
  if NewDiagr.Visible and not NewDiagr.NotLPointPost then begin
    if tbLPoint.State = dsInsert then begin
      NewLPoint := True;
      if not NewDiagr.InsertByButton then
        LPointNum := NewDiagr.Lin.Count;
    end else
      NewLPoint := False;
    if tbLPoint['X'] = null then
      tbLPoint['X'] := 0;
    if tbLPoint['Y'] = null then
      tbLPoint['Y'] := 0;
    if TbLPoint['TypCod'] = Null then
      TbLPoint['TypCod'] := LPointNum + 1;
    TbLPoint['Cod'] := NewDiagr.Lin.Cod;
  end;
end;

procedure TDM1.TbLinesBeforeScroll(DataSet: TDataSet);
begin
  if DM1.TbLPoint.State <> dsBrowse then
    DM1.TbLPoint.Post;
end;

procedure TDM1.TbFields1BeforeScroll(DataSet: TDataSet);
begin
  if DM1.TbFPoint.State <> dsBrowse then
    DM1.TbFPoint.Post;
  if DM1.TbFields.State <> dsBrowse then
    DM1.TbFields.Post;
end;

procedure TDM1.TbFields1BeforePost(DataSet: TDataSet);
begin
  if (NewDiagr.Visible) and (Assigned(NewDiagr.F)) and (not FirstPost) and
    (NewDiagr.F.Count < 3) then begin
    ShowMessage(stNotEnPoints);
    MayChange := False;
    Abort;
  end;
end;

procedure TDM1.DataModuleDestroy(Sender: TObject);
begin
  ADOConnection1.Connected := False;
  SaveConnectionInfo;
end;

procedure TDM1.SaveConnectionInfo;
begin
  Ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    Ini.WriteString(Name, 'SQLServer', SQLServer);
    Ini.WriteString(Name, 'SQLDataBase', SQLDataBase);
    Ini.WriteString(Name, 'SQLUserName', SQLUserName);
    Ini.WriteString(Name, 'SQLPassword', SQLUserPassword);
    Ini.WriteBool(Name, 'WinLogon', WinLogon);
    Ini.WriteInteger('Projects', 'CurProject', CurProjectN);
    Ini.WriteInteger('Projects', 'LastN', LastProjectN);
  finally
    Ini.Free;
  end;
end;



procedure TDM1.DataModuleCreate(Sender: TObject);
begin
   // SetGlobalVars;
  LoadConnectionInfo;
  DataBaseChange;
  ElemTab := tabElem;
end;

procedure TDM1.LoadConnectionInfo;
begin
  Ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    SQLServer := Ini.ReadString(Name, 'SQLServer', '(local)');
    SQLDataBase := Ini.ReadString(Name, 'SQLDataBase', 'PETROSBASE');
    SQLUserName := Ini.ReadString(Name, 'SQLUserName', 'sa');
    SQLUserPassword := Ini.ReadString(Name, 'SQLPassword', '123456');
    WinLogon := Ini.ReadBool(Name, 'WinLogon', False);
    LastProjectN := Ini.ReadInteger('Projects', 'LastN', 1);
    CurProjectN := Ini.ReadInteger('Projects', 'CurProject', 1)
  finally
    Ini.Free;
  end;
end;


procedure TDM1.DataBaseChange;
var S: Widestring;
begin
  S := stConnectionString;
  if WinLogon then
    S := S + 'Integrated Security=SSPI;';
  S := S + 'Password=' + WideString(SQLUserPassword) +
    ';User ID=' + WideString(SQLUserName) + ';Initial Catalog=' +
    SQLDataBase + ';Data Source=' + SQLServer;
  CloseAll;
  ADOConnection1.Connected := False;
  ADOConnection1.ConnectionString := S;
  ConnectToTab;
end;

procedure TDM1.CloseAll;
begin
  if Assigned(MainForm) then
    MainForm.CloseAll;
end;

procedure TDM1.ConnectToTab;
begin
  try
    AdoConnection1.Connected := True;
  except
    if MessageDlg(WideString('Can not open database connection. Do You want to')
      + #13 + #10 + 'change connection properties?', mtError, [mbYes, mbNo], 0) = mrYes then begin
      AskForSettings;
      Application.ProcessMessages;
      DataBaseChange;
      Exit;
    end else
      Halt;
  end;
  try
    TabElem.Open;
    DM1.TabM1.Open;
    TabM1.Properties['Update Criteria'].Value := adCriteriaKey;
    TabLists.Open;
    TabLists.Properties['Update Criteria'].Value := adCriteriaKey;
  except
    on E: Exception do
      ShowMessage('Database tables open error: ' + E.Message);
  end;

end;

procedure TDM1.AskforSettings;
begin
  fSQLSettings := TfSQLSettings.Create(Application);
  fSQLSettings.Edit1.Text := SQLServer;
  fSQLSettings.Edit2.Text := SQLDataBase;
  fSQLSettings.Edit3.Text := SQLUserName;
  fSQLSettings.Edit4.Text := SQLUserPassword;
  if WinLogon then
    fSQLSettings.RadioGroup1.ItemIndex := 0
  else
    fSQLSettings.RadioGroup1.ItemIndex := 1;
  if fSQLSettings.ShowModal = mrOK then begin
    SQLServer := fSQLSettings.Edit1.Text;
    SQLDataBase := fSQLSettings.Edit2.Text;
    SQLUserName := fSQLSettings.Edit3.Text;
    SQLUserPassword := fSQLSettings.Edit4.Text;
    WinLogon := fSQLSettings.RadioGroup1.ItemIndex = 0;
    fSQLSettings.Free;
   // DataBaseChange;
  end else
    fSQLSettings.Free;
end;


function TDM1.GetAnal(IdAn: Integer): Boolean;
begin
  Result := OpenQr('Select * from RHADATA where AnId=' + InttoStr(IdAn), qAnal);
end;

function TDM1.GetAnalLong(IdAn: Integer): Boolean;
begin
  Result := OpenQr('Select * from RHADATA where AnId=' + InttoStr(IdAn), qAnalLong);
end;

function TDM1.GetFullAnal(IdAn: Integer): Boolean;
begin
  Result := OpenQr('Select *, (Select Region from Regions  where id=d.Region)as RegionVal,' +
    '(Select Rock from Rocks  where id=d.Rock)as RockVal,' +
    '(Select GBody from GBodies  where id=d.GBody)as GBodyVal,' +
    '(Select GeolId from GeolIds  where id=d.GeolId)as GeolIdVal' +
    ' from RHADATA d where AnId=' + InttoStr(IdAn), qAnal);
end;

procedure TDM1.DataSource2DataChange(Sender: TObject; Field: TField);
begin
  if (field = nil) and (TabM1['Source'] <> null) then
    OpenQr('Select * from Source where Id=' + intToStr(TabM1['Source']), qSource)
end;

procedure TDM1.TabM1BeforePost(DataSet: TDataSet);
begin
  if (DataSet['Source'] <> Null) and
    OpenQr('Select Num from Source where Id=' + IntToStr(DataSet['Source']), q1Time) then
    DataSet['ArrNum'] := q1Time['Num'];
end;

procedure TDM1.TabD1AfterOpen(DataSet: TDataSet);
begin
  TCustomADODataSet(DataSet).Properties['Update Criteria'].Value := adCriteriaKey;
end;

procedure TDM1.TbFields1AfterOpen(DataSet: TDataSet);
begin
     TADOTable(DataSet).Properties['Update Criteria'].Value := adCriteriaKey;
end;

procedure TDM1.tabElemBeforeDelete(DataSet: TDataSet);
begin
      if DataSet['Num']<95 then
        Abort;
end;

procedure TDM1.DSDiagrDataChange(Sender: TObject; Field: TField);
begin
     if (Field=nil) then begin
     if (DSDiagr.DataSet['ID']<>Null) then
       OpenQR('Select * from Fields where DiagrID='+IntToStr(DSDiagr.DataSet['ID']),
       tbFields)
     else
        OpenQR('Select * from Fields where DiagrID=0',tbFields)
     end;
end;

procedure TDM1.TbFieldsAfterInsert(DataSet: TDataSet);
begin
     DataSet['DiagrID']:=tbDiagr['ID'];
end;

procedure TDM1.DSFieldDataChange(Sender: TObject; Field: TField);
begin
      if (Field=nil)then begin
      if (DSField.DataSet['ID']<>Null) then
       OpenQR('Select * from FPoints where FieldID='+IntToStr(DSField.DataSet['ID']),
       tbFPoint)
        else
         OpenQR('Select * from FPoints where FieldID=0',tbFPoint)
       end;
end;

procedure TDM1.TbFPointAfterInsert(DataSet: TDataSet);
begin
     DataSet['FieldID']:=tbFields['id'];
end;

end.

