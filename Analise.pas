unit Analise;

interface

uses Windows, SysUtils, Classes, Graphics, StdCtrls, Chemist, RHAGlobs, ESBRtns,
  DB, ADODB, Dialogs, ComCtrls, Forms, Variants, ADOUtilsS, math;

type

  TIntRealObj = class
    Num: integer;
    C: Real;
    constructor Create(An: integer; Ac: Real);
    function OrdOf(S: TIntRealObj): integer;
      //1 - если S меньше, -1 S больше
  end;


  TAnalis = class(TList)
  public
    Rang: string;
    Descriptor: string[200];
    Eq: string[20];
    H, E, TTT, A, Summa, an, Ox,Tn: real;
    CalcVes: Boolean;
    NotChem: Boolean;
    ATOM: array[1..MendCount] of real;
    AW: real;
    AWA: real;
    MolFactor: real;
    MolFactorAW: real;
    Hn: real;
    constructor Create;
    constructor CreateT(Tabl, Tabl2: TDataset);
    {constructor InitLoad(FileNum,Num : integer);}
    procedure SetVal(I: Integer; V: real);
    {Procedure WriteTo(var F:Text); }
    function GetString: string;
    procedure Recalc(ATitle: TAnalisTitle);
  end;

  TAComponent = class
    Value: real;
  end;

var

  Analises: TList;
  Plist, PNameList: TStringList;
  Filename: string[60];
  NormA, NormH: real;
  NAnal: Integer;
  BadAnalise: Boolean;
  NewAnalises: Boolean;
  Oxy: array[1..MendCount] of real;
  NEl: Integer;
  S: array[1..MendCount] of Integer;

const
  Titles: TStringList = nil;
  LastTitle: Integer = 0;
  ChangedTitle: Boolean = False;
  CalcFirst: Boolean = True;
  MinAtDol: Double = 0.00000000000009;

resourcestring
  stTooMany = 'Too many components! (';
  stCompErr = 'Error in components list!';
  stDropFe = 'Imposible presents of Fe-total and Fe++ or Fe+++ in same analyzes' +
    'Fe-total is ignored';

function TranslateR(const S: string; var RF: string;
  var ErPos: Byte): Boolean;
function TitleIsValid(const S: string; Edit: TComboBox; NotChem: Boolean = False): Boolean;
function MakeRStr(const S, Eq: string): string;
procedure RecalcTable(Table: TADOQuery; PB1: TProgressBar);


implementation

function TranslateR(const S: string; var RF: string;
  var ErPos: Byte): Boolean;
var I, Beg, EN, N: Byte;
  SS, RS, fs: string;
begin
  RF := '';
  Result := True;
  Beg := 1;
  SS := ReplaceChStr(S, '=', ' ');
  SS := ReplaceChStr(SS, ' ', ',');
  while Pos(',,', SS) > 0 do
    SS := ReplaceSymbol(SS, ',,', ',');
  repeat
    RS := StripLChStr(Copy(SS, Beg, Length(SS) - Beg + 1), ',');
    EN := Pos(',', RS);
    if EN = 0 then EN := Length(RS) + 1;
    fs := Copy(RS, 1, EN - 1);
    if fs = '' then break;
    I := ValidFormula(fs, MendTab.AlfaN > 0);
    if I > 0 then break;
    N := MendTab.GetNumber(fs);
    RF := RF + PadLeftStr(IntToStr(N), RSymLen);
    Beg := Beg + EN;
  until EN = Length(RS) + 1;
  if I <> 0 then begin
    Result := False;
    ErPos := Beg + I - 2;
  end;
end;

function TitleIsValid(const S: string; Edit: TComboBox; NotChem: Boolean = False): Boolean;
var I, Beg, EN: Integer;
  k: integer;
  RS, fs: string;
begin
  Beg := 1;
  k := 0;
  repeat
    RS := Copy(S, Beg, Length(S) - Beg + 1);
    EN := Pos(',', RS);
    if EN = 0 then
      EN := Length(RS) + 1;
    fs := Copy(RS, 1, EN - 1);
    if fs = '' then
      break;
    I := ValidFormula(fs, NotChem);
    if I > 0 then
      break;
    Beg := Beg + EN;
    inc(k);
  until EN = Length(RS) + 1;
  if k > MaxCompCount then begin
    Result := false;
    if Assigned(Edit) then
      ShowMessage(stTooMany + IntToStr(K) + ')');
    exit;
  end;
  if I = 0 then
    Result := True
  else begin
    Result := False;
    if Assigned(Edit) then begin
      ShowMessage(stCompErr);
      Edit.SetFocus;
      Edit.SelStart := Beg + I - 2;
      Edit.SelLength := 1;
    end; {_ if Assigned(Edit) then begin _}
  end; {_ NOT if I = 0 then Result := True _}
end; {_ function TitleIsValid(const S: string; Edit: TComboBox): Boolean; _}


function MakeRStr(const S, Eq: string): string;
var I, N: Integer;
begin
  Result := '';
  for I := 0 to (Length(S) div RSymLen) - 1 do begin
    N := StrToInt(Copy(S, I * RSymLen + 1, RSymLen));
    if N>0 then begin
    if N < 95 then
      Result := Result + PadRightStr(MendSym[N], ElSymLen)
    else  begin
      ElemTab.Locate('Num', N, []);
      Result := Result + PadRightStr(ElemTab['Elem'], ElSymLen)
    end;
    end else
      Result:=PadRightStr('?',ElSymLen);
    if I < Min(MaxHALen, Length(Eq)) then Result := Result + Eq[I + 1]
    else {_ NOT if I < Min(MaxHALen, Length(Eq)) then Result := Result + Eq[I + 1] _}
      Result := Result + ' ';
    if I = MaxHALen - 1 then Result := Result + '  ';
  end; {_ for I := 0 to (Length(S) div 3) - 1 do begin _}
end; {_ function MakeRStr(const S, Eq: string): string; _}

procedure RecalcTable(Table: TADOQuery; PB1: TProgressBar);
var i, k: integer;
  CT: Boolean;
begin
  Ct := ChangedTitle;
  ChangedTitle := false;
  with Table do begin
    try
      DisableControls;
      First;
      k := 0;
      while not EOF do begin
        PB1.Position := round(100 * k / Table.RecordCount + 1);
        Application.ProcessMessages;
        Edit;
        if NewAnalises or Ct then
          for i := 0 to AnalisTitle.Count - 1 do
            Table['N' + IntToStr(I + 1)] := Table['N' + IntToStr(I + 1)] /
              TFormula(AnalisTitle[i]).Delit;
        Post;
        inc(K);
        Next;
      end; {_ while not EOF do begin _}
    finally
      EnableControls;
    end; {_ try _}
  end; {_ with Table do begin _}
end;



{############################# TAnalis ###########################}

constructor TAnalis.Create;
var I: Integer;
begin
  inherited Create;
  for I := 1 to AnalisTitle.Count do
    Add(TAComponent.Create);
end; {constructor TAnalis.Create;}



procedure TAnalis.SetVal(I: Integer; V: real);
var P: TAComponent;
begin
  P := Items[I];
  P.Value := V;
end; {procedure TAnalis.SetVal(I: Integer; V: real);}

function TAnalis.GetString: string;
var I: Integer;
  P: TAComponent;
  S: string[7];
  S1: string;
begin
  S1 := '';
  for I := 0 to Count - 1 do begin
    P := Items[I];
    if P.Value > 0.099 then Str(P.Value: 6: 2, S)
    else if P.Value = 0 then Str(P.Value: 6: 0, S)
    else {_ NOT if P.Value = 0 then Str(P.Value: 6: 0, S) _} begin Str(P.Value: 7: 4, S);
      System.Delete(S, 2, 1)
    end; {_ NOT if P.Value = 0 then Str(P.Value: 6: 0, S) _}
    S1 := S1 + S;
  end; {_ for I := 0 to Count - 1 do begin _}
  Str(Summa: 7: 2, S);
  GetString := S1 + S;
end; {_ function TAnalis.GetString: string; _}



{Procedure TAnalis.WriteTo(var F:Text);
var S : string[60];
begin
 if Length(Descriptor)<6 then S:=Pad(Descriptor,5)
  else S:=Descriptor;
  Writeln(F,GetString,'     ',S);
end; }


constructor TAnalis.CreateT(Tabl, Tabl2: TDataset);
var I: Integer;
 { r: real;}
begin
  inherited Create;
  for I := 1 to AnalisTitle.Count do begin
    Add(TAComponent.Create);
    if Tabl['N' + IntToStr(I)] <> Null then begin
      {R := Tabl['N' + IntToStr(I)];}
      TAComponent(Items[I - 1]).Value := Tabl['N' + IntToStr(I)]
    end else TAComponent(Items[I - 1]).Value := -1;
    {r := TAComponent(Items[I - 1]).Value}
  end;
  if Tabl['Descript'] <> Null then
    Descriptor := Tabl['Descript']
  else Descriptor := '';
  NotChem := (Tabl2['Type'] = 'nc') or (Tabl.FieldByName('Alfa').AsInteger > 0);
  CalcVes := (Tabl2['Type'] = 'cv') or (Tabl2['Type'] = 'mv');
  for I := 1 to MendCount do
    if Tabl['A' + IntToStr(I)] <> Null then
      ATOM[I] := Tabl['A' + IntToStr(I)]
    else ATOM[I] := -1;
  if Tabl['Ox'] <> Null then Ox := Tabl['Ox'];
  if Tabl['AWA'] <> Null then AWA := Tabl['AWA'];
  if Tabl['AW'] <> Null then AW := Tabl['AW'];
end;


procedure TAnalis.Recalc(ATitle: TAnalisTitle);
var I, K, T, N, NR, J: Byte;
  PF: TFormula;
  PC: TAComponent;
  R, R1, Sum, Sum1, Sum0, Mol, Oxigen: real;
  L: TList;
begin
  if ATitle.Count = 0 then exit;
  Sum := 0;
  Sum1 := 0;
  if CalcFirst then
  for i:= 1 to MendCount do
    S[i]:=-1;
  if NotChem then begin
    if not CalcFirst then
      exit;
    {try
      L := TList.Create;  }
    for I := 0 to ATitle.Count - 1 do begin
      PF := ATitle.Items[I];
      PC := Items[I];
      if PC.Value > 1E-20 then begin
        Sum1 := Sum1 + PC.Value;
      end;
    end;
    Summa := Sum1;
    K := 1;
    for i := 1 to ATitle.Count do begin
      AtomnColich[i] := TAComponent(Items[i - 1]).Value / Sum1;
      if AtomnColich[I] > 1E-20 then begin
       // L.Add(TIntRealObj.Create(AtomnColich[i + 1],TFormula(ATitle.Items[I]).nhNumber))
        J := TFormula(ATitle.Items[I - 1]).nhNumber mod 100;
        if j = 0 then
          j := 100;
        ATOM[j] := AtomnColich[I] * 100;
        S[K] := I;
        Inc(K);
      end;
    end;
    N := K - 1;
    NEl := N;
    {finally
      for i := 0 to L.Count - 1 do
        TIntRealObj(L[i]).Free;
      L.Free;
    end; }
  end else begin
    if CalcFirst then begin
      for I := 1 to MendCount do begin
        AtomnColich[I] := -1;
        Oxy[I] := 0;
      end;

      for I := 0 to ATitle.Count - 1 do begin
        PF := ATitle.Items[I];
        PC := Items[I];
        if PC.Value > 1E-20 then begin
          Sum1 := Sum1 + PC.Value;
          if CalcVes then Mol := PF.Mol else Mol := 1;
          R := PC.Value / Mol;
          J := 54;
          Oxigen := 0;
          for K := 1 to Length(PF.Elements) do begin
            R1 := R * PF.Stechiom[K];
            if AtomnColich[Byte(PF.Elements[K])] < 0 then
              AtomnColich[Byte(PF.Elements[K])] := 0;
            AtomnColich[Byte(PF.Elements[K])] :=
              AtomnColich[Byte(PF.Elements[K])] + R1;
            Sum := Sum + R1;
            if Byte(PF.Elements[K]) = 8 then Oxigen := R1
            else J := Byte(PF.Elements[K]);
          end; {_ for K := 1 to Length(PF.Elements) do begin _}
          Oxy[J] := Oxigen;
        end;
      end; {_ for I := 0 to Title.Count - 1 do begin _}
      Summa := Sum1;
      //Исключение общего железа, если задано еще и валентное
     { if ((AtomnColich[93] > 1E-20) or (AtomnColich[94] > 1E-20)) and (AtomnColich[26] > 1E-20) then begin
        Sum := Sum - AtomnColich[26] - Oxy[26];
        AtomnColich[8] := AtomnColich[8] - Oxy[26];
        AtomnColich[26] := -1;
        Oxy[26] := 0;
        if not Silent then
          ShowMessage(stDropFe);
      end; }
      Sum1 := 0;
      for I := 1 to MendCount do
        if AtomnColich[I] >= 0 then begin
          AtomnColich[I] := AtomnColich[I] / Sum;
          Oxy[I] := Oxy[I] / Sum;
          ATOM[I] := AtomnColich[I] * 100;
          if MendTab.MustMol(i) then
            Sum1 := Sum1 + Atom[i] / MendTab.GetKatSteh(I);
        end else
          ATOM[i] := -1;
      if Sum1 > 1E-20 then
        MolFactor := 100 / Sum1
      else
        MolFactor := 0;
      if AtomnColich[1] > 1E-20 then begin
        Awa := 100 / (100 - Atom[1] * 1.5);
        try
        if Sum1<>Atom[1]/2 then
          MolFactorAW := 100 / (Sum1 - Atom[1] / 2)
        else
           MolFactorAW := 0;
        except
          on Exception do
            MolFactorAW := 0;
        end;
      end else begin
        AWA := 1;
        MolFactorAW := MolFactor;
      end;
      K := 1;
      Ox := 0;
    {sum:=0;
    for i:=1 to MendCount do
        if i<>8 then Sum:=Sum+Atom[i];
        Sum:=sum*100; }
      for I := 1 to MendCount do
        if (Atom[i] > 0) and (i <> 8) then Ox := Ox + Atom[i] * MendTab.GetPetroVes(I);
      if {(AtomnColich[26] < 0) and }((AtomnColich[93] > 0) or (AtomnColich[94] > 0)) then begin
      if AtomnColich[26]<0 then begin
        AtomnColich[26] := 0;
        Atom[26] := 0;
      end;
        if AtomnColich[93] > 1E-20 then begin
          AtomnColich[26] := AtomnColich[26] + AtomnColich[93];
          Atom[26] := Atom[26] + Atom[93];
        end;
        if AtomnColich[94] > 0 then begin
          AtomnColich[26] := AtomnColich[26] + AtomnColich[94];
          Atom[26] := Atom[26] + Atom[94];
        end;
        Oxy[26] := Oxy[93] + Oxy[94];
       { AtomnColich[93] :=0;
        AtomnColich[94]:=0;
         Atom[94]:=0;
         Atom[93]:=0; }
      end;
      for I := 1 to 92 do
        if AtomnColich[I] > 1E-20 then begin
          S[K] := I;
          Inc(K);
        end;
      Ox := Ox / 100;
      AW := Ox;
      if AtomnColich[1] > 0 then
        AW := OX - Atom[1] * MendTab.GetPetroVes(1) / 100;
      N := K - 1;
      NEl := N;
    end {_ if CalcFirst then begin _} {CalcFirst} else begin

      N := NEl;
      if OSub and (AtomnColich[8] > 0) then
        for K := 1 to MaxHALen do
          case S[K] of
            6: if SubC and (AtomnColich[6] > 0) then
                AtomnColich[8] := AtomnColich[8] - AtomnColich[6] * 2;
            9: if SubF and (AtomnColich[9] > 0) then
                AtomnColich[8] := AtomnColich[8] - AtomnColich[9] / 2;

            16: if SubS and (AtomnColich[16] > 0) then
                AtomnColich[8] := AtomnColich[8] - AtomnColich[16];
            17: if SubCl and (AtomnColich[17] > 0) then
                AtomnColich[8] := AtomnColich[8] - AtomnColich[17] / 2;
          end; {_ case S[K] of _}

      Sum := 0;
      if N > 0 then begin
        A := 0;
        H := 0;
        TTT:=0;
        for I := 1 to N do
          if AtomnColich[S[I]] > 0 then
            Sum := Sum + AtomnColich[S[I]];
        Sum0 := 0;
        NR := 0;
        for i := 1 to N do
          if AtomnColich[S[I]] > Sum * MinAtDol then begin
            Sum0 := Sum0 + AtomnColich[S[I]];
            Inc(NR);
          end;
        NormA := ln(NR);
        for I := 1 to n do begin
          if AtomnColich[S[I]] > Sum * MinAtDol then begin
            R := AtomnColich[S[I]] / Sum0;
            R1 := ln(R);
            A := A - R1;
            H := H + R1 * R;
            TTT:=TTT+1/R;
          end {_ if R > 0 then begin _}
        end;
        H := -H;
        A := A / NR - NormA;
        TTT:=Ln(TTT/NR)-NormA;
      end;

      Sum := 0;
      if AtomnColich[8] > 0 then
        for K := MaxHALen + 1 to N do
          AtomnColich[8] := AtomnColich[8] - Oxy[S[K]];
      for I := 1 to min(MaxHALen,n) do
        if AtomnColich[S[I]] > Sum0 * MinAtDol then
          Sum := Sum + AtomnColich[S[I]];
      for I := 1 to min(MaxHALen,n) do
        if AtomnColich[S[I]] > 0 then
          AtomnColich[S[I]] := AtomnColich[S[I]] / Sum;
    end {CalcTwo};
  end;

  if N > 1 then
    for I := 1 to N - 1 do
      for K := 1 to N - I do
        if AtomnColich[S[K]] < AtomnColich[S[K + 1]] then begin
          T := S[K];
          S[K] := S[K + 1];
          S[K + 1] := T;
        end; {_ if AtomnColich[S[K]] < AtomnColich[S[K + 1]] then begin _}
  if NotChem then
    Rang := PadLeftStr(IntToStr(TFormula(ATitle.Items[S[1] - 1]).nhNumber), RSymLen)
  else
    Rang := PadLeftStr(IntToStr(S[1]), RSymLen);
  for I := 2 to N do
    if NotChem then
      Rang := Rang + PadLeftStr(IntToStr(TFormula(ATitle.Items[S[i] - 1]).nhNumber), RSymLen)
    else
      Rang := Rang + PadLeftStr(IntToStr(S[I]), RSymLen);
  if N > 0 then
    R := AtomnColich[S[1]];
  Eq := '';
    for I := 2 to Min(N, MaxHALen) do begin
      R1 := AtomnColich[S[I]];
      if R / R1 < DivEq then Eq := Eq + '='
      else
        Eq := Eq + ' ';
      R := R1;
    end;

  if NotChem then begin
    Sum := 0;
    if N > 0 then begin
      A := 0;
      H := 0;
      TTT:=0;
      for I := 1 to N do
        if AtomnColich[S[I]] > 0 then
          Sum := Sum + AtomnColich[S[I]];
      Sum0 := 0;
      NR := 0;
      for i := 1 to N do
        if AtomnColich[S[I]] > Sum * MinAtDol then begin
          Sum0 := Sum0 + AtomnColich[S[I]];
          Inc(NR);
        end;
      NormA := ln(NR);
      for I := 1 to n do begin
        if AtomnColich[S[I]] > Sum * MinAtDol then begin
          R := AtomnColich[S[I]] / Sum0;
          R1 := ln(R);
          A := A - R1;
          H := H + R1 * R;
          TTT:=TTT+1/R;
        end
      end;
      H := -H;
      A := A / NR - NormA;
      TTT:=Ln(TTT/NR)-NormA;
     { if N<ATitle.Count then begin
         A := 0;
         H := 0;
         TTT:=0;
      end;}
    end;
  end;

  An := 0;
  E := 0;
  TN := 0;
  if N >= MaxHALen then begin //MaxHALen or N?
    NormA := ln(MaxHALen);
    NormH := ln(1 / MaxHALen);
    for I := 1 to MaxHALen do begin
      R := AtomnColich[S[I]]; /// Sum;
      if R > MinAtDol then begin
        R1 := ln(R);
        TN := TN + 1 / R;
        An := An - R1;
        E := E + R1 * R;
      end {_ if R > 0 then begin _}
    end; {_ for I := 1 to MaxHALen do begin _}
    E := -E;
    Tn := Ln(Tn / MaxHALen) - NormA;
  //  E := E / NormH;
    An := An / MaxHALen - NormA;
    {an := An / (-((MaxHALen - 1) * ln(MinAtDol) + ln(1 - (MaxHALen - 1) * MinAtDol)) -
      MaxHALen * ln(MaxHALen));}
  end {_ if N >= MaxHALen then begin _} else begin
    E := 0;
    an := 0;
    Tn:=0;
  end;
end;

{ TIntRealObj }

constructor TIntRealObj.Create(An: integer; Ac: Real);
begin
  C := AC;
  Num := AN;
end;

function TIntRealObj.OrdOf(S: TIntRealObj): integer;
begin
  if C > S.C - 1E-10 then result := 1
  else
    Result := -1
end;

end.

