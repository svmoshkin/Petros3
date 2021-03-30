unit AnalInput;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, Messages,
  Chemist, Grids, RHAGlobs, ESBRtns, Mask, DBCtrls, DB, DBGrids,
  RXDBCtrl, StrUtils, Qrctrls, quickrpt, ComCtrls, SGridPrint, Variants,
  ADODB, DBTables, ADOUtilss;

type
  TAnDlg = class(TForm)
    DataSource1: TDataSource;
    SG1: TRxDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    PB1: TProgressBar;
    Table1: TADOQuery;
    Table1AnId: TAutoIncField;
    Table1ArrId: TIntegerField;
    Table1H: TFloatField;
    Table1A: TFloatField;
    Table1AN: TFloatField;
    Table1R: TStringField;
    Table1Eq: TStringField;
    Table1Descript: TStringField;
    Table1N1: TFloatField;
    Table1N2: TFloatField;
    Table1N3: TFloatField;
    Table1N4: TFloatField;
    Table1N5: TFloatField;
    Table1N6: TFloatField;
    Table1N7: TFloatField;
    Table1N8: TFloatField;
    Table1N9: TFloatField;
    Table1N10: TFloatField;
    Table1N11: TFloatField;
    Table1N12: TFloatField;
    Table1N13: TFloatField;
    Table1N14: TFloatField;
    Table1N15: TFloatField;
    Table1N16: TFloatField;
    Table1N17: TFloatField;
    Table1N18: TFloatField;
    Table1N19: TFloatField;
    Table1N20: TFloatField;
    Table1N21: TFloatField;
    Table1N22: TFloatField;
    Table1N23: TFloatField;
    Table1N24: TFloatField;
    Table1N25: TFloatField;
    Table1N26: TFloatField;
    Table1N27: TFloatField;
    Table1N28: TFloatField;
    Table1N29: TFloatField;
    Table1N30: TFloatField;
    Table1N31: TFloatField;
    Table1N32: TFloatField;
    Table1N33: TFloatField;
    Table1N34: TFloatField;
    Table1N35: TFloatField;
    Table1N36: TFloatField;
    Table1N37: TFloatField;
    Table1N38: TFloatField;
    Table1N39: TFloatField;
    Table1N40: TFloatField;
    Table1Sum: TFloatField;
    Table1A1: TFloatField;
    Table1A2: TFloatField;
    Table1A3: TFloatField;
    Table1A4: TFloatField;
    Table1A5: TFloatField;
    Table1A6: TFloatField;
    Table1A7: TFloatField;
    Table1A8: TFloatField;
    Table1A9: TFloatField;
    Table1A10: TFloatField;
    Table1A11: TFloatField;
    Table1A12: TFloatField;
    Table1A13: TFloatField;
    Table1A14: TFloatField;
    Table1A15: TFloatField;
    Table1A16: TFloatField;
    Table1A17: TFloatField;
    Table1A18: TFloatField;
    Table1A19: TFloatField;
    Table1A20: TFloatField;
    Table1A21: TFloatField;
    Table1A22: TFloatField;
    Table1A23: TFloatField;
    Table1A24: TFloatField;
    Table1A25: TFloatField;
    Table1A26: TFloatField;
    Table1A27: TFloatField;
    Table1A28: TFloatField;
    Table1A29: TFloatField;
    Table1A30: TFloatField;
    Table1A31: TFloatField;
    Table1A32: TFloatField;
    Table1A33: TFloatField;
    Table1A34: TFloatField;
    Table1A35: TFloatField;
    Table1A36: TFloatField;
    Table1A37: TFloatField;
    Table1A38: TFloatField;
    Table1A39: TFloatField;
    Table1A40: TFloatField;
    Table1A41: TFloatField;
    Table1A42: TFloatField;
    Table1A43: TFloatField;
    Table1A44: TFloatField;
    Table1A45: TFloatField;
    Table1A46: TFloatField;
    Table1A47: TFloatField;
    Table1A48: TFloatField;
    Table1A49: TFloatField;
    Table1A50: TFloatField;
    Table1A51: TFloatField;
    Table1A52: TFloatField;
    Table1A53: TFloatField;
    Table1A54: TFloatField;
    Table1A55: TFloatField;
    Table1A56: TFloatField;
    Table1A57: TFloatField;
    Table1A58: TFloatField;
    Table1A59: TFloatField;
    Table1A60: TFloatField;
    Table1A61: TFloatField;
    Table1A62: TFloatField;
    Table1A63: TFloatField;
    Table1A64: TFloatField;
    Table1A65: TFloatField;
    Table1A66: TFloatField;
    Table1A67: TFloatField;
    Table1A68: TFloatField;
    Table1A69: TFloatField;
    Table1A70: TFloatField;
    Table1A71: TFloatField;
    Table1A72: TFloatField;
    Table1A73: TFloatField;
    Table1A74: TFloatField;
    Table1A75: TFloatField;
    Table1A76: TFloatField;
    Table1A77: TFloatField;
    Table1A78: TFloatField;
    Table1A79: TFloatField;
    Table1A80: TFloatField;
    Table1A81: TFloatField;
    Table1A82: TFloatField;
    Table1A83: TFloatField;
    Table1A84: TFloatField;
    Table1A85: TFloatField;
    Table1A86: TFloatField;
    Table1A87: TFloatField;
    Table1A88: TFloatField;
    Table1A89: TFloatField;
    Table1A90: TFloatField;
    Table1A91: TFloatField;
    Table1A92: TFloatField;
    Table1X: TStringField;
    Table1Y: TStringField;
    Table1N41: TFloatField;
    Table1N42: TFloatField;
    Table1N43: TFloatField;
    Table1N44: TFloatField;
    Table1N45: TFloatField;
    Table1N46: TFloatField;
    Table1N47: TFloatField;
    Table1N48: TFloatField;
    Table1N49: TFloatField;
    Table1N50: TFloatField;
    Table1Ox: TFloatField;
    Table1Aw: TFloatField;
    Table1AWA: TFloatField;
    Table1Num: TIntegerField;
    Table1Sample: TStringField;
    Table1Summa: TFloatField;
    Table1Source: TIntegerField;
    Table1GeolId: TIntegerField;
    Table1Rock: TIntegerField;
    Table1Region: TIntegerField;
    Table1GBody: TIntegerField;
    Table1LGID: TStringField;
    Table1LRoc: TStringField;
    Table1LReg: TStringField;
    Table1LGBod: TStringField;
    Table1LSource: TStringField;
    Table1A93: TFloatField;
    Table1A94: TFloatField;
    Table1MolFact: TFloatField;
    Table1MolFactAW: TFloatField;
    Table1ArrNum: TStringField;
    Table1A95: TFloatField;
    Table1A96: TFloatField;
    Table1A97: TFloatField;
    Table1A98: TFloatField;
    Table1A99: TFloatField;
    Table1A100: TFloatField;
    Table1Alfa: TIntegerField;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    CancelBtn: TBitBtn;
    BitBtn5: TBitBtn;
    DBNavigator1: TDBNavigator;
    DelBtn: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn8: TBitBtn;
    Button1: TButton;
    Table1E: TFloatField;
    Table1t: TFloatField;
    Button2: TButton;
    Table1N51: TFloatField;
    Table1N52: TFloatField;
    Table1N53: TFloatField;
    Table1N54: TFloatField;
    Table1N55: TFloatField;
    Table1N56: TFloatField;
    Table1N57: TFloatField;
    Table1N58: TFloatField;
    Table1N59: TFloatField;
    Table1N60: TFloatField;
    Table1Tn: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure Sg1KeyDown(Sender: TObject; var KEY: Word;
      Shift: TShiftState);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CancelBtnClick(Sender: TObject);
    procedure Table11AfterInsert(DataSet: TDataSet);
    procedure Table11CalcFields(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure Table11AfterPost(DataSet: TDataSet);
    procedure SG1ColExit(Sender: TObject);
    procedure Table11BeforePost(DataSet: TDataSet);
    procedure DelBtnClick(Sender: TObject);
    procedure SG1ColEnter(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
   { procedure BitBtn7Click(Sender: TObject);}
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure SG1DblClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure SG1EditButtonClick(Sender: TObject);
    procedure Table11BeforeDelete(DataSet: TDataSet);
    procedure SG1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Ok: Boolean;
    first: boolean;
    procedure CalcSum(DataSet: TDataSet);
    function Sg1Valid(ARow: Integer): Boolean;
  end; {_ TAnDlg = class(TForm) _}



var
  AnDlg: TAnDlg;

implementation

uses DMod1, AnData, ExcelExp, ListBrows, Main, EdBook, TxtImpExp, Analise;

{$R *.DFM}





procedure TAnDlg.FormShow(Sender: TObject);
begin
  BadAnalise := False;
end;

procedure TAnDlg.Sg1KeyDown(Sender: TObject; var KEY: Word;
  Shift: TShiftState);
begin
  if KEY = VK_RETURN then begin
    SG1.Perform(WM_KEYDOWN, VK_TAB, 0);
    SG1.Perform(WM_KEYUP, VK_TAB, 0);
  end;
end;

function TAnDlg.Sg1Valid(ARow: Integer): Boolean;
begin
  Result := True;
  { With SG1 do begin
               for i:=2 to ColCount-1 do
            if not ValidNumString(Cells[i,ARow]) then begin
               ShowMessage('Ошибка в записи числа');
               Col:=i;
               Row:=ARow;
               Result:=false;
               break;
            end;
         end;  }
end; {_ function TAnDlg.Sg1Valid(ARow: Integer): Boolean; _}


procedure TAnDlg.OKBtnClick(Sender: TObject);
var TMPHALen: Integer;
begin
  Ok := True;
  try
    TMPHALen := MaxHALen;
    if ChangedTitle or (Table1.State <> dsBrowse) then begin
      PB1.Position := 0;
      Panel1.Visible := true;
      if DM1.TabM1['MaxHA'] <> Null then
        MaxHALen := DM1.TabM1['MaxHA'];
    end;
    Screen.Cursor := crHourGlass;
    if ChangedTitle then
      RecalcTable(Table1, PB1);

    with Table1 do begin
      if State <> dsBrowse then
        Post;
      {ApplyUpdates;
      CommitUpdates; }
    end; {_ with Table1 do begin _}
  finally
    Panel1.Visible := false;
    Screen.Cursor := crDefault;
    MaxHALen := TMPHALen;
    CLOSE;
    ModalResult := mrOk;
  end;
end; {_ procedure TAnDlg.OKBtnClick(Sender: TObject); _}

procedure TAnDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Ok;
  if Ok and ((Table1.State = dsEdit) or (Table1.State = dsInsert)) then Table1.Post;
end; {_ procedure TAnDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean); _}

procedure TAnDlg.CancelBtnClick(Sender: TObject);
begin
  Ok := True;
  try
  Table1.Cancel;
  except
  end;
 // CLOSE;
end; {_ procedure TAnDlg.CancelBtnClick(Sender: TObject); _}



procedure TAnDlg.Table11AfterInsert(DataSet: TDataSet);
begin
  DataSet['Num'] := LastNum + 1;
  DataSet['Descript'] :=  IntToStr(LastNum + 1) +
    '-' + DM1.TabM1['ArrayName'] + ' ';
  DataSet['Sample'] := IntToStr(DM1.TabM1['Id']) + '-' + AddChar(' ', IntToStr(LastNum + 1), 3);
  DataSet['ArrId'] := DM1.TabM1['Id'];
  DataSet['Source'] := DM1.TabM1['Source'];
  if Roc0 > 0 then
    DataSet['Rock'] := Roc0;
  if Reg0 > 0 then
    DataSet['Region'] := Reg0;
  if GBod0 > 0 then
    DataSet['GBody'] := GBod0;
  if Gid0 > 0 then
    DataSet['GeolId'] := Gid0;
  openQr('Select Num from Source where Id=' + IntToStr(DM1.TabM1['Source']), DM1.q1Time);
  DataSet['ArrNum'] := PadChLeftStr(DM1.q1Time.FieldByName('Num').AsString, ' ', 5) + '-' + IntToStr(DM1.TabM1['Id']);
end; {_ procedure TAnDlg.Table1AfterInsert(DataSet: TDataSet); _}

procedure TAnDlg.Table11CalcFields(DataSet: TDataSet);
begin
  CalcSum(DataSet);
  {if (DataSet.RecNo > 0) then begin
    DataSet['N'] := DataSet.RecNo
  end  else DataSet['N'] := LastNum+1; }
  {if DataSet['Descript']<>Null then
  DataSet['DString'] := Ds + DataSet['Descript']; }
  if (DataSet['Source'] <> Null) and
    openQr('Select Convert(varchar(6),Num) +IsNull('', ''+Author,'''')+ISNull('', ''+Title,'''')as S from Source where ID='
    + intToStr(DataSet['Source']), DM1.q1Time) and
    (DM1.q1Time['S'] <> Null) then
    DataSet['LSource'] := Copy(DM1.q1Time['S'], 1, 255);
end;

procedure TAnDlg.FormActivate(Sender: TObject);
var I: Integer;
  S: string;
begin
  BadAnalise := False;
  CurHelpContext := HelpContext;
  S := '';
  Ok := not DelBtn.Enabled;
  Button2.Enabled := DelBtn.Enabled;
  try
    with SG1 do begin
      Visible := False;
      Columns.Clear;
      for I := 0 to AnalisTitle.Count + 10 do
        Columns.Add;
      Columns.Items[1].Title.CAPTION := 'N';
      Columns.Items[1].FieldName := 'Num';
      Columns.Items[1].Width := 24;
      Columns.Items[0].Title.CAPTION := 'Sum';
      Columns.Items[0].FieldName := 'Sum';
      Columns.Items[0].Width := 48;
      Columns.Items[2].Title.CAPTION := 'ID';
      Columns.Items[2].FieldName := 'Sample';
      Columns.Items[2].Width := 64;
      Columns.Items[2].Visible := SID in UsedFields;
      {Columns.Items[AnalisTitle.Count + 3].Title.CAPTION := 'X'; }
      Columns.Items[AnalisTitle.Count + 3].FieldName := 'X';
      Columns.Items[AnalisTitle.Count + 3].Visible := CRD in UsedFields;
      {Columns.Items[AnalisTitle.Count+2].Width:=88;
      Columns.Items[AnalisTitle.Count + 4].Title.CAPTION := 'Y';}
      Columns.Items[AnalisTitle.Count + 4].FieldName := 'Y';
      Columns.Items[AnalisTitle.Count + 4].Visible := CRD in UsedFields;
      Columns.Items[AnalisTitle.Count + 5].FieldName := 'LGID';
      Columns.Items[AnalisTitle.Count + 5].Visible := GID in UsedFields;
      Columns.Items[AnalisTitle.Count + 6].FieldName := 'LRoc';
      Columns.Items[AnalisTitle.Count + 6].Visible := ROC in UsedFields;
      Columns.Items[AnalisTitle.Count + 7].FieldName := 'LReg';
      Columns.Items[AnalisTitle.Count + 7].Visible := RGN in UsedFields;
      Columns.Items[AnalisTitle.Count + 8].FieldName := 'LGBod';
      Columns.Items[AnalisTitle.Count + 8].Visible := GBD in UsedFields;
      {Columns.Items[AnalisTitle.Count+2].Width:=88;}
      Columns.Items[AnalisTitle.Count + 9].Title.CAPTION :=
        stAnDes;

      Columns.Items[AnalisTitle.Count + 9].FieldName := 'Descript';
      Columns.Items[AnalisTitle.Count + 9].Width := 300;
      Columns.Items[AnalisTitle.Count + 10].FieldName := 'LSource';
      Columns.Items[AnalisTitle.Count + 10].Width := 400;
      if SG1.ReadOnly then
        Columns.Items[AnalisTitle.Count + 10].ButtonStyle := cbsNone
      else
        Columns.Items[AnalisTitle.Count + 10].ButtonStyle := cbsEllipsis;
      for I := 3 to AnalisTitle.Count + 2 do begin
        Columns.Items[I].FieldName := 'N' + IntToStr(I - 2);
        Columns.Items[I].Title.CAPTION := TFormula(AnalisTitle[I - 3]).Symbol;
        Columns.Items[I].Width := 48;
       { S := S + PadLeftStr(Columns.Items[I].Title.CAPTION + ' ', 6); }
      end; {_ for I := 2 to AnalisTitle.Count + 1 do begin _}
     { QRTitle.CAPTION := DM1.TabM1['ArrayName'];
      QRCTitle.CAPTION := S + stAnDes; }
      FixedCols := 1;
      Col := Col + 1;
      Col := Col - 1;
      if Table1.RecordCount < DM1.TabM1['MaxNum'] then
        LastNum := DM1.TabM1['MaxNum']
      else
        LastNum := Table1.RecordCount;
      if NewAnalises then begin
        {first:=true;}

        Table1.Insert;
      end else begin
        Table1.First;
      end;
    end; {_ with SG1 do begin _}
  finally
    SG1.Visible := True;
    SG1.SetFocus;
  end; {_ try _}
end;

procedure TAnDlg.Table11AfterPost(DataSet: TDataSet);
var id: integer;
begin
  Id := DataSet['Num'];
  if (DataSet['Sample'] <> null) and (DataSet.Locate('ArrId;Sample',
    VarArrayOf([DataSet['ArrId'], DataSet['Sample']]), [])) and
    (DataSet['Num'] <> ID) then begin
    ShowMessage(stDoubleID);
    Abort;
  end;
  BadAnalise := False;
  Table1.AutoCalcFields := true;

end; {_ procedure TAnDlg.Table1AfterPost(DataSet: TDataSet); _}

procedure TAnDlg.SG1ColExit(Sender: TObject);
begin
  if SG1.Col < SG1.Columns.Count - 2 then
    if (Table1.State = dsEdit) or (Table1.State = dsInsert) then begin
      if Table1[SG1.Columns.Items[SG1.Col - 1].FieldName] = Null then
        Table1[SG1.Columns.Items[SG1.Col - 1].FieldName] := 0;
      CalcSum(Table1);
    end;
end; {_ procedure TAnDlg.SG1ColExit(Sender: TObject); _}

procedure TAnDlg.Table11BeforePost(DataSet: TDataSet);
var an: TAnalis;
  I: Integer;
begin
  if (DataSet.State = dsInsert) and (DataSet['Sample'] <> null) and OpenQr('Select * from RHADATA where Sample=''' +
    DataSet['Sample'] + ''' and AnID!=' + IntToStr(i), DM1.q1Time) then begin
    ShowMessage(stDoubleID);
    Abort;
  end;
     {#ToDo1 перенести в другие места и в импорт}
  DataSet.AutoCalcFields := false;
     {if DataSet.RecNo>0 then
     LastNum:=DataSet.RecNo;
      DataSet['N']:=LastNum; }
  an := TAnalis.CreateT(DataSet, DM1.TabM1);
  DataSet['Alfa'] := DM1.TabM1['Alfa'];
  CalcFirst := True;
  an.Recalc(AnalisTitle);
  if Nel < MinCompCount then begin
    ShowMessage(stAnNum + DataSet['Sample'] + stNotEnComp + IntToStr(MinCompCount)
      + ')' + stWillNotInput);
    an.Free;
    BadAnalise := True;
    Abort;
  end;
  if DataSet.State = dsInsert then inc(LastNum);
  if not ChangedTitle then begin
    for I := 1 to 100 do
      if An.Atom[i] >= 0 then
        DataSet['A' + IntToStr(I)] := an.ATOM[I];
    CalcFirst := False;
    an.Recalc(AnalisTitle);
    DataSet['R'] := an.Rang;
    //if (an.A > 0) and (an.H > 0) then begin
      DataSet['H'] := An.H;
      //Round(An.H * 1000) / 1000;
      DataSet['A'] := Round(An.A * 1000) / 1000;
      DataSet['AN'] := Round(An.AN * 1000) / 1000;
      DataSet['T'] := Round(An.TTT * 1000) / 1000;
      DataSet['E'] :=An.E;
      DataSet['Tn'] := Round(An.Tn * 1000) / 1000;
      //Round(An.E * 1000) / 1000;
  //  end;
    DataSet['Eq'] := an.Eq;
    DataSet['Ox'] := An.Ox;
    DataSet['Aw'] := An.Aw;
    DataSet['AWA'] := An.AWA;
    if An.CalcVes then
      DataSet['Summa'] := An.Summa
    else
      DataSet['Summa'] := 100;
    DataSet['MolFact'] := An.MolFactor;
    DataSet['MolFactAW'] := An.MolFactorAW;
    an.Free;
  end;
end; {_ procedure TAnDlg.Table1BeforePost(DataSet: TDataSet); _}


procedure TAnDlg.DelBtnClick(Sender: TObject);
begin
  if (BadAnalise) or (Table1.State = dsInsert) then Table1.CANCEL
  else Table1.Delete;
end;

procedure TAnDlg.SG1ColEnter(Sender: TObject);
var S: string;
begin
  if (SG1.SelectedField = Table1.FieldByName('Descript')) and (Table1.State <> dsBrowse)
    then begin
    S := Table1['Descript'];
    S := S + ',';
    Table1['Descript'] := S;
  end;
end;



procedure TAnDlg.BitBtn6Click(Sender: TObject);
{var F: TextFile;
  I: Integer;
  R: real;}
begin
  if ExpToTextForm.DefExport(SG1, nil, False) then
    ExptoTextForm.ExpDbGrid(SG1, nil, Self);

 (* if SaveDialog1.Execute then begin
    AssignFile(F, SaveDialog1.Filename);
    Rewrite(F);
    write(F, '  No');

    write(F, PadLeftStr(SG1.Columns.Items[2].Title.CAPTION, 16));
    write(F, PadLeftStr(SG1.Columns.Items[1].Title.CAPTION, 8));
    for I := 3 to SG1.Columns.Count - 4 do
      write(F, PadLeftStr(SG1.Columns.Items[I].Title.CAPTION, 8));
    WriteLn(F, '    X        Y       Описание');
    with Table1 do begin
      DisableControls;
      First;
      while not EOF do begin
        R := Table1['Num'];
        write(F, R: 4: 0);
        if Table1['Sample'] <> null then
          write(F, PadLeftStr(Table1['Sample'], 16))
        else write(F, '       -        ');
        R := Table1[SG1.Columns.Items[1].FieldName];
        write(F, R: 8: 3);
        for I := 3 to SG1.Columns.Count - 4 do begin
          if (Table1[SG1.Columns.Items[I].FieldName] <> Null)
            then begin
            R := Table1[SG1.Columns.Items[I].FieldName];
            write(F, R: 8: 3);
          end {_ if (Table1[SG1.Columns.Items[I].FieldName] <> Null) _} else write(F, '    -   ');
        end; {_ for I := 1 to SG1.Columns.Count - 4 do begin _}
        if (Table1['x'] <> null) and (Table1['Y'] <> null) then
          write(F, PadLeftStr(Table1['X'], 9), PadLeftStr(Table1['Y'], 9))
        else
          write(F, '    -        -    ');
        WriteLn(F, ' ', Table1['Descript']);
        Next;
      end; {_ while not EOF do begin _}
      EnableControls;
    end; {_ with Table1 do begin _}
    CloseFile(F);
  end;   *)
end;

{procedure TAnDlg.BitBtn7Click(Sender: TObject);
begin
  QR.Preview;
end; }

procedure TAnDlg.BitBtn8Click(Sender: TObject);
begin
  DBGridPrint(SG1, Caption, nil);
end;

procedure TAnDlg.BitBtn5Click(Sender: TObject);
begin
  Application.HelpContext(CurHelpContext);
end; {_ procedure TAnDlg.BitBtn5Click(Sender: TObject); _}

procedure TAnDlg.SG1DblClick(Sender: TObject);
begin
  if not (NewAnalises and DelBtn.Enabled) then begin
    if MainForm.Cadd.Checked then
      AddToList(Table1['Sample'])
    else begin
      CurID := Table1['AnID'];
      TAnalForm.Create(MainForm);
    end;
  end;
end;


procedure TAnDlg.BitBtn3Click(Sender: TObject);
begin
  ExcF.ExportTableToExc(SG1, Caption, nil, Self);
end;

procedure TAnDlg.SG1EditButtonClick(Sender: TObject);
begin
  DM1.TabEdBook.Locate('ID', Table1['Source'], []);
  if EdBookForm.ShowModal = mrOk then begin
    Table1.Edit;
    Table1['Source'] := DM1.TabEdBook['Id'];
  end;
end;

procedure TAnDlg.Table11BeforeDelete(DataSet: TDataSet);
begin
  ExecQr('Delete from ListData where Anal=' + IntToStr(Table1['AnId']), DM1.q1Time);
end;

procedure TAnDlg.SG1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var s: string;
begin
  if (DataCol > 2) and (DataCol < AnalisTitle.Count + 2) then begin
    Sg1.Canvas.Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
    if Sg1.DataSource.DataSet[Column.FieldName] <> Null then begin
      S := FormatAnData(Sg1.DataSource.DataSet[Column.FieldName]);
      S := PadLeftStr(S, 7);
      Sg1.Canvas.TextOut(Rect.Right - Sg1.Canvas.TextWidth(s) - 2, Rect.Top + 1,
        S);
    end;
  end else
    Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TAnDlg.CalcSum(DataSet: TDataSet);
var I: Integer;
  S: real;
  R: Double;
 // Ds: string;
begin
  S := 0;
//  Ds := '';
  for I := 1 to AnalisTitle.Count do
    if DataSet['N' + IntToStr(I)] <> Null then begin
      R := DataSet['N' + IntToStr(I)];
      if NewAnalises and ChangedTitle then
        r := r / TFormula(AnalisTitle[i - 1]).Delit;
      S := S + R;
      //Ds := Ds + Double2Str(R, 6, 2);
    end;

  DataSet['Sum'] := FloatToStrF(S, ffFixed, 8, 4);
end;

procedure TAnDlg.Button1Click(Sender: TObject);
var TMPHALen: Integer;
begin
  Ok := True;
  try
    TMPHALen := MaxHALen;
    PB1.Position := 0;
    Panel1.Visible := true;
    if DM1.TabM1['MaxHA'] <> Null then
      MaxHALen := DM1.TabM1['MaxHA'];
    Screen.Cursor := crHourGlass;
    with Table1 do begin
      if State <> dsBrowse then
        Post;
    end;
    RecalcTable(Table1, PB1);
  finally
    Panel1.Visible := false;
    Screen.Cursor := crDefault;
    MaxHALen := TMPHALen;
    CLOSE;
    ModalResult := mrOk;
  end;
end;

procedure TAnDlg.Button2Click(Sender: TObject);
var T: array[1..MaxCompCount] of real;
  i: integer;
begin
  Table1.DisableControls;
  Button2.Enabled:=False;
  for i := 1 to AnalisTitle.Count  do
    T[i] := 0;
  try
    Table1.First;
    while not Table1.Eof do begin
      for i := 1 to AnalisTitle.Count do
      T[i] := T[i]+Table1.FieldByName('N'+IntToStr(i)).AsFloat;
      Table1.Next;
    end;
    Table1.Insert;
    Table1['Descript'] := 'Average of ' +
      DM1.TabM1['ArrayName'] + ' ';
    for i := 1 to AnalisTitle.Count do
    Table1['N'+IntToStr(i)]:= T[i]/Table1.RecordCount;
    CalcSum(Table1);
    Table1.Post;
  finally
    Table1.EnableControls;
  end;
end;

end.

