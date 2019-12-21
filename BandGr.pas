unit BandGr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODb, ExtCtrls, MoshChart, RHAGlobs, Chemist, Buttons, Menus, ActnList,
  StdCtrls, CheckLst, Variants;

const MaxGraphs = 19;

type
  TBandForm = class(TForm)
    GeoChart1: TGeoChart;
    ActionList1: TActionList;
    SaveFile: TAction;
    Preview: TAction;
    Print: TAction;
    SaveClip: TAction;
    SaveDialog1: TSaveDialog;
    MainMenu1: TMainMenu;
    ASpProp: TAction;
    AExcExp: TAction;
    Concentrations1: TMenuItem;
    Atomic1: TMenuItem;
    Moleculars1: TMenuItem;
    Weight1: TMenuItem;
    Weightrecalcto1001: TMenuItem;
    AtomicwithoutH2O1: TMenuItem;
    MolecularwithoutH2O1: TMenuItem;
    WeightwithoutH2O1: TMenuItem;
    LogMItem: TMenuItem;
    Panel1: TPanel;
    CheckListBox1: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Visiblecomponents1: TMenuItem;
    N3: TMenuItem;
    ShowMinandMax1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    AGroup: TAction;
    Grouping1: TMenuItem;
    Chart1: TMenuItem;
    SaveToFile1: TMenuItem;
    Savetoclippboard1: TMenuItem;
    ExporttoEXCEL1: TMenuItem;
    N1: TMenuItem;
    Preview1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    Chartproperties1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure PreviewExecute(Sender: TObject);
    procedure PrintExecute(Sender: TObject);
    procedure SaveClipExecute(Sender: TObject);
    procedure AExcExpExecute(Sender: TObject);
    procedure Atomic1Click(Sender: TObject);
    procedure Moleculars1Click(Sender: TObject);
    procedure Weight1Click(Sender: TObject);
    procedure Weightrecalcto1001Click(Sender: TObject);
    procedure AtomicwithoutH2O1Click(Sender: TObject);
    procedure MolecularwithoutH2O1Click(Sender: TObject);
    procedure WeightwithoutH2O1Click(Sender: TObject);
    procedure LogMItemClick(Sender: TObject);
    procedure Visiblecomponents1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ShowMinandMax1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AGroupExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    AnType: TDatType;
    Alfa : integer;
    IDs: array[0..MaxGraphs] of integer;
    function GetInd(ID: integer): integer;
  public
    SQLs: TList;
    {NewGraph: boolean;}
    NGraphs: Integer;
    {HaveDev: Boolean;}
    ElNums: array[0..MendCount] of integer;
     {Порядковый номер элемента i на оси X}
    Pres: TPresents;

    {AnW: boolean;
    Atomn: boolean;
    Proc100: boolean; }
    {Elements: array[1..MendCount] of integer;}
    {Mols: boolean;}
    GroupInd: integer;
    Diagr: integer;
    DiagrName: string;
    FieldName: string;
    Tab: TADOTable;
    GValues: TStringList;
    procedure RefreshSql;
    procedure MakeSeries;
    function MakeLabels: boolean;
    procedure FillLabels;
    procedure CreateSeries;
  end;

var
  BandForm: TBandForm;
  Aver, Mins, Maxs: array[0..MaxGraphs, 1..MendCount] of real;
  Counts: array[0..MaxGraphs, 1..MendCount] of integer;
  CapStr: string;

resourcestring
  stMMAv = 'Maximum, minimum and average ';
  stAv = 'Average ';
  stTooMany = 'ERROR! Number of different groups must be less then 21!';
  stGroup = ' grouping by ';
  TooMQ = 'ERROR! Number of queries must be less then 21!';

implementation

uses DMod1, ExcelExp, RollQuery, Grouping, StDiagrams, wait, Main, Devid,
  ADOUtilsS;

{$R *.DFM}

procedure TBandForm.FormCreate(Sender: TObject);
begin
  SQLs := TList.Create;
  GValues := TStringList.Create;
  AnType:=TDatType(DevForm.RadioGroup1.ItemIndex);
  RefreshSql;
  Alfa:=MendTab.AlfaN;
end;

procedure TBandForm.RefreshSql;
var i, j, k: integer;
  s: string;
begin
  SQLs.Clear;
  NGraphs := 0;
  for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
    if QueryRolls.QueryChLBox.Checked[i] then begin
      if SQls.Count > MaxGraphs then begin
        ShowMessage(TooMQ);
        break;
      end;
      SQLs.Add(TADOQuery.Create(Self));
      TADOQuery(Sqls[NGraphs]).Tag := i;
      TADOQuery(Sqls[NGraphs]).Connection:=DM1.ADOConnection1;
      TADOQuery(Sqls[NGraphs]).SQL.Assign(TADOQuery(LQueries[i]).SQL);
      TADOQuery(SQLS[NGraphs]).Open;
      MendTab.AlfaN:=TADOQuery(SQLS[NGraphs]).FieldByName('Alfa').AsInteger;
      Inc(NGraphs);
    end;
  Application.ProcessMessages;
  GroupInd := 0;
  if SQLs.Count > 1 then
    AGroup.Enabled := False;
  try
    CreateSeries;
  except
    on EAbort do
      Exit;
  end;
end;

procedure TBandForm.CreateSeries;
var i: integer;
begin
  NGraphs := 0;
  for i := 0 to MaxGraphs do
    IDs[i] := 0;
  GValues.Clear;
  Application.ProcessMessages;
  try
    GeoChart1.BeginUpdate;
    GeoChart1.Series.Clear;
    if (Sqls.Count > 1) or (GroupInd = 0) then
      for i := 0 to SQLs.Count - 1 do begin
        GeoChart1.Series.Add;
        GeoChart1.Series[GeoChart1.Series.Count - 1].Name :=
          QueryRolls.QueryChLBox.Items[TADOQuery(SQLs[i]).Tag]
          + ' (Min)';
        GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
        GeoChart1.Series.Add;
        GeoChart1.Series[GeoChart1.Series.Count - 1].Name :=
          QueryRolls.QueryChLBox.Items[TADOQuery(SQLs[i]).Tag];
        GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
        GeoChart1.Series.Add;
        GeoChart1.Series[GeoChart1.Series.Count - 1].Name :=
          QueryRolls.QueryChLBox.Items[TADOQuery(SQLs[i]).Tag]
          + ' (Max)';
        GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
        Inc(NGraphs);
      end else begin
      if GroupInd = giDiag then begin
        with TADOQuery(SQLs[0]) do begin
          First;
          while not Eof do begin

            if OpenQr('Select * from Classif where Diagr='+intToStr(Diagr) +' and Anal='+
            IntToStr(TADOQuery(SQLs[0])['AnId']),DM1.q1Time) then begin
              i := GValues.IndexOf(DM1.q1Time['Class']);
              if i < 0 then begin
                GValues.Add(DM1.q1Time['Class']);
                GeoChart1.Series.Add;
                GeoChart1.Series[GeoChart1.Series.Count - 1].Name := DM1.q1Time['Class']
                  + ' (Min)';
                GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
                GeoChart1.Series.Add;
                GeoChart1.Series[GeoChart1.Series.Count - 1].Name := DM1.q1Time['Class'];
                GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
                GeoChart1.Series.Add;
                GeoChart1.Series[GeoChart1.Series.Count - 1].Name := DM1.q1Time['Class']
                  + ' (Max)';
                GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
                Inc(NGraphs);
                if NGraphs > MaxGraphs then begin
                  ShowMessage(stTooMany);
                  Abort;
                end;
              end;
            end;
            Next;
          end;
        end;
      end else begin
        case GroupInd of
          giGid: begin
              FieldName := 'GeolId';
              Tab := DM1.GeolIds;
            end;
          giGBod: begin
              FieldName := 'GBody';
              Tab := DM1.GBodies;
            end;
          giReg: begin
              FieldName := 'Region';
              Tab := DM1.Regions;
            end;
          giRoc: begin
              FieldName := 'Rock';
              Tab := DM1.Rocks;
            end;
        end;
        with TADOQuery(SQLs[0]) do begin
          First;
          while not Eof do begin
            i := GetInd(TADOQuery(SQls[0])[FieldName]);
            if i < 0 then begin
              IDs[NGraphs] := TADOQuery(SQls[0])[FieldName];
              Tab.Locate('Id', TADOQuery(SQls[0])[FieldName], []);
              GeoChart1.Series.Add;
              GeoChart1.Series[GeoChart1.Series.Count - 1].Name := Tab.Fields[1].Value
                + ' (Min)';
              GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
              GeoChart1.Series.Add;
              GeoChart1.Series[GeoChart1.Series.Count - 1].Name := Tab.Fields[1].Value;
              GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
              GeoChart1.Series.Add;
              GeoChart1.Series[GeoChart1.Series.Count - 1].Name := Tab.Fields[1].Value
                + ' (Max)';
              GeoChart1.Series[GeoChart1.Series.Count - 1].MarkType := TGMark((NGraphs) mod 6 + 1);
              Inc(NGraphs);
              if NGraphs > MaxGraphs then begin
                ShowMessage(stTooMany);
                Abort;
              end;
            end;
            Next;
          end;
        end;
      end;
    end;
    GeoChart1.BottomTitle.Title := '';
    Geochart1.LeftTitle.Title := '';
    if ShowMinandMax1.Checked then
      CapStr := stMMAv
    else
      CapStr := stAv;
    MakeLabels;
    MakeSeries;
  finally
    GeoChart1.EndUpdate;
  end;

end;

procedure TBandForm.MakeSeries;
var i, j: integer;
  R: TRPoint;
begin
  GeoChart1.BeginUpdate;
  for j := 0 to NGraphs - 1 do begin
    for i := 0 to 2 do
      GeoChart1.Series[j * 3 + i].Clear;
    for i := 1 to MendCount do
      if (ElNums[i - 1] >= 0) and (Counts[j, i] > 0) then begin
        R.X := ElNums[i - 1];
        R.Z := 0;
        if Mins[j, i] > 1E-12 then
          R.Y := Mins[j, i]
        else
          R.Y := 1E-12;
        GeoChart1.Series[j * 3].Add(TCPoint.Create(R, '', ''));
        if Aver[j, i] > 1E-12 then
          R.Y := Aver[j, i]
        else
          R.Y := 1E-12;
        GeoChart1.Series[j * 3 + 1].Add(TCPoint.Create(R, '', ''));
        if Maxs[j, i] > 1E-12 then
          R.Y := Maxs[j, i]
        else
          R.Y := 1E-12;
        GeoChart1.Series[j * 3 + 2].Add(TCPoint.Create(R, '', ''));
      end;
    Geochart1.Series[3 * j].Active := ShowMinandMax1.Checked;
    Geochart1.Series[3 * j + 2].Active := ShowMinandMax1.Checked;
    GeoChart1.Series[j * 3 + 1].Active := True;
  end;
  GeoChart1.EndUpdate;
end;

function TBandForm.MakeLabels: boolean;
var i, j, K, L: integer;
  A: string;
  r: double;
  S: string;
begin
  S := CapStr+GetCaptionStr(AnType);
  if GroupInd = giDiag then
    S := S + QueryRolls.QueryChLBox.Items[i] + stGroup + DiagrName
  else
    if GroupInd > 0 then
      S:=S+stGroup+GroupForm.RadioGroup1.Items[GroupInd];
      Caption := S;
  for i := 1 to MendCount do begin
    Pres[i] := False;
    for j := 0 to NGraphs - 1 do begin
      Counts[j, i] := 0;
      Mins[j, i] := 1000;
      Maxs[j, i] := -1;
      Aver[j, i] := 0;
    end;
  end;
  for i := 0 to SQLs.Count - 1 do begin
    TADOQuery(SQLs[i]).First;
    while not TADOQuery(SQLs[i]).Eof do begin
      if GroupInd = 0 then
        l := i
      else if GroupInd = giDiag then begin
        if OpenQr('Select * from Classif where Diagr='+intToStr(Diagr) +' and Anal='+
            IntToStr(TADOQuery(SQLs[0])['AnId']),DM1.q1Time) then
          l := GValues.IndexOf(DM1.q1Time['Class'])
        else begin
          TADOQuery(SQLs[i]).Next;
          Continue;
        end;
      end else
        l := GetInd(TADOQuery(SQls[i])[FieldName]);
      for k := 1 to MendCount do
        if CanPresent(k,AnType,0) and
          (TADOQuery(SQLs[i])['A' + intToStr(k)] <> null) then begin
          Pres[K] := True;
          inc(Counts[l, k]);
          r := GetDataValue(TADOQuery(SQLs[i]), k, AnType,0);
          Aver[l, k] := Aver[l, k] + r;
          if Mins[l, k] > r then
            Mins[l, k] := r;
          if Maxs[l, k] < r then
            Maxs[l, k] := r;
        end;
      TADOQuery(SQLs[i]).Next;
    end;
  end;
  for i := 0 to NGraphs - 1 do
    for k := 1 to MendCount do
      if Counts[i, k] > 0 then
        Aver[i, k] := Aver[i, k] / Counts[i, k];
  CheckListBox1.Clear;
  for i := 1 to MendCount do begin
    j := MendTab.Order[i];
    if Pres[j] then begin
      CheckListBox1.Items.Add(MendTab.GetFieldTitle(j));
      CheckListBox1.Checked[CheckListBox1.Items.Count - 1] := True;
    end;
  end;
  FillLabels;
  Result := GeoChart1.SPCount > 0;
end;

procedure TBandForm.FillLabels;
var i, j, k, L: integer;
begin
  for i := 1 to MendCount do
    ElNums[i - 1] := -1;
  GeoChart1.SPLabelsValues.Clear;
  k := 0;
  l := 0;
  for i := 1 to MendCount do begin
    j := MendTab.Order[i];
    if Pres[j] then begin
      if CheckListBox1.Checked[L] then begin
         GeoChart1.SPLabelsValues.Add(GetDataTitle(j,AnType,0));
        ElNums[j - 1] := k;
        Inc(K);
      end;
      Inc(L);
    end;
  end;
  GeoChart1.SPCount := GeoChart1.SPLabelsValues.Count;
end;


procedure TBandForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  Action := caFree;
  for i := 0 to SQls.Count - 1 do begin
    TADOQuery(SQLs[i]).Close;
    {TADOQuery(SQLs[i]).UnPrepare;}
    TADOQuery(SQLs[i]).Free;
  end;
  SQLs.Free;
  for i := 0 to GValues.Count - 1 do
    GValues.Objects[i].Free;
  GValues.Free;
end;

procedure TBandForm.SpeedButton1Click(Sender: TObject);
begin
  CurHelpContext := 77;
  GeoChart1.EditProperties;
  CurHelpContext := HelpContext;
end;

procedure TBandForm.SaveFileExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then
    GeoChart1.SaveToEMF(SaveDialog1.FileName);
end;

procedure TBandForm.PreviewExecute(Sender: TObject);
begin
  CurHelpContext := 87;
  Geochart1.PreView;
  CurHelpContext := HelpContext;
end;

procedure TBandForm.PrintExecute(Sender: TObject);
begin
  GeoChart1.Print;
end;

procedure TBandForm.SaveClipExecute(Sender: TObject);
begin
  GeoChart1.CopyToClipboard;
end;

procedure TBandForm.AExcExpExecute(Sender: TObject);
begin
  ExcF.ExportChartToExc(GeoChart1, Caption, False, nil);
end;

procedure TBandForm.Atomic1Click(Sender: TObject);
begin
  AnType:=dtAtomn;
  CreateSeries;
end;

procedure TBandForm.Moleculars1Click(Sender: TObject);
begin
  AnType:=dtMol;
  CreateSeries;
end;

procedure TBandForm.Weight1Click(Sender: TObject);
begin
  AnType:=dtWeight;
  CreateSeries;
end;

procedure TBandForm.Weightrecalcto1001Click(Sender: TObject);
begin
  AnType:=dtWeight100;
  CreateSeries;
end;

procedure TBandForm.AtomicwithoutH2O1Click(Sender: TObject);
begin
  AnType:=dtAtomnAW;
  CreateSeries;
end;

procedure TBandForm.MolecularwithoutH2O1Click(Sender: TObject);
begin
  AnType:=dtMolAW;
  CreateSeries;
end;

procedure TBandForm.WeightwithoutH2O1Click(Sender: TObject);
begin
  AnType:=dtWeightAW;
  CreateSeries;
end;

procedure TBandForm.LogMItemClick(Sender: TObject);
begin
  LogMItem.Checked := not LogMItem.Checked;
  GeoChart1.Axises[1].Logarithmic := LogMItem.Checked;
end;

procedure TBandForm.Visiblecomponents1Click(Sender: TObject);
begin
  Panel1.Visible := True;
end;

procedure TBandForm.BitBtn1Click(Sender: TObject);
begin
  Panel1.Visible := False;
  FillLabels;
  MakeSeries;
end;

procedure TBandForm.BitBtn2Click(Sender: TObject);
begin
  Panel1.Visible := False;
end;

procedure TBandForm.ShowMinandMax1Click(Sender: TObject);
var i: integer;
  S: string;
begin
  ShowMinandMax1.Checked := not ShowMinandMax1.Checked;
  if ShowMinandMax1.Checked then begin
    CapStr := stMMAv;
    S := Copy(Caption, Length(stAv) + 1, Length(Caption));
    Caption := CapStr + S;
  end else begin
    CapStr := stAv;
    S := Copy(Caption, Length(stMMAv) + 1, Length(Caption));
    Caption := CapStr + S;
  end;
  GeoChart1.BeginUpdate;
  for i := 0 to (Geochart1.Series.Count - 1) div 3 do begin
    Geochart1.Series[3 * i].Active := ShowMinandMax1.Checked;
    Geochart1.Series[3 * i + 2].Active := ShowMinandMax1.Checked;
  end;
  GeoChart1.EndUpdate;
     {GeoChart1.MustRefresh:=True;}
end;

procedure TBandForm.Button1Click(Sender: TObject);
var i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := True;
  CheckListBox1.SetFocus;
end;

procedure TBandForm.Button2Click(Sender: TObject);
var i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := false;
  CheckListBox1.SetFocus;

end;

procedure TBandForm.Button3Click(Sender: TObject);
var i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := not CheckListBox1.Checked[i];
  CheckListBox1.SetFocus;

end;

procedure TBandForm.AGroupExecute(Sender: TObject);
begin
  if Assigned(SQLs) then
    if GroupForm.ShowModal = mrOK then begin
      GroupInd := GroupForm.RadioGroup1.ItemIndex;
      if GroupInd = giDiag then begin
        Diagr := TDiagram(GroupForm.HLB1.Items.Objects[GroupForm.HLB1.ItemIndex]).ID;
        DiagrName := TDiagram(GroupForm.HLB1.Items.Objects[GroupForm.HLB1.ItemIndex]).Name;
      end;
      try
        WForm.Show;
        CreateSeries;
      finally
        WForm.Close;
      end;
    end;
end;

function TBandForm.GetInd(ID: integer): integer;
var i: integer;
begin
  Result := -1;
  for i := 0 to NGraphs - 1 do
    if Id = Ids[i] then begin
      Result := i;
      break;
    end;
end;

procedure TBandForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN:=Alfa;
end;

end.

