unit RHABrows;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, DBTables, Grids, Mask, ExtCtrls,
  {Dbmemox,}RXDBCtrl, ESBRtns, ActnList, Menus, Dialogs, QuickRpt, Qrctrls,
  RHAGlobs, Chemist, ORF, RHAColor,
  Analise, Buttons, DMod1, StrHlder, Variants, ADODB, JvRichEdit;

type
  TFBrows = class(TForm)
    Panel3: TPanel;
    SG1: TRxDBGrid;
    DataSource3: TDataSource;
    QR1: TQuickRep;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    AORF: TAction;
    ORDRang: TAction;
    OrdNum: TAction;
    N2: TMenuItem;
    OrderbyRF1: TMenuItem;
    Orderbynum1: TMenuItem;
    Generalizedrangeformula1: TMenuItem;
    ExcExp: TAction;
    ExporttoEXCEL1: TMenuItem;
    ARHAColor: TAction;
    View1: TMenuItem;
    Colorview1: TMenuItem;
    QRLabel5: TQRLabel;
    ARepres: TAction;
    VarietyofRF1: TMenuItem;
    aNovelty: TAction;
    StrHolder1: TStrHolder;
    NoveltyofRF1: TMenuItem;
    StrHolder2: TStrHolder;
    DetailBand1: TQRBand;
    ChildBand1: TQRChildBand;
    QRDBText7: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    Query2: TADOQuery;
    Query1: TADOQuery;
    Query2Nov: TIntegerField;
    Query1N: TIntegerField;
    Query1AnId: TIntegerField;
    Query1ArrId: TIntegerField;
    Query1H: TFloatField;
    Query1AN: TFloatField;
    Query1R: TStringField;
    Query1Eq: TStringField;
    Query1Descript: TStringField;
    Query1Num: TIntegerField;
    Query1Sample: TStringField;
    Query1Sep: TStringField;
    Query1RF: TStringField;
    Query1GeolId: TIntegerField;
    Query1Rock: TIntegerField;
    Query1Region: TIntegerField;
    Query1GBody: TIntegerField;
    Query1GeolId_1: TStringField;
    Query1Rock_1: TStringField;
    Query1Region_1: TStringField;
    Query1GBody_1: TStringField;
    Query1A: TFloatField;
    Query1ArrNum: TStringField;
    Query1N1: TFloatField;
    Query1N2: TFloatField;
    Query1N3: TFloatField;
    Query1N4: TFloatField;
    Query1N5: TFloatField;
    Query1N6: TFloatField;
    Query1N7: TFloatField;
    Query1N8: TFloatField;
    Query1N9: TFloatField;
    Query1N10: TFloatField;
    Query1N11: TFloatField;
    Query1N12: TFloatField;
    Query1N13: TFloatField;
    Query1N14: TFloatField;
    Query1N15: TFloatField;
    Query1N16: TFloatField;
    Query1N17: TFloatField;
    Query1N18: TFloatField;
    Query1N19: TFloatField;
    Query1N20: TFloatField;
    Query1N21: TFloatField;
    Query1N22: TFloatField;
    Query1N23: TFloatField;
    Query1N24: TFloatField;
    Query1N25: TFloatField;
    Query1N26: TFloatField;
    Query1N27: TFloatField;
    Query1N28: TFloatField;
    Query1N29: TFloatField;
    Query1N30: TFloatField;
    Query1N31: TFloatField;
    Query1N32: TFloatField;
    Query1N33: TFloatField;
    Query1N34: TFloatField;
    Query1N35: TFloatField;
    Query1N36: TFloatField;
    Query1N37: TFloatField;
    Query1N38: TFloatField;
    Query1N39: TFloatField;
    Query1N40: TFloatField;
    Query1N41: TFloatField;
    Query1N42: TFloatField;
    Query1N43: TFloatField;
    Query1N44: TFloatField;
    Query1N45: TFloatField;
    Query1N46: TFloatField;
    Query1N47: TFloatField;
    Query1N48: TFloatField;
    Query1N49: TFloatField;
    Query1N50: TFloatField;
    Query1A1: TFloatField;
    Query1A2: TFloatField;
    Query1A3: TFloatField;
    Query1A4: TFloatField;
    Query1A5: TFloatField;
    Query1A6: TFloatField;
    Query1A7: TFloatField;
    Query1A8: TFloatField;
    Query1A9: TFloatField;
    Query1A10: TFloatField;
    Query1A11: TFloatField;
    Query1A12: TFloatField;
    Query1A13: TFloatField;
    Query1A14: TFloatField;
    Query1A15: TFloatField;
    Query1A16: TFloatField;
    Query1A17: TFloatField;
    Query1A18: TFloatField;
    Query1A19: TFloatField;
    Query1A20: TFloatField;
    Query1A21: TFloatField;
    Query1A22: TFloatField;
    Query1A23: TFloatField;
    Query1A24: TFloatField;
    Query1A25: TFloatField;
    Query1A26: TFloatField;
    Query1A27: TFloatField;
    Query1A28: TFloatField;
    Query1A29: TFloatField;
    Query1A30: TFloatField;
    Query1A31: TFloatField;
    Query1A32: TFloatField;
    Query1A33: TFloatField;
    Query1A34: TFloatField;
    Query1A35: TFloatField;
    Query1A36: TFloatField;
    Query1A37: TFloatField;
    Query1A38: TFloatField;
    Query1A39: TFloatField;
    Query1A40: TFloatField;
    Query1A41: TFloatField;
    Query1A42: TFloatField;
    Query1A43: TFloatField;
    Query1A44: TFloatField;
    Query1A45: TFloatField;
    Query1A46: TFloatField;
    Query1A47: TFloatField;
    Query1A48: TFloatField;
    Query1A49: TFloatField;
    Query1A50: TFloatField;
    Query1A51: TFloatField;
    Query1A52: TFloatField;
    Query1A53: TFloatField;
    Query1A54: TFloatField;
    Query1A55: TFloatField;
    Query1A56: TFloatField;
    Query1A57: TFloatField;
    Query1A58: TFloatField;
    Query1A59: TFloatField;
    Query1A60: TFloatField;
    Query1A61: TFloatField;
    Query1A62: TFloatField;
    Query1A63: TFloatField;
    Query1A64: TFloatField;
    Query1A65: TFloatField;
    Query1A66: TFloatField;
    Query1A67: TFloatField;
    Query1A68: TFloatField;
    Query1A69: TFloatField;
    Query1A70: TFloatField;
    Query1A71: TFloatField;
    Query1A72: TFloatField;
    Query1A73: TFloatField;
    Query1A74: TFloatField;
    Query1A75: TFloatField;
    Query1A76: TFloatField;
    Query1A77: TFloatField;
    Query1A78: TFloatField;
    Query1A79: TFloatField;
    Query1A80: TFloatField;
    Query1A81: TFloatField;
    Query1A82: TFloatField;
    Query1A83: TFloatField;
    Query1A84: TFloatField;
    Query1A85: TFloatField;
    Query1A86: TFloatField;
    Query1A87: TFloatField;
    Query1A88: TFloatField;
    Query1A89: TFloatField;
    Query1A90: TFloatField;
    Query1A91: TFloatField;
    Query1A92: TFloatField;
    Query1A93: TFloatField;
    Query1A94: TFloatField;
    Query1X: TStringField;
    Query1Y: TStringField;
    Query1Ox: TFloatField;
    Query1AW: TFloatField;
    Query1AWA: TFloatField;
    Query1MolFact: TFloatField;
    Query1MolFactAW: TFloatField;
    Query1Summa: TFloatField;
    Query1Source: TIntegerField;
    Query1A95: TFloatField;
    Query1A96: TFloatField;
    Query1A97: TFloatField;
    Query1A98: TFloatField;
    Query1A99: TFloatField;
    Query1A100: TFloatField;
    Query1Alfa: TIntegerField;
    SG2: TStringGrid;
    N3: TMenuItem;
    Analogsofcurrentanalise1: TMenuItem;
    Countofanalogsofcurrentanalise1: TMenuItem;
    Query1E: TFloatField;
    Query1t: TFloatField;
    Numberofdifferentrangeformulas1: TMenuItem;
    Showwithnumbersofanalogiue1: TMenuItem;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    Query1Tn: TFloatField;
    Query1Det: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Table2CalcFields(DataSet: TDataSet);
    procedure BRangClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure QRChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BitBtn7Click(Sender: TObject);
    procedure SG1DblClick(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SG1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ExcExpExecute(Sender: TObject);
    procedure ARHAColorExecute(Sender: TObject);
    procedure ARepresExecute(Sender: TObject);
    procedure aNoveltyExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Analogsofcurrentanalise1Click(Sender: TObject);
    procedure Countofanalogsofcurrentanalise1Click(Sender: TObject);
    procedure Numberofdifferentrangeformulas1Click(Sender: TObject);
    procedure Showwithnumbersofanalogiue1Click(Sender: TObject);
  private
    { private declarations }
    MaxR: integer;
    LL: TStringList;
    ShowAnalog: boolean;
    procedure ExFrm(Col, Row: integer; Val: Variant; var FontColor: TColor;
      var FontBol: Boolean; var NumFormat: string; var FontName: string; var Sep: Boolean);
  public
    SQS: TstringList;
    ORF: TORFForm;
    Fclr: TfRHAColor;
    Titul: string;
    { public declarations }
   { procedure SetRangSQL(RMin, RMax: string);}
    {procedure SetArraySQL(ArrayID: Integer);}
  end;

var
  FBrows: TFBrows;
  {RangSQL : TStringList;}
  rang: boolean;
  PrevR: string;

resourcestring
  stORF = 'Generalized rank formula. ';
  stVarie = ' variety of Rank formulas: ';
  stRepres = ' representativity of Rank formulas: ';
  stNov = ' novelty of Rank formulas: ';

implementation


uses TrioGraph, AnData, TaskSQL, Main, DebuS, wait, ListBrows, TxtImpExp,
  ExcelExp, ComCtrls, ADOUtilsS, Info;

{$R *.DFM}

(*procedure TFBrows.SetRangSQL(RMin, RMax: string);
begin
  Query1.Close;
  Query1.SQL.Clear;
  Query1.Sql.Assign(SQS);
     {Query1.ParamByName('RMin').AsString:=RMin;
     Query1.ParamByName('RMax').AsString:=RMax; }
   Query1.Sql.Add('ORDER BY');
    Query1.Sql.Add(' RHADATA.Descript');
  Query1.Prepare;
  QUery1.Open;
  rang := True;
  TrioForm.Caption := 'Запрос';
end;  *)


(*procedure TFBrows.SetArraySQL(ArrayID: Integer);
var
  i: integer;
begin
  Query1.Close;
  Query1.SQL.Clear;

  TrioSQLForm.SQL0.Strings.Clear;
  for i := 0 to TrioSQLForm.SQLBak.Strings.Count - 1 do begin
    TrioSQLForm.SQL0.Strings.Add(TrioSQLForm.SQLBak1.Strings[i]);
    TrioForm.Query1.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
    TrioForm.Query2.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
    TrioForm.Query3.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
    TrioForm.Query4.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
    TrioForm.Query5.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
    TrioForm.Query6.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
    Query1.SQL.Add(TrioSQLForm.SQLBak1.Strings[i]);
  end;
  TrioForm.Query1.SQL[15] := 'rhadata.ArrId IN (' + IntToStr(ArrayId) + ') ';
  TrioForm.Query1.Prepare;
  TrioForm.Query1.Open;
  Query1.SQL[15] := 'rhadata.ArrId IN (' + IntToStr(ArrayId) + ') ';
  TrioForm.Clb1.Hint :=
    Query1.SQL.Strings[15];
    Query1.Sql.Add('ORDER BY');
    Query1.Sql.Add(' RHADATA.R');
    Query1.SQL.Strings[0]:=Query1.SQL.Strings[0]+',RHADATA.EQ';
  Query1.Prepare;
  QUery1.Open;
  rang := true;
  TrioForm.GeoChart1.Trio:=false;
  TrioForm.GeoChart1.Axises[1].Title := 'An';
  TrioForm.GeoChart1.Axises[0].Title := 'En';
end; *)


procedure TFBrows.FormCreate(Sender: TObject);
var i: Integer;
  S : String;
begin
  {Table1.Open;
  Table2.Open;
  RangSQL := TStringList.Create;
  RangSQL.LoadFromFile('Rang.SQL');}
  QR1.Visible := false;
  SQS := TStringList.Create;
  LL := TStringList.Create;
  SQS.Sorted := False;
 // SQS.Assign(SelQuery.SQL);

  Orf := nil;
  Query1.Connection := SelQuery.Connection;
  Titul := SelSQLName;
  Caption := 'RHA: ' + Titul;
  Application.ProcessMessages;
  //Query1.SQL.Assign(SQS);
  S:=StringReplace(CurQr,'*','*,(select MaxHA from MainRHA where ID=ArrId) as Det ',[]);
  Query1.SQL.Text := S;
  SQS.Assign(Query1.SQL);
  Query1.Sql[Query1.Sql.Count - 1] := ' ORDER BY Substring (rhadata.R,1,' +
    IntToStr(RSymLen * MaxHALen) + '), RHADATA.E desc, RHADATA.An ';
  Rang := True;
//  DebugSql.Memo1.Lines.Assign(Query1.SQL);
 //       DebugSql.ShowModal;
  {Query1.Prepare;}
  Application.ProcessMessages;
  Query2.SQL.Clear;

  if SQS.Count = 2 then
    for i := 0 to 4 do
      Query2.SQL.Add(StrHolder2.Strings[i])
  else begin
    Query2.SQL.Add(StrHolder1.Strings[0]);
    for i := 1 to SQS.Count - 3 do
      Query2.SQL.Add(SQS[i]);
    for i := 1 to 5 do
      Query2.SQL.Add(StrHolder1.Strings[i]);
    for i := 1 to SQS.Count - 3 do
      Query2.SQL.Add(ReplaceSymbol(SQS[i], 'rhadata', 'rd2'));

    Query2.SQL.Add(StrHolder1.Strings[6]);
  end;
 // DebugSql.Memo1.Lines.Assign(Query2.SQL);
 // DebugSql.ShowModal;
  Query1.Open;
  Query1.First;
  MendTab.AlfaN := Query1.FieldByName('Alfa').AsInteger;
end;

procedure TFBrows.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN := Query1.FieldByName('Alfa').AsInteger;
end;

procedure TFBrows.Table2CalcFields(DataSet: TDataSet);
var
  S: string;
  Ind: integer;
begin
  if (DataSet.Eof) and (Sg1.Row > 2) then
    DataSet['N'] := DataSet.RecordCount
  else if DataSet.RecNo > 0 then
    DataSet['N'] := DataSet.RecNo
  else
    DataSet['N'] := 1;
  s := BlankStr(MaxHALen * (ElSymLen + 1)+1);
  if DataSet.RecNo > 1 then begin
    ind := StrFindDif(PrevR, DataSet['R']);
    if (ind > 0) and (Ind < MaxHALen * RSymLen) then
    //  ????
      S:=DashStr(MaxHALen * (ElSymLen + 1) {+1} - (ElSymLen + 1) * ((Ind - 1) div RSymLen));
      if Length(S)>0 then
        S:=S+'-';
      S := PadLeftStr(S, MaxHALen * (ElSymLen + 1)+1);
  end;
  PrevR := DataSet['R'];
  if Rang then
    DataSet['Sep'] := S
  else
    DataSet['Sep'] := '';
  if DataSet['Eq'] <> Null then
    DataSet['RF'] := MakeRStr(DataSet['R'], DataSet['Eq'])
  else DataSet['RF'] := MakeRStr(DataSet['R'], ' ');
  //end;
end;


procedure TFBrows.BRangClick(Sender: TObject);
begin
  WForm.Show;
  Query1.Close;
  Application.ProcessMessages;
  if Sender = OrdRang then begin
    Query1.Sql[Query1.Sql.Count - 1] := ' ORDER BY Substring (rhadata.R,1,' +
      IntToStr(RSymLen * MaxHALen) + '), RHADATA.E desc, RHADATA.An';
    Rang := true
  end else begin
    Query1.Sql[Query1.Sql.Count - 1] := 'ORDER BY rhadata.ArrNum, rhadata.Num';
    rang := false;
  end;
  Query1.Open;
  Query1.First;
  WForm.Close;
end;


procedure TFBrows.FormShow(Sender: TObject);
begin
  ShowAnalog := false;
  QrLabel7.Caption := Caption;
  SG1.Columns[1].Visible := SID in UsedFields;
  SG1.Columns[2].Visible := False;
  SG1.Columns.Items[11].Title.Caption := GeolIdTit;
  SG1.Columns[11].Visible := GID in UsedFields;
  SG1.Columns.Items[12].Title.Caption := RockTit;
  SG1.Columns[12].Visible := ROC in UsedFields;
  SG1.Columns.Items[13].Title.Caption := RegionTit;
  SG1.Columns[13].Visible := RGN in UsedFields;
  SG1.Columns.Items[14].Title.Caption := GBodyTit;
  SG1.Columns[14].Visible := GBD in UsedFields;
  TFloatField(Query1.FieldByName('E')).DisplayFormat := EnFormat;
  TFloatField(Query1.FieldByName('A')).DisplayFormat := EnFormat;
  TFloatField(Query1.FieldByName('H')).DisplayFormat := EnFormat;
  TFloatField(Query1.FieldByName('An')).DisplayFormat := EnFormat;
  TFloatField(Query1.FieldByName('T')).DisplayFormat := EnFormat;
  TFloatField(Query1.FieldByName('Tn')).DisplayFormat := EnFormat;
end;

procedure TFBrows.BitBtn3Click(Sender: TObject);
begin
  QR1.Preview;
end;

procedure TFBrows.BitBtn5Click(Sender: TObject);
begin
  QR1.Print;
end;

procedure TFBrows.BitBtn6Click(Sender: TObject);
begin
  if ExpToTextForm.DefExport(SG1, nil, False) then
    ExptoTextForm.ExpDbGrid(SG1, nil, nil);

end;



procedure TFBrows.QRChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := Rang;
end;

procedure TFBrows.BitBtn7Click(Sender: TObject);
begin
  Application.HelpFile := 'PETROS.HLP';
  Application.HelpCommand(HELP_CONTEXT, 50);
end;

procedure TFBrows.SG1DblClick(Sender: TObject);
begin
  if Query1['AnID'] <> Null then begin
    if MainForm.Cadd.Checked then
      AddToList(Query1['Sample'])
    else begin
      CurID := Query1['AnID'];
      TAnalForm.Create(MainForm);
    end;
  end;
end;

procedure TFBrows.BitBtn8Click(Sender: TObject);
var i, j, k, Max, Num, LastRang: integer;
  S, S1: string;
  Sum: array[1..100] of integer;
begin
  if ORF = nil then ORF := TORFForm.Create(MainForm);
  ORF.Caption := stORF + Titul;
  Application.ProcessMessages;
  for i := 1 to 100 do begin
    Sum[i] := 0;
    for j := 1 to 100 do
      Ranges[i, j] := 0;
  end;
  with Query1 do begin
    try
      DisableControls;
      First;
      while not EOF do begin
        S := Query1['R'];
        for I := 0 to (Length(S) div RSymLen) - 1 do begin
          j := StrToInt(Copy(S, I * RSymLen + 1, RSymLen)) mod 100;
          if j = 0 then j := 100;
          Inc(Ranges[i + 1, j]);
          Inc(Sum[i + 1]);
        end;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
  with ORF.RE1 do begin
    Clear;
    for i := 1 to 34 do
      Paragraph.Tab[i - 1] := I * 9 * (ElSymLen+1);
    LastRang := 0;
    for i := 1 to 100 do
      for j := 1 to 100 do
        if Ranges[i, j] <> 0 then begin
          Inc(LastRang);
          break;
        end;
    S := #9;
  //  PadLeftStr
    for i := 1 to LastRang do begin
      s := S + IntToStr(i) + #9;
      if i = MaxHALen then begin
        s := S + #9;
      end;
    end;
    SelAttributes.Style := [fsItalic, fsBold];
    SelAttributes.Color := clGray;
    Lines.Add(S);
    SelAttributes.Color := clBlack;
    K := 1;
    repeat
      Num := 0;
      S := '`' + IntToStr(K) + #9;
      S1 := #9;
      inc(K);
      for i := 1 to LastRang do begin
        Max := 0;
        for j := 1 to 100 do begin
          if Ranges[i, j] > max then begin
            max := Ranges[i, j];
            Num := j;
          end;
        end;
        if Max > 0 then begin
          S := s + MendTab.GetSymbol(Num);
          S1 := S1 + IntToStr(Round(100 * Max / Sum[i]));
        end;
        s := S + #9;
        S1 := S1 + #9;
        if i = MaxHALen then begin
          s := S + #9;
          S1 := S1 + #9;
        end;
        if Num > 0 then
          Ranges[i, Num] := 0;
      end;
      if Num = 0 then break;
      SelAttributes.Style := [fsBold];
      Lines.Add(S);
      SelAttributes.Style := [];
      Lines.Add(S1);
    until false;
    i := -2;
    DM1.tabElem.First;
    while not DM1.tabElem.Eof do begin
      if DM1.tabElem['Color'] <> clBlack then
        repeat
          i := FindText(DM1.tabElem['Elem'], i + 2, Length(Text) - i + 1, [JvRichEdit.stWholeWord, JvRichEdit.stMatchCase]);
          if i < 0 then
            break
          else begin
            SelStart := i;
            SelLength := Length(DM1.tabElem['Elem']);
            SelAttributes.BackColor := DM1.tabElem['Color'];
          end;
        until False;
      DM1.tabElem.Next;
    end;
    i := 0;
    repeat
      i := FindText('`', i + 2, Length(Text) - i + 1, []);
      if i < 0 then
        break
      else begin
        SelStart := i;
        SelLength := 3;
        SelAttributes.Style := [fsItalic];
        SelAttributes.Color := clGray;
      end;
    until False;
    SelStart := 0;
    SelLength := 0;
    SelAttributes.Color := clBlack;
    SelAttributes.Style := [];
  end;
     {ORF.Show;}
end;


procedure TFBrows.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Query1.Close;
     {Query1.UnPrepare;}
  try
    SQS.Free;
    if Orf <> nil then begin
      Orf.MustFree := True;
      Orf.Free;
    end;
    if FClr <> nil then begin
      FClr.MustFree := True;
      FClr.Free;
    end;
  except
  end;
end;

procedure TFBrows.SG1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if ShowAnalog then begin
    if Query1['Analog'] = 0 then
      SG1.Canvas.Font.Color := clRed;
    Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    //else
    SG1.Canvas.Font.Color := clBlack;

  end;
end;

procedure TFBrows.ExcExpExecute(Sender: TObject);
var i, j, K, ind, OldMax: integer;
  S, SS, W, PrevR: string;
begin
  try

    LL.Clear;
    screen.Cursor := crHourGlass;
    Query1.DisableControls;
    DM1.q1Time.Active := False;
    if Query1.SQL.Count > 2 then begin
      DM1.q1Time.SQL.Assign(Query1.SQL);
      DM1.q1Time.SQL[0] := 'Select Max(Len(R)) as L From RHADATA rhadata Where (';
      DM1.q1Time.SQL.Delete(DM1.q1Time.SQL.Count - 1);
    end else
      DM1.q1Time.SQL.Text := 'Select Max(Len(R)) as L From RHADATA';
    DM1.q1Time.Open;
    MaxR := DM1.q1Time['L'] div 5;
    sg2.RowCount := Query1.RecordCount + 1;
    SG2.ColCount := 1;
    SG2.Cells[0, 0] := 'N';
    if SG1.Columns[1].Visible then begin
      SG2.ColCount := SG2.ColCount + 1;
      SG2.Cells[SG2.ColCount - 1, 0] := SG1.Columns[1].Title.Caption;
    end;
    if SG1.Columns[2].Visible then begin
      SG2.ColCount := SG2.ColCount + 1;
      SG2.Cells[SG2.ColCount - 1, 0] := SG1.Columns[2].Title.Caption;
    end;
    for i := 1 to MaxR do begin
      SG2.ColCount := SG2.ColCount + 1;
      SG2.Cells[SG2.ColCount - 1, 0] := IntToStr(i);
    end;
    for i := 4 to Sg1.Columns.Count - 1 do
      if SG1.Columns[i].Visible then begin
        SG2.ColCount := SG2.ColCount + 1;
        SG2.Cells[SG2.ColCount - 1, 0] := SG1.Columns[i].Title.Caption;
      end;
    Query1.First;
    j := 1;
    OldMax := MaxHALen;
    MaxHALen := 100;
    while not Query1.Eof do begin
      k := 0;
      SG2.Cells[k, j] := InttoStr(j);
      inc(k);
      if SG1.Columns[1].Visible then begin
        SG2.Cells[k, j] := SG1.Columns[1].Field.AsString;
        inc(k);
      end;
      if SG1.Columns[2].Visible then begin
        SG2.Cells[k, j] := SG1.Columns[2].Field.AsString;
        inc(k);
      end;
      if Rang then
        s := Query1['Sep']
      else
        S := '';
      ll.Add(S);
      SS:=Query1['R'];
      W := MakeRStr(SS, Query1['Eq']) + ' ';
      for i := 1 to MaxR do begin
        if I <= Length(W) div (ElSymLen + 1) then begin
          if i = 1 then
            SG2.Cells[k, j] := Copy(W, 1, ElSymLen + 1)
          else
            SG2.Cells[k, j] := Copy(W, (i - 1) * (ElSymLen + 1) + 1, ElSymLen + 1);
        end else
           SG2.Cells[k, j]:='';
        inc(k);
      end;
      for i := 4 to Sg1.Columns.Count - 1 do
        if SG1.Columns[i].Visible then begin
          if (SG1.Columns[i].Field is TFloatField) and
            (TFloatField(SG1.Columns[i].Field).DisplayFormat <> '') then
            SG2.Cells[k, j] := FormatFloat(TFloatField(SG1.Columns[i].Field).DisplayFormat, SG1.Columns[i].Field.AsFloat)
          else
            SG2.Cells[k, j] := SG1.Columns[i].Field.AsString;
          inc(k);
        end;
      inc(j);
      Query1.Next;
    end;
    MaxHALen := OldMax;
    ExcF.ExportSGToExc(SG2, Caption, ExFrm);
  finally
    MaxHALen := OldMax;
    screen.Cursor := crDefault;
    Query1.First;
    Query1.EnableControls;
  end;
end;

procedure TFBrows.ARHAColorExecute(Sender: TObject);
var i, k: Integer;
  S, S1: string;
begin
  if FCLR = nil then
    FCLR := TfRHAColor.Create(MainForm);
  //Add Paragraph? calcwidth/ranf form column namber?
  ORF.Caption := Caption;
  Application.ProcessMessages;
  with FCLR.RE1 do begin
    Clear;
    k := 0;
    SelStart := 0;
    for i := 0 to SG1.Columns.Count - 1 do
      if SG1.Columns[i].Visible then begin
        Paragraph.Tab[k] := SG1.Columns[i].Width div FCLR.RE1.Font.Size;
       { if i = 2 then
          Paragraph.Tab[k] := Paragraph.Tab[k] - 20;}
        inc(k);
      end;
    with Query1 do begin
      try
        DisableControls;
        First;
        while not EOF do begin
          S := '';
          for i := 0 to SG1.Columns.Count - 1 do
            if SG1.Columns[i].Visible then begin
              if (SG1.Columns[i].Field is TFloatField) and
                (SG1.Columns[i].Field.Value <> Null) then
                S1 := FormatFloat(TFloatField(SG1.Columns[i].Field).DisplayFormat, SG1.Columns[i].Field.Value)
              else
                S1 := VarToStr(SG1.Columns[i].Field.Value);
              S := S + S1;
              if i < SG1.Columns.Count - 1 then
                S := S + #9;
            end;
          FCLR.RE1.Lines.Add(S);
          Next;
        end;
      finally
        EnableControls;
      end;
    end;
    i := -2;
    DM1.tabElem.First;
    while not DM1.tabElem.Eof do begin
      if DM1.tabElem['Color'] <> clBlack then
        repeat
          i := FindText(DM1.tabElem['Elem'], i + ElSymLen, Length(Text) - i + 1, [JvRichEdit.stWholeWord, JvRichEdit.stMatchCase]);
          if i < 0 then
            break
          else begin
            SelStart := i;
            SelLength := ElSymLen;
            SelAttributes.BackColor := DM1.tabElem['Color'];
          end;
        until False;
      DM1.tabElem.Next;
    end;
    SelStart := 0;
    SelLength := 0;
    SelAttributes.Color := clBlack;
  end;
end;

procedure TFBrows.ARepresExecute(Sender: TObject);
var r: TStringList;
  s: string;
begin
  try
    r := TStringList.Create;
    Query1.DisableControls;
    Screen.Cursor := crHourGlass;
    Query1.First;
    while not Query1.Eof do begin
      if Query1['R'] <> Null then begin
        s := Copy(Query1['R'], 1, MaxHALen * RSymLen);
        if r.IndexOf(s) < 0 then
          r.Add(s);
      end;
      Query1.Next;
    end;
    Screen.Cursor := crDefault;
    ShowInfo(SelSQLName + '; ' + #10 + stVarie + FloatToStrF(R.Count / Query1.RecordCount,
      ffFixed, 6, 3) + ', ' + #10 + stRepres + FloatToStrF(Query1.RecordCount / R.Count,
      ffFixed, 6, 3));
  finally
    r.Free;
    Query1.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFBrows.aNoveltyExecute(Sender: TObject);
begin

  Query2.SQL[SQS.Count - 1] := IntToStr(MaxHALen * 5);
  Query2.SQL[SQS.Count + 1] := IntToStr(MaxHALen * 5);
  Query2.Open;
  ShowInfo(SelSQLName + '; ' + #10 + stNov +
    FloatToStrF(100 * Query2['Nov'] / Query1.RecordCount, ffFixed, 5, 1) + '%');
  Close;
end;

procedure TFBrows.ExFrm(Col, Row: integer; Val: Variant;
  var FontColor: TColor; var FontBol: Boolean; var NumFormat,
  FontName: string; var Sep: Boolean);
var St: integer;
begin
  if (Row >= 0) then begin
    if (SG1.Columns[1].Visible) then
      st := 2
    else
      st := 1;
    if ShowAnalog then begin
      if SG2.Cells[St, Row] = '0' then
        FontColor := clRed
      else
        FontColor := clBlack;
      Inc(ST);
    end;
    if (Col >= St) and (Col < St + MaxR) then begin
      FontBol := True;
   // FontColor:=clRed;
      if Rang and (Row > 0) and (Row < SG2.RowCount - 1) and (Col < St + MaxHALen) and (Col <= Length(LL[Row]) div ElSymLen) then
        if LL[Row][(Col - st) * (ElSymLen + 1) + 1] <> ' ' then
          Sep := True;
    end;
    if (Col = 0) then
      NumFormat := '#####'
     else if (Col = St + MaxR)or (Col<2) and(SG1.Columns[Col].FieldName='Det')  then
      NumFormat := '###'
    else if (Col >= St + MaxR) and (Col < St + MaxR + 4) then
      NumFormat := '0.###'
    else if Col = St + MaxR + 4 then
      NumFormat := '##0.###'
    else if Col = St + MaxR + 5 then
      NumFormat := '#0.###'
    else if (Col >= St + MaxR + 6)and (Col < St + MaxR + 8) then
      NumFormat := '##0.###'
    else
      NumFormat := '@';

    FontName := 'Arial';
  end;
end;

procedure TFBrows.FormDestroy(Sender: TObject);
begin
  LL.Free;
end;

procedure TFBrows.Analogsofcurrentanalise1Click(Sender: TObject);
var S: string;
  v: TForm;
begin
  if Query1['R'] <> Null then begin
    WForm.Show;
    S := CurQR;
    CurQR := 'Select * from RHAData where ('+ #10#13+'AnID!=' + IntToSTr(Query1['AnID']) +
      ' and Substring(rhadata.R,1,' +
      IntToStr(RSymLen * MaxHALen) + ')=''' + Copy(Query1['R'], 1, RSymLen * MaxHALen) + ''' )' + #10#13
      +
      ' ORDER BY Substring (rhadata.R,1,' +
      IntToStr(RSymLen * MaxHALen) + '), RHADATA.H desc, RHADATA.An ';
    v := TFBrows.Create(MainForm);
    v.Caption := 'Analogs for ' + Query1['Descript'];
    WForm.Close;
    CurQR := S;
  end;
end;

procedure TFBrows.Countofanalogsofcurrentanalise1Click(Sender: TObject);
begin
  if Query1['R'] <> Null then begin
    WForm.Show;
    OpenQr('Select Count(*) as cc from RHAData where AnID!=' + IntToSTr(Query1['AnID']) +
      ' and Substring(rhadata.R,1,' +
      IntToStr(RSymLen * MaxHALen) + ')=''' + Copy(Query1['R'], 1, RSymLen * MaxHALen) + ''' ', DM1.q1Time);
    WForm.Close;
    ShowInfo('There are ' + IntToStr(DM1.q1Time['cc']) + ' analogues of the current analysis in database');
  end;

end;

procedure TFBrows.Numberofdifferentrangeformulas1Click(Sender: TObject);
var r: TStringList;
  s, Res: string;
  i, N: integer;
begin
  try
    r := TStringList.Create;
    Query1.DisableControls;
    Screen.Cursor := crHourGlass;
    N := 0;
    Query1.First;
    while not Query1.Eof do begin
      if Length(Query1['R']) div RSymLen > N then
        N := Length(Query1['R']) div RSymLen;
      Query1.Next;
    end;
    Res := SelSQLName + ' (' + IntToStr(Query1.RecordCount) + ' analyzes)' + #10 +
      'Number of different range formulas:' + #10;
    for i := 1 to N do begin
      R.Clear;
      Query1.First;
      while not Query1.Eof do begin
        if Query1['R'] <> Null then begin
          s := Copy(Query1['R'], 1, i * RSymLen);
          if r.IndexOf(s) < 0 then
            r.Add(s);
        end;
        Query1.Next;
      end;
      Res := Res + 'Range ' + IntToStr(i) + '  -  ' + IntToStr(R.Count) + #10;
    end;
    Screen.Cursor := crDefault;
    ShowInfo(Res);
  finally
    r.Free;
    Query1.EnableControls;
    Screen.Cursor := crDefault;
  end;

end;

procedure TFBrows.Showwithnumbersofanalogiue1Click(Sender: TObject);
var F: TIntegerField;
begin
  ShowAnalog := True;
  screen.Cursor := crHourGlass;
  try
    Query1.Active := False;
    Query1.SQL[0] := 'Select *,(select MaxHA from MainRHA where ID=ArrId) as Det, (Select Count(*) from RHADATA rrr where rrr.AnID!=rhadata.anID' +
      ' and Substring(rhadata.R,1,' + IntToStr(RSymLen * MaxHALen) +
      ')=Substring(RRR.R,1,' + IntToStr(RSymLen * MaxHALen) +
      ')) as Analog From RHADATA rhadata Where (';

    Sg1.Columns[2].Visible := True;
    F := TIntegerField.Create(Self);
    F.Name := 'Query1Analog';
    F.FieldName := 'Analog';
    F.DataSet := Query1;
    F.Index := Query1.FieldCount;
    Query1.FieldDefs.UpDate;
    Query1.Active := True;
    //SG1.DefaultDrawing:=False;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.

