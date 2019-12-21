unit RHAGlobs;

interface

uses Windows, SysUtils, Classes, Forms, ADODB, Dialogs;




const
  DivEq: real = 1.15;
  MaxHALen: integer = 10;
  MendCount = 100;
  ShowCount=MendCount + 3;
  MaxCompCount = 60;
  MaxElemCount = MaxCompCount + 5;
  EnFormat: string='0.###';
  OMax: boolean = true;
  OSub: boolean = true;
  SubF: boolean = true;
  SubCl: boolean = True;
  SubS: boolean = true;
  SubC: boolean = false;
  MinCompCount: integer = 6;
  StatChartBars: integer = 5;

  minCorrCount: integer = 5;
  rBold: real = 0.6;
  rRed: real = 0.8;

  UpdatesStep = 50;

  PCLSID = '{EC001385-C4CF-11D5-B817-000021C3A515}';
  protect = False;
  registered: Boolean = False;
  DayOff: Boolean = False;
  DaysForExp = 60;

  DefaultOrdField: string = 'Sample';


type

  Tint = class
    N: integer;
    constructor Create(An: Integer);
  end;

  TCorr = class
    N: integer;
    Id: integer;
    constructor Create(An, AID: Integer);
  end;

  TGetCellText = function(F: TForm; Col: integer): string;

  TDatType = (dtAtomn, dtAtomnAW, dtMol, dtMolAw, dtWeight, dtWeight100, dtWeightAw, dtKoef,
    dtRecalc, dtEn, dtAn, dtData);

  TPresents = array[1..ShowCount] of boolean;
  UField = (SID, GID, RGN, GBD, ROC, CRD);

  TUsedFields = set of UField;

var

  MainPath: string;
  CurPath: string;
  AppPath: string;
  LastProjectN: integer;
  CurProjectN: integer;

  UsedFields: TUsedFields;
  CurTrio: Boolean;
  CurLogoX: Boolean;
  CurLogoY: Boolean;
  CurAWX, CurAWY, CurAWz: Boolean;
  CurPr100X, CurPr100Y, CurPr100Z: Boolean;
  StBarAuto: Boolean;

  FavDiagram: Integer;


  DataDes: string;
  CurHelpContext: integer;

  DeletedAn: integer;

  Fe2Changed, Fe3Changed: Boolean;

  DayFromFirst: integer;
  Gid0, Roc0, Reg0, GBod0: integer;

const
  GeolIdTit: string = 'Geol. ident.';
  RockTit: string = 'Rock';
  RegionTit: string = 'Region';
  GBodyTit: string = 'Geol. body';
  ElSymLen: integer = 2;
  RSymLen: integer = 5;
  NDist : integer=10;
  UseNDist : boolean=false;
  Silent: Boolean=False;

resourcestring
  StAnal = 'Analyse';
  stNotel = ' has not nonzero elements. Excluded from base';
  stAnNum = 'Analyse N ';
  stDoubleID = 'Analyse with same "sample ID" already exist in data base. ';
  stMark = ' Marked by "!"';
  stNone = 'None';
  stWillNotInsert = '. It will be excluded from importing data';
  stWillNotInput = '. It cannot be included in database';
  stNotAnal = 'Where are not correct analyzes in data set. Data set excluded from base';
  stNoCompList = 'Component list is empty';
  stNoArrayName = 'Data set name is empty';
  stEmptyQuer = 'Query is empty';
  stNoSourceNumber = 'Data source number is absent';
  stNoAuthor = 'Field "Authors" is empty';
  stNoSourceTitle = 'Title of data source is absent';
  stNoBibliography = 'Field "Bibliography" is empty';
  stNotEnComp = 'Count of components less then minimal value (';
  stDoubleSourceNumber = 'This source number is alredy in use';
  stErrorInData = 'Error in data for ';
  stError = 'Error!';
  stChemElError = 'Error in symbol of chemical element';
  stFormErr = 'Error in formula: ';
  stHforAw = 'Hydrogen is not allowed in calculation without water';
  stEnForAW = 'Entropy and Anentropy is not allowed in calculation without water';
  stCurList = 'Current list: ';
  stCurQuery = 'Current query: ';
  stCurArray = 'Current data set: ';
  stAnDes = 'Sample description';
  stSum = 'Sum';
  stFullGID = 'Geological identificators';
  stFullGBody = 'Geological bodies';
  stDoubleVal = 'This value already exist in the table. Values must be unique.';
  stMustRecalk = 'You must recalculate all base after changing of this property';
  stAtomn = ' atomic %';
  stWeight = ' weight %';
  stAnW = ' without water.';
  st100 = ' (recalc. to 100%)';
  stMols = ' molecular %';




var
  CurId: integer;
  SelSQLName: string;
  SelQuery: TAdoQuery;

function FormatAnData(R: Double): string;
function rK(s, s2: string): Boolean;
function GetCaptionStr(AnType: TDatType): string;
function AddChar(C: Char; const S: string; N: Integer): string;
{ AddChar return a string left-padded to length N with characters C. }
function GetFieldName(ElNum : Integer) : string;

implementation

uses Chemist;


function AddChar(C: Char; const S: string; N: Integer): string;
begin
  if Length(S) >= N then
    Result := S
  else
    Result := StringOfChar(C, N - Length(S)) + S;
end;

function rK(s, s2: string): Boolean;
var S1: string;
  i: integer;
begin
  S1 := '';
  for i := 1 to Length(S) do
    s1 := S1 + char(Byte(S[i]) + 24 + StrToInt(S[i]) - i + 1);
  S1 := S1 + IntToStr(Byte(S[Length(S)]));
  S1 := S1[Length(S1)] + Copy(S1, 1, Length(S1) - 1);
  if Length(S1) < 10 then
    S1 := 'A' + S1;
  if Length(S1) < 10 then
    S1 := S1 + 'C';
  S1 := Copy(S1, 1, 10);
  Result := (s1 = s2);
end;


function FormatAnData(R: Double): string;
begin
  if abs(R) > 1 then
    Result := FormatFloat('###0.##', R)
  else if abs(R) > 0.01 then
    Result := FormatFloat('0.###', R)
  else if abs(R) > 0.001 then
    Result := FormatFloat('0.####', R)
 { else if abs(R) > 0.0001 then
    Result := FormatFloat('0.#####', R)}
  else
    Result := FloatToStrF(R, ffExponent, 2, 1);
end;

function GetCaptionStr(AnType: TDatType): string;
begin
  if MendTab.AlfaN > 0 then
    Result := 'Concentrations.'
  else begin
    Result := '';
    if AnType in [dtAtomn, dtAtomnAW] then
      Result := Result + stAtomn
    else if AnType in [dtMol, dtMolAW] then
      Result := Result + stMols
    else if AnType in [dtWeight, dtWeight100, dtWeightAW] then
      Result := Result + stWeight;
    if AnType = dtWeight100 then
      Result := Result + st100;
    if AnType in [dtAtomnAW, dtMolAW, dtWeightAW] then
      Result := Result + stAnW
    else
      Result := Result + '.';
  end;
end;

{ Tint }

constructor Tint.Create(An: Integer);
begin
  inherited Create;
  N := AN;
end;

{ TCorr }

constructor TCorr.Create(An, AID: Integer);
begin
  inherited Create;
  N := AN;
  Id := AID;
end;

function GetFieldName(ElNum : Integer) : string;
begin
  Result:='';
   if (ElNum>0) and (ElNum<=MendCount) then
   Result:='A' + IntToStr(ElNum)
   else if ElNum=101 then
    Result:='E'
   else if ElNum=102 then
    Result:='An'
   else if (ElNum = 103) then
     Result := 'Tn'
   else
    ShowMessage('Ошибка в номере поля  - '+IntToStr(ElNum));
end;


end.

