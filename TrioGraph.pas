unit TrioGraph;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, ADODB, StdCtrls,
  Buttons, Series, JvComponentBase, JvInterpreter, ActnList, Menus,
  StrHlder, Grids, DBGrids, Hintctrl, Boxes, Mend_C, ComCtrls, MoshChart, {xBGround, xGraFill,} ESBRtns,
  RHAGlobs, ColorBtns, Analise, TabMend, Chemist, TaskSQL,
  CrysMath, StDiagrams,
  Explor, Math, Registry, DMod1, EDCoefs, RollQuery,
  ActiveX, ComObj, axctrls,
  variants, ADOUtilsS, Spin;

const
  MaxGraph = 30;


type
  TTrioForm = class(TForm)
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    Button2: TButton;
    Button5: TButton;
    Button10: TButton;
    Button11: TButton;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MendTabl1: TMendTabl;
    BitBtn5: TBitBtn;
    Button6: TButton;
    Button7: TButton;
    BitBtn7: TBitBtn;
    CheckBox11: TCheckBox;
    Edit1: TEdit;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    Label6: TLabel;
    MendTabl2: TMendTabl;
    BitBtn4: TBitBtn;
    Button8: TButton;
    Button9: TButton;
    BitBtn6: TBitBtn;
    CheckBox10: TCheckBox;
    Edit2: TEdit;
    GeoChart1: TGeoChart;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Button12: TButton;
    Button13: TButton;
    CheckBox12: TCheckBox;
    MendTabl3: TMendTabl;
    Edit3: TEdit;
    Label9: TLabel;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Label10: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    BHY: TButton;
    BAY: TButton;
    BHX: TButton;
    BAX: TButton;
    CheckBox8: TCheckBox;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    CheckBox9: TCheckBox;
    StrH1: TStrHolder;
    StrAx: TStrHolder;
    StrTit: TStrHolder;
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
    SaveClip: TAction;
    Savetoclippboard1: TMenuItem;
    AGrOpt: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    AExcExp: TAction;
    ExporttoEXCEL1: TMenuItem;
    CheckBox15: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    RadioGroup2: TRadioGroup;
    CheckBox6: TCheckBox;
    N4: TMenuItem;
    r1: TMenuItem;
    ARefresh: TAction;
    CheckBox7: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    HDBGrid2: THDBGrid;
    Label11: TLabel;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    DBGrid2: TDBGrid;
    ListBox2: THListBox;
    ListBox4: THListBox;
    ListBox1: THListBox;
    ListBox3: THListBox;
    ListBox5: THListBox;
    ListBox6: THListBox;
    Label13: TLabel;
    HDBGrid1: THDBGrid;
    Label14: TLabel;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    Label15: TLabel;
    HDBGrid3: THDBGrid;
    Label16: TLabel;
    DBGrid3: TDBGrid;
    BitBtn3: TBitBtn;
    Butt4: TButton;
    BitBtn10: TBitBtn;
    CheckBox16: TCheckBox;
    BtAY: TButton;
    ButtAX: TButton;
    XPRogr: TJvInterpreterProgram;
    YProgr: TJvInterpreterProgram;
    ZProgr: TJvInterpreterProgram;
    Button3: TButton;
    ButtT1: TButton;
    ButtE2: TButton;
    Button4: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Label17: TLabel;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    CheckBox17: TCheckBox;
    procedure PrintClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GeoChart1Zoom(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    {procedure Clb1Click(Sender: TObject);}
    {procedure CheckBox2Click(Sender: TObject);}
    procedure BFileClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ColorButton1Change(Sender: TObject);
    procedure GeoChart1AfterDraw(Sender: TObject);
    procedure Color95Button1Click(Sender: TObject);
    procedure GeoChart1ClickLegend(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ButtAXClick(Sender: TObject);
    procedure ButtE2Click(Sender: TObject);
    procedure BAXClick(Sender: TObject);
    procedure BHXClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    {procedure GeoChart1ClickAxis(Sender: TCustomChart; Axis: TChartAxis;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);}
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    {procedure GeoChart1GetNextAxisLabel(Sender: TChartAxis;
      LabelIndex: Integer; var LabelValue: Double; var Stop: Boolean);}
    procedure Label1Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox4DblClick(Sender: TObject);
    procedure SCopyClick(Sender: TObject);
    procedure GeoChart1ClickPoint(Sender: TObject; SerIndex: Integer;
      Point: TCPoint; Button: TMouseButton);
    procedure ListBox5Click(Sender: TObject);
    procedure ListBox6DblClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure GeoChart1AfterInterPaint(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure AExcExpExecute(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure GeoChart1SetTrio(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ARefreshExecute(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure GeoChart1SetDataPoint(Sender: TObject; SerIndex: Integer;
      DSet: TDataSet; Point: TCPoint);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Butt4Click(Sender: TObject);
    procedure BtAYClick(Sender: TObject);
    procedure BAYClick(Sender: TObject);
    procedure MendTabl1TypeAnaliseClick(Ind: Integer);
    procedure MendTabl2TypeAnaliseClick(Ind: Integer);
    procedure MendTabl3TypeAnaliseClick(Ind: Integer);
    procedure Button3Click(Sender: TObject);
    procedure ButtT1Click(Sender: TObject);
    procedure BHYClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
  private
    { Private declarations }
    fStandart: boolean;
    procedure SetTrio(const Value: boolean);
  public
    { Public declarations }
    SQLs: TList;
    NewGraph: boolean;
    FTrio: boolean;
    DSources: TList;
    NGraphs: Integer;
    TitX: string;
    TitY: string;
    TitZ: string;
    LogX: Boolean;
    LogY: Boolean;
    MustCalc, MustR, MustTrend: array[1..MaxGraph] of boolean;
    Kr: array[1..MaxGraph] of string[10];
  {MTr, NPoints: array[1..NGraphs] of integer;}
    SerStyle: array[1..MaxGraph] of TPenStyle;

    LastLabelValue: real;
    AWX, AWY, AWZ: boolean;
    AtX, AtY, AtZ: boolean;
    Pr100X, Pr100Y, Pr100Z: Boolean;
    MolsX, MolsY, MolsZ: Boolean;
    Diagr: TDiagram;
    CFontName: TFontName;
    CFontCharset: TFontCharset;
    startLabelLog: integer;
    XTitul: string;
    YTitul: string;
    ZTitul: string;
    XAlgo: Boolean;
    YAlgo: Boolean;
    ZAlgo: Boolean;
    XAlgID: integer;
    YAlgID: integer;
    ZAlgID: integer;
    XVarID: integer;
    YVarID: integer;
    ZVarID: integer;
    ClassForm: TClassForm;
    WasClass: Boolean;
    Alfa: Integer;
    {procedure SetMarks(Sender: TChartSeries; ValueIndex: Longint;
      var MarkText: string);}
    {procedure Trend;}
    procedure DoAxes(Xf, Yf, Zf: string);
    procedure SetStandart(S: boolean);
    property Standart: boolean read fStandart write SetStandart;
    property Trio: boolean read FTrio write SetTrio;
    procedure LoadProgram(RecID: integer; Progr: TJvInterpreterProgram);
  end;

var
  TrioForm: TTrioForm;
  {Names: array[1..NGraphs] of TStringList;}
  StAx, StForm: TStringList;



resourcestring
  stCorrel = 'Correlation ';
  stCoef = 'coefficients ';
  stOut = 'Out of any fields';
  stOutInt = 'Out of any intervals';
  stNotSID = 'Can not move items with undefined Sample ID';
  stNotMols = ' is not in standart set for calculation of molecular %.';
  stAnWater = ' without water';
  stDelPoin = 'Delete selected point from diagram?';
  stDelP = 'Point removing';
  stNotPoly = 'There are no series with polynom approximation on the diagram. Change diagram properties';
  stRegress = 'Equations of polinomial regression.';
function MakeAxisSQl(s1: string; var Sq, Sg, SqAs, SAx: string; Mols, AnW, pr100: boolean; ANum: integer = 0): boolean;


implementation

uses AnData, Main, wait, ExcelExp, ListBrows, DebuS, ChangeClass, Options,
  Storage, Recalc, Regres;



{$R *.DFM}

procedure TTrioForm.PrintClick(Sender: TObject);
begin
  GeoChart1.Print;
end;

procedure TTrioForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
  MendTab.AlfaN := Alfa;
end;

{procedure TTrioForm.SetMarks(Sender: TChartSeries; ValueIndex: Longint;
  var MarkText: string);
var
  i: integer;
begin
  if (Sender = GeoChart1.Series[0]) then i := 1
  else i := 2;
  MarkText := IntToStr(Names[i].IndexOf(GeoChart1.Series[3 * (i - 1) + 2].
    XLabel[ValueIndex]) + 1);
end;  }


procedure TTrioForm.FormCreate(Sender: TObject);
var
  i, j, n, sn: integer;
  Reg: TRegistry;
  F: TextFile;
  FF: file;
  S: string;
  Dg: boolean;
begin
  NGraphs := 0;
  SQLs := TList.Create;
  ClassForm := nil;
  DSources := TList.Create;
  for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
    if QueryRolls.QueryChLBox.Checked[i] then begin
      DM1.q1Time.SQL.Assign(TADOQuery(LQueries[i]).SQL);
      DM1.q1Time.Open;
      Alfa := DM1.q1Time.FieldByName('Alfa').AsInteger;
      MendTab.AlfaN := Alfa;
      DM1.q1Time.Close;
      Break;
    end;
  if not MustDiag then begin
    for i := 0 to 2 do
      if CurTrio then
        StrAx.Strings.Add(ConfigDlg.StrAx.Strings[i])
      else
        StrAx.Strings.Add(ConfigDlg.StrAx2.Strings[i]);

    for i := 0 to 2 do
      if CurTrio then
        StrTit.Strings.Add(ConfigDlg.StrTit.Strings[i])
      else
        StrTit.Strings.Add(ConfigDlg.StrTit2.Strings[i]);

  end else begin
    if (Alfa <> CurDiag.AlphaN) and (CurDiag.AlphaN >= 0) then begin
      ShowMessage('Alpabets of diagram an dataset is not equal!');
      Abort;
    end;
    for i := 0 to 2 do
      if CurDiag.Trio then
        StrAx.Strings.Add(ConfigDlg.StrAx.Strings[i])
      else
        StrAx.Strings.Add(ConfigDlg.StrAx2.Strings[i]);

    for i := 0 to 2 do
      if CurDiag.Trio then
        StrTit.Strings.Add(ConfigDlg.StrTit.Strings[i])
      else
        StrTit.Strings.Add(ConfigDlg.StrTit2.Strings[i]);
  end;
  Label17.Caption := 'Alphabet #' + IntToStr(Alfa);
  Application.ProcessMessages;
  try
    GeoChart1.BeginUpdate;
    GeoChart1.Series.Clear;
    if not MustDiag then begin
      LogX := CurLogoX;
      LogY := CurLogoY;
      Trio := CurTrio;
      StrH1.Strings.Clear;
      GeoChart1.Trio := Trio;
    end;
    if Trio then
      for i := 0 to ConfigDlg.SQL0.Strings.Count - 1 do
        StrH1.Strings.Add(ConfigDlg.SQL0.Strings[i])
    else
      for i := 0 to ConfigDlg.SQL2.Strings.Count - 1 do
        StrH1.Strings.Add(ConfigDlg.SQL2.Strings[i]);



       { DebugSql.Memo1.Lines.Assign(StrH1.Strings);
        DebugSql.ShowModal; }

    for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
      if QueryRolls.QueryChLBox.Checked[i] then begin
        SQLs.Add(TAdoQuery.Create(Self));
        TAdoQuery(Sqls[NGraphs]).Tag := NGraphs + 1;
        TAdoQuery(Sqls[NGraphs]).Connection := DM1.ADOConnection1;
        for j := 0 to StrH1.Strings.Count - 1 do
          TAdoQuery(Sqls[NGraphs]).SQL.Add(StrH1.Strings[j]);
        if TAdoQuery(LQueries[i]).SQL.Count > 1 then begin
          if TAdoQuery(LQueries[i]).SQL.Count > 2 then
            TAdoQuery(Sqls[NGraphs]).SQL.Add('AND(');
          for j := 1 to TAdoQuery(LQueries[i]).SQL.Count - 1 do
            TAdoQuery(Sqls[NGraphs]).SQL.Add(TAdoQuery(LQueries[i]).SQL[j]);
        end;
        DSources.Add(TDataSource.Create(Self));
        TDataSource(DSources[NGraphs]).DataSet := TAdoQuery(Sqls[NGraphs]);
        GeoChart1.Series.Add;
        {GeoChart1.Series[NGraphs].Active := false;}
        GeoChart1.Series[NGraphs].Name := QueryRolls.QueryChLBox.Items[i];
        GeoChart1.Series[NGraphs].DataSource := TDataSource(DSources[NGraphs]);
        GeoChart1.Series[NGraphs].XFieldName := 'Fx';
        GeoChart1.Series[NGraphs].YFieldName := 'Fy';
        GeoChart1.Series[NGraphs].ZFieldName := 'Fz';
        if (SID in UsedFields) then
          GeoChart1.Series[NGraphs].Label1FieldName := 'Sample'
        else
          GeoChart1.Series[NGraphs].Label1FieldName := 'Descript';
        GeoChart1.Series[NGraphs].Label2FieldName := 'Num';
        GeoChart1.Series[NGraphs].DataAware := True;
        GeoChart1.Series[NGraphs].MarkType := TGMark(NGraphs mod 6 + 1);
        if not MustDiag then begin
          GeoChart1.Series[NGraphs].LogorX := CurLogoX;
          GeoChart1.Series[NGraphs].LogorY := CurLogoY;


        {DebugSql.Memo1.Lines.Assign(TAdoQuery(Sqls[NGraphs]).SQL);
        DebugSql.ShowModal;}

        {TAdoQuery(SQLS[NGraphs]).Prepare;}
          TAdoQuery(SQLS[NGraphs]).Open;

        end;
        GeoChart1.Series[NGraphs].Active := True;
        Inc(NGraphs);
      end;


    ListBox1.Items.Assign(StAx);
    ListBox2.Items.Assign(StAx);
    ListBox5.Items.Assign(StAx);

    for i := 1 to NGraphs do begin
      MustR[i] := True;
    end;
    if MustDiag then begin
      Diagr := CurDiag;
       {if Diagr.Trio and (Diagr.Lines.Count=0) then begin
          Diagr.Lines.Add(TLine.Create(TOPoint.Create(0,50),TOPoint.Create(50,0)))
       end; }
      NewGraph := false;
      Standart := true;
    end else begin
      NewGraph := true;
      Standart := False;
    end;
  {Reg := TRegistry.Create;
  Reg.OpenKey('Software', true);
  Reg.OPenKey('RHA', True);
  if Reg.ValueExists('QuCount') then begin
    CFontName := GeoChart1.Legend.Font.Name;
    CFontCharSet := GeoChart1.Legend.Font.Charset;
    CFontName := Reg.ReadString('LFontName');
    CFontCharSet := Reg.ReadInteger('LFontCharSet');
    GeoChart1.Legend.Font.Name := CFontName;
    GeoChart1.Legend.Font.Charset := CFontCharSet;
    Dg := Reg.ReadBool('Standart');
    n := Reg.ReadInteger('QuCount');
    for i := 0 to ChBoxes.Count - 1 do
      TCheckBox(ChBoxes[i]).Enabled := false;
    if Dg then begin
      j := Reg.ReadInteger('Diagram');
      Diagr := TDiagram(Diagrams.Objects[j]);
      StDiaForm.HListBox2.ItemIndex:=J;
    end else begin
      TitX := Reg.ReadString('TitX');
      TitY := Reg.ReadString('TitY');
      TitZ := Reg.ReadString('TitZ');
      XTitul := Reg.ReadString('XTitul');
      YTitul := Reg.ReadString('YTitul');
      ZTitul := Reg.ReadString('ZTitul');
      Trio := Reg.ReadBool('Trio');
      GeoChart1.Legend.Font.Size := Reg.ReadInteger('LFontSize');
      GeoChart1.Norma := Reg.ReadFloat('Norma');
      GeoChart1.Title.Text := Reg.ReadString('Title');
      GeoChart1.Title.Visible := Reg.ReadBool('TitVis');
      GeoChart1.Title.Font.Name := Reg.ReadString('TFontName');
      GeoChart1.Title.Font.Charset := Reg.ReadInteger('TFontCharSet');
      GeoChart1.Title.Font.Size := Reg.ReadInteger('TFontSize');

    end;
    GeoChart1.Legend.InChart:=Reg.ReadBool('LegInCh');
  GeoChart1.Legend.Visible:=Reg.ReadBool('LegVis');
  GeoChart1.Legend.Frame:=Reg.ReadBool('LegFrame');
  GeoChart1.Legend.Transparent:=Reg.ReadBool('LegTran');
    AssignFile(F, 'SQLS.PET');
    try
      Reset(F);
      for i := 0 to n - 1 do begin
        ReadLn(F, j);
        if j = 1 then begin
          TCheckBox(ChBoxes[i]).Enabled := true;
        end else begin
          TCheckBox(ChBoxes[i]).Enabled := false;
        end;
        ReadLn(F, S);
        GeoChart1.Series[i].Name := S;
        ReadLn(F, Sn);

        TAdoQuery(SQLS[i]).Close;
        TAdoQuery(SQLS[i]).SQL.Clear;
        MustCalc[i + 1] := true;
        for j := 0 to Sn - 1 do begin
          ReadLn(F, S);
          TAdoQuery(SQLs[i]).SQL.Add(s);
        end;
        if TCheckBox(ChBoxes[i]).Enabled then begin
          TColor95Button(CLButtons[i]).Hint :=
            TAdoQuery(SQLs[i]).SQL[TAdoQuery(SQLs[i]).SQL.Count - 2];
          TAdoQuery(SQLS[i]).Prepare;
          TAdoQuery(SQLS[i]).Open;
        end else
          TColor95Button(CLButtons[i]).Hint := GroupBox2.Hint;
      end;
    finally
      CloseFile(F);
    end;
    AssignFile(FF, 'Graphs.cfg');
    try
      Reset(FF, 1);
      for i := 0 to GeoChart1.Series.Count - 1 do begin
        GeoChart1.Series[i].LoadProp(FF);
        TCheckBox(ChBoxes[i]).Checked :=  GeoChart1.Series[i].Active;
      end;
    finally
      CloseFile(FF);
    end;
    if Dg then Standart := true
    else Standart := false;
  end else begin
    Trio := GeoChart1.Trio;
    NewGraph := true;
  end;}
    if not Geochart1.Trio then
      Geochart1.LeftTitle.Direction := 90;
  finally
    GeoChart1.EndUpdate;
  end;
end;


procedure TTrioForm.GeoChart1Zoom(Sender: TObject);
begin
  Label1.Visible := false;
end;

procedure TTrioForm.FormShow(Sender: TObject);
var
  i: integer;
  S: string;
  Dg: boolean;
begin
  Label1.Visible := false;
  {CheckBox1.Enabled := True;}
  if NewGraph then begin
    {Standart := false;}
    GeoChart1.Series[0].Active := true;
    for i := 0 to GeoChart1.Axises.Count - 1 do begin
      GeoChart1.Axises[i].Logarithmic := false;
      if Trio then
        GeoChart1.Axises[i].Automatic := false
      else GeoChart1.Axises[i].Automatic := true;
    end;

    MustCalc[1] := true;
   { for i := 1 to GeoChart1.Series.Count - 1 do
      GeoChart1.Series[i].Active := false; }
    TitX := StrAx.Strings[0];
    TitY := StrAx.Strings[1];
    TitZ := StrAx.Strings[2];

    XTitul := StrTit.Strings[0];
    YTitul := StrTit.Strings[1];
    ZTitul := StrTit.Strings[2];
    AWX := CurAWx;
    AWY := CurAWY;
    AWZ := CurAWZ;
    Pr100X := CurPr100X;
    Pr100Y := CurPr100Y;
    Pr100Z := CurPr100Z;
  end;
  if not Standart then begin
    if XTitul = '' then
      GeoChart1.Axises[0].Title := TitX
    else
      GeoChart1.Axises[0].Title := XTitul;
    if YTitul = '' then
      GeoChart1.Axises[1].Title := TitY
    else
      GeoChart1.Axises[1].Title := YTitul;
    if Geochart1.Trio then
      if ZTitul = '' then
        GeoChart1.Axises[2].Title := TitZ
      else
        GeoChart1.Axises[2].Title := ZTitul;
  end;
   CheckBox17.Visible:=Trio and Standart;
  MendTabl1.Text := Titx;
  MendTabl2.Text := TitY;
  MendTabl3.Text := TitZ;
  NewGraph := false;
  FormResize(Sender);
end;


procedure TTrioForm.Button1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to GeoChart1.Axises.Count - 1 do
    GEoChart1.Axises[i].Automatic := true;
  Label1.Visible := false;
end;

procedure TTrioForm.Button2Click(Sender: TObject);
var
  i: integer;
  Mi, Ma: Double;
begin
  {if not Standart then}
  for i := 0 to GeoChart1.Axises.Count - 1 do begin
    GeoChart1.Axises[i].Automatic := False;
    if GeoChart1.Trio and not Standart then
      Geochart1.Axises[i].Minimum := 0;
  end;
  if Standart then begin
    Mi := Diagr.XAx.min;
    Ma := Diagr.XAx.max;
    GeoChart1.Axises[0].SetMinMax(Mi, Ma);
    Mi := Diagr.YAx.min;
    Ma := Diagr.YAx.max;
    GeoChart1.Axises[1].SetMinMax(Mi, Ma);
    if Diagr.Trio then begin
      Mi := Diagr.ZAx.min;
      Ma := Diagr.ZAx.max;
      GeoChart1.Axises[2].SetMinMax(Mi, Ma);
    end;
  {CheckBox1Click(Sender);}
    Label1.Visible := false;
  end;
end;

procedure TTrioForm.SpeedButton3Click(Sender: TObject);
begin
  GeoChart1.Axises[1].Automatic := False;
  GeoChart1.Axises[0].Automatic := False;
  GeoChart1.Axises[1].Maximum := Diagr.YAx.Max;
  GeoChart1.Axises[1].Minimum := (Diagr.YAx.Min + Diagr.YAx.Max) / 2;
  GeoChart1.Axises[0].Minimum := Diagr.XAx.Min;
  GeoChart1.Axises[0].Maximum := (Diagr.XAx.Max + Diagr.XAx.Min) / 2;
  {CheckBox1Click(Sender);}
  Label1.Visible := false;
end;

procedure TTrioForm.SpeedButton4Click(Sender: TObject);
begin
  GeoChart1.Axises[1].Automatic := False;
  GeoChart1.Axises[0].Automatic := False;
  GeoChart1.Axises[1].Maximum := Diagr.YAx.Max;
  GeoChart1.Axises[1].Minimum := (Diagr.YAx.Min + Diagr.YAx.Max) / 2;
  GeoChart1.Axises[0].Maximum := Diagr.XAx.Max;
  GeoChart1.Axises[0].Minimum := (Diagr.XAx.Max + Diagr.XAx.Min) / 2;
  {CheckBox1Click(Sender);}
  Label1.Visible := false;
end;

procedure TTrioForm.SpeedButton5Click(Sender: TObject);
begin
  GeoChart1.Axises[1].Automatic := False;
  GeoChart1.Axises[0].Automatic := False;
  GeoChart1.Axises[1].Minimum := Diagr.YAx.Min;
  GeoChart1.Axises[1].Maximum := (Diagr.YAx.Min + Diagr.YAx.Max) / 2;
  GeoChart1.Axises[0].Minimum := Diagr.XAx.Min;
  GeoChart1.Axises[0].Maximum := (Diagr.XAx.Max + Diagr.XAx.Min) / 2;
  {CheckBox1Click(Sender);}
  Label1.Visible := false;
end;

procedure TTrioForm.SpeedButton6Click(Sender: TObject);
begin
  GeoChart1.Axises[1].Automatic := False;
  GeoChart1.Axises[0].Automatic := False;
  GeoChart1.Axises[1].Minimum := Diagr.YAx.Min;
  GeoChart1.Axises[1].Maximum := (Diagr.YAx.Min + Diagr.YAx.Max) / 2;
  GeoChart1.Axises[0].Maximum := Diagr.XAx.Max;
  GeoChart1.Axises[0].Minimum := (Diagr.XAx.Max + Diagr.XAx.Min) / 2;
  {CheckBox1Click(Sender);}
  Label1.Visible := false;
end;


(*procedure TTrioForm.Clb1Click(Sender: TObject);
var
  i, j: integer;
  Qu: TAdoQuery;
begin
  if (TrioSQLForm.Showmodal = mrOK) or (TrioSQLForm.ModalResult = mrOK) then begin
    i := TColor95Button(Sender).Tag;
    TColor95Button(Sender).Hint :=
      TrioSQLForm.Memo1.Lines[TrioSQLForm.Memo1.Lines.Count - 4];
    {CheckBox1.Checked := false;
    CheckBox1Click(Sender);
    CheckBox1.Enabled := false; }
    TAdoQuery(SQLS[i - 1]).Close;
    TAdoQuery(SQLS[i - 1]).SQL.Clear;
    TAdoQuery(SQLS[i - 1]).Sql.Assign(TrioSQLForm.Memo1.Lines);
    TAdoQuery(SQLS[i - 1]).Prepare;
    TAdoQuery(SQLS[i - 1]).Open;
    TCheckBox(ChBoxes[i - 1]).Checked := True;
    TCheckBox(ChBoxes[i - 1]).Enabled := True;
   { GeoChart1.Series[(i - 1)].DataSource := TAdoQuery(SQLS[i - 1]);
    GeoChart1.Series[(i - 1) * 3 + 2].DataSource := TAdoQuery(SQLS[i - 1]);}
    MustCalc[i] := true;
    Label1.Visible := false;
    GeoChart1.Series[(i - 1)].Active := true;
    {if GeoChart1.LeftAxis.Logarithmic or GeoChart1.BottomAxis.Logarithmic then
      SetAxisMin(TChart(GeoChart1)); }
{    Button1Click(Sender);}
    Caption := 'Запрос';
    GeoChart1.Series[(i - 1)].Name := TrioSQLForm.Edit1.Text;
  end;
end;

procedure TTrioForm.CheckBox2Click(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then begin
    GeoChart1.Series[(TCheckBox(Sender).Tag - 1)].Active := true;
  end else begin
    GeoChart1.Series[(TCheckBox(Sender).Tag - 1)].Active := false;
  end;
  {if not Standart and
    (GeoChart1.LeftAxis.Logarithmic or GeoChart1.BottomAxis.Logarithmic) then
    SetAxisMin(TChart(GeoChart1)); }
end;  *)

procedure TTrioForm.BFileClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    GeoChart1.SaveToEMF(SaveDialog1.FileName);
end;




procedure TTrioForm.SpeedButton1Click(Sender: TObject);
begin
  CurHelpContext := 77;
  GeoChart1.EditProperties;
  if GeoChart1.Trio then RadioGroup1.ItemIndex := 1
  else RadioGroup1.ItemIndex := 0;
  CurHelpContext := HelpContext;
end;



procedure TTrioForm.ColorButton1Change(Sender: TObject);
var
  i, k, j: integer;
  Corr: boolean;
begin
  (*i := TColor95Button(Sender).Tag;
  Corr := MustR[i];
  SerOptionForm.CheckBox1.Checked := Corr;
  SerOptionForm.CheckBox2.Checked := MustTrend[i];
  SerOptionform.ColorButton1.Color := GeoChart1.Series[(i - 1)].Color;
  SerOptionform.ColorButton2.Color :=GeoChart1.Series[(i - 1)].PenColor;
  SerOptionform.SpinEdit1.Value :=GeoChart1.Series[(i - 1)].MarkWidth;
  SerOptionform.SpinEdit2.Value := GeoChart1.Series[(i - 1)].MarkHeight;
  SerOptionForm.ListBox1.ItemIndex :=
    Integer(GeoChart1.Series[(i - 1)].MarkType);
  SerOptionform.ColorButton3.Color :=GeoChart1.Series[(i - 1)].Color;
  SerOptionForm.ListBox2.ItemIndex :=
    Integer(GeoChart1.Series[(i - 1)].LineStyle);
  SerOptionform.SpinEdit3.Value :=
    GeoChart1.Series[(i - 1)].LineWidth;
  SerOptionform.SpinEdit4.Value := GeoChart.Series[i-1].Power;
  {SerOptionform.SpinEdit5.Value := NPoints[i];}
  SerOptionform.Edit1.Text := GeoChart1.Series[(i - 1)].Name;
  SerOptionForm.ShowModal;
  {NPoints[i] := SerOptionform.SpinEdit5.Value;}}
  GeoChart.Series[i-1].Power := SerOptionForm.SpinEdit4.Value;
  GeoChart1.Series[(i - 1)].Color :=
    SerOptionform.ColorButton3.Color;
  GeoChart1.Series[(i - 1)].LineStyle:=
    TLineSeries(SerOptionform.Chart2.Series[0]).LinePen.Style;
  GeoChart1.Series[(i - 1) ].LineWidth := SerOptionform.SpinEdit3.Value;
  for k := 1 to NGraphs do MustCalc[k] := true;
  if GeoChart1.Series[(i - 1)].Name <> SerOptionform.Edit1.Text then begin
     {If Standart and (Diagr.Count>0) then
     With ClassForm do
        for j:=0 to RootN.Count-1 do
           for k:=0 to RootN.Item[j].Count-1 do
                     if RootN.Item[j].Item[k].Text=
                     GeoChart1.Series[(i-1)*3].Title then begin
                       RootN.Item[j].Item[k].Text:= SerOptionform.Edit1.Text;
                       break;
                     end; }
    GeoChart1.Series[(i - 1)].Name := SerOptionform.Edit1.Text;

  end;
  {if SerOptionForm.CheckBox2.Checked then begin
    MustTrend[i] := true;
    Trend;
  end else begin
    GeoChart1.Series[(i - 1) * 3 + 1].Active := false;
    MustTrend[i] := false;
  end; }
  MustR[i] := SerOptionForm.CheckBox1.Checked;
  if Corr <> SerOptionForm.CheckBox1.Checked then begin
         {MustCalc[i]:=true;  }
    GeoChart1.Repaint;
  end;
  TColor95Button(Sender).Color := SerOptionform.ColorButton1.Color;
  GeoChart1.Series[(i - 1)].Color :=
    TColor95Button(Sender).Color;
  TPointSeries(GeoChart1.Series[(i - 1) * 3]).Pointer.Pen.Color :=
  SerOptionform.ColorButton2.Color;
  TPointSeries(GeoChart1.Series[(i - 1) * 3]).Pointer.HorizSize :=
  SerOptionform.SpinEdit1.Value;
  TPointSeries(GeoChart1.Series[(i - 1) * 3]).Pointer.VertSize :=
  SerOptionform.SpinEdit2.Value;
  TPointSeries(GeoChart1.Series[(i - 1) * 3]).Pointer.Style :=
  TSeriesPointerStyle(SerOptionForm.ListBox1.ItemIndex);
  TColor95Button(ClButtons[i - 1]).Color := TColor95Button(Sender).Color;*)
end;

procedure TTrioForm.GeoChart1AfterDraw(Sender: TObject);
var
  YPos, Delt, i, j: integer;
  T: TPoint;
  {CRect: TRect;}
  S: string;
  r: double;
  KRPresent: boolean;
  {function CalcR(Num: integer): double;
  var
    Dx, Dy, rx, ry, S, Mx, My: double;
    i: integer;
  begin
    Result := 0;
    if GeoChart1.Series[(Num - 1)].Count > 1 then begin
      Dx := 0;
      Dy := 0;
      S := 0;
      Mx := GeoChart1.Series[(Num - 1)].XSum /
        GeoChart1.Series[(Num - 1)].Count;
      My := GeoChart1.Series[(Num - 1)].YSum /
        GeoChart1.Series[(Num - 1)].Count;
      for i := 0 to GeoChart1.Series[(Num - 1)].Count - 1 do begin
        rx := (GeoChart1.Series[(Num - 1)].Items[i].Value.X - Mx);
        rY := GeoChart1.Series[(Num - 1)].Items[i].Value.Y - My;
        Dx := Dx + Sqr(Rx);
        Dy := Dy + Sqr(Ry);
        S := s + Rx * Ry;
      end;
      if Dx * DY > 1E-30 then
        result := S / (SQRT(Dx * Dy));

      MustCalc[Num] := false;
    end;
  end; }

begin
  {if not Assigned(ChBoxes) then exit;}
  Label1.Repaint;
  if CheckBox16.Checked then
    for j := 0 to Geochart1.Series.Count - 1 do
      if GeoChart1.Series[j].Active then
        for i := 0 to GeoChart1.Series[j].Count - 1 do begin
          T := GeoChart1.ChartToScreen(GeoChart1.Series[j].Items[i].Value);
          if GeoChart1.PointInChart(T.X, T.Y) then begin
            GeoChart1.Canvas.Font.Assign(GeoChart1.Legend.Font);
            GeoChart1.Canvas.Font.Style := [];
            GeoChart1.Canvas.Font.Height := 14;
            GeoChart1.Canvas.TextOut(T.X - 8, T.y - 17, GeoChart1.Series[j].Items[i].Label2);
          end;
        end;
  if GeoChart1.Trio or not CheckBox8.Checked then exit;

  GeoChart1.Canvas.Font.Assign(GeoChart1.Legend.Font);
  GeoChart1.Canvas.Font.Style := [fsBold];
  GeoChart1.Canvas.Font.Height := 16;
  YPos := 36;
  Delt := 16;
  S := '-1.00';
  KRPresent := false;
  for i := 1 to GeoChart1.Series.Count do
    if GeoChart1.Series[i - 1].Active then begin
      {if MustR[i] then begin }
      if GeoChart1.Series[i - 1].Count > 1 then begin
        GeoChart1.Canvas.Font.Color := Geochart1.Series[i - 1].Color;
        if GeoChart1.Canvas.Font.Color = clWhite then
          GeoChart1.Canvas.Font.Color := clBlack;
        KRPresent := true;
        if (GeoChart1.Series[i - 1].X2Sum -
          Sqr(GeoChart1.Series[i - 1].XSum) / GeoChart1.Series[i - 1].Count > 1E-30) and
          (GeoChart1.Series[i - 1].Y2Sum -
          Sqr(GeoChart1.Series[i - 1].YSum) / GeoChart1.Series[i - 1].Count > 1E-30) then
          R := (GeoChart1.Series[i - 1].XYSum - GeoChart1.Series[i - 1].XSum *
            GeoChart1.Series[i - 1].YSum / GeoChart1.Series[i - 1].Count) / SQRt((GeoChart1.Series[i - 1].X2Sum -
            Sqr(GeoChart1.Series[i - 1].XSum) / GeoChart1.Series[i - 1].Count) * (GeoChart1.Series[i - 1].Y2Sum -
            Sqr(GeoChart1.Series[i - 1].YSum) / GeoChart1.Series[i - 1].Count))
        else
          R := 0;
        KR[i] := FloatToStrF(R, ffFixed, 4, 2);
        {if MustCalc[i] then
          KR[i] := FloatToStrF(CalcR(i), ffFixed, 4, 2);}
        GeoChart1.Canvas.TextOut(GeoChart1.Width -
          GeoChart1.Canvas.TextWidth(S) - 7, YPos, KR[i]);
        inc(YPos, Delt);
      end;
    end;
  GeoChart1.Canvas.Font.Color := clBlack;
  if KRPresent then begin
    GeoChart1.Canvas.Font.Height := 12;
    S := stCorrel;
    GeoChart1.Canvas.TextOut(GeoChart1.Width - GeoChart1.Canvas.TextWidth(S) - 3, 8,
      S);
    S := stCoef;
    GeoChart1.Canvas.TextOut(GeoChart1.Width - GeoChart1.Canvas.TextWidth(S) - 3, 22,
      S);
  end;
end;

procedure TTrioForm.Color95Button1Click(Sender: TObject);
begin
  {SerOptionForm.ShowModal;}
end;

(*procedure TTrioForm.Trend;
var
  i: integer;
  procedure TrendLine(Num: integer);
  var
    A: Vectsys;
    M, i, j, k, n: integer;
    Good: boolean;
    c, x, y, X0, xS: real;
    b: matsys;
  begin
    m := MTr[Num];
    n := GeoChart1.Series[(Num - 1) * 3].XValues.Count;
    for i := 0 to m do begin
      c := 0;
      for k := 0 to n - 1 do
        c := c + GeoChart1.Series[(Num - 1) * 3].YValue[k] *
          stepen(GeoChart1.Series[(Num - 1) * 3].XValue[k], i);
      b[i, m + 1] := c;
      for j := i to m do begin
        c := 0;
        for k := 0 to n - 1 do
          c := c + stepen(GeoChart1.Series[(Num - 1) * 3].XValue[k], (i + j));
        b[i, j] := c;
        b[j, i] := c;
      end;
    end;
    gauss(b, a, m + 1, Good);
    if Good then begin
      X0 := GeoChart1.Series[(Num - 1) * 3].XValues.MinValue;
      Xs := (GeoChart1.Series[(Num - 1) * 3].XValues.MaxValue -
        GeoChart1.Series[(Num - 1) * 3].XValues.MinValue) / NPoints[Num];
      GeoChart1.Series[(Num - 1) * 3 + 1].Clear;
      for i := 0 to NPoints[Num] do begin
        x := X0 + i * Xs;
        y := 0;
        for j := 0 to m do
          y := y + a[j] * Stepen(x, j);
          {y:=Poly(x,Slice(A,m+1));}
        GeoChart1.Series[(Num - 1) * 3 + 1].AddXY(X, Y, '', clTeeColor);
      end;
      GeoChart1.Series[(Num - 1) * 3 + 1].Active := true;
      TLineSeries(GeoChart1.Series[(Num - 1) * 3 + 1]).LinePen.Style := SerStyle[Num];
    end else begin
      ShowMessage('Не удается аппроксимировать выборку ' + IntToStr(Num) +
        ' полиномом степени ' + intToStr(m));
      GeoChart1.Series[(Num - 1) * 3 + 1].Active := false;
    end;
  end;
begin
  for i := 0 to Ngraphs - 1 do
    if TCheckBox(ChBoxes[i]).Checked then
      if MustCalc[i + 1] then
        if MustTrend[i + 1] then TrendLine(i + 1);
end;*)


procedure TTrioForm.GeoChart1ClickLegend(Sender: TObject);
begin
  SpeedButton1Click(Sender);
end;

procedure TTrioForm.BitBtn5Click(Sender: TObject);
var i: integer;
begin
  Panel1.Visible := false;
  Panel1.Enabled := false;
  XAlgo := False;
  YAlgo := False;
  ZAlgo := False;
  Application.ProcessMessages;
  if Awx <> CheckBox11.Checked then begin
    AWX := CheckBox11.Checked;
    TitX := '*';
  end;
  if AWY <> CheckBox10.Checked then begin
    AWY := CheckBox10.Checked;
    TitY := '*';
  end;
  if AWZ <> CheckBox12.Checked then begin
    AWZ := CheckBox12.Checked;
    TitZ := '*';
  end;
  if Pr100X <> CheckBox4.Checked then begin
    Pr100X := CheckBox4.Checked;
    TitX := '*';
  end;
  if Pr100Y <> CheckBox15.Checked then begin
    Pr100Y := CheckBox15.Checked;
    TitY := '*';
  end;
  if Pr100Z <> CheckBox5.Checked then begin
    Pr100Z := CheckBox5.Checked;
    TitZ := '*';
  end;
  if MolsX <> CheckBox7.Checked then begin
    MolsX := CheckBox7.Checked;
    TitX := '*';
  end;
  if MolsY <> CheckBox13.Checked then begin
    MolsY := CheckBox13.Checked;
    TitY := '*';
  end;
  if MolsZ <> CheckBox14.Checked then begin
    MolsZ := CheckBox14.Checked;
    TitZ := '*';
  end;
  if Geochart1.Series.Count > 0 then
    for i := 0 to Geochart1.Series.Count - 1 do begin
      Geochart1.Series[i].LogorX := CheckBox2.Checked;
      Geochart1.Series[i].LogorY := CheckBox3.Checked;
    end;
  if LogX <> CheckBox2.Checked then begin
    CurLogoX := CheckBox2.Checked;
    LogX := CurLogoX;
    StrTit.Strings[0] := Edit1.Text;
    if Trio then
      ConfigDlg.StrTit.Strings[0] := StrTit.Strings[0]
    else
      ConfigDlg.StrTit2.Strings[0] := StrTit.Strings[0];
  end;
  if LogY <> CheckBox3.Checked then begin
    CurLogoY := CheckBox3.Checked;
    LogY := CurLogoY;
    StrTit.Strings[1] := Edit2.Text;
    if Trio then
      ConfigDlg.StrTit.Strings[1] := StrTit.Strings[1]
    else
      ConfigDlg.StrTit2.Strings[1] := StrTit.Strings[1];
  end;
  if not GeoChart1.Trio then begin
    Geochart1.Axises[0].Logarithmic := CheckBox1.Checked;
    Geochart1.Axises[1].Logarithmic := CheckBox9.Checked;
  end;
  XTitul := Edit1.Text;
  YTitul := Edit2.Text;
  ZTitul := Edit3.Text;
  Standart := false;
  DoAxes(MendTabl1.Text, MendTabl2.Text, MendTabl3.Text);
  {Standart := false;}
end;

function MakeAxisSQl(s1: string; var Sq, Sg, SqAs, SAx: string; Mols, AnW, Pr100: boolean; ANum: integer = 0)
  : boolean;
var
  S, Sim: string;
  n, i, OpenS: integer;
  A: Char;
  Os, Cs, Op, Al, Ab, Ox, MulDiv, Err, Num, VesP: boolean;
  Was: array[-11..100] of boolean;
  {92 элемента; 94,93 - Fe; -10(95) -En; -9 - E; -8(96) -An; -7(103) - A ненормированная;
  -6 T; -5(97) - Ox; -4(98) - AW; -3(99) - AWA;-2(100) - Summa;
  -1(101) - MolFact,0(102) - MolFactAW, -11 - Tn }

  procedure Sbros;
  begin
    Os := false;
    Cs := false;
    Op := false;
    Al := false;
    Ab := false;
    Num := false;
    Ox := false;
  end;
  function SetSim: boolean;
  var
    FldName, Factor: string;
  begin
    Result := True;
    if Sim[Length(Sim)] = '$' then begin
      Sim := StripTChStr(Sim, '$');
      n := MendTab.GetNumber(Sim);
      if AnW and (n = 1) then begin
        ShowMessage(stHforAw);
        Abort;
      end;
      if n > 0 then
        FldName := 'rhadata.A' + IntToStr(n) + ''
      else begin
        result := false;
        exit;
      end;
      if AnW then begin
        if Was[-4] then begin
          Sq := Sq + ', rhadata.AW ';
          Was[-4] := false;
        end;
      end else begin
        if Was[-5] then begin
          Sq := Sq + ', rhadata.Ox ';
          Was[-5] := false;
        end;
        if not pr100 then
          if Was[-2] then begin
            Sq := Sq + ', rhadata.Summa ';
            Was[-2] := false;
          end;
      end;
      if pr100 or AnW then
        Factor := FloatToStrF(MendTab.GetPetroVes(n), ffFixed, 6, 2)
      else
        Factor := FloatToStrF(MendTab.GetPetroVes(n) / 100, ffFixed, 6, 4);
      if AnW then
        Sqas := SqAs + '(' + Factor + '*' + FldName + '/rhadata.AW)'
      else begin
        if pr100 then
          Sqas := SqAs + '(' + Factor + '*' + FldName + '/rhadata.Ox)'
        else
          Sqas := SqAs + '(' + Factor + '*' + FldName + '*rhadata.Summa/rhadata.Ox)';
      end;
      if was[n] then begin
        Sq := Sq + ', ' + FldName + ' ';
        if (FldName <> 'rhadata.A') and (FldName <> 'rhadata.An') then begin
          if Sg = '' then
            Sg := '(' + FldName + '>0)'
          else Sg := Sg + 'AND(' + FldName + '>0)';
        end;
        Was[n] := false;
      end;
      VesP := true;
      Result := true;
      Sax := Sax + MendTab.GetPetroSym(n);
      Sim := '';
      exit;
    end;

    if Sim = 'En' then begin
      if AnW then begin
        ShowMessage(stEnForAW);
        Abort;
      end;
      FldName := 'rhadata.E';
      Sqas := SqAs + '(' + FldName + ')';
      MulDiv := True;
      n := -10
    end else
      if Sim = 'E' then begin
        if AnW then begin
          ShowMessage(stEnForAW);
          Abort;
        end;
        FldName := 'rhadata.H';
        Sqas := SqAs + '(' + FldName + ')';
        MulDiv := True;
        n := -9
      end else
        if Sim = 'An' then begin
          if AnW then begin
            ShowMessage(stEnForAW);
            Abort;
          end;
          FldName := 'rhadata.An';
          Sqas := SqAs + '(' + FldName + ')';
          MulDiv := True;
          n := -8;
        end else
          if Sim = 'A' then begin
            if AnW then begin
              ShowMessage(stEnForAW);
              Abort;
            end;
            FldName := 'rhadata.A';
            Sqas := SqAs + '(' + FldName + ')';
            MulDiv := True;
            n := -7
          end else
            if Sim = 'T' then begin
              if AnW then begin
                ShowMessage(stEnForAW);
                Abort;
              end;
              FldName := 'rhadata.T';
              Sqas := SqAs + '(' + FldName + ')';
              MulDiv := True;
              n := -6
            end else
              if Sim = 'Tn' then begin
                if AnW then begin
                  ShowMessage(stEnForAW);
                  Abort;
                end;
                FldName := 'rhadata.Tn';
                Sqas := SqAs + '(' + FldName + ')';
                MulDiv := True;
                n := -11
              end else begin
                n := MendTab.GetNumber(Sim);
                if n < 1 then begin
                  ShowMessage('Error in axis''s code: '+Sim);
                  Abort;
                end;
                FldName := 'rhadata.A' + IntToStr(n) + '';
                if Mols and not MendTab.MustMol(N) then begin
                  ShowMessage(Sim + stNotMols);
                  Abort;
                end;
                if AnW then begin
                  if (n = 1) then begin
                    ShowMessage(stHforAw);
                    Abort;
                  end;
                  if Mols then begin
                    if Was[0] then begin
                      Sq := Sq + ', rhadata.MolFactAW ';
                      Was[0] := false;
                    end;
                    Sqas := SqAs + '(' + FldName + '*rhadata.MolFactAW/' +
                      IntToStr(MendTab.GetKatSteh(N)) + ')';
                  end else begin
                    if Was[-3] then begin
                      Sq := Sq + ', rhadata.AWA ';
                      Was[-3] := false;
                    end;
                    if n = 8 then
                      Sqas := SqAs + '((' + FldName + '-0.5*rhadata.A1)*rhadata.AWA)'
                    else
                      Sqas := SqAs + '(' + FldName + '*rhadata.AWA)';
                  end;
                end else
                  if Mols then begin
                    if Was[-1] then begin
                      Sq := Sq + ', rhadata.MolFact ';
                      Was[-1] := false;
                    end;
                    Sqas := SqAs + '(' + FldName + '*rhadata.MolFact/' +
                      IntToStr(MendTab.GetKatSteh(N)) + ')';
                  end else
                    Sqas := SqAs + '(' + FldName + ')';
              end;
    if was[n] then begin
      Sq := Sq + ', ' + FldName + ' ';
      if (FldName <> 'rhadata.A') and (FldName <> 'rhadata.An')and
      (FldName <> 'rhadata.T') and (FldName <> 'rhadata.Tn') then begin
        if Sg = '' then
          Sg := '(' + FldName + '>0)'
        else Sg := Sg + 'AND(' + FldName + '>0)';
      end;
      Was[n] := false;
    end;
    if Mols then
      SAx := SAx + MendTab.GetPetroSym(n)
    else
      Sax := Sax + Sim;
    Result := true;
    Sim := '';
    if SG = '' then
      sg := '2>1'
  end;

  function SetNum: boolean;
  begin
    if ValidNumString(Sim) then begin
      Sqas := SqAs + Sim;
      Sax := Sax + Sim;
      Result := true;
      Sim := '';
    end else
      result := false;
  end;

begin
  try
    MendTab.AlfaN := ANum;
    Result := true;
    Sq := '';
    Sg := '';
    SqAs := ',(';
    Sax := '';
    s := S1;
    for i := -11 to 100 do
      Was[i] := true;

    Sbros;
    MulDiv := false;
    VesP := False;
    Err := false;
    OPenS := 0;
    Sim := '';
    for i := 1 to Length(S) do begin
      a := S[i];
      case a of
        '1'..'9', '0', '.': if (Al or Ab or Cs or Ox) then Err := true
          else begin
            Sim := Sim + A;
            Sbros;
            Num := true;
          end;
        '(': if (Al or Ab or Cs or num or Ox) then Err := true
          else begin
            Inc(OpenS);
            SqAs := SqAs + A;
            Sax := Sax + A;
            Sbros;
            Os := true;
          end;
        ')': if (Os or Op) then err := true
          else begin
            Dec(OpenS);
            if Al or Ab or Ox then
              if not SetSim then Err := true;
            if num then if not SetNum then Err := true;
            Sbros;
            SqAs := SqAs + A;
            Sax := Sax + A;
            Cs := true;
          end;
        'A'..'Z': if (Al or Ab and (ANum = 0) or Cs or num or Ox) then Err := true
          else begin
            if (ANum = 0) then
              Sim := A
            else
              Sim := Sim + A;
            Sbros;
            Ab := true;
          end;
        'a'..'z', #134, #135: if (not Ab) and (not (Al and ((ANum > 0) or (a = #134) or (a = #135)))) then err := true
          else begin
            Sim := Sim + A;
            Sbros;
            Al := true;
          end;
        '$': if not (Ab or Al) then err := true
          else begin
            Sim := Sim + A;
            Sbros;
            Ox := true;
          end;
        '*', '/': if (Os or Op) then err := true
          else begin
            if Al or Ab or Ox then
              if not SetSim then Err := true;
            if num then if not SetNum then Err := true;
            Sbros;
            SqAs := SqAs + A;
            Sax := Sax + A;
            Op := true;
            MulDiv := True;
          end;
        '+', '-': if (Os or Op) then err := true
          else begin
            if Al or Ab or Ox then if not SetSim then Err := true;
            if num then if not SetNum then Err := true;
            Sbros;
            SqAs := SqAs + A;
            Sax := Sax + A;
            Op := true;
          end
        else Err := true;
      end;
      if OpenS < 0 then Err := true;
      if Err then begin
        ShowMessage(RHAGlobs.stFormErr + s1);
        Result := false;
        exit;
      end;
    end;
    if Al or Ab or Ox then
      if not SetSim then begin
        ShowMessage(RHAGlobs.stFormErr + s1);
        Result := false;
        exit;
      end;
    if num then
      if not SetNum then begin
        ShowMessage(RHAGlobs.stFormErr + s1);
        Result := false;
        exit;
      end;
    if Opens <> 0 then begin
      ShowMessage(RHAGlobs.stFormErr + s1);
      Result := false;
      exit;
    end;
    SqAs := SqAs + ')';
    if not MulDiv then begin
      if VesP then
        Sax := Sax + '(wt%)'
      else if Mols then
        Sax := Sax + '(mol%)'
      else
        Sax := Sax + '(at%)';
    end;
  except
    on EAbort do begin
      ShowMessage(RHAGlobs.stFormErr + s1);
      result := False;
    end;
  end;

end;

procedure TTrioForm.Button5Click(Sender: TObject);
begin
  CheckBox10.Checked := AWY;
  CheckBox11.Checked := AWX;
  CheckBox12.Checked := AWZ;
  CheckBox14.Checked := MolsZ;
  CheckBox13.Checked := MolsY;
  CheckBox7.Checked := MolsX;
  CheckBox7Click(Sender);
  CheckBox13Click(Sender);
  CheckBox14Click(Sender);
  if AWX or MolsX then
    CheckBox4.Checked := true
  else
    CheckBox4.Checked := Pr100X;
  if AWY or MolsY then
    CheckBox15.Checked := true
  else
    CheckBox15.Checked := Pr100Y;
  if AWZ or MolsZ then
    CheckBox5.Checked := true
  else
    CheckBox5.Checked := Pr100Z;
  CheckBox1.Checked := Geochart1.Axises[0].Logarithmic;
  if Geochart1.Series.Count > 0 then begin
    CheckBox2.Checked := Geochart1.Series[0].LogorX;
    CheckBox3.Checked := Geochart1.Series[0].LogorY;
  end;
  CheckBox9.Checked := Geochart1.Axises[1].Logarithmic;
  if GeoChart1.Trio then begin
    TabSheet3.TabVisible := true;
    CheckBox9.Visible := false;
    CheckBox1.Visible := false;
  end else begin
    TabSheet3.TabVisible := false;
    CheckBox9.Visible := true;
    CheckBox1.Visible := true;
  end;
  Panel1.Visible := true;
  Panel1.Enabled := true;
  if Standart then begin
    MendTabl1.Text := Diagr.Xax.Formula;
    MendTabl2.Text := Diagr.Yax.Formula;
    if GeoChart1.Trio then
      MendTabl3.Text := Diagr.Zax.Formula;
  end;
  ListBox3.Clear;
  ListBox4.Clear;
  ListBox6.Clear;
  ListBox3.Items.Assign(Coefs.IDs);
  ListBox4.Items.Assign(Coefs.IDs);
  ListBox6.Items.Assign(Coefs.IDs);
  MendTabl1.SelectAll;
  MendTabl2.SelectAll;
  MendTabl3.SelectAll;
  Edit1.Text := XTitul;
  Edit2.Text := YTitul;
  Edit3.Text := ZTitul;
end;

procedure TTrioForm.ButtAXClick(Sender: TObject);
begin
  MendTabl1.InsertText('A');
end;

procedure TTrioForm.ButtE2Click(Sender: TObject);
begin
  MendTabl2.InsertText('E');
end;

procedure TTrioForm.BAXClick(Sender: TObject);
begin
  MendTabl1.InsertText('An');
end;

procedure TTrioForm.BHXClick(Sender: TObject);
begin
  MendTabl1.InsertText('En');
end;

procedure TTrioForm.ListBox1Click(Sender: TObject);
begin
  MendTabl1.Text := StForm.Strings[ListBox1.ItemIndex];
  Edit1.Text := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TTrioForm.ListBox2Click(Sender: TObject);
begin
  MendTabl2.Text := StForm.Strings[ListBox2.ItemIndex];
  Edit2.Text := ListBox2.Items[ListBox2.ItemIndex];
end;

procedure TTrioForm.Button8Click(Sender: TObject);
var
  i: integer;
  S, F: string;
begin
  if Sender = Button8 then f := MendTabl2.text
  else if Sender = Button6 then f := MendTabl1.text
  else f := MendTabl3.text;
  s := inputBox('Стандартные переменные', 'Введите название переменной',
    f);
  StAx.Add(s);
  i := StAx.IndexOf(S);
  StForm.Insert(i, f);
  ListBox1.Items.Insert(i, s);
  ListBox2.Items.Insert(i, s);
  ListBox5.Items.Insert(i, s);
  StAx.SaveToFile('StAx.rhi');
  StForm.SaveToFile('StForm.rhi');
end;

procedure TTrioForm.Button9Click(Sender: TObject);
var
  i: integer;
begin
  if Sender = Button9 then i := ListBox2.ItemIndex
  else if Sender = Button7 then i := ListBox1.ItemIndex
  else i := ListBox5.ItemIndex;
  StAx.Delete(i);
  StForm.Delete(i);
  StAx.SaveToFile('StAx.rhi');
  StForm.SaveToFile('StForm.rhi');
  ListBox1.Items.Delete(i);
  ListBox2.Items.Delete(i);
  ListBox5.Items.Delete(i);
end;



{procedure TTrioForm.GeoChart1ClickAxis(Sender: TCustomChart;
  Axis: TChartAxis; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Button5Click(Sender);
end;  }

procedure TTrioForm.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to NGraphs - 2 do begin
    TAdoQuery(SQLs[i]).Close;
    {TAdoQuery(SQLs[i]).UnPrepare;}
    TAdoQuery(SQLs[i]).Free;
    TDataSource(Dsources[i]).Free;
  end;
  SQLs.Free;
  Dsources.Free;
  {for i := 1 to NGraphs do
    TStringList(Names[i]).Free;}
  if ClassForm <> nil then begin
    ClassForm.MustFree := True;
    ClassForm.Close;
  end;
end;

procedure TTrioForm.BitBtn6Click(Sender: TObject);
begin
  Panel1.Visible := false;
  Panel1.Enabled := false;
end;

procedure TTrioForm.Button10Click(Sender: TObject);
begin
  StDiaForm.ShowModal;
  if (StDiaForm.ModalResult = mrOK) and (STDiaForm.HListBox2.ItemIndex >= 0)
    then begin
    ClassForm.Free;
    ClassForm := nil;
    Radiogroup2.ItemIndex := 0;
    RadioGroup2.Visible := False;
    Diagr := TDiagram(Diagrams.Objects[STDiaForm.HListBox2.ItemIndex]);
    Standart := True;
  end;
end;

procedure TTrioForm.DoAxes(Xf, Yf, Zf: string);
var
  i: integer;
  s, Sq, Sg, SqAs, SAx: string;
  Chang, MustReopen: boolean;
begin
  try
    Label1.Visible := false;
    WForm.Show;
    GeoChart1.BeginUpdate;
    Chang := false;
    MustReopen := false;
    s := Xf;
    Application.ProcessMessages;
    if S[1] = '!' then begin
      XAlgo := True;
      MustReopen := True;
      if FRootStorage = nil then
        OpenDocFile;
      LoadProgram(XAlgID, XProgr);
      XProgr.Compile;
      GeoChart1.Axises[0].Title := XTitul;
    end else
      if s <> TitX then begin
        if (s <> '') and MakeAxisSql(s, Sq, Sg, SqAs, SAx, MolsX, AwX, Pr100X, Alfa) then begin
          Chang := true;
          StrH1.Strings[1] := Sqas + ' as Fx';
        {StrH1.Strings[2] := Sq;}
          StrH1.Strings[5] := Sg;
          for i := 0 to NGraphs - 1 do begin
            TAdoQuery(SQLS[i]).Close;
          {TAdoQuery(SQLS[i]).SQL[2] := Sq;}
            TAdoQuery(SQLS[i]).SQL[1] := Sqas + ' as Fx';
            TAdoQuery(SQLS[i]).SQL[5] := Sg;
          end;
          TitX := s;
        {if LogX then TitX:= 'Ln('+TitX+')'; }
          CurAWx := AWX;
          CurPr100X := Pr100X;
          StrAx.Strings[0] := TitX;
          i := Pos('Fe†', Sax);
          while i > 0 do begin
            System.Delete(Sax, i, 3);
            System.Insert('(Fe++)', SAx, i);
            i := Pos('Fe†', Sax);
          end;
          i := Pos('Fe‡', Sax);
          while i > 0 do begin
            System.Delete(Sax, i, 3);
            System.Insert('(Fe+++)', SAx, i);
            i := Pos('Fe‡', Sax);
          end;
          if LogX then Sax := 'Log(' + Sax + ')';
          if AWx then Sax := Sax + stAnWater;
          if XTitul = '' then begin
            StrTit.Strings[0] := Sax;
            GeoChart1.Axises[0].Title := Sax
          end else begin
            StrTit.Strings[0] := XTitul;
            GeoChart1.Axises[0].Title := XTitul;
          end;
        end;
      end else if XTitul <> '' then begin
        StrTit.Strings[0] := XTitul;
        GeoChart1.Axises[0].Title := XTitul;
      end;
    if GeoChart1.Trio then begin
      s := Zf;
      if S[1] = '!' then begin
        ZAlgo := True;
        MustReopen := True;
        if FRootStorage = nil then
          OpenDocFile;
        LoadProgram(ZAlgID, ZProgr);
        ZProgr.Compile;
        GeoChart1.Axises[2].Title := ZTitul;
      end else
        if (s <> TitZ) and (s <> '') and MakeAxisSql(s, Sq, Sg, SqAs, SAx, MolsY, AWy, Pr100Z, Alfa) then begin
          Chang := true;
          StrH1.Strings[3] := Sqas + ' as Fz';
        {StrH1.Strings[4] := Sq;}
          StrH1.Strings[9] := Sg;
          StrH1.Strings[10] := ')AND(';
          if AWz then Sax := Sax + stAnWater;
          if ZTitul = '' then begin
            StrTit.Strings[2] := Sax;
            GeoChart1.Axises[2].Title := Sax
          end else begin
            StrTit.Strings[2] := ZTitul;
            GeoChart1.Axises[2].Title := ZTitul;
          end;
          TitZ := s;
          CurAWZ := AWZ;
          CurPr100Z := Pr100Z;
          StrAx.Strings[2] := TitZ;
          for i := 0 to NGraphs - 1 do begin
            TAdoQuery(SQLS[i]).Close;
          {TAdoQuery(SQLS[i]).SQL[4] := Sq;}
            TAdoQuery(SQLS[i]).SQL[3] := Sqas + ' as Fz';
            TAdoQuery(SQLS[i]).SQL[9] := Sg;
            TAdoQuery(SQLS[i]).SQL[10] := ')AND(';
          end;
        end else if ZTitul <> '' then begin
          StrTit.Strings[2] := Sax;
          GeoChart1.Axises[2].Title := ZTitul;
        end;
    end
    else
      for i := 0 to NGraphs - 1 do begin
        TAdoQuery(SQLS[i]).SQL[10] := '';
        {TAdoQuery(SQLS[i]).SQL[3] := '';}
        TAdoQuery(SQLS[i]).SQL[9] := '';
      end;
    s := Yf;
    if S[1] = '!' then begin
      YAlgo := True;
      MustReopen := True;
      if FRootStorage = nil then
        OpenDocFile;
      LoadProgram(YAlgID, YProgr);
      YProgr.Compile;
      GeoChart1.Axises[1].Title := YTitul;
    end else
      if (s <> TitY) and (s <> '') and MakeAxisSql(s, Sq, Sg, SqAs, SAx, MolsX, AWy, Pr100Y, Alfa) then begin
        Chang := true;
        StrH1.Strings[2] := Sqas + ' as Fy';
      {StrH1.Strings[3] := Sq;}
        StrH1.Strings[7] := Sg;
        if LogY then Sax := 'Log(' + Sax + ')';
        if AWy then Sax := Sax + stAnWater;
        if YTitul = '' then begin
          StrTit.Strings[1] := Sax;
          GeoChart1.Axises[1].Title := Sax
        end else begin
          StrTit.Strings[1] := YTitul;
          GeoChart1.Axises[1].Title := YTitul;
        end;
        TitY := s;
        CurAWY := AWY;
        CurPr100Y := Pr100Y;
      {if LogY then TitY:= 'Ln('+TitY+')';}
        StrAx.Strings[1] := TitY;
        for i := 0 to NGraphs - 1 do begin
          TAdoQuery(SQLS[i]).Close;
        {TAdoQuery(SQLS[i]).SQL[3] := Sq;}
          TAdoQuery(SQLS[i]).SQL[2] := Sqas + ' as Fy';
          TAdoQuery(SQLS[i]).SQL[7] := Sg;
        end;
      end else if YTitul <> '' then
      begin
        StrTit.Strings[1] := YTitul;
        GeoChart1.Axises[1].Title := YTitul;
      end;
    Application.ProcessMessages;
    if Chang then begin
      if Trio then
        ConfigDlg.SQL0.Clear
      else
        ConfigDlg.SQL2.Clear;
      for i := 0 to StrH1.Strings.Count - 1 do
        if trio then
          ConfigDlg.SQL0.Strings.Add(StrH1.Strings[i])
        else
          ConfigDlg.SQL2.Strings.Add(StrH1.Strings[i]);




      for i := 0 to 2 do
        if Trio then
          ConfigDlg.StrTit.Strings[i] := StrTit.Strings[i]
        else
          ConfigDlg.StrTit2.Strings[i] := StrTit.Strings[i];


      for i := 0 to 2 do
        if Trio then
          ConfigDlg.StrAx.Strings[i] := StrAx.Strings[i]
        else
          ConfigDlg.StrAx2.Strings[i] := StrAx.Strings[i];
      for i := 0 to NGraphs - 1 do begin
        Application.ProcessMessages;
       {if TCheckBox(ChBoxes[i]).Enabled then begin }
       {TAdoQuery(SQLs[i]).UnPrepare;
       TAdoQuery(SQLS[i]).Prepare;}

        {DebugSql.Memo1.Lines.Assign(TAdoQuery(Sqls[NGraphs - 1]).SQL);
        DebugSql.ShowModal; }

        TAdoQuery(SQLS[i]).Open;
        {end;}
      end;
      GeoChart1.Title.Visible := false;
    end else if MustReopen then begin
      for i := 0 to NGraphs - 1 do begin
        Application.ProcessMessages;
        TAdoQuery(SQLS[i]).Close;

        TAdoQuery(SQLS[i]).Open;
        {end;}
      end;
    end;
    for i := 1 to NGraphs do MustCalc[i] := true;
  finally
    WForm.Close;
    GeoChart1.EndUpdate;
    FRootStorage := nil;
  end;
end;

procedure TTrioForm.SetStandart(S: boolean);
var
  i: integer;
  Str: string;
  Mi, Ma: double;
begin
  fStandart := S;
  Button2.Enabled := S or GeoChart1.Trio;
  GroupBox4.Enabled := S;
  GroupBox4.Visible := s;
  WasClass := False;
  if S then begin
    try
      GeoChart1.BeginUpdate;
      LogX := Diagr.Xax.Log;
      LogY := Diagr.YAx.Log;
      for i := 0 to GeoChart1.Series.Count - 1 do begin
        GeoChart1.Series[i].LogorX := LogX;
        GeoChart1.Series[i].LogorY := LogY;
      end;
      Trio := Diagr.Trio;
      GeoChart1.Norma := Diagr.Norma;
      for i := 0 to GeoChart1.Axises.Count - 1 do begin
        GeoChart1.Axises[i].Automatic := false;
        GeoChart1.Axises[i].Logarithmic := false;
      end;
      GeoChart1.Axises[0].GridVisible := Diagr.ShowGrid;
      GeoChart1.Axises[1].GridVisible := Diagr.ShowGrid;
      Str := '';
      if Diagr.Trio then begin
        GeoChart1.Axises[2].GridVisible := Diagr.ShowGrid;
        Mi := Diagr.ZAx.min;
        Ma := Diagr.ZAx.max;
        GeoChart1.Axises[2].SetMinMax(Mi, Ma);
        AWZ := Diagr.ZAx.AW;
        Pr100Z := Diagr.Zax.proc100;
        MolsZ := Diagr.Zax.Mols;
        Str := Diagr.Zax.Formula;
      end;
      Mi := Diagr.XAx.min;
      Ma := Diagr.XAx.max;
      GeoChart1.Axises[0].SetMinMax(Mi, Ma);
      Mi := Diagr.YAx.min;
      Ma := Diagr.YAx.max;
      GeoChart1.Axises[1].SetMinMax(Mi, Ma);
      AWX := Diagr.Xax.AW;
      AWY := Diagr.YAx.AW;
      Pr100X := Diagr.Xax.proc100;
      Pr100Y := Diagr.Yax.proc100;
      MolsX := Diagr.Xax.Mols;
      MolsY := Diagr.Yax.Mols;
      TitX := '';
      TitY := '';
      TitZ := '';
      if Diagr.Classification and ((diagr.Count > 0) or (Diagr.Interv.Count > 0)) then begin
        Button11.Visible := true;
        Button11.Enabled := true;
        if ClassForm = nil then ClassForm := TClassForm.Create(MainForm);
        ClassForm.DiagrId := Diagr.ID;
        Application.ProcessMessages;
        ClassForm.WindowState := wsMinimized;
        ClassForm.Ptr := @ClassForm;
        Application.ProcessMessages;
        ChangeClForm.ListBox1.Clear;
        with TClassForm(ClassForm) do
          with TreeView1.Items do begin
            Clear;
            RootN := Add(nil, Diagr.Name);
            RootN.ImageIndex := 0;
            for i := 0 to Diagr.Count - 1 do begin
              TVerCollection(Diagr.Items[i]).Node :=
                AddChild(RootN, ReplaceChStr(TVerCollection(Diagr.Items[i]).Name1, '@', ' '));
              ClassForm.IDS.Add(TVerCollection(Diagr.Items[i]).ClId);
              ChangeClForm.ListBox1.Items.AddObject(ReplaceChStr(TVerCollection(Diagr.Items[i]).Name1, '@', ' '),
                Diagr.Items[i]);
            end;
            if (diagr.Count > 0) then begin
              AddChild(RootN, stOut);
              ClassForm.IDS.Add('');
            end;
            for i := 0 to Diagr.Interv.Count - 1 do begin
              TInterval(Diagr.Interv.Items[i]).Node :=
                AddChild(RootN, DelCh(ReplaceChStr
                (TInterval(Diagr.Interv.Items[i]).Name, '@', ' '), '$'));
              ClassForm.IDS.Add(TInterval(Diagr.Interv.Items[i]).ClID);
            end;
            if (diagr.Interv.Count > 0) then begin
              AddChild(RootN, stOutInt);
              ClassForm.IDS.Add('');
            end;
          end;
        GeoChart1.EndUpdate;
      end else begin
        Button11.Visible := false;
        Button11.Enabled := false;
        RadioGroup2.ItemIndex := 0;
        RadioGroup2.Visible := false;
      end;
      GeoChart1.Axises[0].Logarithmic := Diagr.Xax.logor;
      GeoChart1.Axises[1].Logarithmic := Diagr.Yax.logor;
      XTitul := Diagr.Xax.Caption;
      YTitul := Diagr.Yax.Caption;
      ZTitul := Diagr.Zax.Caption;
      DoAxes(Diagr.Xax.Formula, Diagr.Yax.Formula, Str);
      GeoChart1.Title.Text := Diagr.Name;
      GeoChart1.Title.Visible := Diagr.ShowTitle;
    {if Diagr.Yax.Caption <> '' then
      GeoChart1.Axises[0].Title := Diagr.Xax.Caption;
    if Diagr.Xax.Caption <> '' then
      GeoChart1.Axises[1].Title  := Diagr.Yax.Caption;
    if Diagr.Trio and(Diagr.Zax.Caption <> '') then
      GeoChart1.Axises[2].Title  := Diagr.Zax.Caption; }
      if Diagr.Classification and (Diagr.Count > 0) then
        with ClassForm.ListView1 do begin
          Items.Clear;
          Column[2].Caption := GeoChart1.Axises[0].Title;
          Column[3].Caption := GeoChart1.Axises[1].Title;
          if Diagr.Trio then
            Column[4].Caption := GeoChart1.Axises[2].Title
          else
            Column[4].Caption := '';
        end;
    finally
      GeoChart1.EndUpdate;
    end;
  end else begin
    try
      GeoChart1.BeginUpdate;
      for i := 0 to GeoChart1.Axises.Count - 1 do
        GeoChart1.Axises[i].Automatic := true;
      GeoChart1.Title.Text := '';
      GeoChart1.Title.Visible := false;
      Button11.Visible := false;
      Button11.Enabled := false;
    {#ToDo1 Think There?}
   { ClassForm.Close;
    with ClassForm.TreeView1.Items do begin
      for i := 0 to count - 1 do
        TObject(Item[i].Data).Free;
      Clear;
    end; }
    finally
      GeoChart1.EndUpdate;
    end;
  end;
  GeoChart1.EndUpdate;
end;

procedure TTrioForm.Button11Click(Sender: TObject);
var
  i, j, k, l, j1: integer;
  DataSet: TAdoQuery;
  T: TOPoint;
  Old, WasX, WasY: boolean;
  Node: TTreeNode;
  R, X, Y, Z: Double;
  Rep: TRPoint;
begin
  if not WasClass then begin
    RadioGroup2.Visible := True;
    ClassForm.Trio := Diagr.Trio;
    ClassForm.ListView1.Items.Clear;
    for k := 0 to NGraphs - 1 do begin
    {if TCheckBox(ChBoxes.Items[k]).Checked then begin}
      DataSet := SQLs.Items[k];
           {With ClassForm do begin
             for i:=0 to RootN.Count-1 do begin

                 for j:=0 to RootN.Item[i].Count-1 do
                     if RootN.Item[i].Item[j].Text=
                     GeoChart1.Series[(DataSet.Tag-1)*3].Title then begin
                       Old:=true;
                       TClassList(RootN.Item[i].Item[j].Data).Free;
                       RootN.Item[i].Item[j].Data:=TClassList.Create;
                     end;
                 if not Old then
                    TreeView1.Items.AddChildObject(RootN.Item[i],
                    GeoChart1.Series[(DataSet.Tag-1)*3].Title,TClassList.Create);
             end;
        end; }

      try
        DataSet.DisableControls;
        DataSet.First;
        while not DataSet.Eof do begin
          X := DataSet['Fx'];
          Y := DataSet['Fy'];
          if Diagr.Trio then begin
            Z := DataSet['Fz'];
            R := X + Y + Z;
            if R = 0 then begin
              Next;
              Continue;
            end;
            X := X * GeoChart1.Norma / R;
            Y := Y * GeoChart1.Norma / R;
            Z := Z * GeoChart1.Norma / R;
          end;
          T := TOPoint.Create(X, Y);
          if Diagr.Count > 0 then begin
            j := 0;
            for i := 0 to Diagr.Count - 1 do
              if TVerCollection(Diagr.Items[i]).PointIn(T) then
                break
              else Inc(J);

            Old := false;
            with ClassForm do begin
              for i := 0 to RootN.Item[j].Count - 1 do
                if RootN.Item[j].Item[i].Text =
                  GeoChart1.Series[(DataSet.Tag - 1)].Name then begin
                  Old := True;
                  Node := RootN.Item[j].Item[i];
                  break;
                end;
              if not OLd then begin
                Node := TreeView1.Items.AddChildObject(RootN.Item[j],
                  GeoChart1.Series[(DataSet.Tag - 1)].Name, TClassList.Create);
              end;
            end;
            if Diagr.trio then begin
              if DataSet['Sample'] <> null then
                TClassList(Node.Data).Add(TClassPoint.Create(X, Y, Z,
                  DataSet['Descript'], DataSet['AnId'], DataSet['Sample']))
              else TClassList(Node.Data).Add(TClassPoint.Create(X, Y, Z,
                  DataSet['Descript'], DataSet['AnId'], '-'))
            end else
              if DataSet['Sample'] <> null then
                TClassList(Node.Data).Add(TClassPoint.Create(X, Y,
                  0, DataSet['Descript'], DataSet['AnId'], DataSet['Sample']))
              else TClassList(Node.Data).Add(TClassPoint.Create(X, Y,
                  0, DataSet['Descript'], DataSet['AnId'], '-'));
            Node.ImageIndex := 2;
            Node.SelectedIndex := 3;
            Rep.X := X;
            Rep.Y := Y;
            GeoChart1.Series[DataSet.Tag - 1].NearestPoint(Rep, R).Obj := Node;
          end;
          if Diagr.Interv.Count > 0 then begin
            if Diagr.Count = 0 then j := 0
            else j := Diagr.Count + 1;
            j1 := j;
            WasX := false;
            WasY := false;
            for i := 0 to Diagr.Interv.Count - 1 do
              if TInterval(Diagr.Interv.Items[i]).TypCod = 0 then begin
                if not WasY then
                  Inc(J1);
                R := T.X;
                if (R < TInterval(Diagr.Interv.Items[i]).Y) and
                  (R >= TInterval(Diagr.Interv.Items[i]).X) then
                  WasX := true
                else if not WasX then
                  Inc(J);
              end else begin
                if not WasX then
                  Inc(J);
                R := T.Y;
                if (R < TInterval(Diagr.Interv.Items[i]).Y) and
                  (R >= TInterval(Diagr.Interv.Items[i]).X) then
                  WasY := true
                else if not WasY then
                  Inc(J1);
              end;
            Old := false;
            if (j <> Diagr.Interv.Count) or (J = J1) then begin
              with ClassForm do begin
                for i := 0 to RootN.Item[j].Count - 1 do
                  if RootN.Item[j].Item[i].Text =
                    GeoChart1.Series[(DataSet.Tag - 1)].Name then begin
                    Old := True;
                    Node := RootN.Item[j].Item[i];
                    break;
                  end;
                if not OLd then begin
                  Node := TreeView1.Items.AddChildObject(RootN.Item[j],
                    GeoChart1.Series[(DataSet.Tag - 1)].Name, TClassList.Create);
                end;
              end;
              if Diagr.trio then begin
                if DataSet['Sample'] <> null then
                  TClassList(Node.Data).Add(TClassPoint.Create(X, Y, Z,
                    DataSet['Descript'], DataSet['AnId'], DataSet['Sample']))
                else TClassList(Node.Data).Add(TClassPoint.Create(X, Y, Z,
                    DataSet['Descript'], DataSet['AnId'], '-'));
              end else
                if DataSet['Sample'] <> null then
                  TClassList(Node.Data).Add(TClassPoint.Create(X, Y,
                    0, DataSet['Descript'], DataSet['AnId'], DataSet['Sample']))
                else TClassList(Node.Data).Add(TClassPoint.Create(X, Y,
                    0, DataSet['Descript'], DataSet['AnId'], '-'));
              Node.ImageIndex := 2;
              Node.SelectedIndex := 3;
              Rep.X := X;
              Rep.Y := Y;
              GeoChart1.Series[DataSet.Tag - 1].NearestPoint(Rep, R).Obj := Node;
            end;
            if (j1 <> Diagr.Interv.Count) then begin
              Old := false;
              with ClassForm do begin
                for i := 0 to RootN.Item[j1].Count - 1 do
                  if RootN.Item[j1].Item[i].Text =
                    GeoChart1.Series[(DataSet.Tag - 1)].Name then begin
                    Old := True;
                    Node := RootN.Item[j1].Item[i];
                    break;
                  end;
                if not OLd then begin
                  Node := TreeView1.Items.AddChildObject(RootN.Item[j1],
                    GeoChart1.Series[(DataSet.Tag - 1)].Name, TClassList.Create);
                end;
              end;
              if Diagr.trio then begin
                if DataSet['Sample'] <> null then
                  TClassList(Node.Data).Add(TClassPoint.Create(X, Y, Z,
                    DataSet['Descript'], DataSet['AnId'], DataSet['Sample']))
                else TClassList(Node.Data).Add(TClassPoint.Create(X, Y, Z,
                    DataSet['Descript'], DataSet['AnId'], '-'))
              end else
                if DataSet['Sample'] <> null then
                  TClassList(Node.Data).Add(TClassPoint.Create(X, Y,
                    0, DataSet['Descript'], DataSet['AnId'], DataSet['Sample']))
                else TClassList(Node.Data).Add(TClassPoint.Create(X, Y,
                    0, DataSet['Descript'], DataSet['AnId'], '-'));
              Node.ImageIndex := 2;
              Node.SelectedIndex := 3;
              Rep.X := X;
              Rep.Y := Y;
              GeoChart1.Series[DataSet.Tag - 1].NearestPoint(Rep, R).Obj := Node;
            end;
          end;
          T.Free;
          DataSet.Next;
        end;
      finally
        DataSet.EnableControls;
      end;
    {end;}
    end;
    WasClass := True;
    ClassForm.TreeView1.Items[0].Expand(True);
  end;
  ClassForm.WindowState := wsNormal;
  ClassForm.BringToFront;
end;


procedure TTrioForm.Label1Click(Sender: TObject);
begin
  if OpenQr('Select AnID,Sample from RHADATA where ' + GeoChart1.Series[0].Label1FieldName +
    '=''' + Label1.Caption + '''', DM1.q1Time) then begin
    CurID := DM1.q1Time['AnID'];
    if MainForm.Cadd.Checked then
      AddToList(DM1.q1Time['Sample'])
    else
      TAnalForm.Create(MainForm);
  end;
end;

procedure TTrioForm.ListBox3DblClick(Sender: TObject);
begin
  MendTabl1.InsertText(ExpandSym(ListBox3.Items[ListBox3.ItemIndex] + '@'));
end;

procedure TTrioForm.ListBox4DblClick(Sender: TObject);
begin
  MendTabl2.InsertText(ExpandSym(ListBox4.Items[ListBox4.ItemIndex] + '@'));
end;

procedure TTrioForm.SCopyClick(Sender: TObject);
begin
  GeoChart1.CopyToClipboard;
end;

procedure TTrioForm.GeoChart1ClickPoint(Sender: TObject; SerIndex: Integer;
  Point: TCPoint; Button: TMouseButton);
var
  T: TPoint;
  Nod, Node: TTreeNode;
  i: integer;
  ClPoint: TClassPoint;
  CList: TClassList;
  Old: boolean;
begin
  if Point = nil then exit;
  if Button <> mbRight then begin
    try
      Label1.Visible := false;
      with GeoChart1 do begin
        Label1.Caption := Point.Label1;
        T := ChartToScreen(Point.Value);
        if T.X > Width div 2 then
          Label1.Left := T.X - 3 - Label1.Width
        else Label1.Left := T.X + 3;
        if T.Y > Height div 2 then
          Label1.Top := T.Y - 3 - Label1.Height
        else Label1.Top := T.Y + 3;
        Label1.Left := Label1.Left + GeoChart1.Left;
        Label1.Top := Label1.Top + GeoChart1.Top;
        Label1.Visible := true;
        {if MainForm.Cadd.Checked then
          AddToList(Point.Label1);  }
      end;
    except
      on Exception do
        Label1.Visible := false;
    end;
  end else
    if RadioGroup2.ItemIndex = 0 then begin
      Label1.Visible := false;
      if Application.MessageBox(PChar(stDelPoin),
        PChar(stDelP), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_APPLMODAL)
        = ID_YES then begin
        GeoChart1.Series[SerIndex].Remove(Point);
        MustCalc[SerIndex + 1] := true;
        GeoChart1.EndUpdate;
      end;
    end else begin
      ChangeClForm.Label2.Caption := Point.Label1;
      ChangeClForm.Label1.Caption := Diagr.Name;
      Nod := TTreeNode(Point.Obj);
      for i := 0 to ChangeClForm.ListBox1.Items.Count - 1 do
        if ChangeClForm.ListBox1.Items[i] = DelCh(Nod.Parent.Text, '@') then begin
          ChangeClForm.ListBox1.ItemIndex := i;
          break;
        end;

      if ChangeClForm.ShowModal = mrOk then
        if ChangeClForm.ListBox1.Items[ChangeClForm.ListBox1.ItemIndex] <>
          DelCh(Nod.Parent.Text, '@') then begin
          CList := TClassList(Nod.Data);
          ClPoint := nil;
          for i := 0 to CList.Count - 1 do
            if Point.Label1 = TClassPoint(CList.Items[i]).SampID then begin
              ClPoint := TClassPoint(CList.Items[i]);
              CList.Delete(I);
              if CList.Count = 0 then begin
                CList.Free;
                if Nod.Parent.Count = 1 then
                  Nod.Parent.Collapse(false);
                Nod.Delete;
              end;
              Break;
            end;
          if ClPoint = nil then begin
            ShowMessage(stNotSID);
            Exit;
          end;
          with ClassForm do begin
            Nod := TreeView1.Items[1];
            while Nod <> nil do begin
              if Nod.Text = ChangeClForm.ListBox1.Items[ChangeClForm.ListBox1.ItemIndex]
                then
                break;
              Nod := Nod.getNextSibling;
            end;
            if Nod <> nil then begin
              old := false;
              for i := 0 to Nod.Count - 1 do
                if Nod.Item[i].Text =
                  point.Series.Name then begin
                  Old := True;
                  Node := Nod.Item[i];
                  break;
                end;
              if not Old then
                Node := TreeView1.Items.AddChildObject(Nod,
                  point.Series.Name, TClassList.Create);
              Point.Obj := Node;
              TClassList(Node.Data).Add(ClPoint);
              Node.ImageIndex := 2;
              Node.SelectedIndex := 3;
              Nod.Expand(true);
            end;
          end;
        end;
    end;
end;

procedure TTrioForm.ListBox5Click(Sender: TObject);
begin
  MendTabl3.Text := StForm.Strings[ListBox5.ItemIndex];
  Edit3.Text := ListBox5.Items[ListBox5.ItemIndex];
end;


procedure TTrioForm.ListBox6DblClick(Sender: TObject);
begin
  MendTabl3.InsertText(ExpandSym(ListBox6.Items[ListBox6.ItemIndex] + '@'));
end;

procedure TTrioForm.SpeedButton2Click(Sender: TObject);
begin
  CurHelpContext := 87;
  Geochart1.PreView;
  CurHelpContext := HelpContext;
end;


procedure TTrioForm.GeoChart1AfterInterPaint(Sender: TObject);
var i: integer;
  P: TPoint;
  M: TRPoint;
begin
  if Standart then
    Diagr.Draw(GeoChart1);
  if CheckBox6.Checked then begin
    GeoChart1.Canvas.Pen.Width := 2;
    Geochart1.Canvas.Font.Size := 7;
    for i := 0 to GeoChart1.Series.Count - 1 do
      if GeoChart1.Series[i].Active then begin
        M.X := GeoChart1.Series[i].XSum / GeoChart1.Series[i].Count;
        M.Y := GeoChart1.Series[i].YSum / GeoChart1.Series[i].Count;
        M.Z := GeoChart1.Series[i].ZSum / GeoChart1.Series[i].Count;
        P := GeoChart1.ChartToScreen(M);
        GeoChart1.Canvas.Pen.Color := GeoChart1.Series[i].Color;
        GeoChart1.Canvas.Brush.Style := bsClear;
        GeoChart1.Canvas.Ellipse(P.X - 6, P.Y - 6, P.X + 6, P.Y + 6);
        Geochart1.Canvas.TextOut(P.X - 3, P.Y - 6, IntToStr(i + 1));
      end;
  end;
  GeoChart1.Canvas.Pen.Color := clBlack;
  GeoChart1.Canvas.Pen.Width := 1;
end;

procedure TTrioForm.CheckBox8Click(Sender: TObject);
begin
  GeoChart1.Paint;
end;

procedure TTrioForm.SetTrio(const Value: boolean);
var
  i: integer;
begin
  AExcExp.Enabled := not Value;
  if Value <> Ftrio then begin
    FTrio := Value;
    if FTrio then begin
      RadioGroup1.ItemIndex := 1;
      
      if Standart then begin
        CheckBox17.Visible:=True;
        CheckBox17.Checked:=Diagr.Cod=100;
      end else
        CheckBox17.Visible:=False;
      for i := 0 to GeoChart1.Axises.Count - 1 do
        GeoChart1.Axises[i].Logarithmic := false;
      for i := 0 to GeoChart1.Series.Count - 1 do begin
        GeoChart1.Series[i].LogorX := False;
        GeoChart1.Series[i].LogorY := False;
      end;
    end else begin
      RadioGroup1.ItemIndex := 0;
       CheckBox17.Visible:=False;
    end;
    if GeoChart1.Trio <> Value then
      GeoChart1.Trio := Value;
    GroupBox4.Enabled := Standart and not GeoChart1.Trio;
    GroupBox4.Visible := Standart and not GeoChart1.Trio;
    Button2.Enabled := Standart or GeoChart1.Trio;
  end;
end;

procedure TTrioForm.RadioGroup1Click(Sender: TObject);
begin
  if (Trio and (RadioGroup1.ItemIndex = 0)) or
    (not Trio and (RadioGroup1.ItemIndex = 1)) then
    Standart := false;
  if RadioGroup1.ItemIndex = 0 then
    Trio := false
  else Trio := True;
end;

procedure TTrioForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTrioForm.FormResize(Sender: TObject);
begin
  GeoChart1.Height := ClientHeight;
  GeoChart1.Width := ClientWidth - GeoChart1.Left;
end;

procedure TTrioForm.CheckBox3Click(Sender: TObject);
var S: string;
begin
  S := Copy(Edit2.Text, 1, 4);
  if CheckBox3.Checked then begin
    if s <> 'Log(' then begin
      S := 'Log(' + Edit2.Text + ')';
      Edit2.Text := S;
    end;
  end else if s = 'Log(' then begin
    S := Copy(Edit2.Text, 5, Length(Edit2.Text) - 5);
    Edit2.Text := S;
  end;
end;

procedure TTrioForm.CheckBox2Click(Sender: TObject);
var S: string;
begin
  S := Copy(Edit1.Text, 1, 4);
  if CheckBox2.Checked then begin
    if s <> 'Log(' then begin
      S := 'Log(' + Edit1.Text + ')';
      Edit1.Text := S;
    end;
  end else if s = 'Log(' then begin
    S := Copy(Edit1.Text, 5, Length(Edit1.Text) - 5);
    Edit1.Text := S;
  end;
end;

procedure TTrioForm.AExcExpExecute(Sender: TObject);
begin
  ExcF.ExportChartToExc(GeoChart1, GeoChart1.Title.Text, Standart, Diagr);
end;

procedure TTrioForm.CheckBox12Click(Sender: TObject);
begin
  if CheckBox12.Checked then
    CheckBox5.Checked := True;
end;

procedure TTrioForm.CheckBox10Click(Sender: TObject);
begin
  if CheckBox10.Checked then
    CheckBox15.Checked := True;
end;

procedure TTrioForm.CheckBox11Click(Sender: TObject);
begin
  if CheckBox11.Checked then
    CheckBox4.Checked := True;
end;

procedure TTrioForm.CheckBox4Click(Sender: TObject);
begin
  if not CheckBox4.Checked then
    CheckBox11.Checked := false;
end;

procedure TTrioForm.CheckBox15Click(Sender: TObject);
begin
  if not CheckBox15.Checked then
    CheckBox10.Checked := false;
end;

procedure TTrioForm.CheckBox5Click(Sender: TObject);
begin
  if not CheckBox5.Checked then
    CheckBox12.Checked := false;
end;

procedure TTrioForm.GeoChart1SetTrio(Sender: TObject);
begin
  SetTrio(GeoChart1.Trio);
end;

procedure TTrioForm.CheckBox6Click(Sender: TObject);
begin
  GeoChart1.Paint;
end;

procedure TTrioForm.ARefreshExecute(Sender: TObject);
var i, j: integer;
begin
  try
    GeoChart1.BeginUpdate;
    GeoChart1.Series.Clear;
    for i := 0 to NGraphs - 2 do begin
      TAdoQuery(SQLs[i]).Close;
        {TAdoQuery(SQLs[i]).UnPrepare;}
      TAdoQuery(SQLs[i]).Free;
      TDataSource(Dsources[i]).Free;
    end;
    SQLs.Clear;
    Dsources.Clear;
    NGraphs := 0;
    for i := 0 to QueryRolls.QueryChLBox.Items.Count - 1 do
      if QueryRolls.QueryChLBox.Checked[i] then begin
        SQLs.Add(TAdoQuery.Create(Self));
        TAdoQuery(Sqls[NGraphs]).Tag := NGraphs + 1;
        TAdoQuery(Sqls[NGraphs]).Connection := DM1.ADOConnection1;

        {DebugSql.Memo1.Lines.Assign(StrH1.Strings);
        DebugSql.ShowModal;

          DebugSql.Memo1.Lines.Assign(TAdoQuery(Sqls[NGraphs]).SQL);
        DebugSql.ShowModal; }
        for j := 0 to StrH1.Strings.Count - 1 do
          TAdoQuery(Sqls[NGraphs]).SQL.Add(StrH1.Strings[j]);
        if TAdoQuery(LQueries[i]).SQL.Count > 1 then begin
          if TAdoQuery(LQueries[i]).SQL.Count > 2 then
            TAdoQuery(Sqls[NGraphs]).SQL.Add('AND(');
          for j := 1 to TAdoQuery(LQueries[i]).SQL.Count - 1 do
            TAdoQuery(Sqls[NGraphs]).SQL.Add(TAdoQuery(LQueries[i]).SQL[j]);
        end;
        DSources.Add(TDataSource.Create(Self));
        TDataSource(DSources[NGraphs]).DataSet := TAdoQuery(Sqls[NGraphs]);
        GeoChart1.Series.Add;
        {GeoChart1.Series[NGraphs].Active := false;}
        GeoChart1.Series[NGraphs].Name := QueryRolls.QueryChLBox.Items[i];
        GeoChart1.Series[NGraphs].DataSource := TDataSource(DSources[NGraphs]);
        GeoChart1.Series[NGraphs].XFieldName := 'Fx';
        GeoChart1.Series[NGraphs].YFieldName := 'Fy';
        GeoChart1.Series[NGraphs].ZFieldName := 'Fz';
        GeoChart1.Series[NGraphs].Label1FieldName := 'Sample';
        GeoChart1.Series[NGraphs].Label2FieldName := 'Num';
        GeoChart1.Series[NGraphs].DataAware := True;
        GeoChart1.Series[NGraphs].MarkType := TGMark(NGraphs mod 6 + 1);
        if not MustDiag then begin
          GeoChart1.Series[NGraphs].LogorX := CurLogoX;
          GeoChart1.Series[NGraphs].LogorY := CurLogoY;
        end;

        {DebugSql.Memo1.Lines.Assign(TAdoQuery(Sqls[NGraphs]).SQL);
        DebugSql.ShowModal;}

        {TAdoQuery(SQLS[NGraphs]).Prepare;}
        TAdoQuery(SQLS[NGraphs]).Open;

        GeoChart1.Series[NGraphs].Active := True;
        Inc(NGraphs);
      end;
  finally
    GeoChart1.EndUpdate;
  end;

end;

procedure TTrioForm.CheckBox7Click(Sender: TObject);
var i: integer;
  S: string;
begin
  if CheckBox7.Checked then begin
    CheckBox4.Checked := True;
    CheckBox4.Enabled := False;
    MendTabl1.Alternative := False;
    for i := 0 to MendTabl1.ComponentCount - 1 do
      if TComponent(MendTabl1.Components[i]).Tag > 0 then
        TControl(MendTabl1.Components[i]).Enabled :=
          MendTab.MustMol(TComponent(MendTabl1.Components[i]).Tag);
    MendTabl1.ConcEnable := False;
    S := MendTabl1.Text;
    S := StripChar(S, '$');
    MendTabl1.Text := S;
  end else begin
    for i := 0 to MendTabl1.ComponentCount - 1 do
      if TComponent(MendTabl1.Components[i]).Tag > 0 then
        TControl(MendTabl1.Components[i]).Enabled := True;
    MendTabl1.ConcEnable := True;
    CheckBox4.Enabled := True;
  end;
end;

procedure TTrioForm.CheckBox13Click(Sender: TObject);
var i: integer;
  S: string;
begin
  if CheckBox13.Checked then begin
    CheckBox15.Checked := True;
    CheckBox15.Enabled := False;
    MendTabl2.Alternative := False;
    for i := 0 to MendTabl2.ComponentCount - 1 do
      if TComponent(MendTabl2.Components[i]).Tag > 0 then
        TControl(MendTabl2.Components[i]).Enabled :=
          MendTab.MustMol(TComponent(MendTabl2.Components[i]).Tag);
    MendTabl2.ConcEnable := False;
    S := MendTabl2.Text;
    S := StripChar(S, '$');
    MendTabl2.Text := S;
  end else begin
    for i := 0 to MendTabl2.ComponentCount - 1 do
      if TComponent(MendTabl2.Components[i]).Tag > 0 then
        TControl(MendTabl2.Components[i]).Enabled := True;
    MendTabl2.ConcEnable := True;
    CheckBox15.Enabled := True;
  end;
end;

procedure TTrioForm.CheckBox14Click(Sender: TObject);
var i: integer;
  S: string;
begin
  if CheckBox14.Checked then begin
    CheckBox5.Checked := True;
    CheckBox5.Enabled := False;
    MendTabl3.Alternative := False;
    for i := 0 to MendTabl3.ComponentCount - 1 do
      if TComponent(MendTabl3.Components[i]).Tag > 0 then
        TControl(MendTabl3.Components[i]).Enabled :=
          MendTab.MustMol(TComponent(MendTabl3.Components[i]).Tag);
    MendTabl3.ConcEnable := False;
    S := MendTabl3.Text;
    S := StripChar(S, '$');
    MendTabl3.Text := S;
  end else begin
    for i := 0 to MendTabl3.ComponentCount - 1 do
      if TComponent(MendTabl3.Components[i]).Tag > 0 then
        TControl(MendTabl3.Components[i]).Enabled := True;
    MendTabl3.ConcEnable := True;
    CheckBox5.Enabled := True;
  end;
end;

procedure TTrioForm.GeoChart1SetDataPoint(Sender: TObject;
  SerIndex: Integer; DSet: TDataSet; Point: TCPoint);
begin
  if XAlgo then begin
    AlgoForm.VE1.DataSet := DSet;
    AlgoForm.VE1.Atomn := AtX;
    AlgoForm.VE1.AW := AWX;
    AlgoForm.VE1.C100 := Pr100X;
    AlgoForm.VE1.Mols := MolsX;
    XProgr.Run;
    Point.Value.X := AlgoForm.VE1.Data[XVarID];
  end;
  if YAlgo then begin
    AlgoForm.VE1.DataSet := DSet;
    AlgoForm.VE1.Atomn := AtY;
    AlgoForm.VE1.AW := AWY;
    AlgoForm.VE1.C100 := Pr100Y;
    AlgoForm.VE1.Mols := MolsY;
    YProgr.Run;
    Point.Value.Y := AlgoForm.VE1.Data[YVarID];
  end;
  if Trio and ZAlgo then begin
    AlgoForm.VE1.DataSet := DSet;
    AlgoForm.VE1.Atomn := AtZ;
    AlgoForm.VE1.AW := AWZ;
    AlgoForm.VE1.C100 := Pr100Z;
    AlgoForm.VE1.Mols := MolsZ;
    ZProgr.Run;
    Point.Value.Z := AlgoForm.VE1.Data[ZVarID];
  end;
end;

procedure TTrioForm.BitBtn2Click(Sender: TObject);
begin
  MendTabl1.Text := '';
  MendTabl1.InsertText('!' + DM1.TabRec['Name'] + ':' + DM1.TabVars['FLDName']);
  Edit1.Text := DM1.TabVars['FLDName'];
  XAlgID := DM1.TabRec['ID'];
  XVarID := DM1.TabVars['Pos'];
  AtX := not DM1.TabRec['W'];
  CheckBox11.Checked := DM1.TabRec['AW'];
  CheckBox4.Checked := DM1.TabRec['C100'];
  CheckBox7.Checked := DM1.TabRec['Mols'];
end;

procedure TTrioForm.BitBtn1Click(Sender: TObject);
begin
  MendTabl2.Text := '';
  MendTabl2.InsertText('!' + DM1.TabRec['Name'] + ':' + DM1.TabVars['FLDName']);
  Edit2.Text := DM1.TabVars['FLDName'];
  YAlgID := DM1.TabRec['ID'];
  YVarID := DM1.TabVars['Pos'];
  AtY := not DM1.TabRec['W'];
  CheckBox10.Checked := DM1.TabRec['AW'];
  CheckBox15.Checked := DM1.TabRec['C100'];
  CheckBox13.Checked := DM1.TabRec['Mols'];
end;

procedure TTrioForm.BitBtn3Click(Sender: TObject);
begin
  MendTabl3.Text := '';
  MendTabl3.InsertText('!' + DM1.TabRec['Name'] + ':' + DM1.TabVars['FLDName']);
  Edit3.Text := DM1.TabVars['FLDName'];
  ZAlgID := DM1.TabRec['ID'];
  ZVarID := DM1.TabVars['Pos'];
  AtZ := not DM1.TabRec['W'];
  CheckBox12.Checked := DM1.TabRec['AW'];
  CheckBox5.Checked := DM1.TabRec['C100'];
  CheckBox14.Checked := DM1.TabRec['Mols'];
end;

procedure TTrioForm.LoadProgram(RecID: integer; Progr: TJvInterpreterProgram);
var StMain: IStorage;
  MainName: WideString;
  Reader: TReader;
  Ostr: TOleStream;
  stm: IStream;
  i: integer;
begin
  MainName := 'Algorithm' + IntToStr(RecID);
  OleCheck(FRootStorage.OpenStorage(PWideChar(MainName), nil,
    STGM_READ or STGM_SHARE_EXCLUSIVE, nil, 0, StMain));
  try
    OleCheck(StMain.OpenStream('Programm_Text', nil,
      STGM_READ or STGM_SHARE_EXCLUSIVE, 0, stm));
    Ostr := TOleStream.Create(stm);
    try
      Reader := TReader.Create(Ostr, 1024);
      try
        Progr.Pas.Text := Reader.ReadString;
      finally
        Reader.Free;
      end;
    finally
      Ostr.Free;
      stm := nil;
    end;
  finally
    stMain := nil;
  end;
end;

procedure TTrioForm.Butt4Click(Sender: TObject);
var TRform: TRegrForm;
var i, j: integer;
  IsPoly: Boolean;
  S: string;
begin
  isPoly := False;
  for i := 0 to Geochart1.Series.Count - 1 do
    if GeoChart1.Series[i].Kind = stPointAppro then begin
      isPoly := True;
      break;
    end;
  if not IsPoly then begin
     // Geochart1.
    for i := 0 to Geochart1.Series.Count - 1 do
      GeoChart1.Series[i].Kind := stPointAppro;
    IsPoly := True;
  end;
  if isPoly then begin
    TRForm := TRegrForm.Create(Mainform);
    TRForm.Memo1.Lines.Clear;
    for i := 0 to Geochart1.Series.Count - 1 do
      if GeoChart1.Series[i].Kind = stPointAppro then begin
        s := GeoChart1.Series[i].Name + ':  Y = ' +
          FloatToStrF(GeoChart1.Series[i].KRegr[0], ffGeneral, 4, 1);
        for j := 1 to GeoChart1.Series[i].Power do begin
          S := S + ' + (' + FloatToStrF(GeoChart1.Series[i].KRegr[j], ffGeneral, 4, 1) +
            ')*X';
          if j > 1 then
            S := S + '^' + IntToStr(j);
        end;
        TRForm.Memo1.Lines.Add(S);
      end;
    TRForm.Caption := stRegress + Geochart1.Title.Text;
  end else
    ShowMessage(stNotPoly);
end;

procedure TTrioForm.BtAYClick(Sender: TObject);
begin
  MendTabl2.InsertText('A');
end;

procedure TTrioForm.BAYClick(Sender: TObject);
begin
  MendTabl2.InsertText('An');
end;

procedure TTrioForm.MendTabl1TypeAnaliseClick(Ind: Integer);
begin
  if not CheckBox7.Checked then
    MendTabl1.MSpeedButton9.Enabled := ind = 0;
end;

procedure TTrioForm.MendTabl2TypeAnaliseClick(Ind: Integer);
begin
  if not CheckBox13.Checked then
    MendTabl2.MSpeedButton9.Enabled := ind = 0;
end;

procedure TTrioForm.MendTabl3TypeAnaliseClick(Ind: Integer);
begin
  if not CheckBox14.Checked then
    MendTabl3.MSpeedButton9.Enabled := ind = 0;
end;

procedure TTrioForm.Button3Click(Sender: TObject);
begin
  MendTabl1.InsertText('E');
end;

procedure TTrioForm.ButtT1Click(Sender: TObject);
begin
  MendTabl1.InsertText('T');
end;

procedure TTrioForm.BHYClick(Sender: TObject);
begin
  MendTabl2.InsertText('En');
end;

procedure TTrioForm.Button4Click(Sender: TObject);
begin
  MendTabl2.InsertText('T');
end;

procedure TTrioForm.Button14Click(Sender: TObject);
begin
  Edit1.Text := MendTabl1.Text;
end;

procedure TTrioForm.Button15Click(Sender: TObject);
begin
  Edit2.Text := MendTabl2.Text;
end;

procedure TTrioForm.Button16Click(Sender: TObject);
begin
  Edit3.Text := MendTabl3.Text;
end;

procedure TTrioForm.Button17Click(Sender: TObject);
begin
  MendTabl1.InsertText('Tn');
end;

procedure TTrioForm.Button18Click(Sender: TObject);
begin
  MendTabl2.InsertText('Tn');
end;

procedure TTrioForm.Button19Click(Sender: TObject);
begin
   MendTabl3.InsertText('En');
end;

procedure TTrioForm.Button20Click(Sender: TObject);
begin
      MendTabl3.InsertText('E');
end;

procedure TTrioForm.Button21Click(Sender: TObject);
begin
      MendTabl3.InsertText('An');
end;

procedure TTrioForm.Button22Click(Sender: TObject);
begin
     MendTabl3.InsertText('A');
end;

procedure TTrioForm.Button23Click(Sender: TObject);
begin
     MendTabl3.InsertText('Tn');
end;                      

procedure TTrioForm.Button24Click(Sender: TObject);
begin
     MendTabl3.InsertText('T');
end;

procedure TTrioForm.CheckBox17Click(Sender: TObject);
begin
  if Standart then begin
    if CheckBox17.Checked then
        Diagr.Cod:=100
     else
      Diagr.Cod:=0;
     GeoChart1.Paint;
  end;
end;

end.

