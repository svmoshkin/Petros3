unit ADOUtilsS;

interface

uses
  SysUtils, Classes, DB, ADODB, DBGrids, Dialogs,
  Variants;

{type
StrArr =Array of String;}

var GlQr: TADOQuery;
  GLSysQr: TADOQuery;
  tCat: TADOQuery;


{$IFDEF OldSys}
const QListLen: Integer = 700;
{$ELSE}
const QListLen: Integer = 150;
{$ENDIF}



function LocateInFragLookUp(ID: Integer; Q: TADOQuery; TableName, FieldName: string;
  TabName2, LookField, ValField: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean;
function LocateInFragPartLookUp(ID: Integer; Q: TADOQuery; TableName, FieldName: string;
  TabName2, LookField, ValField: string; Len: Integer = 1; ID_Cat: Integer = 0): Boolean;
function Locate2InFrag(ID, ID2: Integer; Q: TADOQuery; TableName, FieldName,
  FieldName2: string; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean;
function LocateInFrag(ID: Integer; Q: TADOQuery; TableName, FieldName: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;
function LocateInFragW(ID: Integer; Q: TADOQuery; TableName, FieldName,
  Where: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean;
function LocateInFragPart(ID: Integer; Q: TADOQuery; TableName, FieldName: string;
  Len: Integer = 1; ID_Cat: Integer = 0): Boolean; overload;
function LocateInFragPart(ID: Integer; Q: TADOQuery; TableName, FieldName: string;
  Cats: TList; Len: Integer = 1; ID_Cat: Integer = 0): Boolean; overload;
function LocateInFrag2V(ID: Integer; Q: TADOQuery; TableName,
  FieldName, FieldName2, FieldSumList: string; ID_Cat: Integer = 0): Boolean;
function GetSpFrag(Q: TADOQuery; TableName, FieldName, Val: string;
  FList: string = '*'; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean; overload;
function GetSpFrag(Q: TADOQuery; TableName, FieldName, Val: string;
  Cats: TList; FList: string = '*'): Boolean; overload;
function GetSpFragOrd(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
function GetSpFragOrd(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  Cats: TList; FList: string = '*'): Boolean; overload;
function GetSpFrag_(Q: TADOQuery; TableName, FieldName, Val: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;
function GetSpFrag_Ord(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;
function GetSpFragW(Q: TADOQuery; TableName, FieldName, Val: string;
  Where: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
function GetSpFragW(Q: TADOQuery; TableName, FieldName, Val: string;
  Cats: TList; Where: string; FList: string = '*'): Boolean; overload;
function GetSpFragW_(Q: TADOQuery; TableName, FieldName, Val: string;
  Where: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
function GetSpFragW_(Q: TADOQuery; TableName, FieldName, Val: string;
  Cats: TList; Where: string; FList: string = '*'): Boolean; overload;
function GetSpFragLookUp(Q: TADOQuery; TableName, FieldName, TableName2,
  LookField, ValField, Val: string; FList: string = '*'; ID_Cat: Integer = 0; Where: string = ''): Boolean; overload;
function GetSpFragLookUp(Q: TADOQuery; TableName, FieldName, TableName2,
  LookField, ValField, Val: string; Cats: TList; FList: string = '*'): Boolean; overload;
function LocateInFrag2(ID: Integer; Q: TADOQuery; TableName, FieldName,
  FieldName2: string; ID_Cat: Integer = 0): Boolean;
function LocateInFrag2Part(ID: Integer; Q: TADOQuery; TableName, FieldName,
  FieldName2: string; Len: Integer = 1; ID_Cat: Integer = 0): Boolean;
function GetSpFrag2(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2: string; FList: string = '*'; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean; overload;
function GetSpFrag2(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2: string; Cats: TList; FList: string = '*'): Boolean; overload;
function GetSpFrag2Ord(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2: string; OrdList: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
function GetSpFrag2Ord(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2: string; Cats: TList; OrdList: string; FList: string = '*'): Boolean; overload;
function GetSpFrag2V(Q: TADOQuery; TableName, FieldName,
  FieldName2, Val, Val2, FieldList: string; ID_Cat: Integer = 0): Boolean;
function GetSpFrag2W(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2, Where: string; OrdList: string; FList: string = '*'; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean;
function OpenGlQr(SQ: string; ID_Cat: Integer = 0): Boolean;
function OpenGlSysQr(SQ: string): Boolean;
function ExecQr(SQ: string; Qr: TADOQuery; ID_Cat: Integer = 0): Boolean;
function ExecQrN(SQ: string; Qr: TADOQuery; ID_Cat: Integer = 0): Integer;
function OpenQr(SQ: string; Qr: TADOQuery; ID_Cat: Integer = 0): Boolean;
function GetAvtSprStr(ID_Un: Integer; AvtType: Integer; ID_Cat: Integer = 1000000): string;
function Get1Sprav(ID: Integer; TabName: string; ID_Cat: Integer = 0): boolean; overload;
function Get1Sprav(ID: Integer; TabName: string; Qr: TADOQuery; ID_Cat: Integer = 0): boolean; overload;
function Get1Sprav(chrCode: string; TabName: string; Qr: TADOQuery; ID_Cat: Integer = 0): boolean; overload;
//function Get1Sprav(chrCode: string; TabName: String; Qr: TADOQuery; ID_Cat: Integer = 0): boolean; overload;
function Get1Sprav2(ID, ID2: Integer; TabName: string; Field2: string; ID_Cat: Integer = 0): boolean;

function PrepareLike(Str: string): string;
function PrepareForSQL(Str: string): string;
function PrepareForAdvSearch(Str: string): string; //Убивает символы шума
function ValidSP(W: string): Boolean;

function PrepCatStr(W: string; ID_Cat: Integer): string;
//символ |должен стоять перед всеми именами таблиц, относящихся к локальному каталогу

function PrepareInsertStr(S: array of string): string;

function FillIDString(SG: TDBGrid): string;
function FillValString(SG: TDBGrid; FN: string): string;


function GetTableName(Q: TADOQuery): string;
function findEqRecord(QSource, QDest: TADOQuery; FList: string): boolean;

function GetCountStr(q: string; Qr: TADOQuery): string;
//Возвращает значение поля С переведенное из int в str
function GetRecordCount(TabName: string; Qr: TADOQuery; ID_Cat: integer = 0): integer;
function Get1IntVal(q: string; Fn: string; Qr: TADOQuery; ID_Cat: integer = 0): Integer;
//Возвращает целое значение(Null=0) поля "Fn" первой строки запроса
function Get1StrVal(q: string; Fn: string; Qr: TADOQuery; ID_Cat: integer = 0): string;

function GetSpFragOrd_Multi(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;

function ReplaceSymbol(const S, OldPattern, NewPattern: string): string;

implementation

uses TntForms, Forms, Controls, IntList;

function ReplaceSymbol(const S, OldPattern, NewPattern: string): string;
begin
  Result := StringReplace(S, OldPattern, NewPattern, [rfReplaceAll]);
end;


function FillValString(SG: TDBGrid; FN: string): string;
var i: Integer;
  S: string;
  BM: TBookMark;
begin
  if SG.DataSource.DataSet.FieldByName(FN) = nil then exit;
  BM := SG.DataSource.DataSet.GetBookmark;
  try
    SG.DataSource.DataSet.DisableControls;
    S := '';
    for i := 0 to SG.SelectedRows.Count - 1 do begin
      SG.DataSource.DataSet.GotoBookmark(pointer(SG.SelectedRows.Items[i]));
      s := S + SG.DataSource.DataSet[FN];
      if i < SG.SelectedRows.Count - 1 then
        S := S + ',';
    end;
    Result := S;
    SG.DataSource.DataSet.GotoBookmark(BM);
    SG.DataSource.DataSet.FreeBookmark(BM);
  finally
    SG.DataSource.DataSet.EnableControls;
  end;
end;

function FillIDString(SG: TDBGrid): string;
var i: Integer;
  S: string;
  BM: TBookMark;
begin
  BM := SG.DataSource.DataSet.GetBookmark;
  try
    SG.DataSource.DataSet.DisableControls;
    S := '';
    for i := 0 to SG.SelectedRows.Count - 1 do begin
      SG.DataSource.DataSet.GotoBookmark(pointer(SG.SelectedRows.Items[i]));
      s := S + IntToStr(SG.DataSource.DataSet['ID']);
      if i < SG.SelectedRows.Count - 1 then
        S := S + ',';
    end;
    Result := S;
    SG.DataSource.DataSet.GotoBookmark(BM);
    SG.DataSource.DataSet.FreeBookmark(BM);
  finally
    SG.DataSource.DataSet.EnableControls;
  end;
end;

function GetSpFrag_(Q: TADOQuery; TableName, FieldName, Val: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;
  //Работает через строковое >=
begin
  Result := GetSpFrag_Ord(Q, TableName, FieldName, Val, FieldName, FList, ID_Cat);
end;

function GetSpFrag_Ord(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;
  //Работает через строковое >=
var _TableName, s: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;
  S := string('Select top ' + IntToStr(QListLen) + ' ' + FList + ' from ' +
    PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + '>= N''' +
    PrepareForSQL(Val) + '''');
  if OrdList <> '' then
    S := S + ' ORDER BY ' + OrdList;
  Result := OpenQr(S, Q);
end;


function GetSpFrag(Q: TADOQuery; TableName,
  FieldName, Val: string; FList: string = '*'; ID_Cat: Integer = 0; NoOrder: boolean = false): boolean;
begin
  if NoOrder then
    Result := GetSpFragOrd(Q, TableName, FieldName, Val, '', FList, ID_Cat)
  else
    Result := GetSpFragOrd(Q, TableName, FieldName, Val, FieldName, FList, ID_Cat);
end;


function GetSpFragOrd_Multi(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean;
var _TableName, sql_str: string;
  ValList: TStringList;
  i: integer;
begin
  ValList := TStringList.Create;
  try
    if ID_Cat <> 0 then
      _TableName := '|'
    else
      _TableName := '';
    _TableName := _TableName + TableName;
    if pos(' ', Val) > 0 then
      ValList.CommaText := Val
    else
      ValList.Add(Val);
    sql_str := string('Select top ' + IntToStr(QListLen) + ' ' + FList + ' from ' +
      PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + ' Like N''' +
      PrepareLike(ValList[0]) + '%''');
    if ValList.Count > 1 then begin
      sql_str := 'select * from (' + sql_str + ') as AAA where ' + FieldName + ' Like N''' + '% ' + PrepareLike(ValList[1]) + '%''';
      if ValList.Count > 2 then
        for i := 2 to ValList.Count - 1 do
          sql_str := sql_str + ' and ' + FieldName + ' Like N''' + '% ' + PrepareLike(ValList[i]) + '%''';

    end;
    if OrdList <> '' then
      sql_str := sql_str + string(' ORDER BY ' + OrdList);
    Result := OpenQr(sql_str, Q);
  finally
    ValList.Free;
  end;
end;


function GetSpFragOrd(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
var _TableName, sql_str: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;

  sql_str := string('Select top ' + IntToStr(QListLen) + ' ' + FList + ' from ' +
    PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + ' Like N''' +
    PrepareLike(Val) + '%''');

  if OrdList <> '' then
    sql_str := sql_str + string(' ORDER BY ' + OrdList);
  Result := OpenQr(sql_str, Q);
end;

function GetSpFrag(Q: TADOQuery; TableName, FieldName, Val: string; Cats: TList; FList: string = '*'): Boolean;
begin
  Result := GetSpFragOrd(Q, TableName, FieldName, Val, FieldName, Cats, FList);
end;

function GetSpFragOrd(Q: TADOQuery; TableName, FieldName, Val, OrdList: string;
  Cats: TList; FList: string = '*'): Boolean; overload;
var _TableName, s: string;
  i, ID_Cat: Integer;
begin
  if (Cats = nil) or (Cats.Count = 0) then
    Result := GetSpFrag(Q, TableName, FieldName, Val, FList, 0)
  else begin
    _TableName := '|' + TableName;
    s := s + string('Select top ' + IntToStr(QListLen) + ' * from (');
    for i := 0 to Cats.Count - 1 do begin
      ID_Cat := TIntObj(Cats[i]).Val;
      if i > 0 then
        S := S + string('UNION');
      S := S + string('Select top ' + IntToStr(QListLen) + ' ' + FList +
        ', ' + IntToStr(ID_Cat) + ' as ID_Cat' +
        ' from ' +
        PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + ' Like N''' +
        PrepareLike(Val) + '%''');
    end;
    S := S + string(') as QWER');
    if OrdList <> '' then
      S := S + ' ORDER BY ' + OrdList;

    Result := OpenQr(s, Q);
  end;
end;


function GetSpFragW(Q: TADOQuery; TableName, FieldName, Val: string; Where: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
var _TableName, s: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;
  if Where <> '' then begin
    s := string('Select top ' + IntToStr(QListLen) + ' ' + PrepCatStr(FList, ID_Cat) + ' from ' +
      PrepCatStr(_TableName, ID_Cat) + ' where ' + Where + ' and ' + FieldName + ' Like N''' +
      PrepareLike(Val) + '%'' ORDER BY ' + FieldName);
    Result := OpenQr(s, Q);
  end else
    Result := GetSpFrag(Q, TableName, FieldName, Val, Flist, ID_Cat);
end;


function GetSpFragW(Q: TADOQuery; TableName, FieldName, Val: string; Cats: TList; Where: string; FList: string = '*'): Boolean; overload;
var _TableName, s: string;
  i, ID_Cat: Integer;
begin
  if (Cats = nil) or (Cats.Count = 0) then
    Result := GetSpFrag(Q, TableName, FieldName, Val, FList, 0)
  else begin
    _TableName := '|' + TableName;
    s := string('Select top ' + IntToStr(QListLen) + ' * from (');
    for i := 0 to Cats.Count - 1 do begin
      ID_Cat := TIntObj(Cats[i]).Val;
      if i > 0 then
        S := S + string('UNION');
      S := s + string('Select top ' + IntToStr(QListLen) + ' ' + FList +
        ', ' + IntToStr(ID_Cat) + ' as ID_Cat' +
        ' from ' +
        PrepCatStr(_TableName, ID_Cat) + ' where ' + Where + ' and ' + FieldName + ' Like N''' +
        PrepareLike(Val) + '%''');
    end;
    S := s + string(') as QWER ORDER BY ' + FieldName);
    Result := OpenQr(S, Q);
  end;
end;


function GetSpFragW_(Q: TADOQuery; TableName, FieldName, Val: string; Where: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
var _TableName, s: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;
  s := string('Select top ' + IntToStr(QListLen) + ' ' + PrepCatStr(FList, ID_Cat) + ' from ' +
    PrepCatStr(_TableName, ID_Cat) + ' where ' + Where + ' and ' + FieldName + ' >= N''' +
    PrepareForSQL(Val) + ''' ORDER BY ' + FieldName);
  Result := OpenQr(S, Q);
end;


function GetSpFragW_(Q: TADOQuery; TableName, FieldName, Val: string; Cats: TList; Where: string; FList: string = '*'): Boolean; overload;
var _TableName: string;
  i, ID_Cat: Integer;
begin
  if (Cats = nil) or (Cats.Count = 0) then
    Result := GetSpFrag(Q, TableName, FieldName, Val, FList, 0)
  else begin
    _TableName := '|' + TableName;

    Q.Active := False;
    Q.SQL.Clear;
    Q.SQL.Add(string('Select top ' + IntToStr(QListLen) + ' * from ('));
    for i := 0 to Cats.Count - 1 do begin
      ID_Cat := TIntObj(Cats[i]).Val;
      if Q.SQL.Count > 1 then
        Q.SQL.Add(string('UNION'));
      Q.SQL.Add(string('Select top ' + IntToStr(QListLen) + ' ' + FList +
        ', ' + IntToStr(ID_Cat) + ' as ID_Cat' +
        ' from ' +
        PrepCatStr(_TableName, ID_Cat) + ' where ' + Where + ' and ' + FieldName + ' >= N''' +
        PrepareForSQL(Val) + ''''));
    end;
    q.SQL.Add(string(') as QWER ORDER BY ' + FieldName));
    Q.Open;
    Result := Q.RecordCount > 0;
  end;
end;


function GetSpFragLookUp(Q: TADOQuery; TableName, FieldName, TableName2, LookField, ValField, Val: string;
  FList: string = '*'; ID_Cat: Integer = 0; Where: string = ''): Boolean;
var W, w1, _TableName, _TableName2: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;
  if (ID_Cat <> 0) and (Pos('.', TableName2) = 0) then
    _TableName2 := '|'
  else
    _TableName2 := '';
  _TableName2 := _TableName2 + TableName2;
  if LookField <> '' then begin
    W1 := string(',(Select T.' + ValField + ' from ') + PrepCatStr(_TableName2, ID_Cat) + ' t where T.ID='
      + 'tt.' + LookField + ')';
    W := W1 + ' As LLL ';
  end;
  W := string('Select top ' + IntToStr(QListLen) + ' ' + FList + w + ' from ' +
    PrepCatStr(_TableName, ID_Cat) + ' tt where ' + FieldName + ' Like N''' + PrepareLike(Val) + '%''');
  if Where <> '' then
    W := W + ' and ' + Where + ' ';
  W := W + ' ORDER BY ' + FieldName + W1;
  OpenQr(W, Q);
  Result := Q.RecordCount > 0;
end;

function GetSpFragLookUp(Q: TADOQuery; TableName, FieldName, TableName2, LookField, ValField, Val: string; Cats: TList; FList: string = '*'): Boolean;
var W, _TableName, _TableName2: string;
  i, ID_Cat: Integer;
begin
  if (Cats = nil) or (Cats.Count = 0) then
    Result := GetSpFragLookUp(Q, TableName, FieldName, TableName2, LookField,
      ValField, Val, FList, 0)
  else begin
    _TableName := '|' + TableName;
    if (Pos('.', TableName2) = 0) then
      _TableName2 := '|'
    else
      _TableName2 := '';
    _TableName2 := _TableName2 + TableName2;
    Q.Active := False;
    Q.SQL.Clear;
    Q.SQL.Add(string('Select top ' + IntToStr(QListLen) + ' * from ('));
    for i := 0 to Cats.Count - 1 do begin
      ID_Cat := TIntObj(Cats[i]).Val;
      if Q.SQL.Count > 1 then
        Q.SQL.Add(string('UNION'));
      if LookField <> '' then
        W := string(',(Select T.' + ValField + ' from ') + PrepCatStr(_TableName2, ID_Cat) + ' t where T.ID='
          + 'TT.' + LookField + ') As LLL ';
      Q.SQL.Add(string('Select top ' + IntToStr(QListLen) + ' ' + FList + w +
        ', ' + IntToStr(ID_Cat) + ' as ID_Cat' +
        ' from ' +
        PrepCatStr(_TableName, ID_Cat) + ' TT where ' + FieldName + ' Like N''' +
        PrepareLike(Val) + '%'''));
    end;
    Q.SQL.Add(string(') as QWER ORDER BY ' + FieldName));
    Q.Open;
    Result := Q.RecordCount > 0;
  end;
end;

function GetSpFrag2W(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2, Where: string; OrdList: string; FList: string = '*'; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean;
var _TableName, sql_str: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;

  sql_str := string('Select top ' + IntToStr(QListLen) + ' ' + FList + ' from ' +
    PrepCatStr(_TableName, ID_Cat) + ' where (' + Where + ') and ' + FieldName + ' Like N''' +
    PrepareLike(Val) + '%'' and ' + FieldName2 + ' Like N''' + PrepareLike(Val2) + '%''');

  if OrdList <> '' then
    sql_str := sql_str + string(' ORDER BY ' + OrdList);
  Result := OpenQr(sql_str, Q);
end;

function GetSpFrag2Ord(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2: string; OrdList: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean; overload;
var _TableName, sql_str: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;

  sql_str := string('Select top ' + IntToStr(QListLen) + ' ' + FList + ' from ' +
    PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + ' Like N''' +
    PrepareLike(Val) + '%'' and ' + FieldName2 + ' Like N''' + PrepareLike(Val2) + '%''');

  if OrdList <> '' then
    sql_str := sql_str + string(' ORDER BY ' + OrdList);
  Result := OpenQr(sql_str, Q);
end;


function GetSpFrag2(Q: TADOQuery; TableName, FieldName,
  FieldName2, Val, Val2: string; FList: string = '*'; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean;
begin
  if NoOrder then
    Result := GetSpFrag2Ord(Q, TableName, FieldName, FieldName2, Val, Val2, '', FList, ID_Cat)
  else
    Result := GetSpFrag2Ord(Q, TableName, FieldName, FieldName2, Val, Val2, FieldName + ',' + FieldName2, FList, ID_Cat);
end;



function GetSpFrag2Ord(Q: TADOQuery; TableName, FieldName, FieldName2, Val,
  Val2: string; Cats: TList; OrdList: string; FList: string = '*'): Boolean; overload;
var _TableName, sql_str: string;
  i, ID_Cat: Integer;
begin
  if (Cats = nil) or (Cats.Count = 0) then
    Result := GetSpFrag2(Q, TableName, FieldName, FieldName2, Val, Val2, FList, 0)
  else begin
    _TableName := '|' + TableName;

    sql_str := string('Select top ' + IntToStr(QListLen) + ' * from (');
    for i := 0 to Cats.Count - 1 do begin
      ID_Cat := TIntObj(Cats[i]).Val;
      if i > 0 then
        sql_str := sql_str + string('UNION');
      sql_str := sql_str + string('Select top ' + IntToStr(QListLen) + ' ' + FList +
        ', ' + IntToStr(ID_Cat) + ' as ID_Cat' +
        ' from ' +
        PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + ' Like N''' +
        PrepareLike(Val) + '%'' and ' + FieldName2 + ' Like N''' +
        PrepareLike(Val2));
      if OrdList <> '' then
        sql_str := sql_str + '%'' ORDER BY ' + FieldName + ',' + FieldName2;
    end;

    sql_str := sql_str + string(')as QWER');
    if OrdList <> '' then
      sql_str := sql_str + ' ORDER BY ' + OrdList;
    Result := OpenQr(sql_str, q);
  end;
end;

function GetSpFrag2(Q: TADOQuery; TableName, FieldName, FieldName2, Val, Val2: string; Cats: TList; FList: string = '*'): Boolean;
begin
  Result := GetSpFrag2Ord(q, TableName, FieldName, FieldName2, Val, Val2, Cats, FieldName + ',' + FieldName2, FList);
end;


function GetSpFrag2V(Q: TADOQuery; TableName, FieldName,
  FieldName2, Val, Val2, FieldList: string; ID_Cat: Integer = 0): Boolean;
var W, _TableName: string;
  i: Integer;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TableName;
  if FieldList = '' then
    Result := GetSpFrag2(Q, _TableName, FieldName, FieldName2, Val, Val2, '*', ID_Cat)
  else begin
    W := '(';
    i := Pos(';', FieldList);
    if i = 0 then
      I := Length(FieldList) + 1;
    while i > 0 do begin
      if W <> '(' then
        W := W + '+''\''+' + Trim(Copy(FieldList, 1, i - 1))
      else
        W := W + Trim(Copy(FieldList, 1, i - 1));
      Delete(FieldList, 1, i);
      i := Pos(';', FieldList);
      if (i = 0) and (Length(FieldList) > 0) then
        I := Length(FieldList) + 1;
    end;
    W := W + ') as AAA, ' + FieldName + ', ' + FieldName2;
    Q.Active := False;
    Q.SQL.Clear;
    Q.SQL.Add(string('Select top ' + IntToStr(QListLen) + ' ID, ' + W + ' from ' +
      PrepCatStr(_TableName, ID_Cat) + ' where ' + FieldName + ' Like N''' +
      PrepareLike(Val) + '%'' and ' + FieldName2 + ' Like N''' +
      PrepareLike(Val2) + '%'''));
    Q.Open;
    Result := Q.RecordCount > 0;
  end;
end;

function LocateInFrag(ID: Integer; Q: TADOQuery; TableName,
  FieldName: string; FList: string = '*'; ID_Cat: Integer = 0): boolean;
var FM: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then
    FM := GLQR.FieldByName(FieldName).Value
  else
    FM := '';
  Result := GetSpFrag(Q, TableName, FieldName, FM, FList, ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;

function LocateInFragW(ID: Integer; Q: TADOQuery; TableName, FieldName, Where: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean;
var FM: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then
    FM := GLQR.FieldByName(FieldName).Value
  else
    FM := '';
  Result := GetSpFragW(Q, TableName, FieldName, FM, Where, FList, ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;


function LocateInFragLookUp(ID: Integer; Q: TADOQuery; TableName, FieldName: string; TabName2, LookField, ValField: string; FList: string = '*'; ID_Cat: Integer = 0): Boolean;
var FM: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then
    FM := GLQR.FieldByName(FieldName).Value
  else
    FM := '';
  Result := GetSpFragLookUp(Q, TableName, FieldName, TabName2, LookField, ValField, FM, FList, ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;


function LocateInFragPartLookUp(ID: Integer; Q: TADOQuery; TableName,
  FieldName: string; TabName2, LookField, ValField: string; Len: Integer = 1; ID_Cat: Integer = 0): Boolean;
var FM: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then begin
    FM := GLQR.FieldByName(FieldName).Value;
    FM := Copy(FM, 1, Len);
  end else
    FM := '';
  Result := GetSpFragLookUp(Q, TableName, FieldName, TabName2, LookField, ValField, FM, '*', ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;



function LocateInFragPart(ID: Integer; Q: TADOQuery; TableName, FieldName: string; Len: Integer = 1; ID_Cat: Integer = 0): Boolean;
var FM: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then begin
    FM := GLQR.FieldByName(FieldName).Value;
    FM := Copy(FM, 1, Len);
  end else
    FM := '';
  Result := GetSpFrag(Q, TableName, FieldName, FM, '*', ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;

function LocateInFragPart(ID: Integer; Q: TADOQuery; TableName, FieldName: string; Cats: TList; Len: Integer = 1; ID_Cat: Integer = 0): Boolean;
var FM: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then begin
    FM := GLQR.FieldByName(FieldName).Value;
    FM := Copy(FM, 1, Len);
  end else
    FM := '';
  Result := GetSpFrag(Q, TableName, FieldName, FM, Cats);
  if Result then
    Result := Q.Locate('ID_Cat,ID', VarArrayOf([ID_Cat, ID]), [])
end;

function LocateInFrag2(ID: Integer; Q: TADOQuery; TableName,
  FieldName, FieldName2: string; ID_Cat: Integer = 0): Boolean;
var FM, FM2: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then
    FM := GLQR.FieldByName(FieldName).Value
  else
    FM := '';
  if GLQR.FieldByName(FieldName2).Value <> Null then
    FM2 := GLQR.FieldByName(FieldName2).Value
  else
    FM2 := '';
  Result := GetSpFrag2(Q, TableName, FieldName, FieldName2, FM, FM2, '*', ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;

function LocateInFrag2Part(ID: Integer; Q: TADOQuery; TableName, FieldName, FieldName2: string; Len: Integer = 1; ID_Cat: Integer = 0): Boolean;
var FM, FM2: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then
  begin
    FM := GLQR.FieldByName(FieldName).Value;
    FM := Copy(FM, 1, Len);
  end
  else
    FM := '';
  if GLQR.FieldByName(FieldName2).Value <> Null then
  begin
    FM2 := GLQR.FieldByName(FieldName2).Value;
    FM2 := Copy(FM2, 1, Len);
  end
  else
    FM2 := '';
  Result := GetSpFrag2(Q, TableName, FieldName, FieldName2, FM, FM2, '*', ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;

function LocateInFrag2V(ID: Integer; Q: TADOQuery; TableName,
  FieldName, FieldName2, FieldSumList: string; ID_Cat: Integer = 0): Boolean;
var FM, FM2: string;
begin
  Get1Sprav(ID, TableName, ID_Cat);
  if GLQR.FieldByName(FieldName).Value <> Null then
    FM := GLQR.FieldByName(FieldName).Value
  else
    FM := '';
  if GLQR.FieldByName(FieldName2).Value <> Null then
    FM2 := GLQR.FieldByName(FieldName2).Value
  else
    FM2 := '';
  Result := GetSpFrag2V(Q, TableName, FieldName, FieldName2, FM, FM2, FieldSumList, ID_Cat);
  if Result then begin
    if ID_Cat < 1000000 then
      Result := Q.Locate('ID', ID, [])
    else
      Result := Q.Locate('ID_Un', ID, [])
  end;
end;


function Locate2InFrag(ID, ID2: Integer; Q: TADOQuery;
  TableName, FieldName, FieldName2: string; ID_Cat: Integer = 0; NoOrder: boolean = false): Boolean;
var FM: string;
begin
  Get1Sprav2(ID, ID2, TableName, FieldName2, ID_Cat);
  if GlQr.FieldByName(FieldName).Value <> Null then
    FM := GLQr.FieldByName(FieldName).Value
  else
    FM := '';
  Result := GetSpFrag(Q, TableName, FieldName, FM, '*', ID_Cat, NoOrder);
  if Result then
    Result := Q.Locate('ID;' + FieldName2, VarArrayOf([ID, ID2]), []);
end;

function ValidSP(W: string): Boolean;
begin
  Result := (Trim(W) <> '') and ((W[1] <> '[') or (W[Length(W)] <> ']'));
end;

function Get1Sprav(ID: Integer; TabName: string; ID_Cat: Integer = 0): boolean;
var _TableName: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TabName;
  if ID_Cat < 1000000 then
    Result := OpenGlQr(string('Select * from ' + PrepCatStr(_TableName, ID_Cat) + ' where ID=') + IntToStr(ID))
  else
    Result := OpenGlQr(string('Select * from ' + PrepCatStr(_TableName, ID_Cat) + ' where ID_Un=') + IntToStr(ID))
end;

function Get1Sprav(ID: Integer; TabName: string; Qr: TADOQuery; ID_Cat: Integer = 0): boolean;
var _TableName: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TabName;
  if ID_Cat < 1000000 then
    OpenQr('Select * from ' + _TableName + ' where ID=' + IntToStr(ID), Qr, ID_Cat)
  else
    OpenQr('Select * from ' + _TableName + ' where ID_Un=' + IntToStr(ID), Qr, ID_Cat);
  Result := Qr.RecordCount > 0;
end;

function Get1Sprav(chrCode: string; TabName: string; Qr: TADOQuery; ID_Cat: Integer = 0): boolean;
var _TableName: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TabName;
  Qr.Active := False;
  Qr.SQL.Clear;
  Qr.SQL.Add('Select * from ' + PrepCatStr(_TableName, ID_Cat) + ' where chrCode=''' + chrCode + '''');
  Qr.Open;
  Result := Qr.RecordCount > 0;
end;


function Get1Sprav2(ID, ID2: Integer; TabName: string; Field2: string; ID_Cat: Integer = 0): boolean;
var _TableName: string;
begin
  if ID_Cat <> 0 then
    _TableName := '|'
  else
    _TableName := '';
  _TableName := _TableName + TabName;
  Result := OpenGlQr('Select * from ' + PrepCatStr(_TableName, ID_Cat) + ' where ID=' + IntToStr(ID) +
    ' and ' + Field2 + '=' + IntToStr(ID2));
end;

function OpenGlQr(SQ: string; ID_Cat: Integer = 0): Boolean;
begin
  Result := OpenQr(SQ, GlQr, ID_Cat);
end;

function OpenGlSysQr(SQ: string): Boolean;
begin
  Result := OpenQr(SQ, GlSysQr);
end;

function ExecQr(SQ: string; Qr: TADOQuery; ID_Cat: Integer = 0): Boolean;
begin
  Qr.Active := False;
  Qr.SQL.Clear;
  // QR.SQL.Add(SQ);
  QR.SQL.Add(PrepCatStr(SQ, ID_Cat));
  Result := Qr.ExecSQL > 0;
end;


function ExecQrN(SQ: string; Qr: TADOQuery; ID_Cat: Integer = 0): Integer;
begin
  Qr.Active := False;
  Qr.SQL.Clear;
  // QR.SQL.Add(SQ);
  QR.SQL.Add(PrepCatStr(SQ, ID_Cat));
  Result := Qr.ExecSQL;
end;



function OpenQr(SQ: string; Qr: TADOQuery; ID_Cat: Integer = 0): Boolean;
var s: string;
begin
  Qr.Active := False;
  Qr.SQL.Clear;
  try
    s := PrepCatStr(SQ, ID_Cat);
    Qr.SQL.Add(s);
  except
    ShowMessage('Оно пришло... Ошибка добавления в OpenQr:' + s);
    Result := False;
    Exit;
  end;
  Screen.Cursor := crSQLWait;
  try
   // try
    Qr.Open;
   // except
  // end;
  finally
    Screen.Cursor := crDefault;
  end;
  Result := Qr.RecordCount > 0;
end;

function PrepareLike(Str: string): string;
begin
  Result := ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(Str, '''', ''''''),
    '[', '[[]'), '%', '[%]');
end;

function PrepareForSQL(Str: string): string;
begin
  Result := ReplaceSymbol(Str, '''', '''''');
end;

function PrepareForAdvSearch(Str: string): string;
begin
  Result := ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(
    ReplaceSymbol(Trim(Str), '''', ''), '"', ''), '[', ''), ']', ''), '(', ''), ')', ''), '.', '');
end;

function PrepCatStr(W: string; ID_Cat: Integer): string;
//символ |должен стоять перед всеми именами таблиц, относящихся к каталогу  c ID_Cat
//символы - |^ - стоять перед всеми именами таблиц, относящихся к локальному каталогу
begin
  Result := W;
  if (ID_Cat > 0) and
    tCat.Locate('Id', ID_Cat, []) then begin
    Result := ReplaceSymbol(Result, '|^', tCat.FieldByName('BaseName').Value + '.dbo.');
    if (tCat.FindField('ExtBaseName') <> nil) and (tCat.FieldByName('ExtBaseName').AsString <> '') then
      Result := ReplaceSymbol(Result, '||', '[' + tCat.FieldByName('ServerName').Value +
        '].' + tCat.FieldByName('ExtBaseName').Value + '.dbo.');
    Result := ReplaceSymbol(Result, '|#', '[' + tCat.FieldByName('ServerName').Value +
      '].tempdb.dbo.');
    Result := ReplaceSymbol(Result, '|', '[' + tCat.FieldByName('ServerName').Value +
      '].' + tCat.FieldByName('BaseName').Value + '.dbo.');
  end else
    Result := ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(W, '|^', ''), '|#', '#'), '|', '');

end;

function GetTableName(Q: TADOQuery): string;
var s: string;
begin
  S := UpperCase(Q.SQL.Text);
  Delete(S, 1, Pos(' FROM ', S) + 5);
  S := Trim(S);
  Result := Copy(S, 1, Pos(' ', S));
end;

function findEqRecord(QSource, QDest: TADOQuery; FList: string): boolean;
var i: integer;
  S, Fn, Fl: string;
begin
  result := False;
  if FList <> '' then begin
    FL := FList;
    S := 'Select * from ' + GetTableName(QSource) + ' where ID!=' + intToStr(QSource.FieldByName('ID').Value);
    i := Pos(',', Fl);
    if (i = 0) and (Length(FL) > 0) then
      i := Length(FL) + 1;
    while i > 0 do begin
      Fn := Copy(Fl, 1, i - 1);
      Delete(FL, 1, i);
      S := S + ' and ' + FN;
      if QSource.FieldByName(FN).Value <> Null then begin
        if QSource.FieldByName(FN) is TIntegerField then
          S := S + '=' + IntToStr(QSource.FieldByName(FN).Value)
        else
          S := S + '= N''' + PrepareForSQL(QSource.FieldByName(FN).Value) + ''''
      end else
        S := S + ' is Null';
      i := Pos(',', Fl);
      if (i = 0) and (Length(FL) > 0) then
        i := Length(FL) + 1;
    end;
    Result := OpenQr(S, QDest)
  end;
end;

function GetCountStr(q: string; Qr: TADOQuery): string;
begin
  if OpenQr(q, Qr) then
    Result := IntToStr(Qr['C'])
  else
    Result := '';
end;


function PrepareInsertStr(S: array of string): string;
var i: integer;
begin
  Result := '';
  for i := 0 to High(S) do
    Result := Result + 'N''' + PrepareForSQL(S[i]) + ''',';
  if Length(Result) > 0 then
    Delete(Result, Length(Result), 1);
end;

function GetAvtSprStr(ID_Un: Integer; AvtType: Integer; ID_Cat: Integer = 1000000): string;
var Tn: string;
begin
  TN := '|S' + IntToStr(AvtType);
  if Length(Tn) < 4 then
    TN := TN + '0';
  if OpenGlQr('Select Name from ' + TN + ' where ID_Un=' + InttoStr(ID_Un), ID_Cat) then
    Result := GlQr.FieldByName('Name').Value
  else
    Result := '';
end;

function Get1IntVal(q: string; Fn: string; Qr: TADOQuery; ID_Cat: integer = 0): Integer;
begin
  Result := 0;
  if OpenQr(q, Qr, ID_Cat) and (Qr[Fn] <> Null) then
    Result := Qr[Fn];
end;

function Get1StrVal(q: string; Fn: string; Qr: TADOQuery; ID_Cat: integer = 0): string;
begin
  Result := '';
  if OpenQr(q, Qr, ID_Cat) and (Qr[Fn] <> Null) then
    Result := Qr[Fn];
end;

function GetRecordCount(TabName: string; Qr: TADOQuery; ID_Cat: integer = 0): integer;
begin
  Result := 0;
  if OpenQr('Select Count(*) as C from ' + TabName, Qr) then
    Result := Qr['C'];
end;

end.

