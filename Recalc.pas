unit Recalc;

interface

uses
  SysUtils, Forms, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, ValueExtractor, Grids, DBGrids, Hintctrl, MoshUtils,
  EdvShape, Chemist, Dialogs, Db, DBCtrls, JvInterpreter_all,
  Clipbrd, ADODB, Mask, DMod1, ESBRtns, Variants, JvComponentBase,
  JvInterpreter, JvInterpreterFm, JvExControls, JvEditorCommon,
  JvEditor, JvHLEditor;

type
  TAlgoForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    VE1: TValueExtractor;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Button1: TButton;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    HDBGrid2: THDBGrid;
    AdvShape1: TAdvShape;
    AdvShape2: TAdvShape;
    Panel1: TPanel;
    Label4: TLabel;
    Label8: TLabel;
    Button3: TButton;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ScrollBox1: TScrollBox;
    AdvShape3: TAdvShape;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    GroupBox4: TGroupBox;
    HDBGrid1: THDBGrid;
    PaintBox1: TAlgoPanel;
    GroupBox5: TGroupBox;
    ListBox1: TListBox;
    BitBtn9: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit2: TEdit;
    Edit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    AlgoShape1: TAlgoShape;
    Label5: TLabel;
    Panel2: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Label12: TLabel;
    RAProgr: TJvInterpreterFm;
    RAHLEditor1: TJvHLEditor;
    RAEditor2: TJvHLEditor;
    RAEditor1: TJvHLEditor;
    procedure BitBtn4Click(Sender: TObject);
    procedure AdvShape2Click(Sender: TObject);
    procedure PaintBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PaintBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure AdvShape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvShape3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvShape3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AdvShape1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure VE1GetValue(Sender: TObject; Num, AnType: Integer;
      var Value: Variant);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    {procedure AdvShape2StartDrag(Sender: TObject;
      var DragObject: TDragObject); }
  public
    First: Boolean;
    LeftDown, RightDown: Boolean;
    StMouse: TPoint;
    OldX, OldY: integer;
    MX: Integer;
    MY: integer;
    DRObject: TObject;
    WasDraged: boolean;
    SelectedBlock: TAdvShape;
    WasValidated: Boolean;
    NewRecord: Boolean;
    RecordID: integer;
    procedure AlgoLineClick(Sender: TObject);
    procedure LoadRec;
  end;

var
  AlgoForm: TAlgoForm;
  Variables: TStringList;
  RVars: TStringList;
  Res: TStringList;
  ChemVars: TStringList;
  ErrLine, ErrPos: integer;
  Posit: integer;

function ParseBlock(B: TAlgoShape): Boolean;

resourcestring
  stNewRec = 'New recalculation';
  stManyStarts = 'More then one start block!';
  stDelTitl = 'Deleting of block';
  stDelet = 'Delete selected block?';
  stNoBlocks = 'No blocks in algorithm';
  stFirstEnd = '"End if" cannot be first block!';
  stOutVar = 'Output variable ';
  stNotFoundInRes = ' not found in left parts of operators!';
implementation

uses TabMend, RHAGlobs;

{$R *.DFM}

procedure TAlgoForm.BitBtn4Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TAlgoForm.AdvShape2Click(Sender: TObject);
var i: integer;
  S: TStringList;
begin
  TAdvShape(Sender).Visible := True;
  DrObject := nil;
  WasDraged := False;
  if SelectedBlock <> nil then
    SelectedBlock.IsSelected := False;
  TAdvShape(Sender).IsSelected := True;
  SelectedBlock := TAlgoShape(Sender);
  if SelectedBlock.Shape <> stDownTriangle then begin
    BitBtn1.Enabled := False;
    BitBtn4.Enabled := False;
    GroupBox4.Enabled := False;
    GroupBox3.Enabled := False;
    BitBtn9.Enabled := True;
    if SelectedBlock.Shape <> stEllipse then begin
      Panel1.Visible := True;
      GroupBox5.Enabled := True;
      Label8.Caption := SelectedBlock.Caption;
      RaEditor1.Lines.Assign(TAlgoShape(SelectedBlock).Lines);
      RaEditor1.SetFocus;
      RaEditor1.SetCaret(0, 0);
    end else begin
      Panel2.Visible := True;
      i := Pos(':=', TAlgoShape(SelectedBlock).Lines.Text);
      if i > 0 then begin
        Edit3.Text := Copy(TAlgoShape(SelectedBlock).Lines.Text, 0, i - 1);
        S := TStringList.Create;
        S.Text := Copy(TAlgoShape(SelectedBlock).Lines.Text, I + 2,
          Length(TAlgoShape(SelectedBlock).Lines.Text));
        RaEditor2.Lines.Assign(S);
        S.Free;
      end else begin
        Edit3.Text := '';
        RAEditor2.Lines.Clear;
      end;
    end;
  end;
end;

procedure TAlgoForm.PaintBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin

  if Source is TAdvShape then begin
    Accept := True;
  end else
    Accept := false;
end;

procedure TAlgoForm.PaintBox1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  First := True;
  if (Source is TAdvShape) then
  begin
   { if TAdvShape(Source).Owner = PaintBox1 then begin
      TAdvShape(Source).Top := Y;
      TAdvShape(Source).Left := X;
      TAdvShape(Source).Visible := True;
      TAdvShape(Source).Enabled := True;
    end else begin }
    if X > PaintBox1.Width - 100 then
      PaintBox1.Width := PaintBox1.Width + 100;
    if Y > PaintBox1.Height - 100 then
      PaintBox1.Height := PaintBox1.Height + 100;
      {New := TAlgoShape.Create(PaintBox1);
      PaintBox1.Blocks.Add(New);
      New.Top := Y;
      New.Left := X;
      New.Height := TAdvShape(Source).Height;
      New.Width := TAdvShape(Source).Width;
      New.Shape := TAdvShape(Source).Shape;
      New.Caption := TAdvShape(Source).Caption;
      New.Font.Assign(TAdvShape(Source).Font);
      New.Parent := PaintBox1;}
    if TAdvShape(PaintBox1.Blocks.Last).Shape = stDiamond then
      TAdvShape(PaintBox1.Blocks.Last).Alignment := taLeftJustify;
    TAdvShape(PaintBox1.Blocks.Last).OnMouseUp := AdvShape3MouseUp;
    TAdvShape(PaintBox1.Blocks.Last).OnMouseDown := AdvShape3MouseDown;
    TAdvShape(PaintBox1.Blocks.Last).OnMouseMove := AdvShape3MouseMove;
    TAdvShape(PaintBox1.Blocks.Last).OnDblClick := AdvShape2Click;
   { end;}
  end;
end;

{procedure TAlgoForm.AdvShape2StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
     if TAdvShape(Sender).Owner=PaintBox1 then begin
     TAdvShape(Sender).Visible:=False;
     TAdvShape(Sender).Enabled:=False;
     end;
end; }

procedure TAlgoForm.AdvShape3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Panel1.Visible then Exit;
  OldX := TAdvShape(Sender).Left - X;
  OldY := TAdvShape(Sender).Top - Y;
  MX := X;
  MY := Y;
  StMouse := PaintBox1.ScreenToClient(TAdvShape(Sender).ClientToScreen(Point(X, Y)));
  DrObject := Sender;
  if ssLeft in Shift then begin
    LeftDown := True;
    DrObject := Sender;
  end else if ssRight in Shift then begin
    RightDown := True;
    First := True;
  end;
  if SelectedBlock <> nil then
    SelectedBlock.IsSelected := False;
  SelectedBlock := TAlgoShape(Sender);
  TAlgoShape(Sender).IsSelected := True;
end;

procedure TAlgoForm.AdvShape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var En: TPoint;
begin
  if Panel1.Visible then Exit;
  if LeftDown then begin
    TAdvShape(Sender).Visible := True;
    if WasDraged then begin
      if X + OldX > PaintBox1.Width - 100 then
        PaintBox1.Width := PaintBox1.Width + 100;
      if OldY + Y > PaintBox1.Height - 100 then
        PaintBox1.Height := PaintBox1.Height + 100;
      if not First then
        TAdvShape(DRObject).DragDraw(PaintBox1.Canvas, OldX + MX, OldY + MY);
      TAdvShape(DrObject).Top := OldY + Y;
      TAdvShape(DrObject).Left := OldX + X;
      TAdvShape(Sender).Enabled := True;
      WasDraged := False;
      TAdvShape(Sender).IsSelected := False;

    end else
      AlgoLineClick(Sender);
    LeftDown := False;
  end else if RightDown then begin
    En := PaintBox1.ScreenToClient(TAdvShape(Sender).ClientToScreen(Point(X, Y)));
    PaintBox1MouseUp(Sender, Button, Shift, En.X, En.Y);
  end;
  DrObject := nil;
end;

procedure TAlgoForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     {if DRObject<>nil then begin
        if not wasDraged and (abs(OldX-X)+abs(OldY-Y)>4) then begin
           WasDraged:=True;
           First:=True;
        end;
        if WasDraged then begin
            if not First then
          TAdvShape(DRObject).DragDraw(PaintBox1.Canvas,OldX,OldY);
        TAdvShape(DRObject).DragDraw(PaintBox1.Canvas,X,Y);
        OldX:=X;
        OldY:=Y;
        First:=False;
        end;
     end;}
  if RightDown then begin
    PaintBox1.Canvas.Pen.Color := clRed;
    PaintBox1.Canvas.Pen.Mode := pmXor;
    if not First then begin
      PaintBox1.Canvas.MoveTo(StMouse.X, StMouse.Y);
      PaintBox1.Canvas.LineTo(MX, MY);
    end else
      First := False;
    PaintBox1.Canvas.MoveTo(StMouse.X, StMouse.Y);
    PaintBox1.Canvas.LineTo(X, Y);
    Mx := X;
    MY := Y;
    PaintBox1.Canvas.Pen.Mode := pmCopy;
  end;
end;

procedure TAlgoForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var L: TAlgoLine;
  St: TPoint;
begin
  if LeftDown then begin
    if WasDraged then begin
        {TAdvShape(DrObject).Top:=Y;
        TAdvShape(DrObject).Left:=X; }
      TAdvShape(DrObject).Visible := True;
      TAdvShape(DrObject).Enabled := True;
      if X > PaintBox1.Width - 100 then
        PaintBox1.Width := PaintBox1.Width + 100;
      if Y > PaintBox1.Height - 100 then
        PaintBox1.Height := PaintBox1.Height + 100;
      WasDraged := False;
    end;
    LeftDown := False;
  end else if RightDown then begin
    if not First then begin
      PaintBox1.Canvas.Pen.Color := clRed;
      PaintBox1.Canvas.Pen.Mode := pmXor;
      PaintBox1.Canvas.MoveTo(StMouse.X, StMouse.Y);
      PaintBox1.Canvas.LineTo(X, Y);
      PaintBox1.Canvas.Pen.Mode := pmCopy;
    end;
    RightDown := false;
    if (SelectedBlock <> nil) and (Sender is TAlgoShape) and (Sender <> SelectedBlock) then begin
      L := TAlgoLine.Create(PaintBox1);
      L.Visible := False;
      L.Parent := PaintBox1;
      L.OnClick := AlgoLineClick;
      St := TAlgoShape(SelectedBlock).ScreenToClient(PaintBox1.ClientToScreen(StMouse));
      TAlgoShape(SelectedBlock).Conect(St.X, St.Y, L);
      St := TAlgoShape(Sender).ScreenToClient(PaintBox1.ClientToScreen(Point(x, Y)));
      TAlgoShape(Sender).Conect(St.X, St.Y, L);
      if (L.Down = nil) or (L.Up = nil) or (L.Down = L.Up) then
        L.Free
      else begin
        PaintBox1.Blocks.Add(L);
        L.Visible := True;
      end;
      PaintBox1.Invalidate;
    end;
  end;
  DrObject := nil;
end;

procedure TAlgoForm.AdvShape3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var en: TPoint;
begin
  if DRObject <> nil then begin
    if LeftDown then begin
      if not wasDraged and (abs(MX - X) + abs(MY - Y) > 4) then begin
        WasDraged := True;
        First := True;
        TAdvShape(Sender).Visible := False;
        Application.ProcessMessages;
      end;
      if WasDraged then begin
        if not First then
          TAdvShape(DRObject).DragDraw(PaintBox1.Canvas, OldX + MX, OldY + MY);
        TAdvShape(DRObject).DragDraw(PaintBox1.Canvas, OldX + X, OldY + Y);
        Mx := X;
        MY := Y;
        First := False;
      end;
    end else if RightDown then begin
      En := PaintBox1.ScreenToClient(TAdvShape(Sender).ClientToScreen(Point(X, Y)));
      PaintBox1MouseMove(Sender, Shift, En.x, En.Y);
    end;
  end;
end;

procedure TAlgoForm.Button3Click(Sender: TObject);
begin
  RAEditor1.Lines.Clear;
  RaEditor1.SetFocus;
  RaEditor1.SetCaret(0, 0);
end;

procedure TAlgoForm.BitBtn5Click(Sender: TObject);
begin
  Panel1.Visible := False;
  ActiveControl := nil;
  BitBtn1.Enabled := True;
  BitBtn4.Enabled := True;
  GroupBox4.Enabled := True;
  GroupBox3.Enabled := True;
  GroupBox5.Enabled := False;
  BitBtn9.Enabled := False;
end;

procedure TAlgoForm.BitBtn6Click(Sender: TObject);
var s: string;
  i: integer;
  Ed1: Boolean;
begin
  if SelectedBlock.Shape = stEllipse then begin
    TAlgoShape(SelectedBlock).Lines.Assign(RaEditor2.Lines);
    if Edit3.Text <> '' then
      TAlgoShape(SelectedBlock).Lines[0] := Edit3.Text + ':=' + TAlgoShape(SelectedBlock).Lines[0];
    Ed1 := False;
  end else begin
    ED1 := True;
    TAlgoShape(SelectedBlock).Lines.Assign(RaEditor1.Lines);
  end;
  if ParseBlock(TAlgoShape(SelectedBlock)) then begin
    if Ed1 then
      BitBtn5Click(Sender)
    else
      BitBtn8Click(Sender);
    if (SelectedBlock.Shape in [stRectangle, stRoundRect]) and
      (TAlgoShape(SelectedBlock).Results.Count > 0) then begin
      S := '';
      for i := 0 to TAlgoShape(SelectedBlock).Results.Count - 1 do
        S := S + TAlgoShape(SelectedBlock).Results[i] + ', ';
      Delete(S, Length(S) - 1, 2);
      SelectedBlock.Caption := S;
    end;
    if (SelectedBlock.Shape = stEllipse) and
      (TAlgoShape(SelectedBlock).Results.Count > 0) then
      SelectedBlock.Caption := TAlgoShape(SelectedBlock).Results[0];
    if (SelectedBlock.Shape = stDiamond) and
      (TAlgoShape(SelectedBlock).Lines.Count > 0) then
      SelectedBlock.Caption := TAlgoShape(SelectedBlock).Lines[0];
  end else begin
    RaEditor1.SetFocus;
    RaEditor1.SetCaret(0, ErrLine);
  end;
end;

procedure TAlgoForm.FormCreate(Sender: TObject);
var i: integer;
begin
  {Blocks := TList.Create;}
  DM1.TabRec.Open;
  DM1.TabVars.Open;
  Variables := TStringList.Create;
  Variables.Sorted := True;
  Variables.Duplicates := dupIgnore;
  RVars := TStringList.Create;
  RVars.Sorted := True;
  RVars.Duplicates := dupIgnore;
  Res := TStringList.Create;
  Res.Sorted := True;
  Res.Duplicates := dupIgnore;
  ChemVars := TStringList.Create;
  ChemVars.Sorted := True;
  ChemVars.Duplicates := dupIgnore;
  for i := 1 to NFunctions do
    ListBox1.Items.Add(stFunc[i]);
end;

procedure TAlgoForm.FormDestroy(Sender: TObject);
begin
  {Blocks.Free;}
  Variables.Free;
  ChemVars.Free;
  RVars.Free;
  Res.Free;
  DM1.TabRec.Close;
  DM1.TabVars.Close;
end;

procedure TAlgoForm.BitBtn1Click(Sender: TObject);
var i, j, k: integer;
  Start: TAlgoShape;
  A: TAdvShape;
  RPath, EndOfAll, PNo: Boolean;
  Stack: TList;
  S, S1: string;
  function GetNextBlock: Boolean;
  var i, j: integer;
  begin
    Result := True;
    if Start.Shape in [stRectangle, stRoundRect, stEllipse] then begin
      if Stack.Count > 0 then
        for i := 0 to Stack.Count - 1 do
          for j := 0 to Start.Results.Count - 1 do
            TAlgoShape(Stack[i]).Results.Add(Start.Results[j]);
      if (Start.Down <> nil) and (Start.Down.Down <> nil) then
        Start := Start.Down.Down
      else
        Result := false;
    end else
      if Start.Shape = stDiamond then begin
        if RPath then begin
          if (Start.No <> nil) and (Start.No.Down <> nil) then
            Start := Start.No.Down
          else
            Result := false;
        end else begin
          if (Start.Yes <> nil) and (Start.Yes.Down <> nil) then
            Start := Start.Yes.Down
          else
            Result := false;
        end;
      end else
        if Start.Shape = stDownTriangle then begin
          if RPath then begin
            RPath := TAlgoShape(Stack.Last).PathNo;
            Stack.Remove(Stack.Last);
            if (Start.Down <> nil) and (Start.Down.Down <> nil) then
              Start := Start.Down.Down
            else
              Result := false;
          end else
            if stack.Count > 0 then begin
              RPath := True;
              Start := Stack.Last;
              PNo := True;
            end else
              Result := false;
        end;
  end;
begin
  WasValidated := False;
  Res.Clear;
  Variables.Clear;
  RVars.Clear;
  if DM1.TabVars.State <> dsBrowse then
    DM1.TabVars.Post;
  if PaintBox1.Blocks.Count < 1 then begin
    ShowMessage(stNoBlocks);
    Exit;
  end;
  try
    STack := TList.Create;
    k := 0;
    for i := 0 to PaintBox1.Blocks.Count - 1 do begin
      A := TAdvShape(PaintBox1.Blocks[i]);
      if (A is TAlgoShape) then begin
        if ParseBlock(TAlgoShape(A)) then begin
          for j := 0 to TAlgoShape(A).Results.Count - 1 do begin
            Variables.Add(TAlgoShape(A).Results[j]);
            Res.Add(TAlgoShape(A).Results[j]);
          end;
          for j := 0 to TAlgoShape(A).Variables.Count - 1 do begin
            Variables.Add(TAlgoShape(A).Variables[j]);
            RVars.Add(TAlgoShape(A).Variables[j]);
          end;
          if (TAlgoShape(A).Up = nil) then begin
            Start := TAlgoShape(A);
            inc(k);
          end;
        end else begin

          Abort;
        end;
      end;
    end;
    if k > 1 then begin
      ShowMessage(stManyStarts);
      Abort;
    end;
    if Start.Shape = stDownTriangle then begin
      ShowMessage(stFirstEnd);
      Abort;
    end;
    ChemVars.Clear;
    RAHLEditor1.BeginUpdate;
    RAHLEditor1.Lines.Clear;
    RAHLEditor1.Lines.Add('Unit petros;');
    RAHLEditor1.Lines.Add('function Main : boolean;');
    RAHLEditor1.Lines.Add('var _VE : TValueExtractor;');
    S := '';
    for i := 0 to Variables.Count - 1 do
      if Length(S) < 80 then
        S := S + Variables[i] + ','
      else begin
        {if i = Variables.Count - 1 then
          Delete(S, Length(S), 1);}
        RAHLEditor1.Lines.Add(S);
        S := Variables[i] + ',';
      end;
    if S <> '' then Delete(S, Length(S), 1);
    if Variables.Count > 0 then
      S := S + ' : Variant;';
    RAHLEditor1.Lines.Add(S);
    Posit := 0;
    RAHLEditor1.Lines.Add('begin');
    inc(Posit, 2);
    RAHLEditor1.Lines.Add('  Result:=True;');
    {RAHLEditor1.Lines.Add('try');}
    RAHLEditor1.Lines.Add('  _VE :=TValueExtractor(Application.FindComponent(''AlgoForm'').FindComponent(''VE1''));');
    for i := RVars.Count - 1 downto 0 do begin
      S := RVars[i];
      if S[1] = '_' then begin
        j := MendTab.GetNumById(S);
        if j > 0 then begin
          RVars.Delete(i);
          S := '  ' + S + ':=_VE.GetValue(' + IntToStr(J) + ');';
          RAHLEditor1.Lines.Add(S);
        end;
      end;
    end;

    with DM1.TabVars do begin
      DisableControls;
      try
        First;
        while not eof do begin
          S := AnsiLowerCase(DM1.TabVars['Name']);
          RPath := True;
          for i := 0 to Res.Count - 1 do
            if S = Res[i] then begin
              RPath := False;
              RVars.Add(S);
              break;
            end;
          if RPath then begin
            ShowMessage(stOutVar + DM1.TabVars['Name'] + stNotFoundInRes);
            Abort;
          end;
          Next;
        end;
      finally
        EnableControls;
      end;
    end;

    RPath := false;
    EndOfAll := false;
    for i := 0 to RVars.Count - 1 do
      RAHLEditor1.Lines.Add('  ' + RVars[i] + ':=null;');
    PNo := False;
    repeat
      if (Start.Shape = stDiamond) then begin
        S := '';
        if PNo then begin
          RPath := True;
          PNo := False;
          RAHLEditor1.Lines.Add(BlankStr(Posit) + 'else begin');
          inc(Posit, 2);
        end else begin
          Stack.Add(Start);
          Start.PathNo := RPath;
          RPath := False;
          if Start.Variables.Count > 0 then begin
            S := 'if ';
            for i := 0 to Start.Variables.Count - 1 do
              S := S + '(' + Start.Variables[i] + '<>Null)and';
            Delete(S, Length(s) - 2, 3);
            S := S + ' then ';

          end;
          s := S + 'begin';
          RAHLEditor1.Lines.Add(BlankStr(Posit) + S);
          inc(Posit, 2);
          S := 'if ';
          for i := 0 to Start.Lines.Count - 1 do begin
            S := S + Start.Lines[i];
            RAHLEditor1.Lines.Add(BlankStr(Posit) + S);
            S := '';
          end;
          RAHLEditor1.Lines.Add(BlankStr(Posit) + S + ' then begin');
          inc(Posit, 2);
        end;
      end else if Start.Shape in [stRectangle, stRoundRect] then begin
        if Start.Variables.Count > 0 then begin
          S := 'if ';
          for i := 0 to Start.Variables.Count - 1 do
            S := S + '(' + Start.Variables[i] + '<>Null)and';
          Delete(S, Length(s) - 2, 3);
          RAHLEditor1.Lines.Add(BlankStr(Posit) + S + ' then begin');
          inc(Posit, 2);
        end;
        for i := 0 to Start.Lines.Count - 1 do
          RAHLEditor1.Lines.Add(BlankStr(Posit) + Start.Lines[i]);
        if Start.Variables.Count > 0 then begin
          {RAHLEditor1.Lines.Add(BlankStr(Posit-2)+'end else begin');
          for i := 0 to Start.Results.Count - 1 do
            RAHLEditor1.Lines.Add(BlankStr(Posit)+Start.Results[i] + ':=Null;');}
          Dec(Posit, 2);
          RAHLEditor1.Lines.Add(BlankStr(Posit) + 'end;');
        end;
      end else
        if Start.Shape = stEllipse then begin
          {RAHLEditor1.Lines.Add(BlankStr(Posit)+'begin');
          inc(Posit, 2);}
          if Start.Results.Count > 0 then begin
            RAHLEditor1.Lines.Add(BlankStr(Posit) + Start.Results[0] + ':=0;');
            for i := 0 to Start.Variables.Count - 1 do
              RAHLEditor1.Lines.Add(BlankStr(Posit) + 'if ' + Start.Variables[i] +
                '<>Null then ' + Start.Results[0] + ':=' + Start.Results[0] + '+' +
                Start.Variables[i] + ';');
          end;
        end else
          if Start.Shape = stDownTriangle then begin
            if RPath then begin
              Dec(Posit, 2);
              RAHLEditor1.Lines.Add(BlankStr(Posit) + 'end;');
              if TAlgoShape(Stack.Last).Variables.Count > 0 then begin
              {RAHLEditor1.Lines.Add(BlankStr(Posit-2)+'end else begin');
              for i := 0 to TAlgoShape(Stack.Last).Results.Count - 1 do
                RAHLEditor1.Lines.Add(BlankStr(Posit)+TAlgoShape(Stack.Last).Results[i] + ':=Null;');}
                Dec(Posit, 2);
                RAHLEditor1.Lines.Add(BlankStr(Posit) + 'end;');
              end else begin
                Dec(Posit, 2);
                RAHLEditor1.Lines.Add(BlankStr(Posit) + 'end;');
              end;
            end else begin
              Dec(Posit, 2);
              RAHLEditor1.Lines.Add(BlankStr(Posit) + 'end');
            end;
          end;
    until not GetNextBlock;
    with DM1.TabVars do begin
      DisableControls;
      try
        First;
       { i := 1;}
        while not eof do begin
          RAHLEditor1.Lines.Add('  _VE.SetData(' + IntToStr(DM1.TabVars['Pos']) + ','
            + DM1.TabVars['Name'] + ');');
          Next;
        {  inc(i);}
        end;
      finally
        EnableControls;
      end;
    end;
    RAHLEditor1.Lines.Add('end;');
    RAHLEditor1.Lines.Add('end.');
    PageControl1.ActivePage := TabSheet3;
  finally
    RAHLEditor1.EndUpdate;
    Stack.Free;
  end;
end;

procedure TAlgoForm.AdvShape1Click(Sender: TObject);
begin
  SelectedBlock := TAlgoShape(Sender);
end;

function ParseBlock(B: TAlgoShape): Boolean;
var Cod: integer;
begin
  Result := True;
  if (AlgoForm.SelectedBlock <> nil) and (AlgoForm.SelectedBlock <> B) then
    AlgoForm.SelectedBlock.IsSelected := False;
  AlgoForm.SelectedBlock := B;
  B.IsSelected := True;
  if not B.FindVariables(ErrLine, ErrPos, Cod) then begin
    Result := False;
    ShowMessage(GetErrorStr(Cod));
    AlgoForm.PaintBox1.Invalidate;
    Exit;
  end;
end;

procedure TAlgoForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var T, T1: string;
begin
  if (ActiveControl <> RAEditor1) and (ActiveControl <> RAEditor2) and
    (PageControl1.ActivePage = TabSheet2) and (ActiveControl <> HDBGrid1) and
    (Key = VK_DELETE) and (SelectedBlock <> nil) then begin
    T := stDelet;
    T1 := stDelTitl;
    if Application.MessageBox(PChar(T), PChar(T1),
      MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1 + MB_APPLMODAL) = ID_YES then begin
      PaintBox1.Blocks.Remove(SelectedBlock);
      SelectedBlock.Free;
      SelectedBlock := nil;
    end;
  end;
end;

procedure TAlgoForm.AlgoLineClick(Sender: TObject);
begin
  ActiveControl := nil;
  if SelectedBlock <> nil then
    SelectedBlock.IsSelected := False;
  SelectedBlock := TAdvShape(Sender);
  SelectedBlock.IsSelected := True;
end;



procedure TAlgoForm.BitBtn3Click(Sender: TObject);
begin
     {if NewRecord then
        DM1.TabRec.Insert
     else}
  DM1.TabRec.Edit;
  DM1.TabRec['W'] := CheckBox1.Checked;
  DM1.TabRec['AW'] := CheckBox3.Checked;
  DM1.TabRec['C100'] := CheckBox2.Checked;
  DM1.TabRec['Mols'] := CheckBox4.Checked;
    {DM1.DM1.TabRec['Name']:=Edit1.Text;}
  DM1.TabRec['Descript'] := Edit2.Text;
  DM1.TabRec['Validated'] := WasValidated;
  DM1.TabRec.Post;
  if DM1.TabVars.State <> dsBrowse then
    DM1.TabVars.Post;
  ModalResult := mrOK;
  {Close;}
end;

procedure TAlgoForm.BitBtn2Click(Sender: TObject);
var x, y: integer;
begin
  RAProgr.Source := RAHLEditor1.Lines.Text;
  WasValidated := False;
  {RAProgr.Compile;}
  try
    RaProgr.Run;
    {if RaProgr.VResult then begin}
    ShowMessage('   OK!');
    WasValidated := true;
   { end; }
  except
    on E: EjvInterpreterError do begin
      ShowMessage(E.Message);
      RAHLEditor1.CaretFromPos(E.ErrPos, X, Y);
      RAHLEditor1.SetCaret(X, Y);
      RAHLEditor1.SetFocus;
    end else
    raise;
    WasValidated := False;
  end;
end;

procedure TAlgoForm.ListBox1DblClick(Sender: TObject);
var S: string;
  i, j: integer;
begin
  if Panel1.Visible then begin
    S := ListBox1.Items[ListBox1.ItemIndex];
    i := Length(S) + 1;
    S := S + '(';
    for j := 2 to stFArg[ListBox1.ItemIndex + 1] do
      S := S + ',';
    S := S + ')';
    j := RaEditor1.CaretX;
    RaEditor1.BeginUpdate;
    RAEditor1.InsertText(S);
    RAEditor1.CaretX := i + j;
    RAEditor1.EndUpdate;
    RAEditor1.SetFocus;
  end;
end;

procedure TAlgoForm.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := not Panel1.Visible;
end;

procedure TAlgoForm.BitBtn9Click(Sender: TObject);
var S: string;
  i: integer;
begin
  MendForm.MendTabl1.OnlyOne := True;
  MendForm.MendTabl1.Comma := False;
  MendForm.MendTabl1.ConcEnable := False;
  MendForm.MendTabl1.EnableType := False;
  if MendForm.ShowModal = mrOK then begin
    if (not Ve1.Atomn) then
      S := MendTab.GetPetroSym(MendForm.MendTabl1.LastElementNum)
    else if (Ve1.Mols) then begin
      S := MendTab.GetOxide(MendForm.MendTabl1.LastElementNum);
      if MendForm.MendTabl1.LastElementNum = 26 then
        S := S + 'tot';
    end else begin
      S := MendTab.GetSymbol(MendForm.MendTabl1.LastElementNum);
      if MendForm.MendTabl1.LastElementNum = 93 then
        S := S + '3'
      else if MendForm.MendTabl1.LastElementNum = 94 then
        S := S + '2';
    end;
    S := '_' + S;
    if SelectedBlock.Shape = stEllipse then begin
      I := RaEditor2.CaretX;
      RAEditor2.BeginUpdate;
      RAEditor2.InsertText(S + ',');
      RaEditor2.CaretX := i + Length(S) + 1;
      RAEditor2.EndUpdate;
      RAEditor2.SetFocus;
    end else begin
      I := RaEditor1.CaretX;
      RAEditor1.BeginUpdate;
      RAEditor1.InsertText(S);
      RaEditor1.CaretX := i + Length(S);
      RAEditor1.EndUpdate;
      RAEditor1.SetFocus;
    end;
  end;
  MendForm.MendTabl1.OnlyOne := False;
end;

procedure TAlgoForm.FormShow(Sender: TObject);
begin
  Variables.Clear;
  ChemVars.Clear;
  RVars.Clear;
  SelectedBlock := nil;
  VE1.DataSet := nil;
  if NewRecord then begin
    GroupBox2.Enabled := True;
    CheckBox1.Checked := false;
    CheckBox3.Checked := False;
    CheckBox4.Checked := False;
    {Edit1.Text:=stNewRec;}
    Edit2.Text := '';
  end else begin
    GroupBox2.Enabled := false;
    LoadRec;
  end;
end;

procedure TAlgoForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then begin
    CheckBox4.Checked := false;
    if not CheckBox3.Checked then
      CheckBox2.Enabled := True;
  end else begin
    CheckBox2.Enabled := False;
    CheckBox2.Checked := True;
  end;
  VE1.Atomn := not CheckBox1.Checked;
end;

procedure TAlgoForm.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked then begin
    CheckBox1.Checked := false;
    CheckBox2.Enabled := False;
    CheckBox2.Checked := True;
  end;
  VE1.Mols := CheckBox4.Checked;
end;

procedure TAlgoForm.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then begin
    CheckBox2.Enabled := False;
    CheckBox2.Checked := True;
  end else if CheckBox1.Checked then
    CheckBox2.Enabled := True;
  VE1.AW := CheckBox3.Checked;
end;

procedure TAlgoForm.CheckBox2Click(Sender: TObject);
begin
  VE1.C100 := CheckBox2.Checked;
end;

procedure TAlgoForm.LoadRec;
begin
  CheckBox1.Checked := DM1.TabRec['W'] = 1;
  CheckBox1Click(nil);
  CheckBox3.Checked := DM1.TabRec['AW'];
  CheckBox3Click(nil);
  CheckBox2.Checked := DM1.TabRec['C100'];
  CheckBox2Click(nil);
  CheckBox4.Checked := DM1.TabRec['Mols'];
  CheckBox4Click(nil);
    {Edit1.Text:=DM1.DM1.TabRec['Name'];}
  if DM1.TabRec['Descript'] <> null then
    Edit2.Text := DM1.TabRec['Descript']
  else
    Edit2.Text := '';
  WasValidated := DM1.TabRec['Validated'];
end;

procedure TAlgoForm.Button1Click(Sender: TObject);
begin
  LoadRec;
end;

procedure TAlgoForm.VE1GetValue(Sender: TObject; Num, AnType: Integer;
  var Value: Variant);
begin
  Value := GetConcValue(VE1.DataSet, Num, TDatType(AnType));
end;

procedure TAlgoForm.Button2Click(Sender: TObject);
begin
  RAEditor2.Lines.Clear;
  RaEditor2.SetFocus;
  RaEditor2.SetCaret(0, 0);
end;

procedure TAlgoForm.BitBtn8Click(Sender: TObject);
begin
  Panel2.Visible := False;
  ActiveControl := nil;
  BitBtn1.Enabled := True;
  BitBtn4.Enabled := True;
  GroupBox4.Enabled := True;
  GroupBox3.Enabled := True;
  GroupBox5.Enabled := False;
  BitBtn9.Enabled := False;
end;

procedure TAlgoForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

end.

