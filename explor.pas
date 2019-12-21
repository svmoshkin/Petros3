unit explor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, ImgList, Printers, RHAGlobs,
  ActnList, Menus, ESBRtns, Variants;

type
  TClassForm = class(TForm)
    Panel1: TPanel;
    TreeView1: TTreeView;
    ListView1: TListView;
    Splitter1: TSplitter;
    SaveDialog1: TSaveDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    FontDialog1: TFontDialog;
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
    Font: TAction;
    Font1: TMenuItem;
    AAccept: TAction;
    Accept1: TMenuItem;
    N2: TMenuItem;
    Img: TImageList;
    Img1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeView1Expanded(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure BFileClick(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AAcceptExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RootN: TTreeNode;
    Trio: boolean;
    MustFree: boolean;
    Ptr: pointer;
    DiagrId: integer;
    IDS: TStringList;
  end;

  TClassList = class(TList)
    destructor Destroy; override;
  end;

  TClassPoint = class
    X, Y, Z: real;
    Descript: string;
    Id: LongInt;
    SampID: string[16];
    constructor Create(Ax, Ay, Az: real; AD: string; AID: Longint; ASamp: string);
  end;

var
  {ClassForm: TClassForm;}
  Clf, OpF, CldF, OpDf, Mark: TBitmap;

resourcestring
  StAbsent = 'Absent';
  stTitle = 'PETROS, Classification results';

implementation
uses AnData, Main, DMod1, ADOUtilsS;
{$R *.DFM}
{$R Custom.res}



procedure TClassForm.FormCreate(Sender: TObject);
begin
   {WindowState:=wsMinimized;}
  MustFree := False;
  IMG.AddMasked(CLf, clFuchsia);
  IMG.AddMasked(Opf, clFuchsia);
  IMG.AddMasked(ClDf, clFuchsia);
  IMG.AddMasked(OpDf, clFuchsia);
  IMG1.AddMasked(Mark, clFuchsia);
  IMG1.AddMasked(Mark, clFuchsia);
  TreeView1.Images := IMG;
  TreeView1.StateImages := Img1;
  IDS := TStringList.Create;
end;

procedure TClassForm.FormDestroy(Sender: TObject);
begin
     {IMG.Free;}
  IDS.Free;
  Pointer(Ptr^) := nil;
end;

procedure TClassForm.TreeView1Expanded(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 1;
  Node.SelectedIndex := 1;
end;

procedure TClassForm.TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;
end;

{ TClassList }

destructor TClassList.Destroy;
var i: integer;
begin
  for i := 0 to Count - 1 do
    TClassPoint(Items[i]).Free;
  inherited Destroy;
end;

{ TClassPoint }

constructor TClassPoint.Create(Ax, Ay, Az: real; AD: string; AID: Integer; ASamp: string);
begin
  inherited Create;
  X := Ax;
  Y := Ay;
  Z := Az;
  Descript := Ad;
  ID := AId;
  SampID := ASamp;
end;

procedure TClassForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
var T: TListItem;
  I: integer;
  P: TClassPoint;
begin
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;
  if Node.ImageIndex = 2 then
    for i := 0 to TClassList(Node.Data).Count - 1 do begin
      P := TClassPoint(TClassList(Node.Data).Items[i]);
      T := ListView1.Items.Add;
      T.Caption := P.SampID;
      T.SubItems.Add(P.Descript);
      T.SubItems.Add(FloatToStrF(P.X, ffFixed, 7, 3));
      T.SubItems.Add(FloatToStrF(P.Y, ffFixed, 7, 3));
      if Trio then
        T.SubItems.Add(FloatToStrF(P.Z, ffFixed, 7, 3))
      else T.SubItems.Add('');
      T.SubItems.Add(IntToStr(P.ID));
    end;
  ListView1.Items.EndUpdate;
end;

procedure TClassForm.BFileClick(Sender: TObject);
var F: TextFile;
  i, j, k: integer;
begin
  if SaveDialog1.Execute then begin
    AssignFile(F, SaveDialog1.FileName);
    Rewrite(F);
    Writeln(F, '                  ' + RootN.Text);
    Writeln(F);
    for i := 0 to RootN.Count - 1 do
      if RootN.Item[i].Count > 0 then begin
        Writeln(F, RootN.Item[i].Text);
        for j := 0 to RootN.Item[i].Count - 1 do begin
          Writeln(F, '     ' + RootN.Item[i].Item[j].Text);
          for k := 0 to TClassList(RootN.Item[i].Item[j].Data).Count - 1 do
            Writeln(F, '        ' + PadRightStr(TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
              .Items[k]).SampID, 16) + ' ' +
              TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
              .Items[k]).Descript);
        end;
      end;
    CloseFile(F);
  end;
end;

procedure TClassForm.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Node: TTreeNode;
begin
  if Button = mbRight then begin
    Node := TreeView1.GetNodeAt(X, Y);
    if Node <> nil then begin
      if Node.StateIndex < 0 then Node.StateIndex := 1
      else Node.StateIndex := -1;
      TreeView1.Invalidate;
    end;
  end;
end;

procedure TClassForm.BitBtn2Click(Sender: TObject);
var i, j, k, d, h, l1, l2: integer;
  ParentCheck, ChildCheck, RootCheck: boolean;
begin
  if PrinterSetupDialog1.Execute then
    with Printer do begin
      Title := stTitle;
      Canvas.Font := FontDialog1.Font;
      BeginDoc;
      H := Canvas.TextHeight('RHA');
      d := H;
      Canvas.Font.Style := [fsBold, fsUnderline];
      Canvas.TextOut(180, D, RootN.Text);
      Inc(D, H);
      if RootN.StateIndex > 0 then RootCheck := true
      else RootCheck := false;
      for i := 0 to RootN.Count - 1 do begin
        ChildCheck := false;
        for j := 0 to RootN.Item[i].Count - 1 do
          if RootN.Item[i].Item[j].StateIndex > 0 then
            ChildCheck := True;
        if (RootN.Item[i].StateIndex > 0) or RootCheck then
          ParentCheck := True
        else ParentCheck := false;
        if ParentCheck or ChildCheck then begin
          Inc(D, H);
          if D > PageHeight - 11 * h then begin
            d := H;
            NewPage;
          end;
          Canvas.Font.Style := [fsBold];
          Canvas.TextOut(20, D, RootN.Item[i].Text);
          Inc(D, round(H * 1.5));
          if RootN.Item[i].Count = 0 then begin
            Canvas.Font.Style := [fsItalic];
            Canvas.TextOut(50, D, StAbsent);
            Inc(D, round(H * 1.5));
            if D > PageHeight - 9 * H then begin
              d := H;
              NewPage;
            end;
          end;
        end;
        for j := 0 to RootN.Item[i].Count - 1 do
          if (RootN.Item[i].Item[j].StateIndex > 0)
            or ParentCheck then begin
            if D > PageHeight - 10.5 * H then begin
              d := H;
              NewPage;
            end;
            Canvas.Font.Style := [];
            Canvas.TextOut(50, D, RootN.Item[i].Item[j].Text);
            Inc(D, round(H * 1.5));
            Canvas.TextOut(80, D, ListView1.Column[1].Caption);
            if Length(ListView1.Column[1].Caption) > 8 then
              L1 := Canvas.TextWidth(ListView1.Column[1].Caption)
            else L1 := Canvas.TextWidth('99999999');
            Canvas.TextOut(90 + L1, D, ListView1.Column[2].Caption);
            if Length(ListView1.Column[2].Caption) > 8 then
              L2 := Canvas.TextWidth(ListView1.Column[2].Caption)
            else L2 := Canvas.TextWidth('99999999');
            Canvas.TextOut(100 + L1 + L2, D, ListView1.Column[0].Caption);
            Inc(D, round(H * 1.5));
            for k := 0 to TClassList(RootN.Item[i].Item[j].Data).Count - 1 do
            begin
              Canvas.TextOut(85, D, FloatToStrF(
                TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
                .Items[k]).X, ffGeneral, 4, 1));
              Canvas.TextOut(95 + L1, D, FloatToStrF(
                TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
                .Items[k]).Y, ffGeneral, 4, 1));
              Canvas.TextOut(100 + L1 + L2, D,
                TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
                .Items[k]).Descript);
              Inc(D, round(H * 1.5));
              if D > PageHeight - 8 * h then begin
                d := H;
                NewPage;
              end;
            end;
          end;
      end;
      EndDoc;
    end;
end;

procedure TClassForm.SpeedButton1Click(Sender: TObject);
begin
  FontDialog1.Execute;
end;

procedure TClassForm.ListView1DblClick(Sender: TObject);
begin
  CurID := STrToInt(ListView1.Selected.SubItems[3]);
  TAnalForm.Create(MainForm);
end;

procedure TClassForm.FormClose(Sender: TObject; var Action: TCloseAction);
var i, j: integer;
begin
  
  if MustFree then begin
     for i := 0 to RootN.Count - 1 do
    for j := RootN.Item[i].Count - 1 downto 0 do begin
      TClassList(RootN.Item[i].Item[j].Data).Free;
      RootN.Item[i].Item[j].Delete;
    end;
  Action := caFree;
  end else
  Action := caMinimize;
end;

procedure TClassForm.AAcceptExecute(Sender: TObject);
var i, j, k: integer;
begin
  try
  DM1.TbDiagrId.DisableControls;
  DM1.TbDiagrId.Locate('ID',DiagrID,[]);
  finally
    DM1.TbDiagr.EnableControls;
    end;
    for i := 0 to RootN.Count - 1 do
      if (RootN.Item[i].Count > 0) and (IDS[i] <> '') then begin
        for j := 0 to RootN.Item[i].Count - 1 do
          for k := 0 to TClassList(RootN.Item[i].Item[j].Data).Count - 1 do begin
            {Writeln(F, '        ' +PadRightStr(TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
              .Items[k]).SampID,16)+' '+
              TClassPoint(TClassList(RootN.Item[i].Item[j].Data)
              .Items[k]).Descript); }
             if OpenQr('Select * from Classif where Diagr='+IntToStr(DiagrID)+
             ' and Anal='+IntToStr(TClassPoint(TClassList(RootN.Item[i].Item[j].Data).Items[k]).ID),
             DM1.q1Time) then  begin
              DM1.q1Time.Edit;
              DM1.q1Time['Class'] := IDS[i];
              DM1.q1Time.Post;
            end else begin
              DM1.q1Time.Insert;
              DM1.q1Time['Diagr'] := DiagrID;
              DM1.q1Time['Anal'] :=
                TClassPoint(TClassList(RootN.Item[i].Item[j].Data).Items[k]).ID;
              DM1.q1Time['Class'] := IDS[i];
              DM1.q1Time.Post;
            end;
          end;
      end;
end;

procedure TClassForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

initialization
  Clf := TBitmap.Create;
  OpF := TBitmap.Create;
  CldF := TBitmap.Create;
  OpDf := TBitmap.Create;
  Mark := TBitmap.Create;
     {IMG:=TImageList.Create;}
  Clf.LoadFromResourceName(HInstance, 'CLOSEF');
  Opf.LoadFromResourceName(HInstance, 'OPENF');
  ClDf.LoadFromResourceName(HInstance, 'CLOSEDOCF');
  OpDF.LoadFromResourceName(HInstance, 'OPENDOCF');
  Mark.LoadFromResourceName(HInstance, 'MARK');
finalization
  Clf.Free;
  OpF.Free;
  CldF.Free;
  OpDf.Free;
  Mark.Free;

end.

