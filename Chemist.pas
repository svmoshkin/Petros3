unit Chemist;


interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StrUtils, ESBRtns, ADODB, ADOUtilsS,RHAGlobs;



const MendCount = 100;
      ShowCount=MendCount + 3;

type
 {SetOfChar = set of char;}


  TElem = class
    number: byte;
    constructor Create(num: byte);
    function GetSymbol: string;
    function GetVes: real;
  {constructor Load(var S : TStream);
  Procedure Store(var S : TStream); }
  end;

  TMendTab = class
  private
    FOrder: array[1..MendCount] of byte;
    function GetOrder(Index: Integer): Byte;
    procedure SetOrder(Index: Integer; const Value: Byte);
  public
    MustOx: array[1..MendCount] of byte;
    AlfaN: Integer;


    constructor Create;
    function GetVes(Num: integer): real;
    function GetGroup(Num: integer): byte;
    function GetSymbol(Num: integer): string;
    function GetNumber(Sym: string): byte;
  {Номеp элемента в алфавите по символу или 0 пpи ошибке}
    function GetFullNumber(Sym: string): byte;
  {Номеp элемента  по символу или 0 пpи ошибке}
    function getValent(Num: byte; Plus: boolean): byte;
    function GetOxideSt(num: byte; First: boolean): string;
  {Стехиом коэф. для главного оксида. First=true - коэф. пpи
  элементе, false - пpи кислоpоде}
    function GetOxideVes(Num: integer): real;
         {Мол. вес основного оксида, или атомный вес, если оксида нет}
    function GetOxide(Num: integer): string;
         {Формула основного оксида, или символ элемента, если
         оксида нет}
    function GetPetroVes(Num: Integer): real;
        { Атоммный вес или вес оксида в завис. от петрохимических правил}
    function GetPetroSym(Num: Integer): string;
    function GetFieldTitle(Num: Integer): string;
    function GetInterSymb(Num: integer): string;
    function GetOxideTitle(Num: integer): string;
    function MustMol(Num: integer): boolean;
    function GetKatSteh(Num: integer): integer;
    function GetNumById(Id: string): integer;
    property Order[Index: Integer]: Byte read GetOrder write SetOrder;
            {Символ элемента или оксида  в завис. от петрохимических правил}
  end;


  TFormula = class
    Symbol: string;
    Elements: string[100];
    nhNumber: integer;
    Stechiom: array[1..100] of real;
    Mol: real;
    NElem: integer;
    Delit: real;
    NotChem: Boolean;
    constructor Create(S: string; NC: Boolean);
    function IsValid(const S: string): boolean; virtual;
    procedure Error;
  end;

  TAnalisTitle = class(TList)
    Title: string;
    NotChem: Boolean;
    constructor Create(S: string; NC: Boolean);
    destructor Destroy; override;
    function MakeString(kod: Byte): string;
  end;

function ValidFormula(S: string; NotChem: Boolean = False; Strong : boolean=True): byte;
{Возвpащает позицию пеpвой ошибки в химической фоpмуле или 0 если все OK}

(*procedure ReadFormula(Title : String);
{Обpабатывает диалог ввода химической фоpмулы и создает объект ChemFormula}*)

procedure MesMol;
{Выводит значение молекуляpного веса для ChemFormula}




const
  UpLet = ['A'..'Z'];
  DownLet = ['a'..'z', #134, #135];
  ValentPlus: array[0..16] of byte = (0, 1, 2, 3, 4, 5, 4, 7, 2, 1, 2, 3,
    4, 5, 4, 0, 4);
  ValentMin: array[0..16] of byte = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
    3, 2, 1, 0);
  AtVes: array[1..MendCount] of real = (1.00797, 4.00260, 6.93900, 9.01220, 10.81100,
    12.01115, 14.00670, 15.99940, 18.99840, 20.18300, 22.98980, 24.31200,
    26.98150, 28.08600, 30.97380, 32.06400, 35.45300, 39.94800, 39.10200,
    40.08000, 44.95600, 47.90000, 50.94200, 51.99600, 54.93810, 55.84700,
    58.93320, 58.71000, 63.54000, 65.37000, 69.72000, 72.59000, 74.92160,
    78.96000, 79.90900, 83.80000, 85.47000, 87.62000, 88.90500, 91.22000,
    92.90600, 95.94000, 97.00000, 101.07000, 102.90500, 106.40000, 107.87000,
    112.40000, 114.82000, 118.69000, 121.75000, 127.60000, 126.90440, 131.30000,
    132.90500, 137.34000, 138.91000, 140.12000, 140.90700, 144.24000, 147.00000,
    150.35000, 151.96000, 157.25000, 158.92400, 162.50000, 164.93000, 167.26000,
    168.93400, 173.04000, 174.97000, 178.49000, 180.94800, 183.85000, 186.20000,
    190.20000, 192.20000, 195.09000, 196.96700, 200.59000, 204.37000, 207.19000,
    208.98000, 210.00000, 210.00000, 222.00000, 223.00000, 226.00000, 227.00000,
    232.03800, 231.00000, 238.03000, 55.847, 55.847, 1, 1, 1, 1, 1, 1);
  MendSym: array[1..MendCount] of string[2] = ('H', 'He', 'Li', 'Be', 'B', 'C', 'N', 'O',
    'F', 'Ne', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'Ar', 'K', 'Ca', 'Sc',
    'Ti', 'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se',
    'Br', 'Kr', 'Rb', 'Sr', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag',
    'Cd', 'In', 'Sn', 'Sb', 'Te', 'I', 'Xe', 'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd',
    'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 'Hf',
    'Ta', 'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At',
    'Rn', 'Fr', 'Ra', 'Ac', 'Th', 'Pa', 'U', 'Fe', 'Fe', '?', '?', '?', '?', '?', '?');
  Group: array[1..MendCount] of Byte = (1, 0, 1, 2, 11, 12, 13, 14, 15, 0, 1, 2, 11, 12,
    13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 9, 10, 11, 12, 13, 14, 15, 0,
    1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 3, 3,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 5, 6, 7, 8, 8, 8, 9, 10, 11, 12, 13,
    14, 15, 0, 1, 2, 16, 16, 16, 16, 3, 2, 1, 1, 1, 1, 1, 1);
  MMol: array[1..MendCount] of Byte = (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0,
    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  MOx: array[1..MendCount] of Byte = (1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  MMolD: array[1..MendCount] of Byte = (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0,
    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  MOxD: array[1..MendCount] of Byte = (1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1);
  Ordr: array[1..MendCount] of Byte = (14, 22, 13, 93, 94, 26, 25, 12, 20, 11, 19, 15, 1, 2, 3,
    4, 5, 6, 7, 8, 9, 10, 16, 17, 18, 21, 23, 24, 27, 28, 29, 30, 31, 32, 33, 34,
    35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72,
    73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91,
    92, 1, 1, 1, 1, 1, 1);
  MathSym = ['+', '-', '*', '/', '(', ')'];


 {MendAsc:PMendDialog=nil;}
  ChemFormula: TFormula = nil;



var
  MendTab: TMendTab;
  AtomnColich: array[1..MendCount] of real;
  AnalisTitle: TAnalisTitle = nil;
  Fe2: TStringList;
  Fe3: TStringList;
  ElemTab: TADOTable;

resourcestring
  stFormErr = 'Error in chemical formula';
              {'ОШИБКА В ЗАПИСИ ФОPМУЛЫ'}
              {stTooManyComp='Too many components in analise. Resrict to ';}



implementation

type
  CharSet = set of Char;

var F: file;
  i: Integer;

function Remove(const Ch: CharSet; const S: string): string;
var I: Integer;
begin
  Result := S;
  I := 1;
  while I <= Length(Result) do
    if Result[I] in Ch then
      Delete(Result, I, 1) else
      Inc(I);
end;

{############################# TElem #############################}


constructor TElem.Create(num: byte);
begin
  inherited Create;
  number := num;
end;

{constructor TElem.Load(var S : TStream);
begin
 inherited Create;
 S.Read(Number,SizeOf(Byte));
end;


procedure TElem.Store(var S : TStream);
begin
 S.Write(Number,SizeOf(Byte));
end;  }


function TElem.GetSymbol: string;
begin
  GetSymbol := MendTab.GetSymbol(number);
end;


function TElem.GetVes: real;
begin
  if Number <= MendCount then
    result := MendTab.GetVes(Number)
  else
    Result := 1;
end;




{########################### TMendTab #######################}

constructor TMendTab.Create;
var
  i: integer;
begin
  inherited Create;
  AlfaN := 0;
  if FileExists('ElSeq.pti') then begin
    AssignFile(F, 'ElSeq.pti');
    Reset(F);
    for i := 1 to 94 do
      Blockread(F, FOrder[i], SizeOf(Byte));
    CloseFile(F);
  end else
    for i := 1 to MendCount do
      FOrder[i] := Ordr[i];
  for i := 1 to MendCount do
    MustOx[i] := mox[i];
end;

function TMendTab.GetVes(Num: integer): real;
begin
  if (AlfaN > 0) then
    Result := 1
  else
    if (Num < 1) or (Num > MendCount) then GetVes := 0
    else GetVes := AtVes[num];
end;

function TMendTab.GetGroup(Num: integer): byte;
begin
  if (AlfaN > 0) or (Num < 1) or (Num > MendCount) then GetGroup := 0
  else GetGroup := Group[num];
end;


function TMendTab.GetSymbol(Num: integer): string;
begin
  if (AlfaN = 0) then begin
    if (Num < 1) then
    Result := ''
    else
      Result := MendSym[num];
  end else if ElemTab.Locate('Num', 100 * AlfaN + Num, []) then
    Result := ElemTab['Elem']
  else
    Result := ''
end;

function TMendTab.GetNumber(Sym: string): byte;
begin
  Result := GetFullNumber(Sym);
  if Result > 0 then begin
    Result := Result mod 100;
    if Result = 0 then
      Result := 100;
  end;
end;

function TMendTab.getValent(Num: byte; Plus: boolean): byte;
var
  Gr: byte;
begin
  if (AlfaN = 0) then begin
    Gr := Group[num];
    if plus then begin
      GetValent := ValentPlus[Gr];
      case Gr of
        6: if num = 24 then GetValent := 3;
        7: if num = 25 then GetValent := 2;
        8: if num > 29 then GetValent := 4;
        9: if num = 29 then GetValent := 2;
        13: if num = 7 then GetValent := 4 else
            if num = 83 then GetValent := 3;
        14: begin if num = 8 then GetValent := 0;
            if num = 16 then GetValent := 6;
          end;
      end
    end else GetValent := ValentMin[Gr];
  end else
    Result := 1;
end;


function TMendTab.GetOxideSt(num: byte; First: boolean): string;
 {Стехиом коэф. для главного оксида. First=true - коэф. пpи
 элементе, false - пpи кислоpоде}
begin
  if (AlfaN = 0) then begin
    if First then
      case GetValent(num, true) of
        1, 3, 5, 7: GetOXideSt := '2';
        0, 2, 4, 6: GetOXideSt := '';
      end else
      case GetValent(num, true) of
        0, 1..2: GetOXideSt := '';
        4: GetOXideSt := '2';
        3, 6: GetOXideSt := '3';
        5: GetOXideSt := '5';
        7: GetOXideSt := '7';
      end;
  end else
    GetOXideSt := '';
end;



function TMendTab.GetOxideVes(Num: integer): real;
{Мол. вес основного оксида, или атомный вес, если оксида нет}
var
  t: TFormula;
begin
  if (AlfaN = 0) then begin
    T := TFormula.Create(GetOxide(Num), False);
    Result := T.Mol;
    T.Free;
  end else
    Result := 1;
end;


function TMendTab.GetOxide(Num: integer): string;
{Формула основного оксида, или символ элемента, если
         оксида нет}
begin
  Result := GetSymbol(Num);
  if (AlfaN = 0) and (getValent(Num, True) > 0) then begin
    Result := Result + GetOxideSt(Num, True) + 'O' +
      GetOxideSt(Num, False);
  end;
end;

function TMendTab.GetPetroVes(Num: Integer): real;
var
  k: integer;
{ Атоммный вес или вес оксида в завис. от петрохимических правил}
begin
  if (AlfaN > 0) then
    Result := 1
  else
    if MustOx[Num] > 0 then begin
      if GetOxideSt(Num, True) = '' then k := 1
      else k := StrToInt(GetOxideSt(Num, True));
      Result := GetOxideVes(Num) / k
    end else Result := GetVes(Num);
end;


function TMendTab.GetPetroSym(Num: Integer): string;
{Символ элемента или оксида  в завис. от петрохимических правил}
begin
  if (AlfaN > 0) then
    Result := GetFieldTitle(Num)
  else begin
    if Num = 8 then
      Result := ''
    else if (Num = 101) then
      Result := 'En'
    else if (Num = 102) then
      Result := 'An'
    else if (Num=103) then
      Result:='Tn'
    else if MustOx[Num] > 0 then
      Result := GetOxideTitle(Num)
    else Result := GetFieldTitle(Num);
  end;
end;


{######################## TFormula #############################}

constructor TFormula.Create(S: string; NC: Boolean);
var
  Ch: char;
  AStr, RS: string;
  i, k, j, l, kod, Jump: integer;
  Number: boolean;
  Koef, R: real;
const
  C = [' ', '.', '0'..'9'];
label
  Cont, FeEnd;

  procedure Scobka;
  var
    st: string;
  begin
    St := Copy(AStr, i + 1, Length(AStr) - i);
    l := Pos(')', St) + 1;
    Jump := l - 1;
    repeat
      inc(Jump);
    until (Jump > length(St)) or (St[Jump] in UpLet) or (St[Jump] = '(');
    St := Copy(St, l, Jump - l);
    Inc(Jump, i);
    if st = '' then Koef := 1 else Val(St, Koef, Kod);
  end;

begin
  inherited Create;
  NotChem := NC;
  if NC then begin
    Elements := '';
    NElem := 1;
    Symbol := S;
    if ElemTab.Locate('Elem', s, []) then
      nhNumber := ElemTab['Num']
    else
      nhNumber := -1;
    Delit := 1;
    NElem := 1;
    exit;
  end;
  AStr := s;
  repeat
    i := Pos(' ', AStr);
    if i = 0 then break
    else System.delete(AStr, i, 1);
  until false;
  Symbol := AStr;
  i := Pos('Fe', AStr);
  if i > 0 then begin
    if AStr = 'Fe3O4' then
      AStr := 'Fe' + #134 + 'Fe' + #135 + '2O4'
    else begin
      for j := 0 to Fe2.Count - 1 do
        if AStr = Fe2.Strings[j] then begin
          System.Insert(#134, AStr, i + 2);
          goto FeEnd;
        end;
      for j := 0 to Fe3.Count - 1 do
        if AStr = Fe3.Strings[j] then begin
          System.Insert(#135, AStr, i + 2);
          goto FeEnd;
        end;
    end;
  end;
  FeEnd: Koef := 1;
  i := 1;
  if AStr[1] = '(' then begin
    Scobka;
    inc(i);
  end;
  k := 0;
  rs := AStr[i];
  inc(i);
  Number := false;
  repeat
    if i <= Length(AStr) then Ch := AStr[i]
    else Ch := #0;
    if Ch in ['(', ')'] then begin
      if Ch = '(' then begin
        if Number then begin
          Val(Rs, R, kod);
          Number := False;
          Stechiom[k] := R * Koef;
        end
        else if rs <> '' then begin
          inc(k);
          Elements := Elements +
            Char(MendTab.GetNumber(Rs));
          Stechiom[k] := Koef;
        end;
        Rs := '';
        Scobka;
        inc(i);
      end else begin
        if Number then begin
          Val(Rs, R, kod);
          Number := False;
          Stechiom[k] := R * Koef
        end
        else begin
          inc(k);
          Elements := Elements +
            Char(MendTab.GetNumber(Rs));
          Stechiom[k] := Koef;
        end;
        Rs := '';
        Koef := 1;
        i := Jump;
      end;
      continue;
    end;
    if (Ch in UpLet) or (i = Length(AStr) + 1) then begin
      if Rs = '' then goto Cont;
      if Number then begin
        Val(Rs, R, kod);
        Stechiom[k] := R * Koef
      end
      else begin
        inc(k);
        Elements := Elements +
          Char(MendTab.GetNumber(Rs));
        Stechiom[k] := Koef;
      end;
      RS := '';
      Number := false
    end else begin
      if (ch in C) and not number then begin
        if Rs = '' then goto Cont;
        Number := True;
        inc(k);
        Elements := Elements +
          Char(MendTab.GetNumber(Rs));
        Stechiom[k] := Koef;
        Rs := '';
      end;
    end;
    Cont: Rs := Rs + Ch;
    if k > 15 then break;
    inc(i);
  until i > length(AStr) + 1;
  for i := k downto 2 do begin
    for j := i - 1 downto 1 do
      if Elements[i] = Elements[j] then begin
        delete(Elements, i, 1);
        Stechiom[j] := Stechiom[i] + Stechiom[j];
        for l := i to Length(Elements) + 1 do
          Stechiom[l] := Stechiom[l + 1];
        break;
      end;
  end;
  NElem := Length(Elements);
  Mol := 0;
  for i := 1 to NElem do
  if Byte(elements[i])<MendCount then
    Mol := Mol + AtVes[Byte(Elements[i])] * Stechiom[i]
    else
      ShowMessage('Elements['+intToStr(I)+']='+intToStr(Byte(Elements[i]))+'; '+Symbol);
  Delit := 1;
end;



procedure TFormula.Error;
begin
  ShowMessage(stFormErr);
end;


function TFormula.IsValid(const S: string): boolean;
var
  i: byte;
begin
  if NotChem then
    Result := nhNumber >= 0
  else begin
    i := ValidFormula(S);
    IsValid := (i = 0)
  end;
end;


{####################################################################}



function ValidFormula(S: string; NotChem: Boolean = False; Strong : boolean=True): byte;
var
  Ch: char;
  AStr, RS: string;
  i: integer;
  Scob: byte;
  Number: boolean;
const
  C = [' ', '.', '0'..'9'];
label
  Cont;
begin
  Result := 1;
  if NotChem or not Strong then 
    if ElemTab.Locate('Elem', s, []) then begin
      Result := 0;
    exit;
  end;

  aStr := s;
  repeat
    i := Pos(' ', AStr);
    if i = 0 then break
    else delete(AStr, i, 1);
  until false;
  if AStr = '' then exit;
  Scob := 0;
  if not ((AStr[1] in UpLet) or (AStr[1] in ['(', ')'])) then exit;
  i := 1;
  if AStr[1] in ['(', ')'] then begin
    if AStr[1] = '(' then Scob := 1 else exit;
    inc(i);
  end;
  rs := AStr[i];
  inc(i);
  Number := false;

  repeat
    ValidFormula := i - 1;
    if i <= Length(AStr) then Ch := AStr[i]
    else Ch := #0;
    if Ch in ['(', ')'] then begin
      if Number and (rs <> '') then begin
        if not ValidNumString(Rs) then
          exit;
        Rs := '';
      end;
      if (Ch = '(') and (Scob = 0) then begin
        if not (AStr[i + 1] in UpLet) then begin
          ValidFormula := I + 1;
          exit;
        end;
        Scob := 1;
        Number := False
      end
      else if (Scob = 1) and (Ch = ')') then
        Scob := 0
      else exit;
      inc(i);
      continue;
    end;
    if not (((Ch in UpLet) or (Ch in DownLet) or (ch in C))) and
      (i < Length(AStr) + 1) then begin
      ValidFormula := i;
      exit;
    end;
    if (Ch in UpLet) or (i = Length(AStr) + 1) then begin
      if Number then begin
        Number := false;
        if Rs = '' then goto Cont;
        if not ValidNumString(Rs) then
          exit;
      end else begin
        if Rs = '' then goto Cont;
        if MendTab.GetNumber(Rs) = 0 then
          exit
      end;
      RS := '';
    end else begin
      if (ch in C) and not number then begin
        Number := True;
        if Rs = '' then goto Cont;
        if MendTab.GetNumber(Rs) = 0 then
          exit
        else Rs := '';
      end;

    end;
    Cont: Rs := Rs + Ch;
    inc(i);
  until i > Length(AStr) + 1;
    {else if MendTab.GetNumber(Rs) = 0 then
                    exit; }
  if Scob > 0 then begin
    ValidFormula := Length(AStr) + 1;
    exit;
  end;
  ValidFormula := 0;
end;


procedure MesMol;
{Выводит значение молекуляpного веса для ChemFormula}
var
  Rs: string;
begin
  if assigned(ChemFormula) then begin
    Str(ChemFormula.Mol: 9: 3, Rs);
    ShowMessage(^C + 'Молекуляpный вес ' + #13 +
      ^C + ChemFormula.Symbol + #13 + ^C + Rs);
  end;
end;


{########################### TAnalisTitle ##################}

constructor TAnalisTitle.Create(S: string; NC: Boolean);
var RS, fs: string;
  Beg, EN: Byte;
begin
  inherited Create;
  Title := S;
  NotChem := NC;
  if S = '' then exit;
  Beg := 1;
  repeat
    RS := Copy(S, Beg, Length(S) - Beg + 1);
    EN := Pos(',', RS);
    if EN = 0 then EN := Length(RS) + 1;
    fs := Copy(RS, 1, EN - 1);
    if fs = '' then break;
    Add(TFormula.Create(fs, NC));
    {if Count>=MaxCompCount  then begin
        ShowMessage(stTooManyComp+IntToStr(MaxCompCount));
        break;
    end;}
    Beg := Beg + EN;
  until EN = Length(RS) + 1;
end; {_ constructor TAnalisTitle.Create(S: string); _}




destructor TAnalisTitle.Destroy;
var i: integer;
begin
  for i := 0 to Count - 1 do
    TFormula(Items[i]).Free;
  inherited;

end;

function TAnalisTitle.MakeString(kod: Byte): string;
var S, ST: string;
  P: TFormula;
  I, J, len: Integer;
begin
  ST := '  N';
  if kod = 0 then len := 14 else len := kod;
  for I := 1 to Count do begin
    P := Items[I - 1];
    S := P.Symbol;
    for J := 1 to Len - Length(S) do
      S := ' ' + S;
    ST := ST + S;
  end; {_ for I := 1 to Count do begin _}
  MakeString := ST;
end; {_ function TAnalisTitle.MakeString(kod: Byte): string; _}


{--------------------------------------------------------------------}



function TMendTab.GetFieldTitle(Num: Integer): string;
begin
  if (AlfaN = 0) and (Num = 94) then Result := 'Fe++'
  else if (AlfaN = 0) and (Num = 93) then Result := 'Fe+++'
  else if (Num = 101) then Result := 'En'
  else if (Num = 102) then Result := 'An'
  else if (Num = 103) then Result := 'Tn'
  else Result := GetSymbol(Num);
end;



function TMendTab.GetInterSymb(Num: integer): string;
begin
  if (AlfaN = 0) and (Num = 94) then Result := 'Fe†'
  else if (AlfaN = 0) and (Num = 93) then Result := 'Fe‡'
  else Result := GetSymbol(Num);
end;

function TMendTab.GetOxideTitle(Num: integer): string;
begin
  Result := GetOxide(Num);
  if (AlfaN = 0) and (Num = 26) then
    Result := Result + ' tot';
end;

function TMendTab.MustMol(Num: integer): boolean;
begin
  if (AlfaN = 0) and (Num <= MendCount) then
    Result := MMol[Num] = 1
  else if Num > 100 then
    Result := True
  else
    result := False;
end;

function TMendTab.GetKatSteh(Num: integer): integer;
begin
  if AlfaN = 0 then
    case GetValent(num, true) of
      1, 3, 5, 7: Result := 2;
      0, 2, 4, 6: Result := 1;
    else Result := -1;
    end
  else Result := -1;
end;

function TMendTab.GetNumById(Id: string): integer;
var s: string;
  i: integer;
begin
  Result := 0;
  S := AnsiLowerCase(Remove(['_', ' '], Id));
  if s = 'fe2' then
    Result := 94
  else if s = 'fe3' then result := 93
  else
    for i := 1 to MendCount do
      if (s = AnsiLowerCase(GetInterSymb(i))) or
        (s = AnsiLowerCase(Remove([' '], GetOxideTitle(i)))) then begin
        Result := i;
        Exit;
      end

end;




function TMendTab.GetOrder(Index: Integer): Byte;
begin
  if (AlfaN = 0) and (Index <= 94) then
    Result := Forder[Index]
  else if (Index <= 101) then
    Result := Index
  else begin
    Result := Index mod 100;
    if Result = 0 then
      result := 100;
  end;
end;

procedure TMendTab.SetOrder(Index: Integer; const Value: Byte);
begin
  if (AlfaN = 0) and (Index <= 94) then
    FOrder[Index] := Value;
end;

function TMendTab.GetFullNumber(Sym: string): byte;
var
  i: integer;
  Rs: string;
begin
  Rs := Trim(Sym);
  if AlfaN = 0 then begin
    if Rs = 'Fe‡' then begin
    Result := 93;
    exit;
    end
    else if Rs = 'Fe†' then begin
      Result := 94;
      exit
      end
    else begin
      Result := 0;
      for i := 1 to 92 do
        if Rs = MendSym[i] then begin
          Result := i;
          exit;
        end;
    end;
  end;
  if ElemTab.Locate('Elem', Rs, []) then
    Result := ElemTab['Num']
  else Result := 0;
end;

initialization

  MendTab := TMendTab.Create;
  Fe2 := TStringList.Create;
  Fe3 := TStringList.Create;

finalization
  MendTab.Free;
  Fe2.Clear;
  Fe2.Free;
  Fe3.Clear;
  Fe3.Free;
 { AssignFile(F, 'ElSeq.pti');
  rewrite(F);
  for i := 1 to MendCount do
    BlockWrite(F, Ordr[i], SizeOf(Byte));
  CloseFile(F);}
end.

