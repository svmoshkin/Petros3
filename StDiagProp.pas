unit StDiagProp;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, NumInp, ESBRtns,
  Boxes, Mend_C, StDiagrams, Dialogs, Hintctrl, Math, Spin, EDCoefs,
  MoshChart, Chemist, DBCtrls, Mask, Grids, DBGrids, Db, Variants;

type
  TNewDiagr = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label35: TLabel;
    RadioGroup2: TRadioGroup;
    DBEdit1: TDBEdit;
    CheckBox1: TDBCheckBox;
    CheckBox2: TDBCheckBox;
    CheckBox10: TDBCheckBox;
    NumInp21: TDBEdit;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label29: TLabel;
    MendTabl1: TMendTabl;
    BHX: TButton;
    BAX: TButton;
    ListBox3: TListBox;
    Edit2: TDBEdit;
    CheckBox8: TDBCheckBox;
    CheckBox4: TDBCheckBox;
    CheckBox11: TDBCheckBox;
    CheckBox13: TDBCheckBox;
    CheckBox16: TDBCheckBox;
    NumInp3: TDBEdit;
    NumInp4: TDBEdit;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label30: TLabel;
    MendTabl2: TMendTabl;
    Button1: TButton;
    Button2: TButton;
    ListBox4: TListBox;
    Edit3: TDBEdit;
    CheckBox3: TDBCheckBox;
    CheckBox5: TDBCheckBox;
    CheckBox12: TDBCheckBox;
    CheckBox14: TDBCheckBox;
    CheckBox17: TDBCheckBox;
    NumInp5: TDBEdit;
    NumInp6: TDBEdit;
    TabSheet8: TTabSheet;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    MendTabl3: TMendTabl;
    ListBox5: TListBox;
    Edit5: TDBEdit;
    NumInp19: TDBEdit;
    NumInp20: TDBEdit;
    CheckBox9: TDBCheckBox;
    CheckBox15: TDBCheckBox;
    CheckBox18: TDBCheckBox;
    TabSheet4: TTabSheet;
    Label4: TLabel;
    GroupBox9: TGroupBox;
    Label28: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Button8: TButton;
    Button3: TButton;
    Button5: TButton;
    TabSheet5: TTabSheet;
    Label15: TLabel;
    GroupBox4: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    NumInp11: TNumInp;
    NumInp12: TNumInp;
    Button18: TButton;
    HListBox2: THListBox;
    Button15: TButton;
    Button16: TButton;
    TabSheet6: TTabSheet;
    Label22: TLabel;
    GroupBox7: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Button33: TButton;
    GroupBox8: TGroupBox;
    Label26: TLabel;
    ListBox2: TListBox;
    SpinEdit3: TSpinEdit;
    Button25: TButton;
    Button26: TButton;
    Chart1: TGeoChart;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    DBGrid1: THDBGrid;
    DBGrid2: TDBGrid;
    Button6: TButton;
    Label36: TLabel;
    Button4: TButton;
    Button12: TButton;
    Button13: TButton;
    NumInp7: TDBEdit;
    NumInp8: TDBEdit;
    Button7: TButton;
    RadioGroup1: TRadioGroup;
    HDBGrid1: THDBGrid;
    Label2: TLabel;
    DBGrid3: TDBGrid;
    CheckBox7: TDBCheckBox;
    ListBox1: TListBox;
    CheckBox6: TDBCheckBox;
    NumInp17: TDBEdit;
    NumInp18: TDBEdit;
    Button19: TButton;
    Button20: TButton;
    Button9: TButton;
    Button10: TButton;
    Label3: TLabel;
    SpinEdit6: TSpinEdit;
    Label13: TLabel;
    ButtAX: TButton;
    Button11: TButton;
    Button17: TButton;
    ButtT1: TButton;
    Button14: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    CheckBox19: TCheckBox;
    procedure ListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure BHXClick(Sender: TObject);
    procedure BAXClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Chart1AfterDraw(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure Button18Click(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure HListBox2Click(Sender: TObject);
    procedure HListBox2DblClick(Sender: TObject);
    procedure TabSheet6Show(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox4DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure NumInp21Exit(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure NumInp3Exit(Sender: TObject);
    procedure NumInp4Exit(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure MendTabl2Create(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure NumInp5Exit(Sender: TObject);
    procedure NumInp6Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure NumInp19Exit(Sender: TObject);
    procedure NumInp20Exit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure Button12Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HDBGrid1CellClick(Column: TColumn);
    procedure Button9Click(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabSheet6Exit(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure ButtAXClick(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure ButtT1Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure CheckBox19Click(Sender: TObject);
  private
    { Private declarations }
    procedure FieldSet;
    procedure LineSet;
  public
    Diag: TDiagram;
    F: TVerCollection;
    Lin: TCurve;
    InsertByButton: Boolean;
    NotFPointPost: Boolean;
    NotLPointPost: Boolean;
    IntNum: Integer;
    procedure SetMinMax;
    function GetFieldIndex: integer;
    function GetLinIndex: integer;
    function FindPointNum(ID: integer): integer;
    function FindLPointNum(ID: integer): integer;
    procedure AfterPointPost(New: Boolean);
    procedure AfterLPointPost(New: Boolean);
    procedure FieldsControls(Enable: Boolean);
    procedure LinesControls(Enable: Boolean);
    { Public declarations }
  end;

var
  NewDiagr: TNewDiagr;
  AllOK: Boolean;
  PointNum, LPointNum: integer;
  Editing: boolean;
  FirstPost: Boolean;
  LastLabelValue: real;
  MayChange: Boolean;

resourcestring
  stNotAxisForm = 'Formulas for all axis must be not empty!';
  stNewField = 'New field';
  stNewLine = 'New line';
  stFName = 'Field name';
  stFId = 'Classification ID for field';
  stNewInterv = 'New interval';
  stIName = 'Interval name';
  stIId = 'Classification ID for interval';
  stChangeIntName = 'Edit interval name';
  stChangeIID = 'Edit ID for interval';
  stNotEmpty = 'Name must be not empty';
  stEditField = 'Edit field properties';
  stLineEd = 'Editing of line';
  stLName = 'Line name';
  stMustEnd = 'You must complete operation with object!';
  stNotEnPoints = 'Field must have at least 3 points!';


implementation

uses TrioGraph, RHAGlobs, DMod1;

{$R *.DFM}

procedure TNewDiagr.ListBox1Click(Sender: TObject);
begin
  if Assigned(F) then begin
    F.Style := TPenStyle(ListBox1.ItemIndex);
    DM1.TbFields['PenStyle'] := ListBox1.ItemIndex;
    Chart1.Paint;
  end;
end;

procedure TNewDiagr.FormShow(Sender: TObject);
var
  i: integer;
begin
  OkBtn.Enabled := true;
  Button5.Enabled := True;
  Button3.Enabled := True;
  Button15.Enabled := True;
  HListBox2.Enabled := True;
  if DM1.TbDiagr.State = dsEdit then begin
    DM1.TbDiagr['XMin'] := Diag.Xax.Min;
    DM1.TbDiagr['XMax'] := Diag.Xax.Max;
    DM1.TbDiagr['YMin'] := Diag.Yax.Min;
    DM1.TbDiagr['YMax'] := Diag.Yax.Max;
    DM1.TbDiagr['ZMin'] := Diag.Zax.Min;
    DM1.TbDiagr['ZMax'] := Diag.Zax.Max;
    DM1.TbDiagr['ShowGrid'] := Diag.ShowGrid;
    DM1.TbDiagr['ShowNames'] := Diag.ShowNames;
  end else
    DM1.TbDiagr.Edit;
  SpinEdit6.Value:=Diag.AlphaN;
  if Diag.Trio then begin
    Chart1.BeginUpdate;
    Chart1.Axises[0].Minimum := 0;
    Chart1.Axises[1].Minimum := 0;
    Chart1.Axises[0].Maximum := Diag.Xax.max;
    Chart1.Axises[0].Minimum := Diag.Xax.Min;
    Chart1.Axises[1].Maximum := Diag.Yax.max;
    Chart1.Axises[1].Minimum := Diag.Yax.Min;
    Chart1.EndUpdate;
    SetMinMax;
  end;

  CheckBox16Click(Sender);
  CheckBox17Click(Sender);
  CheckBox18Click(Sender);
  CheckBox8Click(Sender);
  CheckBox3Click(Sender);

  CheckBox2Click(Sender);
  CheckBox19.Checked:=Diag.Cod=100;
  Chart1.Title.Text := Diag.Name;
  MendTabl1.Text := Diag.Xax.Formula;
  MendTabl2.Text := Diag.Yax.Formula;
  MendTabl3.Text := Diag.Zax.Formula;
  {CheckBox2.Checked := Diag.ShowGrid;}
  PageControl1.ActivePage := TabSheet1;
  Dm1.TbFields.First;
  if Diag.Count > 0 then begin
    {F := TVerCollection(Diag.First);}
    FieldsControls(True);
    DBGrid1CellClick(nil);
  end else
    FieldsControls(False);
  DM1.TbLines.First;
  if Diag.Lines.Count > 0 then begin
    LinesControls(True);
    HDBGrid1CellClick(nil);
  end else
    LinesControls(False);
  HListBox2.Clear;
  for i := 0 to Diag.interv.Count - 1 do
    HListBox2.Items.Add(TInterval(Diag.Interv[i]).Name);
  if HListBox2.Items.Count > 0 then begin
    HListBox2.ItemIndex := 0;
    HListBox2Click(nil);
  end;
  ListBox3.Clear;
  ListBox4.Clear;
  ListBox5.Clear;
  ListBox3.Items.Assign(Coefs.IDs);
  ListBox4.Items.Assign(Coefs.IDs);
  ListBox5.Items.Assign(Coefs.IDs);
  MendTabl1.SelectAll;
  MendTabl2.SelectAll;
  MendTabl3.SelectAll;
  if Diag.Trio then
    RadioGroup2.ItemIndex := 1
  else
    RadioGroup2.ItemIndex := 0;
  RadioGroup2Click(Sender);
  NumInp3Exit(Sender);
  NumInp5Exit(Sender);
  MayChange := True;
end;

procedure TNewDiagr.OKBtnClick(Sender: TObject);
var i: Integer;
begin
  Diag.Classification := CheckBox10.Checked;
  Diag.AlphaN:=SpinEdit6.Value;
  Diag.Name := DBEdit1.Text;
  if Diag.Name = '' then begin
    ShowMessage(stNotEmpty);
    AllOK := False;
    PageControl1.ActivePageIndex := 0;
    exit;
  end;
  SetMinMax;
  Diag.Xax.Caption := Edit2.Text;
  Diag.Yax.Caption := Edit3.Text;
  Diag.Zax.Caption := Edit5.Text;
  Diag.Xax.Formula := MendTabl1.Text;
  Diag.Yax.Formula := MendTabl2.Text;
  Diag.Zax.Formula := MendTabl3.Text;
  if (Diag.Xax.Formula = '') or (Diag.Yax.Formula = '') or
    (Diag.Trio and (Diag.Xax.Formula = '')) then begin
    ShowMessage(stNotAxisForm);
    AllOK := False;
    exit;
  end;
   if DM1.TbFields.State <> dsBrowse then
    DM1.TbFields.Post;
  AllOK := MayChange;
 
  if DM1.TBFPoint.State <> dsBrowse then
    DM1.TBFPoint.Post;
  if DM1.TbLines.State <> dsBrowse then
    DM1.TbLines.Post;
  if DM1.TBLPoint.State <> dsBrowse then
    DM1.TBLPoint.Post;
      { NotFPointPost:=true;
  with Dm1.TbFields do begin
       First;
       while not eof do
             Delete;
  end;
  for i := 0 to Diag.Count - 1 do begin
    try
      DM1.TbFields.Insert;
      TVerCollection(Diag.Items[i]).SaveToTable(DM1.TbFields, DM1.TbFPoint);
    except
      on Exception do
        DM1.TbFields.Cancel;
    end;
  end;
  NotFPointPost:=False; }
end;

procedure TNewDiagr.TabSheet4Show(Sender: TObject);
begin
  MayChange := True;
  if Assigned(Diag) and (Diag.Count > 0) then
    FieldSet;
end;

procedure TNewDiagr.BHXClick(Sender: TObject);
begin
  MendTabl1.InsertText('En');
end;

procedure TNewDiagr.BAXClick(Sender: TObject);
begin
  MendTabl1.InsertText('An');
end;

procedure TNewDiagr.Button1Click(Sender: TObject);
begin
  MendTabl2.InsertText('En');
end;

procedure TNewDiagr.Button2Click(Sender: TObject);
begin
  MendTabl2.InsertText('An');
end;

procedure TNewDiagr.Button5Click(Sender: TObject);
begin
  if DM1.TbFPoint.State <> dsBrowse then
    DM1.TbFPoint.Post;
  try
  if DM1.TbFields.State <> dsBrowse then
    DM1.TbFields.Post;
  except
        on EAbort do
           Exit;
  end;
  Dm1.TbFields.Append;
  Dm1.TbFields['Name1'] := 'Field' + IntToStr(Diag.Count + 1);
  if Diag.Classification then
    Dm1.TbFields['ClassId']:='F'+IntToStr(Diag.Count + 1);
  if Assigned(F) then
    F.UnMark;
  F := TVerCollection.Create(Dm1.TbFields['Name1'], Diag.Count + 1);
  F.Marked := True;
  Dm1.TbFields['Width'] := 1;
  Dm1.TbFields['Bez'] := False;
  Dm1.TbFields['PenStyle'] := 0;
  ListBox1.ItemIndex := 0;
  SpinEdit1.Value := 1;
  FirstPost := True;
  DM1.TbFields.Post;
  FirstPost := False;
  F.Id := Dm1.TbFields['ID'];
  DM1.TbFields.Edit;
  Dm1.TbFields['Width'] := 1;
  Dm1.TbFields['Bez'] := False;
  Dm1.TbFields['PenStyle'] := 0;
  ListBox1.ItemIndex := 0;
  SpinEdit1.Value := 1;
  Diag.Add(f);
  Editing := false;
  FieldsControls(True);
end;

procedure TNewDiagr.Button4Click(Sender: TObject);
begin
  DM1.TBFPoint.Append;
  { PointNum:=F.Count-1;}
  InsertByButton := False;
  DBGrid2.SetFocus;
end;



procedure TNewDiagr.Button6Click(Sender: TObject);
begin
  if F.Count > 0 then begin
    {F.Add(ToPoint.Copy(TOPoint(F.Items[0])));}
    DM1.TbFPoint.Append;
    DM1.TbFPoint['X'] := TOPoint(F.First).X;
    DM1.TbFPoint['Y'] := TOPoint(F.First).Y;
    DM1.TbFPoint.Post;
    Chart1.Paint;
    DBGrid2.SetFocus;
  end;
end;

procedure TNewDiagr.Chart1AfterDraw(Sender: TObject);
var
  i: integer;
begin
  Chart1.Canvas.Font.Height := 10;
  if assigned(Diag) then Diag.Draw(Chart1);
  if Assigned(F) then F.Draw(Chart1);
  if Assigned(Lin) then Lin.Draw(Chart1);
end;




procedure TNewDiagr.Button11Click(Sender: TObject);
begin
   MendTabl1.InsertText('E');
end;

procedure TNewDiagr.Button13Click(Sender: TObject);
begin
  if DM1.TbFPoint.State = dsInsert then
    DM1.TbFPoint.Cancel
  else begin
    F.DelPoint(TOPoint(F[PointNum]));
    DM1.TbFPoint.Delete;
    if PointNum = F.Count then
      Dec(PointNum);
    if PointNum >= 0 then
      TOPoint(F[PointNum]).Mark := True;
    Chart1.Paint;
  end;
end;

procedure TNewDiagr.CheckBox3Click(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Yax.Logor := CheckBox3.Checked;
  if CheckBox3.Checked then begin
    if DM1.TbDiagr['YMin'] <= 0 then
      DM1.TbDiagr['YMin'] := 0.0001;
   { NumInp5.min := 1E-20;
    NumInp6.min := 1E-20;
    NumInp2.min := 1E-20;
    NumInp8.min := 1E-20;
    NumInp10.min := 1E-20;
    NumInp12.min := 1E-20;
    NumInp14.min := 1E-20;
    NumInp16.min := 1E-20;}
  end else begin
    {NumInp5.min := -10000;
    NumInp6.min := -10000;
    NumInp2.min := -10000;
    NumInp8.min := -10000;
    NumInp10.min := -10000;
    NumInp12.min := -10000;
    NumInp14.min := -10000;
    NumInp16.min := -10000; }
  end;
  Chart1.Axises[1].Logarithmic := CheckBox3.Checked;
end;

procedure TNewDiagr.CheckBox8Click(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Xax.Logor := CheckBox8.Checked;
  if CheckBox8.Checked then begin
    if DM1.TbDiagr['XMin'] <= 0 then
      DM1.TbDiagr['XMin'] := 0.0001;
    {NumInp3.min := 1E-20;
    NumInp4.min := 1E-20;
    NumInp1.min := 1E-20;
    NumInp7.min := 1E-20;
    NumInp9.min := 1E-20;
    NumInp11.min := 1E-20;
    NumInp13.min := 1E-20;
    NumInp15.min := 1E-20;}
        {Chart1.BottomAxis.LabelsAngle:=90;
        Chart1.BottomAxis.LabelsAngle:=90;
        Chart3.BottomAxis.LabelsAngle:=90;
        Chart4.BottomAxis.LabelsAngle:=90; }
  end else begin
    {NumInp3.min := -10000;
    NumInp4.min := -10000;
    NumInp1.min := -10000;
    NumInp7.min := -10000;
    NumInp9.min := -10000;
    NumInp11.min := -10000;
    NumInp13.min := -10000;
    NumInp15.min := -10000; }
        {Chart1.BottomAxis.LabelsAngle:=0;
        Chart1.BottomAxis.LabelsAngle:=0;
        Chart3.BottomAxis.LabelsAngle:=0;
        Chart4.BottomAxis.LabelsAngle:=0; }
  end;
  Chart1.Axises[0].Logarithmic := CheckBox8.Checked;
end;






procedure TNewDiagr.Button15Click(Sender: TObject);
var
  S: string;
begin
  S := InputBox(stNewInterv, StIName,
    IntToStr(Diag.Interv.Count + 1));
  if s <> '' then begin
    Diag.Interv.Add(TInterval.Create(0, 0));
    TInterval(Diag.Interv.Last).Name := S;
    HListBox2.Items.Add(S);
    if CheckBox10.Checked then begin
      S := InputBox(stNewInterv, StIID,
        '');
      TInterval(Diag.Interv.Last).ClID := S;
    end;
    HListBox2.ItemIndex := HListBox2.Items.Count - 1;
    OKBtn.Enabled := false;
    Button15.Enabled := false;
    HListBox2.Enabled := false;
    NumInp11.SetFocus;
  end else ShowMessage(stNotEmpty);
end;

procedure TNewDiagr.Button16Click(Sender: TObject);
begin
  if HListBox2.ItemIndex >= 0 then begin
    Diag.Interv.Delete(HListBox2.ItemIndex);
    HlistBox2.Items.Delete(HListbox2.ItemIndex);
    OKBtn.Enabled := true;
    Button15.Enabled := true;
    HListBox2.Enabled := true;
    Chart1.Paint;
  end;
end;


procedure TNewDiagr.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
     MayChange:=True;
  if PageControl1.ActivePageIndex = 4 then begin
    try
      if DM1.TbFPoint.State <> dsBrowse then
        DM1.TbFPoint.Post;
      if DM1.TbFields.State <> dsBrowse then
        DM1.TbFields.Post;
    except
      on Exception do
    end;
end;
AllowChange := MayChange;
end;

procedure TNewDiagr.Button18Click(Sender: TObject);
var
  r: real;
begin
  OKBtn.Enabled := true;
  Button15.Enabled := true;
  HListBox2.Enabled := true;
  if Numinp11.Value > NumInp12.Value then begin
    R := Numinp11.Value;
    Numinp11.Value := NumInp12.Value;
    NumInp12.Value := R;
  end;
  TInterval(Diag.interv[HListbox2.ItemIndex]).X := NumInp11.Value;
  TInterval(Diag.interv[HListbox2.ItemIndex]).y := NumInp12.Value;
  TInterval(Diag.interv[HListbox2.ItemIndex]).TypCod := RadioGroup1.ItemIndex;
  Chart1.Paint;
end;

procedure TNewDiagr.TabSheet5Show(Sender: TObject);
begin
  MayChange := True;
end;

procedure TNewDiagr.RadioGroup1Click(Sender: TObject);
begin
  TInterval(Diag.interv[HListbox2.ItemIndex]).X := NumInp11.Value;
  TInterval(Diag.interv[HListbox2.ItemIndex]).y := NumInp12.Value;
  TInterval(Diag.interv[HListbox2.ItemIndex]).TypCod := RadioGroup1.ItemIndex;
  Chart1.Paint;
end;





procedure TNewDiagr.HListBox2Click(Sender: TObject);
begin
  if HListbox2.ItemIndex >= 0 then begin
    NumInp11.Value := TInterval(Diag.interv[HListbox2.ItemIndex]).X;
    NumInp12.Value := TInterval(Diag.interv[HListbox2.ItemIndex]).y;
    RadioGroup1.ItemIndex := TInterval(Diag.interv[HListbox2.ItemIndex]).TypCod;
  end;
end;

procedure TNewDiagr.HListBox2DblClick(Sender: TObject);
var
  s: string;
begin
  S := InputBox(stChangeIntName, stIName,
    TInterval(Diag.Interv[HListBox2.ItemIndex]).Name);
  if s <> '' then begin
    TInterval(Diag.Interv[HListBox2.ItemIndex]).Name := S;
    HListBox2.Items[HListBox2.ItemIndex] := S;
    if CheckBox10.Checked then begin
      S := InputBox(stChangeIID, StIID,
        TInterval(Diag.Interv[HListBox2.ItemIndex]).ClID);
      TInterval(Diag.Interv.Last).ClID := S;
    end;
    Chart1.Paint;
  end else ShowMessage(stNotEmpty);
end;





procedure TNewDiagr.TabSheet6Show(Sender: TObject);
begin
  MayChange := True;
  if Assigned(Diag) and (Diag.Lines.Count > 0) then
    LineSet;
end;

procedure TNewDiagr.Button25Click(Sender: TObject);
begin
  if DM1.TbLPoint.State <> dsBrowse then
    DM1.TbLPoint.Post;
  Dm1.TbLines.Append;
  Dm1.TbLines['Name1'] := 'Line ' + IntToStr(Diag.Lines.Count + 1);
  if Assigned(Lin) then
    Lin.UnMark;
  Lin := TCurve.Create(Dm1.TbLines['Name1'], Diag.Lines.Count + 1);
  Dm1.TbLines['Bez'] := False;
  Dm1.TbLines['Width'] := 1;
  SpinEdit3.Value := 1;
  Dm1.TbLines['Width'] := 1;
  ListBox2.ItemIndex := 0;
  Dm1.TbLines['PenStyle'] := 0;
  Lin.Marked := True;
  DM1.TbLines.Post;
  Lin.Id := Dm1.TbLines['ID'];
  DM1.TbLines.Edit;
  Diag.Lines.Add(Lin);
  LinesControls(True);


  {if s <> '' then begin
    Lin := TCurve.Create(S, Diag.Count + 1);
    HListBox3.Items.Add(S);
    HListBox3.ItemIndex := HListBox3.Items.Count - 1;
    GroupBox5.Visible := true;
    OKBtn.Enabled := false;
    Button25.Enabled := false;
    Button26.Enabled := false;
    Button27.Enabled := false;
    NumInp13.SetFocus;
    Editing := false;
    PointNum := -1;
    ListBox2.ItemIndex := Integer(Lin.Style);
    SpinEdit3.Value := Lin.Width;
    CheckBox6.Checked := Lin.Bez;
    Button17.Enabled := false;
    Button21.Enabled := false;
    Button32.Enabled := true;
  end else ShowMessage(stNotEmpty);}

end;

procedure TNewDiagr.Button26Click(Sender: TObject);
var R: TCurve;
begin
  if DM1.TbLines.RecordCount > 0 then begin
    R := Diag.Lines[GetLinIndex];
    Diag.Lines.Delete(GetLinIndex);
    if Assigned(Lin) and (R = Lin) then begin
      FreeandNil(Lin)
    end else
      R.Free;
    DM1.TbLines.Cancel;
    DM1.TbLines.Delete;
    Chart1.Paint;
  end;
  if DM1.TbLines.RecordCount = 0 then
    LinesControls(False)
  else
    LineSet;
end;



procedure TNewDiagr.Button19Click(Sender: TObject);
begin
  DM1.TBLPoint.Insert;
  Lin.UnMark;
  InsertByButton := True;
  DBGrid3.SetFocus;

  {Lin.Insert(PointNum + 1, TOPoint.Create(NumInp13.Value, NumInp14.Value));

  inc(PointNum);

  if PointNum < Lin.Count then
    TOPoint(Lin[PointNum]).Mark := True
  else TOPoint(Lin[PointNum - 1]).Mark := True;
  if PointNum > 0 then Button21.Enabled := true
  else Button21.Enabled := false;
  if PointNum < Lin.Count - 1 then Button17.Enabled := true
  else Button17.Enabled := false;
  NumInp13.SetFocus;
  Chart1.Paint; }
end;

procedure TNewDiagr.Button20Click(Sender: TObject);
begin
  if DM1.TbLPoint.State = dsInsert then
    DM1.TbLPoint.Cancel
  else begin
    Lin.DelPoint(TOPoint(Lin[LPointNum]));
    DM1.TbLPoint.Delete;
    if LPointNum = Lin.Count then
      Dec(LPointNum);
    if LPointNum >= 0 then
      TOPoint(Lin[LPointNum]).Mark := True;
    Chart1.Paint;
  end;
end;





procedure TNewDiagr.Button33Click(Sender: TObject);
begin
  Lin.NamePos.X := DM1.TbLines['NamePosX'];
  Lin.NamePos.Y := DM1.TbLines['NamePosY'];
  Chart1.Paint;
end;



procedure TNewDiagr.CheckBox6Click(Sender: TObject);
begin
  if Assigned(Lin) then begin
    Lin.Bez := CheckBox6.Checked;
    Chart1.Paint;
  end;
end;

procedure TNewDiagr.ListBox2Click(Sender: TObject);
begin
  if Assigned(Lin) then begin
    Lin.Style := TPenStyle(ListBox2.ItemIndex);
    DM1.TbLines['PenStyle'] := ListBox2.ItemIndex;
    Chart1.Paint;
  end;
end;

procedure TNewDiagr.SpinEdit3Change(Sender: TObject);
begin
  if Assigned(Lin) then begin
    Lin.Width := SpinEdit3.Value;
    DM1.TbLines['Width'] := SpinEdit3.Value;
    if SpinEdit3.Value > 1 then begin
      ListBox2.ItemIndex := 0;
      ListBox2.Enabled := false;
      Lin.Style := psSolid;
    end else ListBox2.Enabled := true;
    Chart1.Paint;
  end;
end;







procedure TNewDiagr.CheckBox7Click(Sender: TObject);
begin
  if Assigned(F) then begin
    F.Bez := CheckBox7.Checked;
    Chart1.Paint;
  end;
end;

procedure TNewDiagr.SpinEdit1Change(Sender: TObject);
begin
  if Assigned(F) then begin
    F.Width := SpinEdit1.Value;
    DM1.TbFields['Width'] := SpinEdit1.Value;
    if SpinEdit1.Value > 1 then begin
      ListBox1.ItemIndex := 0;
      ListBox1.Enabled := false;
      F.Style := psSolid;
    end else ListBox1.Enabled := true;
    Chart1.Paint;
  end;
end;

procedure TNewDiagr.ListBox3DblClick(Sender: TObject);
begin
  MendTabl1.InsertText(ExpandSym(ListBox3.Items[ListBox3.ItemIndex] + '@'));
end;

procedure TNewDiagr.ListBox4DblClick(Sender: TObject);
begin
  MendTabl2.InsertText(ExpandSym(ListBox4.Items[ListBox4.ItemIndex] + '@'));
end;

procedure TNewDiagr.FormCreate(Sender: TObject);
begin
  Diag := nil;
end;

procedure TNewDiagr.RadioGroup2Click(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  if RadioGroup2.ItemIndex = 0 then begin
    Diag.Cod := 0;
    Diag.Trio := false;
    DM1.TbDiagr['Trio'] := False;
    DM1.TbDiagr['Cod'] := 0;
    Chart1.Trio := false;
    Chart1.Trio := false;
   { Chart4.Trio := false;}
    TabSheet8.TabVisible := false;
    Label35.Visible := false;
    NumInp21.Visible := false;
    CheckBox8.Enabled := true;
    CheckBox3.Enabled := true;
    TabSheet5.TabVisible := true;
    CheckBox19.Checked:=False;
    CheckBox19.Visible:=False;
  end else begin
   // Diag.Cod := 100;
    Diag.Trio := true;
    if DM1.TbDiagr['Norma'] = null then begin
      DM1.TbDiagr['Norma'] := 100;
      NumInp21Exit(Sender);
    end;
    DM1.TbDiagr['Trio'] := True;
   // DM1.TbDiagr['Cod'] := 100;
    Chart1.Trio := true;
    Chart1.Norma := Diag.Norma;
    TabSheet8.TabVisible := true;
    Label35.Visible := true;
    NumInp21.Visible := true;
    CheckBox8.Enabled := false;
    CheckBox3.Enabled := false;
    CheckBox3.Checked := false;
    CheckBox8.Checked := false;
    TabSheet5.TabVisible := false;
    CheckBox19.Visible:=True;
  end;
end;



procedure TNewDiagr.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then begin
    CheckBox13.Checked := True;
    CheckBox13.Enabled := False;
  end else
    CheckBox13.Enabled := True;
  if Assigned(Diag) then
    Diag.Xax.AW := CheckBox4.Checked;
end;

procedure TNewDiagr.CheckBox5Click(Sender: TObject);
begin
  if Assigned(Diag) then begin
    if CheckBox5.Checked then begin
      CheckBox14.Checked := True;
      CheckBox14.Enabled := False;
    end else
      CheckBox14.Enabled := True;
    Diag.Yax.AW := CheckBox5.Checked;
  end;
end;

procedure TNewDiagr.CheckBox15Click(Sender: TObject);
begin
  if Assigned(Diag) then
    Diag.Zax.proc100 := CheckBox15.Checked;
end;

procedure TNewDiagr.CheckBox16Click(Sender: TObject);
var i: integer;
  S: string;
begin
  if not Assigned(Diag) then Exit;
  Diag.Xax.Mols := CheckBox16.Checked;
  if CheckBox16.Checked then begin
    CheckBox13.Checked := True;
    CheckBox13.Enabled := False;
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
    CheckBox13.Enabled := True;
  end;
end;

procedure TNewDiagr.CheckBox17Click(Sender: TObject);
var i: integer;
  S: string;
begin
  if not Assigned(Diag) then Exit;
  Diag.Yax.Mols := CheckBox17.Checked;
  if CheckBox17.Checked then begin
    CheckBox14.Checked := True;
    CheckBox14.Enabled := False;
    MendTabl1.Alternative := False;
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
    CheckBox14.Enabled := True;
  end;
end;

procedure TNewDiagr.CheckBox18Click(Sender: TObject);
var i: integer;
  S: string;
begin
  if not Assigned(Diag) then Exit;
  Diag.Zax.Mols := CheckBox18.Checked;
  if CheckBox18.Checked then begin
    CheckBox15.Checked := True;
    CheckBox15.Enabled := False;
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
    CheckBox15.Enabled := True;
  end;
end;

procedure TNewDiagr.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

procedure TNewDiagr.CheckBox1Click(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.ShowTitle := CheckBox1.Checked;
    Diag.Name := DBEdit1.Text;
    Chart1.Title.Visible := Diag.ShowTitle;
  end;
end;

procedure TNewDiagr.CheckBox2Click(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.ShowGrid := CheckBox2.Checked;
    Chart1.BeginUpdate;
    Chart1.Axises[0].GridVisible := Diag.ShowGrid;
    Chart1.Axises[1].GridVisible := Diag.ShowGrid;
    Chart1.Axises[2].GridVisible := Diag.ShowGrid;
    Chart1.EndUpdate;
  end;
end;

procedure TNewDiagr.NumInp21Exit(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.Norma := DM1.TbDiagr['Norma'];
    Chart1.Norma := Diag.Norma;
    DM1.TbDiagr['XMax'] := Chart1.Axises[0].Maximum;
    DM1.TbDiagr['XMin'] := Chart1.Axises[0].Minimum;
    DM1.TbDiagr['YMax'] := Chart1.Axises[1].Maximum;
    DM1.TbDiagr['YMin'] := Chart1.Axises[1].Minimum;
    DM1.TbDiagr['ZMax'] := Chart1.Axises[2].Maximum;
    DM1.TbDiagr['ZMin'] := Chart1.Axises[2].Minimum;
    Diag.Xax.min := Chart1.Axises[0].Minimum;
    Diag.Xax.max := Chart1.Axises[0].Maximum;
    Diag.Yax.min := Chart1.Axises[1].Minimum;
    Diag.Yax.max := Chart1.Axises[1].Maximum;
    Diag.Zax.min := Chart1.Axises[2].Minimum;
    Diag.Zax.max := Chart1.Axises[2].Maximum;
  end;
end;

procedure TNewDiagr.Edit2Change(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.Xax.Caption := Edit2.Text;
    Chart1.Axises[0].Title := Diag.Xax.Caption;
  end;
end;

procedure TNewDiagr.CheckBox11Click(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.Xax.Log := CheckBox11.Checked;
  end;
end;

procedure TNewDiagr.CheckBox13Click(Sender: TObject);
begin
  if Assigned(Diag) then
    Diag.Xax.proc100 := CheckBox13.Checked;
end;

procedure TNewDiagr.NumInp3Exit(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Xax.Min := Dm1.TbDiagr['XMin'];
  if Diag.Xax.Min < Diag.Xax.max then begin
    Chart1.BeginUpdate;
    Chart1.Axises[0].Maximum := Diag.Xax.max;
    Chart1.Axises[0].Minimum := Diag.Xax.Min;
    Chart1.EndUpdate;
    SetMinMax;
  end;
end;

procedure TNewDiagr.NumInp4Exit(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Xax.Max := Dm1.TbDiagr['XMax'];
  if Diag.Xax.Min < Diag.Xax.max then begin
    Chart1.BeginUpdate;
    Chart1.Axises[0].Minimum := Diag.Xax.Min;
    Chart1.Axises[0].Maximum := Diag.Xax.max;
    Chart1.EndUpdate;
    SetMinMax;
  end;
end;

procedure TNewDiagr.DBEdit1Exit(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.Name := DBEdit1.Text;
    Chart1.Title.Text := Diag.Name;
  end;
end;

procedure TNewDiagr.MendTabl2Create(Sender: TObject);
begin
  MendTabl2.MendTablCreate(Sender);

end;

procedure TNewDiagr.Edit3Change(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.Yax.Caption := Edit3.Text;
    Chart1.Axises[1].Title := Diag.Yax.Caption;
  end;
end;

procedure TNewDiagr.CheckBox12Click(Sender: TObject);
begin
  if Assigned(Diag) then
    Diag.Yax.Log := CheckBox12.Checked;
end;

procedure TNewDiagr.CheckBox14Click(Sender: TObject);
begin
  if Assigned(Diag) then
    Diag.Yax.proc100 := CheckBox14.Checked;
end;

procedure TNewDiagr.NumInp5Exit(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Yax.Min := Dm1.TbDiagr['YMin'];
  if Diag.Yax.Min < Diag.Yax.max then begin
    Chart1.BeginUpdate;
    Chart1.Axises[1].Maximum := Diag.Yax.max;
    Chart1.Axises[1].Minimum := Diag.Yax.Min;
    Chart1.EndUpdate;
    SetMinMax;
  end;
end;

procedure TNewDiagr.NumInp6Change(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Yax.Max := Dm1.TbDiagr['YMax'];
  if Diag.Yax.Min < Diag.Yax.max then begin
    Chart1.BeginUpdate;
    Chart1.Axises[1].Minimum := Diag.Yax.Min;
    Chart1.Axises[1].Maximum := Diag.Yax.max;
    Chart1.EndUpdate;
    SetMinMax;
  end;
end;

procedure TNewDiagr.FormDestroy(Sender: TObject);
begin
     {Diag.Free;}
end;

procedure TNewDiagr.SetMinMax;
begin
  if Diag.Trio then begin
    Dm1.TbDiagr['XMax'] := Chart1.Axises[0].Maximum;
    Dm1.TbDiagr['XMin'] := Chart1.Axises[0].Minimum;
    Diag.Xax.min := Chart1.Axises[0].Minimum;
    Diag.Xax.max := Chart1.Axises[0].Maximum;
    Dm1.TbDiagr['YMax'] := Chart1.Axises[1].Maximum;
    Dm1.TbDiagr['YMin'] := Chart1.Axises[1].Minimum;
    Diag.Yax.min := Chart1.Axises[1].Minimum;
    Diag.Yax.max := Chart1.Axises[1].Maximum;

    Dm1.TbDiagr['ZMax'] := Chart1.Axises[2].Maximum;
    Dm1.TbDiagr['ZMin'] := Chart1.Axises[2].Minimum;
    Diag.Zax.min := Chart1.Axises[2].Minimum;
    Diag.Zax.max := Chart1.Axises[2].Maximum;
  end;
end;

procedure TNewDiagr.Edit5Change(Sender: TObject);
begin
  if Assigned(Diag) then begin
    Diag.Zax.Caption := Edit5.Text;
    Chart1.Axises[2].Title := Diag.Zax.Caption;
  end;
end;

procedure TNewDiagr.CheckBox9Click(Sender: TObject);
begin
  if Assigned(Diag) then begin
    if CheckBox9.Checked then begin
      CheckBox15.Checked := True;
      CheckBox15.Enabled := False;
    end else
      CheckBox15.Enabled := True;
    Diag.Zax.AW := CheckBox9.Checked;
  end;
end;

procedure TNewDiagr.NumInp19Exit(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Zax.Min := Dm1.TbDiagr['ZMin'];
  if Diag.Zax.Min < Diag.Zax.max then begin
    Chart1.BeginUpdate;
    Chart1.Axises[2].Maximum := Diag.Zax.max;
    Chart1.Axises[2].Minimum := Diag.Zax.Min;
    Chart1.EndUpdate;
    SetMinMax;
  end;
end;

procedure TNewDiagr.NumInp20Exit(Sender: TObject);
begin
  if not Assigned(Diag) then Exit;
  Diag.Zax.MAx := Dm1.TbDiagr['ZMAx'];
  if Diag.Zax.Min < Diag.Zax.max then begin
    Chart1.BeginUpdate;
    Chart1.Axises[2].Minimum := Diag.Zax.Min;
    Chart1.Axises[2].Maximum := Diag.Zax.max;
    Chart1.EndUpdate;
    SetMinMax;
  end;
end;

function TNewDiagr.GetFieldIndex: integer;
var i: Integer;
begin
  Result := -1;
  for i := 0 to Diag.Count - 1 do
    if DM1.TbFields['ID'] = TVerCollection(Diag[i]).Id then begin
      Result := i;
      Exit;
    end;
end;

procedure TNewDiagr.DBGrid1CellClick(Column: TColumn);
var
  s: string;
begin
  if Assigned(Diag) and (Diag.Count > 0) then begin
    FieldSet;
  end;
end;

procedure TNewDiagr.Button3Click(Sender: TObject);
var r: TVerCollection;
begin
  if DM1.TbFields.RecordCount > 0 then begin
    R := Diag[GetFieldIndex];
    Diag.Delete(GetFieldIndex);
    if Assigned(F) and (R = F) then begin
      FreeandNil(F)
    end else
      R.Free;
    MayChange:=True;
    DM1.TbFields.Cancel;
    DM1.TbFields.Delete;
    Chart1.Paint;
  end;
  if DM1.TbFields.RecordCount = 0 then
    FieldsControls(False)
  else
    FieldSet;
end;

procedure TNewDiagr.Button8Click(Sender: TObject);
begin
  F.NamePos.X := DM1.TbFields['NamePosX'];
  F.NamePos.Y := DM1.TbFields['NamePosY'];
  Chart1.Paint;
end;

procedure TNewDiagr.AfterPointPost(New: Boolean);
var i: Integer;
  CurID: Integer;
begin
  InsertByButton := False;
  if new then begin
    F.Insert(PointNum, TOPoint.Create(DM1.TbFPoint['X'], DM1.TbFPoint['Y']));
  {inc(PointNum);}
  end;
  F.UnMark;
  TOPoint(F[PointNum]).Mark := True;
  F.Marked := True;
  TOPoint(F[PointNum]).X := DM1.TbFPoint['X'];
  TOPoint(F[PointNum]).Y := DM1.TbFPoint['Y'];
  TOPoint(F[PointNum]).ID := DM1.TbFPoint['ID'];
  TOPoint(F[PointNum]).Cod := F.Cod;
  if PointNum <> F.Count - 1 then begin
    NotFPointPost := True;
    CurId := DM1.TbFPoint['ID'];
    try
      DM1.TbFPoint.DisableControls;
      for i := PointNum + 1 to F.Count - 1 do begin
        DM1.TbFPoint.Locate('ID', TOPoint(F[i]).ID, []);
        DM1.TbFPoint.Edit;
        DM1.TbFPoint['TypCod'] := TOPoint(F[i]).TypCod;
        DM1.TbFPoint.Post;
      end;
    finally
      DM1.TbFPoint.Locate('ID', CurID, []);
      DM1.TbFPoint.EnableControls;
    end;
    NotFPointPost := False;
  end;
  Chart1.Paint;
end;

procedure TNewDiagr.DBGrid2CellClick(Column: TColumn);
begin
  if (Dm1.TbFPoint.State = dsBrowse) and (Dm1.TbFPoint.RecordCount > 0) then begin
    PointNum := FindPointNum(Dm1.TbFPoint['ID']);
    F.UnMark;
    TOPoint(F[PointNum]).Mark := True;
    F.Marked := True;
    Chart1.Paint;
  end;
end;

function TNewDiagr.FindPointNum(ID: integer): integer;
var i: Integer;
begin
  Result := -1;
  for i := 0 to F.Count - 1 do
    if ID = TOPoint(F[i]).ID then begin
      Result := i;
      Exit;
    end;
end;

procedure TNewDiagr.Button12Click(Sender: TObject);
begin
  DM1.TBFPoint.Insert;
  TOPoint(F[PointNum]).Mark := False;
     {Inc(PointNum);}
  InsertByButton := True;
  DBGrid2.SetFocus;
end;

procedure TNewDiagr.Button7Click(Sender: TObject);
begin
  if DM1.TBFPoint.State <> dsBrowse then
    DM1.TBFPoint.Post;
end;

procedure TNewDiagr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(F) then
    F.UnMark;
  if Assigned(Lin) then
    Lin.UnMark;
end;

procedure TNewDiagr.FieldsControls(Enable: Boolean);
begin
  Button3.Enabled := Enable;
  GroupBox2.Enabled := Enable;
  DBGrid2.Enabled := Enable;
  Button4.Enabled := Enable;
  Button12.Enabled := Enable;
  Button7.Enabled := Enable;
  Button6.Enabled := Enable;
  Button13.Enabled := Enable;
  GroupBox9.Enabled := Enable;
end;

procedure TNewDiagr.HDBGrid1CellClick(Column: TColumn);
begin
  if Assigned(Diag) and (Diag.Lines.Count > 0) then begin
    LineSet;
  end;
end;

function TNewDiagr.GetLinIndex: integer;
var i: Integer;
begin
  Result := -1;
  for i := 0 to Diag.Lines.Count - 1 do
    if DM1.TbLines['ID'] = TCurve(Diag.Lines[i]).Id then begin
      Result := i;
      Exit;
    end;

end;

procedure TNewDiagr.LinesControls(Enable: Boolean);
begin
  Button26.Enabled := Enable;
  GroupBox8.Enabled := Enable;
  DBGrid3.Enabled := Enable;
  Button9.Enabled := Enable;
  Button19.Enabled := Enable;
  Button10.Enabled := Enable;
  Button20.Enabled := Enable;
  GroupBox7.Enabled := Enable;
end;

procedure TNewDiagr.Button9Click(Sender: TObject);
begin
  DM1.TBLPoint.Append;
  { LPointNum:=Lin.Count-1;}
  InsertByButton := False;
  DBGrid3.SetFocus;
end;

procedure TNewDiagr.Button10Click(Sender: TObject);
begin
  if DM1.TBLPoint.State <> dsBrowse then
    DM1.TBLPoint.Post;
end;

procedure TNewDiagr.DBGrid3CellClick(Column: TColumn);
begin
  if (Dm1.TbLPoint.State = dsBrowse) and (Dm1.TbLPoint.RecordCount > 0) then begin
    PointNum := FindLPointNum(Dm1.TbLPoint['ID']);
    Lin.UnMark;
    TOPoint(Lin[LPointNum]).Mark := True;
    Lin.Marked := True;
    Chart1.Paint;
  end;
end;

function TNewDiagr.FindLPointNum(ID: integer): integer;
var i: Integer;
begin
  Result := -1;
  for i := 0 to Lin.Count - 1 do
    if ID = TOPoint(Lin[i]).ID then begin
      Result := i;
      Exit;
    end;

end;

procedure TNewDiagr.AfterLPointPost(New: Boolean);
var i: Integer;
  CurID: Integer;
begin
  InsertByButton := False;
  if new then begin
    Lin.Insert(LPointNum, TOPoint.Create(DM1.TbLPoint['X'], DM1.TbLPoint['Y']));
  {inc(LPointNum);}
  end;
  Lin.UnMark;
  TOPoint(Lin[LPointNum]).Mark := True;
  Lin.Marked := True;
  TOPoint(Lin[LPointNum]).X := DM1.TbLPoint['X'];
  TOPoint(Lin[LPointNum]).Y := DM1.TbLPoint['Y'];
  TOPoint(Lin[LPointNum]).ID := DM1.TbLPoint['ID'];
  TOPoint(Lin[LPointNum]).Cod := Lin.Cod;
  if LPointNum <> Lin.Count - 1 then begin
    NotLPointPost := True;
    CurId := DM1.TbLPoint['ID'];
    try
      DM1.TbLPoint.DisableControls;
      for i := LPointNum + 1 to Lin.Count - 1 do begin
        DM1.TbLPoint.Locate('ID', TOPoint(Lin[i]).ID, []);
        DM1.TbLPoint.Edit;
        DM1.TbLPoint['TypCod'] := TOPoint(Lin[i]).TypCod;
        DM1.TbLPoint.Post;
      end;
    finally
      DM1.TbLPoint.Locate('ID', CurID, []);
      DM1.TbLPoint.EnableControls;
    end;
    NotLPointPost := False;
  end;
  Chart1.Paint;
end;

procedure TNewDiagr.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (AllOK) or (ModalResult <> mrOK);
end;

procedure TNewDiagr.TabSheet6Exit(Sender: TObject);
begin
  if DM1.TbLPoint.State <> dsBrowse then
    DM1.TbLPoint.Post;
  if DM1.TbLines.State <> dsBrowse then
    DM1.TbLines.Post;
end;

procedure TNewDiagr.FieldSet;
begin
  if Assigned(F) then
    F.UnMark;
  if Assigned(Lin) then
    Lin.UnMark;
  F := Diag[GetFieldIndex];
  FieldsControls(True);
  F.Marked := True;
  DM1.TbFPoint.First;
  PointNum := 0;
  if F.Count > 0 then
    TOPoint(F.First).Mark := True;
  Editing := True;
  Chart1.Paint;

  DM1.TbFields.Edit;
  if DM1.TbFields['Width'] > 0 then
    SpinEdit1.Value := DM1.TbFields['Width']
  else
    SpinEdit1.Value := 1;
  ListBox1.ItemIndex := DM1.TbFields['PenStyle'];
end;

procedure TNewDiagr.LineSet;
begin
  if Assigned(Lin) then
    Lin.UnMark;
  if Assigned(F) then
    F.UnMark;
  Lin := Diag.Lines[GetLinIndex];
  LinesControls(True);
  Lin.Marked := True;
  DM1.TbLPoint.First;
  LPointNum := 0;
  if Lin.Count > 0 then
    TOPoint(Lin.First).Mark := True;
    {Editing := True;}
  Chart1.Paint;
  if not DM1.TbLines.Eof then begin
    DM1.TbLines.Edit;
    if DM1.TbLines['Width'] > 0 then
      SpinEdit3.Value := DM1.TbLines['Width']
    else
      SpinEdit3.Value := 1;
    if DM1.TbLines['PenStyle'] <> null then
      ListBox2.ItemIndex := DM1.TbLines['PenStyle']
    else
      ListBox2.ItemIndex := 0;
  end;
end;

procedure TNewDiagr.CheckBox10Click(Sender: TObject);
begin
     if Assigned(Diag) then
        Diag.Classification:=CheckBox10.Checked;
end;

procedure TNewDiagr.ButtAXClick(Sender: TObject);
begin
     MendTabl1.InsertText('A');
end;

procedure TNewDiagr.Button17Click(Sender: TObject);
begin
     MendTabl1.InsertText('Tn');
end;

procedure TNewDiagr.ButtT1Click(Sender: TObject);
begin
     MendTabl1.InsertText('T');
end;

procedure TNewDiagr.Button14Click(Sender: TObject);
begin
     MendTabl2.InsertText('E');
end;

procedure TNewDiagr.Button21Click(Sender: TObject);
begin
    MendTabl2.InsertText('A');
end;

procedure TNewDiagr.Button22Click(Sender: TObject);
begin
     MendTabl2.InsertText('Tn');
end;

procedure TNewDiagr.Button23Click(Sender: TObject);
begin
      MendTabl2.InsertText('T');
end;

procedure TNewDiagr.Button24Click(Sender: TObject);
begin
    MendTabl3.InsertText('En');
end;

procedure TNewDiagr.Button27Click(Sender: TObject);
begin
  MendTabl3.InsertText('E');
end;

procedure TNewDiagr.Button28Click(Sender: TObject);
begin
    MendTabl3.InsertText('An');
end;

procedure TNewDiagr.Button29Click(Sender: TObject);
begin
  MendTabl3.InsertText('A');
end;

procedure TNewDiagr.Button30Click(Sender: TObject);
begin
     MendTabl3.InsertText('Tn');
end;

procedure TNewDiagr.Button31Click(Sender: TObject);
begin
      MendTabl3.InsertText('T');
end;

procedure TNewDiagr.CheckBox19Click(Sender: TObject);
begin
     if CheckBox19.Checked then
        Diag.Cod:=100
     else
      Diag.Cod:=0;
     DM1.TbDiagr['Cod'] :=Diag.Cod ;
     Chart1.Paint;
end;

end.

