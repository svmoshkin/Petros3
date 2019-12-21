unit AtProc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, StdCtrls, Buttons, Grids, DBGrids, RHAGlobs, Chemist, DMod1,
  ESBRtns, Qrctrls, quickrpt, ExtCtrls, RXDBCtrl, ActnList, OleServer, Excel97, Menus,
  Variants;

type
  TAtForm = class(TForm)
    SaveDialog1: TSaveDialog;
    DataSource2: TDataSource;
    SG1: TRxDBGrid;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    SaveFile: TAction;
    Print: TAction;
    Action1: TMenuItem;
    SaveToFile1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    ExcAct: TAction;
    ExporttoEXCEL1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    {procedure BitBtn3Click(Sender: TObject);}
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Sg1DblClick(Sender: TObject);
    procedure Sg1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   { procedure QRLabel1Print(sender: TObject; var Value: string);
    procedure QRLabel3Print(sender: TObject; var Value: string);}
    procedure ExcActExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    AnType: TDatType;
  public
    { Public declarations }
    TitleS: string;
    Pres: TPresents;
    Quer: TAdoQuery;
    Elements: array[1..MendCount] of integer;
    DColCount: integer;
    LookCol: integer;
    function GetCText(Col: integer): string;
  end;


var
  AtForm: TAtForm;




function GT(F: TForm; Col: integer): string;

implementation

uses main, AnData, Math, ExcelExp, wait, ListBrows, RollQuery, TxtImpExp,
  SGridPrint;
{#ToDo2 Restore}

{$R *.DFM}

function GT(F: TForm; Col: integer): string;
begin
  Result := TATForm(F).GetCText(Col);
end;

function TATForm.GetCText(Col: integer): string;
var i: integer;
  S: string;
  r: real;
begin
  if Col = 0 then
    S := IntToStr(Quer.RecNo)
  else if (Col > 1) and (Col <= DColCount) then begin
    i := Elements[Col - 1];
    S := '';
    if Quer['A' + IntToStr(i)] <> null then begin
      R := GetConcentration(Quer, i, AnType);
      S := FormatAnData(R);
      (*if AnW then begin
        if Atomn then begin
            {R := 0;}
          if i = 8 then begin
            R := Quer['A8'] * Quer['AWA'];
            if Quer['A1'] <> null then
              r := r - 0.5 * Quer['A1'] * Quer['AWA'];
            S := FormatFloat('#0.###', R);
          end else
            S := FormatFloat('#0.###', Quer['A' + IntToStr(i)] * Quer['AWA']);
        end else if Mols then
          S := FormatFloat('#0.###', Quer['A' + IntToStr(i)] * Quer['MolFactAW']
            / MendTab.GetKatSteh(i))
        else
          S := FormatFloat('#0.###', Quer['A' + IntToStr(i)] *
            MendTab.GetPetroVes(i) / Quer['AW']);
      end else
        if not Atomn then begin
          if Mols then
            S := FormatFloat('#0.###', Quer['A' + IntToStr(i)] * Quer['MolFact']
              / MendTab.GetKatSteh(i))
          else
            if not proc100 then
              S := FormatFloat('#0.###', Quer['A' + IntToStr(i)] * Quer['Summa'] *
                MendTab.GetPetroVes(i) / (Quer['Ox'] * 100))
            else
              S := FormatFloat('#0.###', Quer['A' + IntToStr(i)] *
                MendTab.GetPetroVes(i) / Quer['Ox'])

        end else
          S := FormatFloat('#0.###', Quer['A' + IntToStr(i)]);*)
    end;
  end else
    if (Col >= LookCol) and (Col < LookCol + 4) then begin
      if Col = LookCol then
        S := DM1.GeolIds.LookUp('ID', Quer['GeolId'], 'GeolId')
      else if Col = LookCol + 1 then
        S := DM1.Rocks.LookUp('ID', Quer['Rock'], 'Rock')
      else if Col = LookCol + 2 then
        S := DM1.Regions.LookUp('ID', Quer['Region'], 'Region')
      else if Col = LookCol + 3 then
        S := DM1.GBodies.LookUp('ID', Quer['GBody'], 'GBody');
    end else
      S := Quer[SG1.Columns[Col].FieldName];
  Result := S;
end;

procedure TAtForm.FormCreate(Sender: TObject);
var S: string;
begin
  Quer := SelQuery;
  {Qr.Visible := false;}
  AnType := MainForm.AnType;
  OpenSq(Quer);
  MendTab.AlfaN:=Quer.FieldByName('Alfa').AsInteger;
  S := SelSQLName + ', ';
  S := S + GetCaptionStr(AnType);
     {Quer.Refresh;}
  Caption := S;
  
end;

procedure TAtForm.FormShow(Sender: TObject);
var i, j, Colms: integer;
begin
  Application.ProcessMessages;
  if Quer.RecordCount = 0 then begin
    ShowMessage(stEmptyQuer);
    Close;
    Exit;
  end;
  DataSource2.DataSet := Quer;

 { TitleS := '';}

  GetPresents(Quer, Pres);
  with Sg1 do begin
    Visible := false;
    Columns.Clear;
    Application.ProcessMessages;
    Columns.Add;
    Columns.Items[0].Title.Caption := 'N';
    Columns.Items[0].FieldName := 'Num';
    Columns.Items[0].Width := 32;
    Columns.Add;
    Columns.Items[1].Title.Caption := 'ID';
    Columns.Items[1].FieldName := 'Sample';
    Columns.Items[1].Width := 16 * Sg1.Canvas.TextWidth('s'); ;
    Columns.Items[1].Visible:=SID in UsedFields;
       { Columns.Add;
       Columns.Items[2].FieldName := 'GeolId';}
    Colms := 1;
    for j := 1 to MendCount do begin
      i := MendTab.Order[j];
      if PresentInData(Pres, i, AnType, 0) then begin
        Columns.Add;
        Elements[Colms] := i;
        Inc(Colms);
        Columns.Items[Colms].FieldName := 'A' + IntToStr(i);
        if AnType in [dtAtomn, dtAtomnAW] then begin
          Columns.Items[Colms].Title.Caption := '   ' + GetDataTitle(i, AnType, 0);
          TitleS := TitleS + PadLeftStr(MendTab.GetFieldTitle(i) + '  ', 7);
           Columns.Items[Colms].Width := 44;
        end else begin
          Columns.Items[Colms].Title.Caption := ' ' + GetDataTitle(i, AnType, 0);
          Columns.Items[Colms].Width := 42;
          {TitleS := TitleS + PadLeftStr(GetDataTitle(i, AnType, 0) + ' ', 7);}
        end;
      end;
    end;
    DColCount := Colms;
             {for i:=1 to MendCount do
                 if Pres[i] then begin
                    Columns.Add;
                    Inc(Colms);
                    Columns.Items[Colms].FieldName:='A'+IntToStr(i);
                    Columns.Items[Colms].Title.Caption:='  '+MendTab.MendSym[i];
                    Columns.Items[Colms].Width:=48;
                    TitleS:=TitleS+PadLeftStr (MendTab.MendSym[i]+'   ', 7);
                 end;}
             { Columns.Items[AnalisTitle.Count+2].Title.Caption:='X';
              Columns.Items[AnalisTitle.Count+2].FieldName:='X';}
              {Columns.Items[AnalisTitle.Count+2].Width:=88;}
               {Columns.Items[AnalisTitle.Count+3].Title.Caption:='Y';
              Columns.Items[AnalisTitle.Count+3].FieldName:='Y';
              Columns.Items[AnalisTitle.Count+2].Width:=88;}
    Columns.Add;
    Columns.Items[Colms + 1].Title.Caption := GeolIdTit;
      Columns.Items[Colms + 1].Visible:=GID in UsedFields;
    Columns.Add;
    Columns.Items[Colms + 2].Title.Caption :=RockTit;
      Columns.Items[Colms + 2].Visible:=ROC in UsedFields;
    Columns.Add;
    Columns.Items[Colms + 3].Title.Caption := RegionTit;
      {Columns.Items[Colms + 3].FieldName := 'Region_1';}
      Columns.Items[Colms + 3].Visible:=RGN in UsedFields;
    Columns.Add;
    Columns.Items[Colms + 4].Title.Caption := GBodyTit;
      {Columns.Items[Colms + 4].FieldName := 'GBody_1';}
      Columns.Items[Colms + 4].Visible:=GBD in UsedFields;
    Columns.Add;
    Columns.Items[Colms + 5].Title.Caption :=
      stAnDes;
    Columns.Items[Colms + 5].FieldName := 'Descript';

    if AnType = dtWeight then begin
      Columns.Insert(Colms + 1);
      Columns.Items[Colms + 1].Title.Caption :=
        stSum;
      Columns.Items[Colms + 1].FieldName := 'Summa';
      LookCol := DColCount + 2;
    end else
      LookCol := DColCount + 1;
     { for i:=0 to Quer.Fields.Count-1 do
      ShowMessage(Quer.Fields.Fields[i].FieldName); }
  end;
  Sg1.FixedCols := 2;
  Sg1.Visible := true;
  Sg1.SetFocus;
  {QR.DataSet := Quer;
  QRTitle.Caption := Caption;
  QRCTitle.Caption := Titles + '  ' + stAnDes;   }
end;





procedure TAtForm.BitBtn5Click(Sender: TObject);
begin
 { QR.Print;}
 DBGridPrint(SG1, Caption,GT);
end;

procedure TAtForm.BitBtn2Click(Sender: TObject);
begin
  if ExpToTextForm.DefExport(SG1, nil, False) then
    ExptoTextForm.ExpDbGrid(SG1, GT, Self);
end;

procedure TAtForm.BitBtn4Click(Sender: TObject);
begin
  Application.HelpFile := 'PETROS.HLP';
  Application.HelpCommand(HELP_CONTEXT, 40);
end;

procedure TAtForm.Sg1DblClick(Sender: TObject);
begin
  if MainForm.Cadd.Checked then
    AddToList(Quer['Sample'])
  else begin
    CurID := Quer['AnID'];
    TAnalForm.Create(MainForm);
  end;
end;


procedure TAtForm.Sg1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  S: string;
begin
  if (Quer.RecNo > 0) then begin
    S := GetCText(DataCol);
    if (DataCol = 0) then begin
      s := IntToStr(Quer.RecNo);
      Sg1.Canvas.Brush.Color := Sg1.FixedColor;
      SG1.Canvas.FillRect(Rect);
      //Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed]);
      Sg1.Canvas.TextOut(Rect.Right - Sg1.Canvas.TextWidth(s) - 2, Rect.Top + 1, S);
      Exit;
    end;
    if DataCol = 1 then begin
      Sg1.Canvas.Brush.Color := Sg1.FixedColor;
      Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed]);
      Exit;
    end;
    if (DataCol > 1) and (DataCol <= DColCount) then begin
      S := PadLeftStr(S, 7);
      Sg1.Canvas.TextOut(Rect.Right - Sg1.Canvas.TextWidth(s) - 2, Rect.Top + 1,
        S);
      {end else Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, State);}
    end else
      if (DataCol >= LookCol) and (DataCol < LookCol + 4) then begin
        Sg1.Canvas.Rectangle(Rect.Left - 1, Rect.Top - 1, Rect.Right + 1, Rect.Bottom + 1);
        Sg1.Canvas.TextOut(max(Rect.Right - Sg1.Canvas.TextWidth(s) - 2, Rect.Left + 1), Rect.Top + 1, S);
      end else
        Sg1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TAtForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CloseSq(Quer);
end;


procedure TAtForm.ExcActExecute(Sender: TObject);
begin
  if (Quer.RecNo = 0) then exit;
  ExcF.ExportTableToExc(SG1, Caption, GT, Self);
end;

procedure TAtForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN:=Quer.FieldByName('Alfa').AsInteger;
end;

end.

