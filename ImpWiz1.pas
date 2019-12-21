unit ImpWiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, wizards, Buttons, StdCtrls, OleServer, Excel97, FormEx, Boxes,
  Mend_C, StrHlder, Chemist, Db, DBTables, EsbRtns, Analise, Clipbrd,
  CheckLst, DBCtrls, Mask;

type
  TWizForm = class(TForm)
    Wizard1: TWizard;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    ExcApp: TExcelApplication;
    Panel3: TPanel;
    MendTabl1: TMendTabl;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn9: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure Wizard1ButtonFinishClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Wizard1ButtonNextClick(Sender: TObject; CurrentPage: Integer;
      var AllowMove: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ExcListClick(Sender: TObject);
    procedure CListClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure TabEdBookAfterCancel(DataSet: TDataSet);
    procedure TabEdBookBeforePost(DataSet: TDataSet);
    procedure Wizard1EnteringPage(Sender: TObject; CurrentPage: Integer;
      Direction: TWizardDirection);
  private
    { Private declarations }
    procedure MapField(FName: string; Num: Integer; Adr: string);
    function ValidateCell(X, Y: integer; FieldId: integer; PPM: Boolean;
      FName: string; AnNum: integer): Boolean;
  public
    { Public declarations }
  end;

  Tint = class
    N: integer;
    constructor Create(An: Integer);
  end;

  TCorr = class
    N: integer;
    Id: integer;
    constructor Create(An, AID: Integer);
  end;

var
  WizForm: TWizForm;
  ValidData: Boolean;

resourcestring
  stErr = 'Error in the number cell';
  stRange = 'Value out of range for this field';
  stPromt = 'Input valid value of field ';
  stNotEnComp = 'Count of components less then minimal value (';
  stAnNum = 'Analise N ';
  stWillNotInsert = '). It will be excluded from importing data';

implementation

uses Main, RHAGlobs, DMod1;

{$R *.DFM}

var FRow, ERow, FCol, ECol: integer;
  FieldsCount, AnalCount: integer;
  Sell: Range;

procedure TWizForm.BitBtn1Click(Sender: TObject);
begin
  if Wizard1.ActivePage = '4' then begin
    ValidData := true;
    DM1.TabEdBook.Cancel;
    DM1.TabM1.Cancel;
  end;
  Close;
end;

procedure TWizForm.Wizard1ButtonFinishClick(Sender: TObject);
begin
  Close;
end;

procedure TWizForm.BitBtn2Click(Sender: TObject);
var ok: Boolean;
begin
 { ExcApp.Visible[0] := True;}
  ok := ExcApp.Dialogs[xlDialogOpen].Show(EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam);
  ExcApp.Visible[0] := True;
    { Application.Dialogs(xlDialogOpen).Show}
  MainForm.Hide;
  Application.BringToFront;
end;

procedure TWizForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  BookEdits := Self;
  ValidData := True;
  ExcApp.Connect;
  ExcApp.Visible[0] := True;
  {if ExcApp.Workbooks.Count < 1 then
  begin
    ExcWb := ExcApp.Workbooks.Add(xlWBATWorksheet, 0);
    ExcApp.Workbooks[1].Activate(0);
  end else
      ExcApp.Visible[0]:=True;}
  DM1.ImpFields.Open;
  DM1.Sinonims.Open;

  Application.ProcessMessages;
  Wizard1.ActivePage := '0';
  MainForm.Hide;
  Application.BringToFront;
  Self.Repaint;
end;

procedure TWizForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  MainForm.Visible := true;
  DM1.Sinonims.Close;
  DM1.ImpFields.Close;
  DM1.TabS1.Close;
  DM1.TabSource.Close;

  ExcApp.Disconnect;
end;

procedure TWizForm.BitBtn3Click(Sender: TObject);
begin
  Panel3.Visible := True;
end;

procedure TWizForm.BitBtn4Click(Sender: TObject);
begin
  Panel3.Visible := false;
  PetrList.Items.Add(MendTabl1.Text);
  PetrList.Items.Objects[PetrList.Items.Count - 1] := TInt.Create(-1);
  PetrList.ItemIndex := PetrList.Items.Count - 1;
  ExcListClick(Sender);
end;

procedure TWizForm.BitBtn5Click(Sender: TObject);
begin
  Panel3.Visible := False;
end;

procedure TWizForm.Wizard1ButtonNextClick(Sender: TObject;
  CurrentPage: Integer; var AllowMove: Boolean);
var i, j: integer;
  T, S: string;
  Sl: Range;
begin
  if CurrentPage = 1 then begin
    Sl := Range(ExcApp.Selection[0]);
    Sell := ExcApp.Range[Sl.Cells.Item[1, 1], Sl.Cells.Item[Sl.Rows.Count, Sl.Columns.Count]];
    ERow := Sell.Rows.Count;
    ECol := Sell.Columns.Count;
    if ECol * ERow < 10 then begin
      ShowMessage('Select table!');
      AllowMove := False;
      Exit;
    end;

    PetrList.Clear;
    DM1.ImpFields.First;
    while not DM1.ImpFields.Eof do begin
      PetrList.Items.Add(DM1.ImpFields['DName']);
      PetrList.Items.Objects[PetrList.Items.Count - 1] := TInt.Create(DM1.ImpFields['Id']);
      DM1.ImpFields.Next;
    end;
    PetrList.ItemIndex := -1;
    SpeedButton1.Enabled := false;
    SpeedButton2.Enabled := false;
    CList.Clear;

    ExcList.Clear;
    if RadioGroup1.ItemIndex = 1 then begin
      AnalCount := ECol;
      FieldsCount := ERow;
    end else begin
      AnalCount := ERow;
      FieldsCount := ECol;
    end;

    if CheckBox1.Checked then begin
      Dec(AnalCount);
      if RadioGroup1.ItemIndex = 1 then begin
        for i := 1 to FieldsCount do
          MapField(Sell.Cells.Item[i, 1], i, ExcApp.Range[Sell.Cells.Item[i, 1],
            Sell.Cells.Item[i, 1]].Address[True, False, xlA1,
              False, EmptyParam]);
      end else begin
        for i := 1 to FieldsCount do
          MapField(Sell.Cells.Item[1, i], i, ExcApp.Range[Sell.Cells.Item[1, i],
            Sell.Cells.Item[1, i]].Address[False, True, xlA1,
              False, EmptyParam]);
      end
    end else begin
      if RadioGroup1.ItemIndex = 1 then
        for i := 1 to FieldsCount do
          ExcList.Items.AddObject(ExcApp.Range[Sell.Cells.Item[i, 1], Sell.Cells.Item[i, 1]].Address[True, False, xlA1,
            False, EmptyParam], TInt.Create(i))
      else
        for i := 1 to FieldsCount do
          ExcList.Items.AddObject(ExcApp.Range[Sell.Cells.Item[1, i], Sell.Cells.Item[1, i]].Address[False, True, xlA1,
            False, EmptyParam], TInt.Create(i));
    end
  end
  else if CurrentPage = 2 then begin
    T := '';
    for i := 0 to CList.Items.Count - 1 do
      if TCorr(CList.Items.Objects[I]).Id < 0 then begin
        S := CList.Items[i];
        T := T + Copy(S, Pos(' -> ', S) + 4, Length(S)) + ',';
      end;
    S := T;
         {Titles.Add(S);
          if Lenth(S)<=255 then begin
          end else begin
             DM1.TabM1['Title1']:=S;
             DM1.TabM1['Title2']:=Null;
             DM1.TabM1['Title1']:=Copy(S,1,255);
             DM1.TabM1['Title2']:=Copy(S,256,255);
          end; }
    AnalisTitle.Free;
    AnalisTitle := TAnalisTitle.Create(S);
    if AnalisTitle.Count <= MinCompCount then begin
      ShowMessage(stNotEnComp + IntToStr(MinCompCount) + ')');
      AllowMove := False;
      Exit;
    end;

      {TitleCombo.Items.Add(S);
      Titles.Add(S);
       i:=Table2['Id'];
       DM1.TabM1['Source']:=Table2['Id'];
       DM1.TabM1['NComp']:=AnalisTitle.Count;
       DM1.TabM1.Post;
       if Table2.State <>dsBrowse  then
            Table2.Post;   }
    CheckListBox1.Clear;
    for i := 0 to AnalisTitle.Count - 1 do begin
      CheckListBox1.Items.Add(TFormula(AnalisTitle[I]).Symbol);
      if Length(TFormula(AnalisTitle[I]).Symbol) < 3 then
        CheckListBox1.Checked[i] := true;
    end;
    Button2.Enabled := False;
           {GroupBox2.Enabled:=true;
           GroupBox2.Visible:=true;}
          { BitBtn1.Enabled:=false;
           BitBtn2.Enabled:=false;}
  end else if CurrentPage = 3 then begin
    DM1.TabSource.Open;
    DM1.TabM1.Insert;
    DM1.TabS1.Open;
        {ChangedTitle:=false; !!!!!!!!!!}
    DM1.TabEdBook.Last;
    DM1.TabEdBook.Edit;
  end else if CurrentPage = 4 then begin
    AllowMove := ValidData;
  end;
end;

procedure TWizForm.MapField(FName: string; Num: Integer; Adr: string);
var i: integer;
  FFName: string;
label Ex;
begin
  if FName <> '' then begin
    FFName := StripChStr(FName, ' ');
    if ValidFormula(FFName) = 0 then
      CList.Items.AddObject(FFName + ' -> ' + FFName, TCorr.Create(Num, -1))
    else begin
      for i := 0 to PetrList.Items.Count - 1 do begin
        DM1.ImpFields.FindKey([TInt(PetrList.Items.Objects[i]).N]);
        DM1.Sinonims.First;
        while not DM1.Sinonims.Eof do begin
          if DM1.Sinonims['Text'] = FFName then begin
            CList.Items.AddObject(FFName + ' -> ' + DM1.ImpFields['DName'],
              TCorr.Create(Num, Tint(PetrList.Items.Objects[i]).N));
            PetrList.Items.Objects[i].Free;
            PetrList.Items.Delete(i);
            goto Ex;
          end;
          DM1.Sinonims.Next;
        end;
      end;
      ExcList.Items.AddObject(FFName, TInt.Create(Num));
      Ex: end;
  end else
    ExcList.Items.AddObject(Adr, TInt.Create(Num));
end;

{ Tint }

constructor Tint.Create(An: Integer);
begin
  inherited Create;
  N := AN;
end;

{ TCorr }

constructor TCorr.Create(An, AID: Integer);
begin
  inherited Create;
  N := AN;
  Id := AID;
end;

procedure TWizForm.SpeedButton1Click(Sender: TObject);
begin
  SpeedButton1.Enabled := false;
  CList.Items.Add(ExcList.Items[ExcList.ItemIndex] + ' -> ' + PetrList.Items[PetrList.ItemIndex]);
  CList.Items.Objects[CList.Items.Count - 1] :=
    TCorr.Create(Tint(ExcList.Items.Objects[ExcList.ItemIndex]).N, Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N);
  if (Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N > 0) then begin
    DM1.ImpFields.FindKey([Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N]);
    if not DM1.Sinonims.Locate('FieldID;Text',
      VarArrayof([Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N,
      ExcList.Items[ExcList.ItemIndex]]), []) then begin
      DM1.Sinonims.Insert;
      DM1.Sinonims['FieldId'] := Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N;
      DM1.Sinonims['Text'] := ExcList.Items[ExcList.ItemIndex];
      DM1.Sinonims.Post;
    end;
  end;
  PetrList.Items.Objects[PetrList.ItemIndex].Free;
  PetrList.Items.Delete(PetrList.ItemIndex);
  PetrList.ItemIndex := -1;
  ExcList.Items.Objects[ExcList.ItemIndex].Free;
  ExcList.Items.Delete(ExcList.ItemIndex);
  ExcList.ItemIndex := -1;
end;

procedure TWizForm.ExcListClick(Sender: TObject);
begin
  if (ExcList.ItemIndex >= 0) and (PetrList.ItemIndex >= 0) then
    SpeedButton1.Enabled := true;
end;

procedure TWizForm.CListClick(Sender: TObject);
begin
  if Clist.ItemIndex >= 0 then
    SpeedButton2.Enabled := true;
end;

procedure TWizForm.SpeedButton2Click(Sender: TObject);
var S: string;
begin
  SpeedButton2.Enabled := False;
  S := Clist.Items[CList.ItemIndex];

  ExcList.Items.Add(Copy(S, 1, Pos(' -> ', S) - 1));
  if TCorr(Clist.Items.Objects[CList.ItemIndex]).Id > 0 then begin
    DM1.ImpFields.FindKey([TCorr(Clist.Items.Objects[CList.ItemIndex]).Id]);
    DM1.Sinonims.First;
    while not DM1.Sinonims.Eof do begin
      if DM1.Sinonims['Text'] = ExcList.Items[ExcList.Items.Count - 1] then begin
        DM1.Sinonims.Delete;
        break;
      end;
      DM1.Sinonims.Next;
    end;

  end;
  ExcList.Items.Objects[ExcList.Items.Count - 1] :=
    TInt.Create(TCorr(Clist.Items.Objects[CList.ItemIndex]).N);
  if TCorr(Clist.Items.Objects[CList.ItemIndex]).Id > 0 then begin
    PetrList.Items.Add(Copy(S, Pos(' -> ', S) + 4, Length(S)));
    PetrList.Items.Objects[PetrList.Items.Count - 1] :=
      TInt.Create(TCorr(Clist.Items.Objects[CList.ItemIndex]).ID);
  end;
  CList.Items.Objects[CList.ItemIndex].Free;
  CList.Items.Delete(CList.ItemIndex);
  CList.ItemIndex := -1;
end;

procedure TWizForm.BitBtn6Click(Sender: TObject);
var i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := true;

end;

procedure TWizForm.BitBtn8Click(Sender: TObject);
var i: integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do
    CheckListBox1.Checked[i] := false;

end;

procedure TWizForm.Button3Click(Sender: TObject);
var i, j, Beg, Comp, X, Y: integer;
  S: string;
begin
  Button2.Enabled := true;
  if CheckBox1.Checked then
    Beg := 1
  else
    Beg := 0;
  Comp := -1;
  for i := 1 to FieldsCount do begin
    if TCorr(Clist.Items.Objects[i - 1]).Id < 0 then
      Inc(Comp);
    S := Clist.Items[I - 1];
    s := Copy(S, 1, Pos(' -> ', S) - 1);
    for j := 1 to AnalCount do begin
      if RadioGroup1.ItemIndex = 0 then begin
        X := j + beg;
        Y := i;
      end else begin
        X := i;
        Y := j + beg;
      end;
      repeat
      until ValidateCell(X, Y, TCorr(Clist.Items.Objects[i - 1]).Id,
        CheckListBox1.Checked[Comp], S, j);
    end;
  end;

  for j := 1 to AnalCount do begin
    Comp := 0;
    for i := 1 to FieldsCount do begin
      if RadioGroup1.ItemIndex = 0 then begin
        X := j + beg;
        Y := i;
      end else begin
        X := i;
        Y := j + beg;
      end;
      S := Sell.Cells.Item[X, Y];
      if (TCorr(Clist.Items.Objects[i - 1]).Id < 0) and (S <> '') then
        Inc(Comp);
    end;
    if Comp <= MinCompCount then begin
      ShowMessage(stAnNum + IntToStr(j) + stNotEnComp + IntToStr(MinCompCount)
        + stWillNotInsert);
    end;
  end;
end;

function TWizForm.ValidateCell(X, Y: integer; FieldId: integer; PPM: Boolean;
  FName: string; AnNum: integer): Boolean;
var R, M: extended;
  Inf, Cell: string;
begin
  result := true;
  Cell := Sell.Cells.Item[X, Y];
  if Cell = '' then
    Exit;
  {begin
    Cell := '0';
    Sell.Cells.Item[X, Y] := Cell;
  end; }
  if FieldId < 0 then begin
    if PPM then
      M := 100000
    else
      M := 100;
    if ValidNumString(Cell) then begin
      R := StrToFloat(Cell);
      if (R < M) and (r >= 0) then
        Exit;
      Inf := stRange;
    end else
      Inf := stErr;
    Result := False;
    if InputQuery(Inf, stPromt + FName + '; N=' + IntToStr(AnNum), Cell) then begin
      Sell.Cells.Item[X, Y] := Cell;
      Exit;
    end else
      Close;
  end else begin

  end;

end;

procedure TWizForm.BitBtn7Click(Sender: TObject);
begin
  DM1.TabEdBook.Insert;
  ESourceN.SetFocus;
  ESourceN.ReadOnly := false;
  ESourceA.ReadOnly := false;
  DBEdit4.ReadOnly := false;
  DBEdit5.ReadOnly := false;
end;

procedure TWizForm.TabEdBookAfterCancel(DataSet: TDataSet);
begin
  ESourceN.ReadOnly := true;
  ESourceA.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
end;

procedure TWizForm.TabEdBookBeforePost(DataSet: TDataSet);
begin
  if (DataSet.State = dsInsert) and (DM1.TabSource.FindKey([DataSet['Num']]))
    then begin
    ShowMessage('Этот номер источника уже есть в базе');
    ValidData := false;
    ESourceN.SetFocus;
    Abort;
  end;
  ESourceN.ReadOnly := true;
  ESourceA.ReadOnly := true;
  DBEdit4.ReadOnly := true;
  DBEdit5.ReadOnly := true;
end;

procedure TWizForm.Wizard1EnteringPage(Sender: TObject;
  CurrentPage: Integer; Direction: TWizardDirection);
var s:string;
begin
  if CurrentPage = 4 then begin
    S := Ename.Text;
    EName.SetFocus;
    EName.Text := s;
  end;
end;

end.

