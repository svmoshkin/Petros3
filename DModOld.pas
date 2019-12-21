unit DModOld;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, RHAGlobs, StrUtils, Variants, ADODB;

type
  TDMOld = class(TDataModule)
    Database1: TDatabase;
    Database2: TDatabase;
    TabMain: TTable;
    TMain: TTable;
    DSMain: TDataSource;
    TabData: TTable;
    TData: TTable;
    TabSource: TTable;
    TSource: TTable;
    DSSource: TDataSource;
    TabM3: TTable;
    TabS2: TTable;
    DataSource4: TDataSource;
    DataSource2: TDataSource;
    TabM1: TTable;
    TabM1Id: TAutoIncField;
    TabM1ArrayName: TStringField;
    TabM1Source: TIntegerField;
    TabM1Type: TStringField;            
    TabM1Title1: TStringField;
    TabM1Title2: TStringField;
    TabM1NAnal: TSmallintField;
    TabM1NComp: TSmallintField;
    TabM1Descript: TStringField;
    TabM1MaxNum: TIntegerField;
    DataSource3: TDataSource;
    TabD1: TTable;
    TabD2: TTable;
    DataSource5: TDataSource;
    TTasks: TTable;
    TTables: TTable;
    QuData: TQuery;
    QuMain: TQuery;
    QuSource: TQuery;
    DSTasks: TDataSource;
    TbDiagr: TTable;
    TbInterv: TTable;
    TbFields: TTable;
    DSDiagr: TDataSource;
    DSField: TDataSource;
    TbLines: TTable;
    DSLines: TDataSource;
    TbFPoint: TTable;
    DSFPoint: TDataSource;
    TbLPoint: TTable;
    DSLPoint: TDataSource;
    TbClassIn: TTable;
    TbDiagrId: TTable;
    DSDiagrID: TDataSource;
    TbClassOut: TTable;
    ImpFields: TTable;
    DSimpF: TDataSource;
    Sinonims: TTable;
    DSEdBook: TDataSource;
    TabEdBook: TTable;
    DSSin: TDataSource;
    TabD3: TTable;
    TabClass: TTable;
    TClassif: TTable;
    DSData: TDataSource;
    TabLists: TTable;
    DsLists: TDataSource;
    TabListData: TTable;
    DSListData: TDataSource;
    TabListDataID: TAutoIncField;
    TabListDataList: TIntegerField;
    TabListDataAnal: TIntegerField;
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
    GeolIds: TTable;
    GBodies: TTable;
    Rocks: TTable;
    Regions: TTable;
    DSGBod: TDataSource;
    DSGId: TDataSource;
    DSReg: TDataSource;
    DSRoc: TDataSource;
    TabD1LGId: TStringField;
    TabD1LRoc: TStringField;
    TabD1LReg: TStringField;
    TabD1LGBod: TStringField;
    TabM1Tit: TStringField;
    GeolIdsID: TAutoIncField;
    GeolIdsGeolID: TStringField;
    GeolIdsDescript: TStringField;
    GBodiesId: TAutoIncField;
    GBodiesGBody: TStringField;
    GBodiesDescript: TStringField;
    RocksId: TAutoIncField;
    RocksRock: TStringField;
    RocksDescript: TStringField;
    RegionsID: TAutoIncField;
    RegionsRegion: TStringField;
    RegionsDescript: TStringField;
    TabD1LSource: TStringField;
    TabD1A93: TFloatField;
    TabD1A94: TFloatField;
    TabD1MolFact: TFloatField;
    TabD1MolFactAW: TFloatField;
    MainData: TTable;
    Diction: TTable;
    DSDic: TDataSource;
    TabRec: TTable;
    DSRec: TDataSource;
    TabVars: TTable;
    DSVar: TDataSource;
    SinonimsId: TAutoIncField;
    SinonimsFieldId: TIntegerField;
    SinonimsText: TStringField;
    ImpFieldsId: TAutoIncField;
    ImpFieldsDName: TStringField;
    ImpFieldsFName: TStringField;
    ImpFieldsSize: TIntegerField;
    DictionId: TAutoIncField;
    DictionFieldId: TIntegerField;
    DictionWord: TStringField;
    DictionDesc: TIntegerField;
    TabListsID: TAutoIncField;
    TabListDataSample: TStringField;
    TabListsName: TStringField;
    TabListsComment: TStringField;
    DSInterv: TDataSource;
    TabM1MAxHA: TIntegerField;
    tabElem: TTable;
    TabListDataDescr: TStringField;
    TabS1: TTable;
    q1time: TQuery;
    q2time: TQuery;
    qLongTime: TQuery;
    procedure TabM1BeforeDelete(DataSet: TDataSet);
    procedure TabM1AfterDelete(DataSet: TDataSet);
    procedure TabEdBookAfterCancel(DataSet: TDataSet);
    procedure TabEdBookBeforePost(DataSet: TDataSet);
    procedure TabD1BeforePost(DataSet: TDataSet);
    procedure TabD1AfterInsert(DataSet: TDataSet);
    procedure TabM1AfterInsert(DataSet: TDataSet);
    procedure TabD1AfterPost(DataSet: TDataSet);
    procedure TabListsAfterScroll(DataSet: TDataSet);
    procedure TabM1CalcFields(DataSet: TDataSet);
    procedure TabD1CalcFields(DataSet: TDataSet);
    procedure TabListsBeforeDelete(DataSet: TDataSet);
    procedure TabD1BeforeDelete(DataSet: TDataSet);
    procedure GeolIdsBeforeDelete(DataSet: TDataSet);
    procedure GeolIdsBeforePost(DataSet: TDataSet);
    procedure DictionAfterInsert(DataSet: TDataSet);
    procedure TabRecBeforeDelete(DataSet: TDataSet);
    procedure TabVarsBeforePost(DataSet: TDataSet);
    procedure TabVarsAfterInsert(DataSet: TDataSet);
    procedure TbFieldsAfterCancel(DataSet: TDataSet);
    procedure TbFieldsAfterPost(DataSet: TDataSet);
    procedure TbFieldsBeforeDelete(DataSet: TDataSet);
    procedure TbFPointAfterPost(DataSet: TDataSet);
    procedure TbFPointBeforePost(DataSet: TDataSet);
    procedure TbLinesBeforeDelete(DataSet: TDataSet);
    procedure TbLinesAfterCancel(DataSet: TDataSet);
    procedure TbLinesAfterPost(DataSet: TDataSet);
    procedure TbLPointAfterPost(DataSet: TDataSet);
    procedure TbLPointBeforePost(DataSet: TDataSet);
    procedure TbLinesBeforeScroll(DataSet: TDataSet);
    procedure TbFieldsBeforeScroll(DataSet: TDataSet);
    procedure TbFieldsBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMOld: TDMOld;
  TabD2Count: integer;
  TabD2Inserted: Boolean;
  BookEdits: TForm;
  LastNum: integer;
  NewFPoint: Boolean;
  NewLPoint: Boolean;


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
  EdBook, DeletDescr, Dictionar, StDiagProp;

{$R *.DFM}

procedure TDMOld.TabM1BeforeDelete(DataSet: TDataSet);
var n, i, k: integer;
begin
  Screen.Cursor := crHourGlass;
  try
    TabS1.Active := True;
    TabD1.Active := True;
         {AnDlg.Table2.GoToCurrent(TabM1);
         MainRha.PB1.Position:=0;
         MainRha.Panel1.Visible:=true;}
    N := TabD1.RecordCount;
    i := 1;
    k := 1;
    with TabD1 do begin
      First;
      while i <= n do begin
        Application.ProcessMessages;
                {First;}
        Delete;
        if k >= 50 then begin
          K := 1;
          ApplyUpdates;
          CommitUpdates;
        end;
        inc(i);
        inc(k);
                {MainRha.PB1.Position:=round(100*I/N);}
      end;
          {MainRha.Panel1.Visible:=false;}
      ApplyUpdates;
      CommitUpdates;
    end;
  finally
    Screen.Cursor := crDefault;
    TabD1.Close;
    TabS1.Close;
  end;
end;

procedure TDMOld.TabM1AfterDelete(DataSet: TDataSet);
begin
  if TabM1.EOF then
    ArrayRollsUp.Edit1.Text := '';
end;

procedure TDMOld.TabEdBookAfterCancel(DataSet: TDataSet);
begin
  if BookEdits = DLNew then
    DlNew.TabEdBookAfterCancel(DataSet)
  else
    if BookEdits = WizForm then
      WizForm.TabEdBookAfterCancel(DataSet);
  if BookEdits = EdBookForm then
    EdBookForm.TabEdBookAfterCancel(DataSet);
end;

procedure TDMOld.TabEdBookBeforePost(DataSet: TDataSet);
begin
  if BookEdits = DLNew then
    DlNew.TabEdBookBeforePost(DataSet)
  else
    if BookEdits = WizForm then
      WizForm.TabEdBookBeforePost(DataSet);
end;

procedure TDMOld.TabD1BeforePost(DataSet: TDataSet);
var
  An: TAnalis;
  i: integer;
  Nul: boolean;
begin
  repeat
    if (DataSet['Sample'] <> null) and (TabD3.FindKey([DataSet['Sample']])) and
      (DataSet['AnId'] <> TabD3['AnID']) then begin
      ShowMessage(stDoubleID + ' (' + DataSet['Sample'] + ')' + stMark);
      DataSet['Sample'] := DataSet['Sample'] + '!';
    end else
      Break;
  until False;
  An := TAnalis.CreateT(DataSet, TabM1);
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
    ShowMessage(stAnNum + DataSet['Sample'] + stNotEnComp + IntToStr(MinCompCount)
      + ')' + stWillNotInput);
    an.Free;
    Inc(DeletedAn);
    Abort;
  end;
  Inc(LastNum);
  for i := 1 to MendCount do
    if An.Atom[i] >= 0 then
      DataSet['A' + intToStr(i)] := An.Atom[i];
  CalcFirst := False;
  An.Recalc(AnalisTitle);
  DataSet['ArrId'] := TabM1['Id'];
  DataSet['R'] := An.Rang;
  if (an.A > 0) and (an.H > 0) then begin
    DataSet['H'] := An.H;
    DataSet['A'] := An.A;
    DataSet['AN'] := An.AN;
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

procedure TDMOld.TabD1AfterInsert(DataSet: TDataSet);
begin
  DataSet['Num'] := LastNum + 1;
  DataSet['Descript'] := AddChar(' ', IntToStr(LastNum + 1), 3) +
    '-' + TabM1['ArrayName'] + ' ';
  DataSet['Sample'] := IntToStr(TabM1['Id']) + '-' + IntToStr(LastNum + 1);
  DataSet['ArrId'] := TabM1['Id'];
  DataSet['Source'] := TabM1['Source'];
  DataSet['Rock'] := 1;
  DataSet['Region'] := 1;
  DataSet['GBody'] := 1;
  DataSet['GeolId'] := 1;
end;

procedure TDMOld.TabM1AfterInsert(DataSet: TDataSet);
begin
  LastNum := 0;
  TabM1['MaxHA']:=MaxHALen;
end;

procedure TDMOld.TabD1AfterPost(DataSet: TDataSet);
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

procedure TDMOld.TabListsAfterScroll(DataSet: TDataSet);
begin
  if (TabLists.State = dsBrowse) and (TabLists['Name'] <> null) then
    MainForm.StatusLine.Panels[0].Text := stCurList + TabLists['Name']
  else
    MainForm.StatusLine.Panels[0].Text := stCurList + stNone;
end;

procedure TDMOld.TabM1CalcFields(DataSet: TDataSet);
var s: string;
begin
  if assigned(Titles) and (TabM1.State <> dsInsert)
    and not VarIsNull(TabM1['Title1']) then begin
    S := TabM1['Title1'];
    if not VarIsNull(TabM1['Title2']) then
      S := S + TabM1['Title2'];
    TabM1['Tit'] := S;
  end;
end;

procedure TDMOld.TabD1CalcFields(DataSet: TDataSet);
var Sou: Variant;
begin

  if DataSet['Source'] <> Null then begin
    Sou := TabS1.Lookup('Id', DataSet['Source'], 'Num;Author;Title');
    DataSet['LSource'] := Copy(IntToStr(Sou[0]) + ', ' + Sou[1] + ', ' + Sou[2], 1, 255);
  end;
end;

procedure TDMOld.TabListsBeforeDelete(DataSet: TDataSet);
begin
  with TabListData do begin
    First;
    while not EOF do
      Delete;
  end;
end;

function GetConcValue(Quer: TDataSet; Num: integer; Cod: TDatType): Variant;
var Val: Double;
begin
  Result := Null;
  if (Num < 1) or (Num > MendCount) then abort;

  if Quer['A' + IntToStr(Num)] <> Null then begin
    Val := Quer['A' + IntToStr(Num)];
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
    end;
  end;
end;

function GetConcentration(Quer: TDataSet; Num: integer; Cod: TDatType): Double;
var V: Variant;
begin
  if (Num < 1) or (Num > MendCount) then abort;
  V := GetConcValue(Quer, Num, Cod);
  if V = null then
    Result := 0
  else
    Result := V;
end;

function GetDataTitle(Num: integer; AnType: TDatType; RecId: integer): string;
begin
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

procedure GetPresents(Quer: TDataSet; var Pres: TPresents);
var i, j: integer;
begin
  for j := 1 to MendCount do
    Pres[j] := false;
  with Quer do begin
    try
      DisableControls;
      first;
      while not EOF do begin
        for i := 1 to MendCount do begin
          j := MendTab.Order[i];
          if (Quer['A' + IntToStr(j)] <> null) and (Quer['A' + IntToStr(j)] >= 0)
          then
            Pres[j] := True;
        end;
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
  case AnType of
    dtAtomn: Result := True;
    dtAtomnAW: Result := (Num > 1);
    dtMol: Result := MendTab.MustMol(Num);
    dtMolAw: Result := MendTab.MustMol(Num) and (Num > 1);
    dtWeight, dtWeight100: Result := (Num <> 8);
    dtWeightAW: Result := (Num <> 8) and (Num > 1);
  else
    Result := False;
  end
end;


function GetDataValue(Quer: TDataSet; Num: integer; Cod: TDatType; RecId: integer): Double;
begin
  if Cod in [dtAtomn, dtAtomnAW, dtMol, dtMolAw, dtWeight, dtWeight100, dtWeightAw] then
    Result := GetConcentration(Quer, Num, Cod);
end;

procedure TDMOld.TabD1BeforeDelete(DataSet: TDataSet);
begin
  TabLists.First;
  while not TabLists.Eof do begin
    if TabListData.Locate('Anal', TabD1['AnId'], []) then
      TabListData.Delete;
    TabLists.Next;
  end;
end;

procedure TDMOld.GeolIdsBeforeDelete(DataSet: TDataSet);
var FieldName: string;
  FID: integer;
  WasOpen: Boolean;
  WasFilt: Boolean;
  Filt: string;
begin
  if DataSet['Id'] = 1 then begin
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
  if Maindata.Locate(FieldName, DataSet['Id'], []) or
    TabD2.Locate(FieldName, DataSet['Id'], []) then begin

    if DeletDial.ShowModal = mrOK then begin
      Maindata.Close;
      Maindata.Filter := FieldName + '=' + IntToStr(DataSet['Id']);
      MainData.Filtered := True;
      MainData.Open;
      while MainData.FindFirst do begin
        MainData.Edit;
        MainData[FieldName] := TInt(DeletDial.ListBox1.Items.Objects[DeletDial.ListBox1.ItemIndex]).N;
        MainData.Post;
      end;
      Maindata.Close;
      MainData.Filtered := False;
      MainData.Open;
    end else
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

procedure TDMOld.GeolIdsBeforePost(DataSet: TDataSet);
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

procedure TDMOld.DictionAfterInsert(DataSet: TDataSet);
begin
  if IsEdit then begin
    Diction['FieldId'] := FieldId;
    Diction['Desc'] := Sinonimform.DBGrid1.DataSource.DataSet['Id'];
  end;
end;

procedure TDMOld.TabRecBeforeDelete(DataSet: TDataSet);
begin
  with TabVars do begin
    First;
    while not eof do
      Delete;
  end;
end;

procedure TDMOld.TabVarsBeforePost(DataSet: TDataSet);
begin
  if (TabVars['Pos'] = null) or (tabVars['Name'] = Null) then
    Abort;
end;

procedure TDMOld.TabVarsAfterInsert(DataSet: TDataSet);
begin
  TabVars['Pos'] := TabVars.RecordCount + 1;
  TabVars['DFormat'] := '#0.##';
end;

procedure TDMOld.TbFieldsAfterCancel(DataSet: TDataSet);
begin
     TbFPoint.Cancel;
  if Newdiagr.Visible and (TbFields.State = dsInsert) then begin
    NewDiagr.Diag.Remove(NewDiagr.F);
    FreeandNil(NewDiagr.F);
  end;
end;

procedure TDMOld.TbFieldsAfterPost(DataSet: TDataSet);
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

procedure TDMOld.TbFieldsBeforeDelete(DataSet: TDataSet);
begin
  with TbFpoint do begin
    First;
    while not eof do
      Delete;
  end;
end;

procedure TDMOld.TbFPointAfterPost(DataSet: TDataSet);
begin
  if NewDiagr.Visible and not NewDiagr.NotFPointPost then
    NewDiagr.AfterPointPost(NewFPoint);
end;

procedure TDMOld.TbFPointBeforePost(DataSet: TDataSet);
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

procedure TDMOld.TbLinesBeforeDelete(DataSet: TDataSet);
begin
  with TbLpoint do begin
    First;
    while not eof do
      Delete;
  end;
end;

procedure TDMOld.TbLinesAfterCancel(DataSet: TDataSet);
begin
        TbLPoint.Cancel;
  if Newdiagr.Visible and (TbLines.State = dsInsert) then begin
    NewDiagr.Diag.Lines.Remove(NewDiagr.Lin);
    FreeAndNil(NewDiagr.Lin);
  end;
end;

procedure TDMOld.TbLinesAfterPost(DataSet: TDataSet);
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

procedure TDMOld.TbLPointAfterPost(DataSet: TDataSet);
begin
  if NewDiagr.Visible and not NewDiagr.NotLPointPost then
    NewDiagr.AfterLPointPost(NewLPoint);
end;

procedure TDMOld.TbLPointBeforePost(DataSet: TDataSet);
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

procedure TDMOld.TbLinesBeforeScroll(DataSet: TDataSet);
begin
  if TbLPoint.State <> dsBrowse then
    TbLPoint.Post;
end;

procedure TDMOld.TbFieldsBeforeScroll(DataSet: TDataSet);
begin
  if TbFPoint.State <> dsBrowse then
    TbFPoint.Post;
  if TbFields.State <> dsBrowse then
    TbFields.Post;
end;

procedure TDMOld.TbFieldsBeforePost(DataSet: TDataSet);
begin
  if (NewDiagr.Visible) and (Assigned(NewDiagr.F))and (not FirstPost) and
    (NewDiagr.F.Count < 3) then begin
    ShowMessage(stNotEnPoints);
    MayChange := False;
    Abort;
  end;
end;

end.

