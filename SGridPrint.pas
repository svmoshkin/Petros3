unit SGridPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls, StdCtrls, MButton, FormStylist, Hintctrl,
  Math, db, qrprntr, printers, {Globals,} dbgrids, RHAGlobs, TntStdCtrls;

type
  TfQRep = class(TForm)
    Panel1: TPanel;
    MButton2: TMButton;
    MButton3: TMButton;
    MButton4: TMButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: THListBox;
    ListBox2: THListBox;
    MButton5: TMButton;
    MButton6: TMButton;
    MButton7: TMButton;
    MButton8: TMButton;
    MButton9: TMButton;
    MButton10: TMButton;
    MButton11: TMButton;
    TitleFontDialog: TFontDialog;
    PrintDialog1: TPrintDialog;
    Label1: TLabel;
    ColumnFontDialog: TFontDialog;
    DetailFontDialog: TFontDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    HEdit1: THEdit;
    Label4: TLabel;
    AttribFontDialog: TFontDialog;
    MButton12: TMButton;
    Label5: TLabel;
    MCheckRadioBox1: TCheckBox;
    MCheckRadioBox2: TCheckBox;
    MCheckRadioBox4: TCheckBox;
    MCheckRadioBox5: TCheckBox;
    MButton1: TButton;
    procedure MButton2Click(Sender: TObject);
    procedure MButton3Click(Sender: TObject);
    procedure MButton9Click(Sender: TObject);
    procedure MButton10Click(Sender: TObject);
    procedure MButton11Click(Sender: TObject);
    procedure MButton5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MButton6Click(Sender: TObject);
    procedure MButton7Click(Sender: TObject);
    procedure MButton8Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MButton12Click(Sender: TObject);
    procedure MCheckRadioBox1Click(Sender: TObject);
    procedure HEdit1Change(Sender: TObject);
  private
    { Private declarations }
    procedure ReportClear(theQRLabel: TQRLabel; theQRDBText: TQRDBText); // Tarasov
  public
    RepList: TStringList; // Tarasov
    theQR1: TQuickRep; // Tarasov
    PrintSize: Extended;
    Change: boolean;
   { DMSys : TDMSys;}
    DBG: TDBGrid;
    Title: string;
    GetTxt : TGetCellText;
    { Public declarations }
    procedure DefineReport(theTitleFont, theColFont, theDetFont: TFont);
    procedure SetButtons;
    procedure QRLabelPrint(sender: TObject; var Value: string);
  end;


var
  fQRep: TfQRep;
  TitleLabel: TQRLabel;
  theQR1: TQuickRep; // Tarasov
  thePart: integer;
  theLeft: integer; // Добавил Тарасов
  HasParts: boolean;
  theOrient: TPrinterOrientation;
  GenWidth, thePageWidth: Extended;

resourcestring
              stDate='Date';
              stList='Page';
              stTime='Time';
              stPart='. Part ';

procedure DBGridPrint(SG: TDBGrid; Title: string; GetText : TGetCellText); stdcall; export;

implementation

uses RepLstViewUnit {, PreviewUnit};

{$R *.DFM}

procedure DBGridPrint(SG: TDBGrid; Title: string;GetText : TGetCellText);
var i: Integer;
begin
  try
    SG.DataSource.DataSet.DisableControls;
    fQRep := TfQRep.Create(Application);
   { fQRep.DMSys:=DMS;}
    fQRep.DBG := SG;
    fQRep.Title := Title;
    fQRep.GetTxt:=GetText;
    for i := 0 to SG.Columns.Count - 1 do
      if SG.Columns[i].Visible then
        fQRep.ListBox2.Items.AddObject(SG.Columns[i].Title.Caption, SG.Columns[i]);
      {else
        fQRep.ListBox1.Items.AddObject(SG.Columns[i].Title.Caption, SG.Columns[i]);}
    fQRep.ShowModal;
  finally
    SG.DataSource.DataSet.EnableControls;
    fQRep.Free;
  end;

end;

procedure TfQRep.MButton2Click(Sender: TObject);
begin
  try
    Screen.Cursor := crHourglass;
    if Change then
      DefineReport(TitleFontDialog.Font, ColumnFontDialog.Font, DetailFontDialog.Font);
    if HasParts then begin
      if not Assigned(RepLstViewFrm) then
        RepLstViewFrm := TRepLstViewFrm.Create(Application);
      RepLstViewFrm.ShowModal;
    end
    else begin
      Screen.Cursor := crDefault;
             //fQRep.thepagecount := 0;
     // fPreview.QRPreview1.PageNumber := 1;
     { theQR1.PreviewModal;
      fPreview.ShowModal;}
      theQR1.Preview;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfQRep.MButton3Click(Sender: TObject);
var i: integer;
begin
  if PrintDialog1.Execute then begin
    DefineReport(TitleFontDialog.Font, ColumnFontDialog.Font, DetailFontDialog.Font);
    for i := 0 to Replist.Count - 1 do begin
      fQrep.Repaint;
      TQuickRep(RepList.Objects[i]).Print;
    end;
  end;
end;

procedure TfQRep.MButton9Click(Sender: TObject);
begin
  if TitleFontDialog.Execute then
    Change := True;
end;

procedure TfQRep.MButton10Click(Sender: TObject);
begin
  if ColumnFontDialog.Execute then
    Change := True;
end;

procedure TfQRep.MButton11Click(Sender: TObject);
begin
  if DetailFontDialog.Execute then
    Change := True;
end;

procedure TfQRep.ReportClear(theQRLabel: TQRLabel; theQRDBText: TQRDBText);
var i: integer;
begin
  with theQR1 do begin
    for i := ComponentCount - 1 downto 0 do
      if ((Components[i] is TQRLabel) and (Components[i] = theQRLabel)) or
        ((Components[i] is TQRDBText) and (Components[i] = theQRDBText)) then
        Components[i].Free;
    theLeft := 0;
    GenWidth := 0;
  end;
end;

// Вставка Тарасова № 1. Процедура создания экземпляра отчета

procedure CreateNewRep(var CurQR: TQuickRep; CurDataSet: TDataSet);
var theQRPrinter: TQRPrinter;
begin
  Printer.Refresh;
  thePageWidth := 0;
  CurQR := TQuickRep.Create(fQRep);
  CurQr.Page.Orientation := poLandscape;
  CurQR.Units := Pixels; //MM;
  CurQR.Page.PaperSize := A4;
  CurQr.Page.BottomMargin := 80.0;
  CurQr.Page.TopMargin := 20.0;
  {CurQr.Page.LeftMargin:=10.0;
  CurQr.Page.RightMargin:=0.0; }
  CurQR.Parent := fQRep;
  CurQR.PrinterSettings.PrinterIndex := Printer.PrinterIndex;
  {CurQR.Page.PaperSize := Custom;
  CurQR.Page.Orientation := Printer.Orientation;
  CurQR.Page.Width := GetDeviceCaps(Printer.Handle, HORZSIZE);
  CurQR.Page.Length := GetDeviceCaps(Printer.Handle, VERTSIZE);}

  thePageWidth := CurQR.Page.Width - (CurQR.Page.LeftMargin + CurQR.Page.RightMargin);
 // theQRPrinter := TQRPrinter.Create;
 // theQRPrinter.Orientation := Printer.Orientation;

  with CurQR do begin
    DataSet := CurDataSet;
    with Bands do begin
      HasPageHeader := True;
      HasColumnHeader := True;
      HasDetail := True;
    end;
    if HasParts = False then begin
      TitleLabel := TQRLabel.Create(CurQR);
      TitleLabel.Parent := CurQR.Bands.PageHeaderBand;
      TitleLabel.Alignment := taCenter;
      TitleLabel.AutoSize := True;
      TitleLabel.AlignToBand := True;
      TitleLabel.Caption := fQRep.HEdit1.Text;
    end;
    theLeft := 0;
    GenWidth := 0;
    CurQR.Visible := False;
  end;
end;
// Конец вставки Тарасова № 1

procedure TfQRep.DefineReport(theTitleFont, theColFont, theDetFont: TFont); // Tarasov
var i, k: Integer;
  QRL: TQRLabel;
  QRD: TQRDBText;
  QRS: TQRSysData;
  QRF: TQRShape;
  R, R1: Extended;
const WdSpace = 8;
  procedure SetProp;
  begin
    with theQR1 do begin
      Bands.PageHeaderBand.Font := AttribFontDialog.Font;
      TitleLabel.Font := theTitleFont;
      Bands.ColumnHeaderBand.Font := theColFont;
    {Bands.ColumnHeaderBand.Frame.DrawTop := True;
    Bands.ColumnHeaderBand.Frame.DrawBottom := True; }
      Bands.DetailBand.Font := theDetFont;
    end;

  {if MCheckRadioBox3.Checked then begin
    QRL := TQRLabel.Create(theQR1);
    QRL.Parent := theQR1.Bands.PageHeaderBand;
    QRL.Alignment := taLeftJustify;
    QRL.AutoSize := True;
    QRL.AlignToBand := True;
    DMSys.cdsSysStrings.Locate('ID', ssBurik, []);
    QRL.Caption := DMSys.cdsSysStrings['string'];
    TitleLabel.Top := QRL.Top + QRL.Height + 6;
  end;     }
    theQR1.Bands.PageHeaderBand.Height := TitleLabel.Top + TitleLabel.Height + 6;
    if MCheckRadioBox1.Checked then begin
      QRL := TQRLabel.Create(theQR1);
      QRL.Parent := theQR1.Bands.PageHeaderBand;
      QRL.Alignment := taLeftJustify;
      QRL.AutoSize := True;
      QRL.Caption := stDate+':  ';
      QRL.AlignToBand := True;
      QRL.Top := theQR1.Bands.PageHeaderBand.Height;
      QRS := TQRSysData.Create(theQR1);
      QRS.Parent := theQR1.Bands.PageHeaderBand;
      QRS.Alignment := taLeftJustify;
      QRS.Top := QRL.Top;
      QRS.AutoSize := True;
      QRS.Data := qrsDate;
      QRS.Left := QRL.Left + QRL.Width + 8;
      theQR1.Bands.PageHeaderBand.Height := QRL.Top + QRL.Height + 6;
    end;
    if MCheckRadioBox4.Checked then begin
      QRS := TQRSysData.Create(theQR1);
      QRS.Parent := theQR1.Bands.PageHeaderBand;
      QRS.Alignment := taRightJustify;
      QRS.Top := TitleLabel.Top + TitleLabel.Height + 6;
      QRS.AutoSize := True;
      QRS.Data := qrsPageNumber;
      QRS.AlignToBand := True;
      QRL := TQRLabel.Create(theQR1);
      QRL.Parent := theQR1.Bands.PageHeaderBand;
      QRL.Alignment := taLeftJustify;
      QRL.AutoSize := True;
      QRL.Caption := stList+':  ';
      QRL.Left := QRS.Left - QRL.Width - 6;
      QRL.Top := QRS.Top;

      theQR1.Bands.PageHeaderBand.Height := QRL.Top + QRL.Height + 6;
    end;
    if MCheckRadioBox2.Checked then begin
      QRL := TQRLabel.Create(theQR1);
      QRL.Parent := theQR1.Bands.PageHeaderBand;
      QRL.Alignment := taLeftJustify;
      QRL.AutoSize := True;
      QRL.Caption := stTime+':';
      QRL.AlignToBand := True;
      if MCheckRadioBox1.Checked then
        QRL.Top := theQR1.Bands.PageHeaderBand.Height
      else
        QRL.Top := TitleLabel.Top + TitleLabel.Height + 6;
      QRS := TQRSysData.Create(theQR1);
      QRS.Parent := theQR1.Bands.PageHeaderBand;
      QRS.Alignment := taLeftJustify;
      QRS.Top := QRL.Top;
      QRS.AutoSize := True;
      QRS.Data := qrsTime;
      QRS.Left := QRL.Left + QRL.Width + 8;
      theQR1.Bands.PageHeaderBand.Height := QRL.Top + QRL.Height + 6;
    end;
  end;
begin
  HasParts := False;
  CreateNewRep(theQR1, DBG.DataSource.DataSet);
  SetProp;
  i := 0;
  thePart := 1;
  RepList := TStringList.Create;


  Label1.Font.Assign(theColFont);
  R := Label1.Canvas.TextWidth('Moshkin') / DBG.Canvas.TextWidth('Moshkin');
  Label1.Font.Assign(theDetFont);
  R1 := Label1.Canvas.TextWidth('Moshkin') / DBG.Canvas.TextWidth('Moshkin');
  if R1 > R then
    R := R1;

  while i <= ListBox2.Items.Count - 1 do begin
    with theQR1 do begin
      QRL := TQRLabel.Create(theQR1);
      QRL.Parent := theQR1.Bands.ColumnHeaderBand;
      QRL.Alignment := taCenter;
      QRL.AutoSize := False;
      QRL.Left := theLeft;
      QRL.Width := Round(Max(length(TColumn(ListBox2.Items.Objects[i]).Title.Caption),
        TColumn(ListBox2.Items.Objects[i]).Width) * R) + 1;
      QRL.Caption := TColumn(ListBox2.Items.Objects[i]).Title.Caption;
      QRL.Top := 1;
      TQRBand(QRL.Parent).Height := QRL.Height + 6;
      QRL.Height := TQRBand(QRL.Parent).Height - 1;

      QRD := TQRDBText.Create(theQR1);
      QRD.Parent := theQR1.Bands.DetailBand;

      QRD.AutoSize := False;
      QRD.Top := 0;
      TQRBand(QRD.Parent).Height := QRD.Height + 6;
      QRD.Height := TQRBand(QRD.Parent).Height;
      QRD.Left := theLeft;
      QRD.Width := QRL.Width;
      QRD.DataSet := theQR1.DataSet;
      QRD.DataField := TColumn(ListBox2.Items.Objects[i]).FieldName;
      QRD.Tag:=TColumn(ListBox2.Items.Objects[i]).Index;
      QRD.OnPrint:=QRLabelPrint;
      if QRD.DataSet.FieldByName(QRD.DataField) is TStringField then begin
        QRD.Alignment := taLeftJustify;
        QRL.Alignment := taLeftJustify;
      end else
        QRD.Alignment := taRightJustify;
      if MCheckRadioBox5.Checked then begin
         {}
        QRL.Frame.DrawRight := True;

        QRD.Frame.DrawRight := True;
        if theLeft = 0 then begin
          QRD.Frame.DrawLeft := True;
          QRL.Frame.DrawLeft := True;
        end;
      end;
    end;
    if GenWidth >= thePageWidth then begin
      HasParts := True;

      QRF := TQRShape.Create(theQR1);
      QRF.Parent := theQR1.Bands.ColumnHeaderBand;
      QRF.Top := 0;
      QRF.Left := 0;
      QRF.Height := theQR1.Bands.ColumnHeaderBand.Height;
      QRF.Width := QRL.Left - WdSpace;
      QRF.Shape := qrsRectangle;
      QRF.Brush.Style := bsClear;
      ReportClear(QRL, QRD);
      i := i - 1;
      RepList.AddObject(Title + stPart + IntToStr(thePart), theQR1);
      thePart := thePart + 1;
      {theLeft := 0;
      GenWidth := 0;}
      CreateNewRep(theQR1, DBG.DataSource.DataSet);
      with theQR1 do begin
        Bands.PageHeaderBand.Font := AttribFontDialog.Font;
        Bands.ColumnHeaderBand.Font := theColFont;
        Bands.DetailBand.Font := theDetFont
      end;
    end
    else begin
      GenWidth := GenWidth + QRL.Size.Width + WdSpace;
      inc(theLeft, QRL.Width + WdSpace);
    end;
    i := i + 1;
  end;
  QRF := TQRShape.Create(theQR1);
  QRF.Parent := theQR1.Bands.ColumnHeaderBand;
  QRF.Top := 0;
  QRF.Left := 0;
  QRF.Height := theQR1.Bands.ColumnHeaderBand.Height;
  QRF.Width := QRL.Left + QRL.Width;
  QRF.Shape := qrsRectangle;
  QRF.Brush.Style := bsClear;
  if HasParts = True then
    RepList.AddObject(Title + stPart + IntToStr(thePart), theQR1)
  else
    RepList.AddObject(Title, theQR1);
  Change := False;
end;

procedure TfQRep.MButton5Click(Sender: TObject);
var i: Integer;
begin
  if ListBox1.SelCount > 0 then begin
    for i := 0 to ListBox1.Items.Count - 1 do
      if ListBox1.Selected[i] then
        ListBox2.Items.AddObject(ListBox1.Items[i],
          ListBox1.Items.Objects[i]);
    for i := ListBox1.Items.Count - 1 downto 0 do
      if ListBox1.Selected[i] then
        ListBox1.Items.Delete(i);
    SetButtons;
    Change := True;
  end;
end;

procedure TfQRep.SetButtons;
begin
  MButton5.Enabled := (ListBox1.ItemIndex >= 0);
  MButton6.Enabled := (ListBox2.ItemIndex >= 0);
  MButton7.Enabled := (ListBox1.ItemIndex >= 0);
  MButton8.Enabled := (ListBox2.ItemIndex >= 0);
end;

procedure TfQRep.FormShow(Sender: TObject);
begin
  ListBox1.ItemIndex := 0;
  Change := True; ;
  SetButtons;
  HEdit1.Text := Title;
end;

procedure TfQRep.MButton6Click(Sender: TObject);
var i: Integer;
begin
  if ListBox2.ItemIndex >= 0 then begin
    for i := 0 to ListBox2.Items.Count - 1 do
      if ListBox2.Selected[i] then
        ListBox1.Items.AddObject(ListBox2.Items[i],
          ListBox2.Items.Objects[i]);
    for i := ListBox2.Items.Count - 1 downto 0 do
      if ListBox2.Selected[i] then
        ListBox2.Items.Delete(i);
    SetButtons;
    Change := True;
  end;
end;

procedure TfQRep.MButton7Click(Sender: TObject);
var i: Integer;
begin
  for i := 0 to ListBox1.Items.Count - 1 do
    ListBox2.Items.AddObject(ListBox1.Items[i],
      ListBox1.Items.Objects[i]);
  ListBox1.Items.Clear;
  SetButtons;
  Change := True;
end;

procedure TfQRep.MButton8Click(Sender: TObject);
var i: Integer;
begin
  for i := 0 to ListBox2.Items.Count - 1 do
    ListBox1.Items.AddObject(ListBox2.Items[i],
      ListBox2.Items.Objects[i]);
  ListBox2.Items.Clear;
  SetButtons;
  Change := True;
end;

procedure TfQRep.ListBox1Click(Sender: TObject);
begin
  SetButtons;
end;

procedure TfQRep.FormDestroy(Sender: TObject);
begin
  theQR1.Free;
 // FreeAndNil(fPreview);
  FreeAndNil(RepLstViewFrm);
end;

procedure TfQRep.MButton1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Change := True
end;

procedure TfQRep.FormActivate(Sender: TObject);
begin
 { if not Assigned(fPreview) then
    fPreview := TfPreview.Create(Application);}
end;

procedure TfQRep.MButton12Click(Sender: TObject);
begin
  if AttribFontDialog.Execute then begin
    DefineReport(TitleFontDialog.Font, ColumnFontDialog.Font, DetailFontDialog.Font);
    Change := True;
  end;
end;

procedure TfQRep.MCheckRadioBox1Click(Sender: TObject);
begin
  Change := True;
end;

procedure TfQRep.QRLabelPrint(sender: TObject; var Value: string);
begin
      if Assigned(GetTxt) then begin
          Value:=GetTxt(TForm(DBG.Owner),TComponent(Sender).Tag)+' ';
      end
      else Value:=Value+' ';
end;

procedure TfQRep.HEdit1Change(Sender: TObject);
begin
     Change:=True;
end;

end.

