unit ExcelExp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, OleServer, Excel97, NumInp, dbgrids, grids, MoshChart, Db, StDiagrams, RHAGlobs,
  Variants, Excel2000;

type
  EExcFormatCell = procedure(Col, Row: integer; Val: Variant; var FontColor: TColor;
    var FontBol: Boolean; var NumFormat: string; var FontName : String; var Sep : Boolean) of object;

  TExcF = class(TForm)
    ExcApp: TExcelApplication;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    NumInp1: TNumInp;
    NumInp2: TNumInp;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LCID: integer;
    WbCount: integer;
    function ConnectExc: boolean;
    procedure ExportTableToExc(G: TDBGrid; Title: string; GetText: TGetCellText; Frm: TForm; EFC: EExcFormatCell = nil);
    procedure ExportSGToExc(SG1: TStringGrid; Title: string; EFC: EExcFormatCell = nil);
    procedure ExportChartToExc(G: TGeoChart; Title: string; Standart: Boolean;
      Diagr: TDiagram);
  end;

var
  ExcF: TExcF;
  ExcVersion: string;
  ExcVer: integer;

resourcestring
  stExNotFound = 'MS Excel not found';
  stNotIns = 'Error of new Excel sheet insertion';
  stVersion = 'Version ';
  stNotSupVer = ' of MS EXCEL not supported. Version 8.0 or higher is require.';
  stAx = 'Axises:';
  stSer = 'Series:';
  stFields = 'Fields';
  stInterv = 'Intervals';
  stLines = 'Lines and points';

implementation

uses wait, TxtImpExp;

{$R *.DFM}

function TExcF.ConnectExc: boolean;
begin
  ShowModal;
  Result := ModalResult = mrOK;
  if ModalResult = mrOk then begin
    try
      WForm.Show;
      Application.ProcessMessages;
      ExcApp.Connect;
      Application.ProcessMessages;


      (*  procedure Formname.CopytoClipboardandLExc1Click(Sender: TObject);
var
  e id : integer;
  WS:  Worksheet;
begin
  CopyGridToClipboard(dbgrid1);
  try
  begin
    ExcelApplication1 := Texcelapplication.Create(self);
    ExcelApplication1.Connect;
    e id := getuserdefaultlcid; //Gets the current user default locale ID
    ExcelApplication1.Workbooks.Add(emptyparam, e id);
    ExcelApplication1.Visible[e id] := true;

    WS := ExcelApplication1.Activesheet as  Worksheet;
    WS.Paste(EmptyParam, EmptyParam, e id);
    WS.Range['A1', 'A1'].EntireRow.Font.FontStyle := 'Bold'; //make 1st row bold
//    WS.Range['A1', 'Z1'].EntireColumn.Resize[emptyparam, emptyparam]; //not working - want to re-size col.
  end
  finally
    ExcelApplication1.Disconnect;
    ExcelApplication1.Quit;
  end;
end;

The answer is "autofit":
    WS.Range['A1', 'Z1'].EntireColumn.AutoFit;
        *)

    except
      on Exception do begin
        ShowMessage(stExNotFound);
        Result := False;
        WForm.Close;
        Exit;
      end;
    end;
    try
       {lcid := GetUserDefaultLCID;}
      LCID := 0;
      ExcVersion := ExcApp.Version[LCID];
      { ExcVer:=StrToInt(Copy(ExcVersion,1,1));
       if ExcVer<8 then begin
          ShowMessage(stVersion+ExcVersion+stNotSupVer);
         Result := False;
        Exit;
       end; }
      if ExcApp.Workbooks.Count = 0 then
        WbCount := 0;
      if CheckBox1.Checked or (WbCount = 0) then begin

        if WbCount = 0 then begin
          ExcApp.Workbooks.Add(xlWBATWorksheet, LCID);
          ExcApp.Workbooks[1].Activate(LCID);
          ExcApp.Workbooks[1].Windows[1].Caption := 'Import from PETROS';
          Inc(WbCount);
        end else begin
          ExcApp.Workbooks[1].Worksheets.Add(EmptyParam, EmptyParam, 1, xlWBATWorksheet, LCID);
          Inc(WbCount);
        end;
      end;
    except
      on Exception do begin
        ShowMessage(stExNotFound);
        Result := False;
        ExcApp.Disconnect;
        WForm.Close;
      end;
    end;
  end;
end;


procedure TExcF.ExportChartToExc(G: TGeoChart; Title: string; Standart: Boolean;
  Diagr: TDiagram);
var X1, Y1, i, k, XMax: integer;
  V: OleVariant;
  EChart, EApp: Variant;
  ARange: array[0..1, 0..50] of Variant;
  DRange: array[0..1, 0..80] of Variant;
  IRange: array[0..1, 0..39] of Variant;
begin
  if ConnectExc then begin
    try
      Y1 := Round(NumInp1.Value); {First Column}
      X1 := Round(NumInp2.Value); {First Row}
      ExcApp.Cells.Item[X1, Y1 + 1] := Title;
      ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 1], ExcApp.Cells.Item[X1, Y1 + 1]].Font.Size := 12;
      ExcApp.Cells.Item[X1 + 1, Y1] := stAx;
      ExcApp.Cells.Item[X1 + 2, Y1 + 1] := 'Y = ' + G.Axises[1].Title;
      if G.Spaid then begin
        ExcApp.Cells.Item[X1 + 1, Y1 + 1] := 'X = ';
        for i := 0 to G.SPLabelsValues.Count - 1 do
          ExcApp.Cells.Item[X1 + 1, Y1 + 2 + i] := G.SPLabelsValues.Strings[i];
      end else
        ExcApp.Cells.Item[X1 + 1, Y1 + 1] := 'X = ' + G.Axises[0].Title;
      ExcApp.Cells.Item[X1 + 3, Y1] := stSer;
      for i := 0 to G.Series.Count - 1 do
        ExcApp.Cells.Item[X1 + 3 + i, Y1 + 1] := IntToStr(i + 1) + ' - ' + G.Series[i].Name;
      ExcApp.Range[ExcApp.Cells.Item[X1, Y1], ExcApp.Cells.Item[X1 + 5 + G.Series.Count, Y1 + 3 * G.Series.Count]].Font.Bold := True;

      X1 := X1 + 5 + G.Series.Count;
      XMax := 0;
      if G.Spaid then begin
        for i := 0 to G.SPLabelsValues.Count - 1 do
          ExcApp.Cells.Item[X1 + 1 + i, Y1] := G.SPLabelsValues.Strings[i];
        {ExcApp.Range[, ExcApp.Cells.Item[X1 + G.SPLabelsValues.Count, Y1]].Value := V;}
        for k := 0 to G.Series.Count - 1 do begin
          ExcApp.Cells.Item[X1, Y1 + k + 1] := 'Y' + IntToStr(k + 1);
          V := VarArrayCreate([0, G.Series[k].Count - 1, 0, 0], varVariant);
          for i := 0 to G.Series[k].Count - 1 do begin
            V[i, 0] := G.Series[k].Items[i].Value.Y;
          end;
          ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + k + 1], ExcApp.Cells.Item[X1 + G.Series[k].Count, Y1 + k + 1]].Value := V;
          ARange[0, k] := ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1], ExcApp.Cells.Item[X1 + G.Series[k].Count, Y1]];
          ARange[1, k] := ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + k + 1], ExcApp.Cells.Item[X1 + G.Series[k].Count, Y1 + k + 1]];
        end
      end else
        for k := 0 to G.Series.Count - 1 do begin
          ExcApp.Cells.Item[X1, Y1 + 3 * k] := 'X' + IntToStr(k + 1);
          ExcApp.Cells.Item[X1, Y1 + 3 * k + 1] := 'Y' + IntToStr(k + 1);
          ExcApp.Cells.Item[X1, Y1 + 3 * k + 2] := 'ID' + IntToStr(k + 1);
          V := VarArrayCreate([0, G.Series[k].Count - 1, 0, 2], varVariant);
          for i := 0 to G.Series[k].Count - 1 do begin
            V[i, 0] := G.Series[k].Items[i].Value.X;
            V[i, 1] := G.Series[k].Items[i].Value.Y;
            V[i, 2] := G.Series[k].Items[i].Label1;
          end;
          if XMax < X1 + G.Series[k].Count then
            XMax := X1 + G.Series[k].Count;
          ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + 3 * k], ExcApp.Cells.Item[X1 + G.Series[k].Count, Y1 + 3 * k + 2]].Value := V;
          ARange[0, k] := ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + 3 * k], ExcApp.Cells.Item[X1 + G.Series[k].Count, Y1 + 3 * k]];
          ARange[1, k] := ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + 3 * k + 1], ExcApp.Cells.Item[X1 + G.Series[k].Count, Y1 + 3 * k + 1]];
        end;
      X1 := XMax + 2;
      if Standart then begin
        XMax := X1;
        if Diagr.Count > 0 then begin
          ExcApp.Cells.Item[X1, Y1 + 1] := stFields;
          ExcApp.Cells.Item[X1, Y1 + 1].Font.Bold := True;
          Inc(X1, 2);
          XMax := X1;
          for k := 0 to Diagr.Count - 1 do begin
            ExcApp.Cells.Item[X1 - 1, Y1 + 2 * k] := TVerCollection(Diagr.Items[k]).Name1;

            V := VarArrayCreate([0, TVerCollection(Diagr.Items[k]).Count - 1, 0, 1], varVariant);
            for i := 0 to TVerCollection(Diagr.Items[k]).Count - 1 do begin
              V[i, 0] := TOPoint(TVerCollection(Diagr.Items[k]).Items[i]).X;
              V[i, 1] := TOPoint(TVerCollection(Diagr.Items[k]).Items[i]).Y;
            end;
            ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 2 * k], ExcApp.Cells.Item
              [X1 + TVerCollection(Diagr.Items[k]).Count - 1, Y1 + 2 * k + 1]].Value := V;
            DRange[0, k] := ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 2 * k], ExcApp.Cells.Item
              [X1 + TVerCollection(Diagr.Items[k]).Count - 1, Y1 + 2 * k]];
            DRange[1, k] := ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 2 * k + 1], ExcApp.Cells.Item
              [X1 + TVerCollection(Diagr.Items[k]).Count - 1, Y1 + 2 * k + 1]];
            if XMax < X1 + TVerCollection(Diagr.Items[k]).Count then
              XMax := X1 + TVerCollection(Diagr.Items[k]).Count;
          end
        end;
        if Diagr.Interv.Count > 0 then begin
          X1 := XMax + 1;
          ExcApp.Cells.Item[X1, Y1 + 1] := stInterv;
          ExcApp.Cells.Item[X1, Y1 + 1].Font.Bold := True;
          inc(X1, 2);
          for k := 0 to Diagr.Interv.Count - 1 do begin
            if TInterval(Diagr.Interv[k]).Name <> '' then
              ExcApp.Cells.Item[X1 - 1, Y1 + 2 * k] := TInterval(Diagr.Interv[k]).Name
            else
              ExcApp.Cells.Item[X1 - 1, Y1 + 2 * k] := k + 1;
            V := VarArrayCreate([0, 3, 0, 1], varVariant);
            if TInterval(Diagr.Interv[k]).TypCod = 0 then begin
              V[0, 0] := TInterval(Diagr.Interv[k]).X;
              V[0, 1] := G.Axises[1].Minimum;
              V[1, 0] := TInterval(Diagr.Interv[k]).X;
              V[1, 1] := G.Axises[1].Maximum;
              V[2, 0] := TInterval(Diagr.Interv[k]).Y;
              V[2, 1] := G.Axises[1].Minimum;
              V[3, 0] := TInterval(Diagr.Interv[k]).Y;
              V[3, 1] := G.Axises[1].Maximum;
            end else begin
              V[0, 0] := G.Axises[0].Minimum;
              V[0, 1] := TInterval(Diagr.Interv[k]).X;
              V[1, 0] := G.Axises[0].Maximum;
              V[1, 1] := TInterval(Diagr.Interv[k]).X;
              V[2, 0] := G.Axises[0].Minimum;
              V[2, 1] := TInterval(Diagr.Interv[k]).Y;
              V[3, 0] := G.Axises[0].Maximum;
              V[3, 1] := TInterval(Diagr.Interv[k]).Y;
            end;
            ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 2 * k], ExcApp.Cells.Item
              [X1 + 3, Y1 + 2 * k + 1]].Value := V;
            IRange[0, 2 * k] := ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 2 * k], ExcApp.Cells.Item
              [X1 + 1, Y1 + 2 * k]];
            IRange[1, 2 * k] := ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 2 * k + 1], ExcApp.Cells.Item
              [X1 + 1, Y1 + 2 * k + 1]];
            IRange[0, 2 * k + 1] := ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1 + 2 * k], ExcApp.Cells.Item
              [X1 + 3, Y1 + 2 * k]];
            IRange[1, 2 * k + 1] := ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1 + 2 * k + 1], ExcApp.Cells.Item
              [X1 + 3, Y1 + 2 * k + 1]];
          end;
          Inc(X1, 2);
        end;
        if Diagr.Lines.Count > 0 then begin

        end;
      end;
      if ExcVer = 8 then begin
        EAPP := ExcApp.Charts;
        EChart := EApp.Add(EmptyParam, EmptyParam, 1);
         {EChart := ExcApp.Charts.Add(EmptyParam, EmptyParam,1,EmptyParam,LCID);}
      end else
        EChart := ExcApp.Charts.Add(EmptyParam, EmptyParam, EmptyParam, EmptyParam, LCID);
      if G.Spaid then
        EChart.ChartType := xlLineMarkers
      else
        EChart.ChartType := xlXYScatter;
      {EChart.SeriesCollection.Item(1).Values:=ARange[1,0];
      EChart.SeriesCollection.Item(1).XValues:=ARange[0,0];}
      for i := 0 to G.Series.Count - 1 do begin
        EChart.SeriesCollection.Add(ARange[1, i], xlColumns, False, False, False);
        EChart.SeriesCollection.Item(i + 1).XValues := ARange[0, i];
        EChart.SeriesCollection.Item(i + 1).Name := G.Series[i].Name;
      end;
      i := EChart.SeriesCollection.Count;
      if Standart then begin
        if Diagr.Count > 0 then
          for k := 0 to Diagr.Count - 1 do begin
            EChart.SeriesCollection.Add(DRange[1, k],
              xlColumns, False, False, False);
            EChart.SeriesCollection.Item(k + i + 1).XValues := DRange[0, k];
            EChart.SeriesCollection.Item(k + i + 1).ChartType := xlXYScatterLinesNoMarkers;
            EChart.SeriesCollection.Item(k + i + 1).Border.Color := RGB(0, 0, 0);
          end;
        if Diagr.Interv.Count > 0 then begin
          i := EChart.SeriesCollection.Count;
          for k := 0 to Diagr.Interv.Count * 2 - 1 do begin
            EChart.SeriesCollection.Add(IRange[1, k],
              xlColumns, False, False, False);
            EChart.SeriesCollection.Item(k + i + 1).XValues := IRange[0, k];
            EChart.SeriesCollection.Item(k + i + 1).ChartType := xlXYScatterLinesNoMarkers;
            EChart.SeriesCollection.Item(k + i + 1).Border.LineStyle := xlDash;
            EChart.SeriesCollection.Item(k + i + 1).Border.Color := RGB(0, 0, 0);
          end;
        end;
        if Diagr.Lines.Count > 0 then begin

        end;
      end;


      if G.Spaid then begin

      end else begin
        if G.Axises[0].Logarithmic then
          EChart.Axes(xlCategory, EmptyParam).ScaleType := xlScaleLogarithmic;
        EChart.Axes(xlCategory, EmptyParam).MaximumScale := G.Axises[0].Maximum;
        if G.Axises[0].Logarithmic then
          EChart.Axes(xlCategory, EmptyParam).MinimumScale := G.Axises[0].Minimum
        else
          EChart.Axes(xlCategory, EmptyParam).MinimumScale := G.Axises[0].Label0;
      end;
      if G.Axises[1].Logarithmic then begin
        EChart.Axes(xlValue, EmptyParam).ScaleType := xlScaleLogarithmic;
        EChart.Axes(xlValue, EmptyParam).CrossesAt := G.Axises[1].Minimum;
        EChart.Axes(xlValue, EmptyParam).MaximumScale := G.Axises[1].Maximum;
        EChart.Axes(xlValue, EmptyParam).CrossesAt := G.Axises[1].Minimum;
        EChart.Axes(xlValue, EmptyParam).MinimumScale := G.Axises[1].Minimum;
      end else begin
        EChart.Axes(xlValue, EmptyParam).MaximumScale := G.Axises[1].Maximum;
        EChart.Axes(xlValue, EmptyParam).MinimumScale := G.Axises[1].Label0;
      end;
      EChart.HasLegend := G.Legend.Visible;
      if G.Legend.Visible then
        for k := EChart.SeriesCollection.Count downto G.Series.Count + 1 do
          EChart.Legend.LegendEntries(k).Delete;
      EChart.PlotArea.Fill.ForeColor.SchemeColor := 2;
      EChart.Axes(xlValue, EmptyParam).HasTitle := True;
      EChart.Axes(xlCategory, EmptyParam).HasTitle := True;
      EChart.Axes(xlValue, EmptyParam).AxisTitle.Font.Size := 12;
      EChart.Axes(xlCategory, EmptyParam).AxisTitle.Font.Size := 12;
      EChart.Axes(xlValue, EmptyParam).AxisTitle.Text := G.Axises[1].Title;
      EChart.Axes(xlCategory, EmptyParam).AxisTitle.Text := G.Axises[0].Title;

      EChart.Axes(xlCategory, EmptyParam).HasMajorGridlines := G.Axises[0].GridVisible;
      if G.Axises[0].GridVisible then
        EChart.Axes(xlCategory, EmptyParam).MajorGridlines.Border.LineStyle := xlDash;
      EChart.Axes(xlCategory, EmptyParam).HasMinorGridlines := G.Axises[0].MinorGridVisible;
      if G.Axises[0].MinorGridVisible then
        EChart.Axes(xlCategory, EmptyParam).MinorGridlines.Border.LineStyle := xlDash;
      EChart.Axes(xlCategory, EmptyParam).MinorTickMark := xlTickMarkOutside;
      EChart.Axes(xlValue, EmptyParam).HasMajorGridlines := G.Axises[1].GridVisible;
      if G.Axises[1].GridVisible then
        EChart.Axes(xlValue, EmptyParam).MajorGridlines.Border.LineStyle := xlDash;
      EChart.Axes(xlValue, EmptyParam).HasMinorGridlines := G.Axises[1].MinorGridVisible;
      if G.Axises[1].MinorGridVisible then
        EChart.Axes(xlValue, EmptyParam).MinorGridlines.Border.LineStyle := xlDash;
      EChart.Axes(xlValue, EmptyParam).MinorTickMark := xlTickMarkOutside;

      for i := 0 to G.Series.Count - 1 do begin
        EChart.SeriesCollection.Item(i + 1).MarkerSize := G.Series[i].MarkHeight;
        EChart.SeriesCollection.Item(i + 1).MarkerBackgroundColor := ColorToRGB(G.Series[i].Color);
        EChart.SeriesCollection.Item(i + 1).MarkerForegroundColor := ColorToRGB(G.Series[i].PenColor);
        if G.Series[i].Approximation = apPolinom then begin
          if G.Series[i].Power < 2 then
            EChart.SeriesCollection.Item(i + 1).Trendlines.Add(xlLinear, EmptyParam,
              EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam)
          else begin
            if G.Series[i].Power <= 6 then k := G.Series[i].Power
            else k := 6;
            EChart.SeriesCollection.Item(i + 1).Trendlines.Add(xlPolynomial, k,
              EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
          end;
          case G.Series[i].LineStyle of
            psDot: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.LineStyle := xlDot;
            psDash: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.LineStyle := xlDash;
            psDashDot: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.LineStyle := xlDashDot;
            psDashDotDot: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.LineStyle := xlDashDotDot;
          end;
          EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.Color := ColorToRGB(G.Series[i].Color);
          case G.Series[i].LineWidth of
            1: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.Weight := xlThin;
            2: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.Weight := xlMedium;
            3..20: EChart.SeriesCollection.Item(i + 1).Trendlines[1].Border.Weight := xlThick;
          end;
        end;
      end;
      {if not G.Spaid then}
      for i := 0 to G.Series.Count - 1 do begin
        case G.Series[i].Kind of
          stLine: begin
              if not G.Spaid then begin
                case G.Series[i].LineType of
                  ltNone: EChart.SeriesCollection.Item(i + 1).ChartType := xlXYScatter;
                  ltStraight: EChart.SeriesCollection.Item(i + 1).ChartType := xlXYScatterLinesNoMarkers;
                  ltBesier: EChart.SeriesCollection.Item(i + 1).ChartType := xlXYScatterSmoothNoMarkers;
                end;
              end else
                EChart.SeriesCollection.Item(i + 1).MarkerStyle := xlMarkerStyleNone;
              if G.Series[i].LineType <> ltNone then
                case G.Series[i].LineStyle of
                  psDot: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDot;
                  psDash: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDash;
                  psDashDot: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDashDot;
                  psDashDotDot: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDashDotDot;
                end;
              EChart.SeriesCollection.Item(i + 1).Border.Color := ColorToRGB(G.Series[i].Color);
              case G.Series[i].LineWidth of
                1: EChart.SeriesCollection.Item(i + 1).Border.Weight := xlThin;
                2: EChart.SeriesCollection.Item(i + 1).Border.Weight := xlMedium;
                3..20: EChart.SeriesCollection.Item(i + 1).Border.Weight := xlThick;
              end;
            end;

          stPointLine: begin
              if not G.Spaid then begin
                case G.Series[i].LineType of
                  ltNone: EChart.SeriesCollection.Item(i + 1).ChartType := xlXYScatter;
                  ltStraight: EChart.SeriesCollection.Item(i + 1).ChartType := xlXYScatterLines;
                  ltBesier: EChart.SeriesCollection.Item(i + 1).ChartType := xlXYScatterSmooth;
                end;
              end;
              if G.Series[i].LineType <> ltNone then
                case G.Series[i].LineStyle of
                  psDot: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDot;
                  psDash: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDash;
                  psDashDot: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDashDot;
                  psDashDotDot: EChart.SeriesCollection.Item(i + 1).Border.LineStyle := xlDashDotDot;
                end;
              EChart.SeriesCollection.Item(i + 1).Border.Color := ColorToRGB(G.Series[i].Color);
              case G.Series[i].LineWidth of
                1: EChart.SeriesCollection.Item(i + 1).Border.Weight := xlThin;
                2: EChart.SeriesCollection.Item(i + 1).Border.Weight := xlMedium;
                3..20: EChart.SeriesCollection.Item(i + 1).Border.Weight :=xlThick;
              end;
            end;
        end;
      end;

      if G.Title.Visible or (Title <> '') then begin
        EChart.HasTitle := True;
        if Title <> '' then
          EChart.ChartTitle.Characters.Text := Title
        else
          EChart.ChatrTitle.Characters.Text := G.Title.Text;
        EChart.ChartTitle.Font.Size := 14;
      end else
        EChart.HasTitle := False;
      ExcApp.Visible[LCID] := True;
    finally
      ExcApp.Disconnect;
      WForm.Close;
    end;
  end;
end;

procedure TExcF.ExportSGToExc(SG1: TStringGrid; Title: string; EFC: EExcFormatCell = nil);
var i, j: integer;
  Ncol: integer;
  X1, Y1: integer;
  V: OleVariant;
  NF,FontName: string;
  EColor: TColor;
  EBold,Sep: Boolean;
  Val: Variant;
begin
  if ExpToTextForm.DefExport(nil, SG1, True) then begin
    if ConnectExc then begin
      EColor := 0;
      EBold := False;
      NF := '@';
      try
        NCol := NFields;
        Y1 := Round(NumInp1.Value); {First Column}
        X1 := Round(NumInp2.Value); {First Row}
        ExcApp.Cells.Item[X1, Y1 + 1] := Title;
        ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 1], ExcApp.Cells.Item[X1, Y1 + 1]].Font.Bold := True;
        ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 1], ExcApp.Cells.Item[X1, Y1 + 1]].Font.Size := 12;
        ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1], ExcApp.Cells.Item[X1, Y1 + Ncol - 1]].Font.Bold := True;

        for i := 0 to Ncol - 1 do
          ExcApp.Cells.Item[X1 + 1, Y1 + i] := SG1.Cells[ind[i], 0];
        V := VarArrayCreate([0, Sg1.RowCount - 2, 0, NCol - 1], varVariant);
        ExcApp.Visible[LCID] := True;
        for j := 1 to Sg1.RowCount - 1 do
          for i := 0 to Ncol - 1 do
            V[j - 1, i] := SG1.Cells[ind[i], j];
        if not Assigned(EFC) then
          ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1],
            ExcApp.Cells.Item[Sg1.RowCount + X1, Y1 + NCol - 1]].NumberFormat := '@'
        else begin
          for j := 1 to Sg1.RowCount - 1 do
            for i := 0 to Ncol - 1 do begin
              val := SG1.Cells[ind[i], j];
              EColor := 0;
              EBold := False;
              NF := '@';
              FontName:='';
              Sep:=False;
              EFC(ind[i], j, Val, EColor, EBold, NF,FontName,Sep);
              ExcApp.Range[ExcApp.Cells.Item[X1 + j+1, Y1 + i],
                ExcApp.Cells.Item[X1 + j+1, Y1 + i]].Font.Color := EColor;
              if EBold then
                ExcApp.Range[ExcApp.Cells.Item[X1 + j+1, Y1 + i],
                  ExcApp.Cells.Item[X1 + j+1, Y1 + i]].Font.Bold := True;
              if FontName<>'' then
                 ExcApp.Range[ExcApp.Cells.Item[X1 + j+1, Y1 + i],
                  ExcApp.Cells.Item[X1 + j+1, Y1 + i]].Font.Name:=FontName;
              ExcApp.Range[ExcApp.Cells.Item[X1 + j+1, Y1 + i],
                ExcApp.Cells.Item[X1 + j+1, Y1 + i]].NumberFormat := NF;
                if Sep then begin
                    ExcApp.Range[ExcApp.Cells.Item[X1 + j+1, Y1 + i],
                ExcApp.Cells.Item[X1 + j+1, Y1 + i]].Borders[xlEdgeBottom].LineStyle:=xlContinuous;
                   ExcApp.Range[ExcApp.Cells.Item[X1 + j+1, Y1 + i],
                ExcApp.Cells.Item[X1 + j+1, Y1 + i]].Borders[xlEdgeBottom].Weight:={xlThin;//}xlThick;
                end;
            end;
        end;
        ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1], ExcApp.Cells.Item[Sg1.RowCount + X1, Y1 + NCol - 1]].Value := V;
        for i := 0 to NCol - 1 do
          ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + i],
            ExcApp.Cells.Item[X1 + Sg1.RowCount, Y1 + i]].AutoFormat
            (xlRangeAutoFormatClassic1, False, False, False, False, False, EmptyParam);
      finally
        ExcApp.Disconnect;
        WForm.Close;
      end;
    end;
  end;

end;

procedure TExcF.ExportTableToExc(G: TDBGrid; Title: string; GetText: TGetCellText; Frm: TForm; EFC: EExcFormatCell = nil);
var i, j: integer;
  Ncol: integer;
  X1, Y1: integer;
  V: OleVariant;
  NF,FontName: string;
  EColor: TColor;
  EBold,Sep: Boolean;
  Val: Variant;
begin
  if ExpToTextForm.DefExport(G, nil, True) then begin
    if ConnectExc then begin
      EColor := 0;
      EBold := False;
      NF := '@';
      try
        NCol := NFields;
        Y1 := Round(NumInp1.Value); {First Column}
        X1 := Round(NumInp2.Value); {First Row}
        ExcApp.Cells.Item[X1, Y1 + 1] := Title;
        ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 1], ExcApp.Cells.Item[X1, Y1 + 1]].Font.Bold := True;
        ExcApp.Range[ExcApp.Cells.Item[X1, Y1 + 1], ExcApp.Cells.Item[X1, Y1 + 1]].Font.Size := 12;

        ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1], ExcApp.Cells.Item[X1, Y1 + Ncol - 1]].Font.Bold := True;
        for i := 0 to Ncol - 1 do
          ExcApp.Cells.Item[X1 + 1, Y1 + i] := G.Columns[ind[i]].Title.Caption;
        ExcApp.Visible[0] := True;
        try
          G.DataSource.DataSet.DisableControls;
          G.DataSource.DataSet.First;
          V := VarArrayCreate([0, G.DataSource.DataSet.RecordCount - 1, 0, NCol - 1], varVariant);
          j := X1 + 2;
          while not G.DataSource.DataSet.Eof do begin
            for i := 0 to NCol - 1 do begin
              if not Assigned(GetText) then
                V[j - X1 - 2, i] := G.DataSource.DataSet[G.Columns.Items[ind[i]].FieldName]
              else
                V[j - X1 - 2, i] := GetText(Frm, ind[i]);
              if Assigned(EFC) then begin
                val := V[j - X1 - 2, i];
                EColor := 0;
                EBold := False;
                NF := '@';
                FontName:='';
                Sep:=False;
                EFC(ind[i], j, Val, EColor, EBold, NF,FontName,Sep);
                ExcApp.Range[ExcApp.Cells.Item[j, Y1 + i],
                  ExcApp.Cells.Item[j, Y1 + i]].Font.Color := EColor;
                if EBold then
                  ExcApp.Range[ExcApp.Cells.Item[j, Y1 + i],
                    ExcApp.Cells.Item[j, Y1 + i]].Font.Bold := True;
                if FontName<>'' then
                 ExcApp.Range[ExcApp.Cells.Item[X1 + j, Y1 + i],
                  ExcApp.Cells.Item[X1 + j, Y1 + i]].Font.Name:=FontName;
                ExcApp.Range[ExcApp.Cells.Item[j, Y1 + i],
                  ExcApp.Cells.Item[j, Y1 + i]].NumberFormat := NF;
                if Sep then begin
                   ExcApp.Range[ExcApp.Cells.Item[j, Y1 + i],
                  ExcApp.Cells.Item[j, Y1 + i]].Borders[xlEdgeBottom].LineStyle:=xlContinuous;
                  ExcApp.Range[ExcApp.Cells.Item[j, Y1 + i],
                  ExcApp.Cells.Item[j, Y1 + i]].Borders[xlEdgeBottom].Weight:=xlThin;//xlThick;
                end;
              end;
            end;
            Inc(j);
            G.DataSource.DataSet.Next;
          end;
          if not Assigned(EFC) then begin
            if not CheckBox2.Checked then begin
              for i := 0 to NCol - 1 do
                if Assigned(G.Columns.Items[ind[i]].Field) and
                  (G.Columns.Items[ind[i]].Field.DataType = ftInteger) then
                  ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1 + i],
                    ExcApp.Cells.Item[j - 1, Y1 + i]].NumberFormat := '######0'
                else if Assigned(G.Columns.Items[ind[i]].Field) and
                  (G.Columns.Items[ind[i]].Field.DataType = ftFloat) then
                  ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1 + i],
                    ExcApp.Cells.Item[j - 1, Y1 + i]].NumberFormat := '####0.########'
                else
                  ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1 + i],
                    ExcApp.Cells.Item[j - 1, Y1 + i]].NumberFormat := '@';
            end else
              ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1],
                ExcApp.Cells.Item[j - 1, Y1 + NCol - 1]].NumberFormat := '@';
          end;

          ExcApp.Range[ExcApp.Cells.Item[X1 + 2, Y1], ExcApp.Cells.Item[j - 1, Y1 + NCol - 1]].Value := V;
        finally
          G.DataSource.DataSet.First;
          G.DataSource.DataSet.EnableControls;
        end;
        for i := 0 to NCol - 1 do
          ExcApp.Range[ExcApp.Cells.Item[X1 + 1, Y1 + i],
            ExcApp.Cells.Item[j, Y1 + i]].AutoFormat
            (xlRangeAutoFormatClassic1, False, False, False, False, False, EmptyParam);

      finally
        ExcApp.Disconnect;
        WForm.Close;
      end;
    end;
  end;
end;

procedure TExcF.FormCreate(Sender: TObject);
begin
  LCID := getuserdefaultlcid;
end;

procedure TExcF.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

end.

