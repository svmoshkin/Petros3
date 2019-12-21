unit ImpWiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, wizards, Buttons, StdCtrls, OleServer, Excel97, FormEx, Boxes,
  Mend_C, StrHlder, Chemist, Db, ADODb, EsbRtns, Analise, Clipbrd,
  CheckLst, DBCtrls, Mask, strUtils, RHAGlobs, ComCtrls, Grids, DBGrids,
  Excel2000, Variants, ADOUtilsS, NumInp, ExcelXP;

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
    BitBtn2: TBitBtn;
    Image1: TImage;
    Label2: TLabel;
    StaticText3: TStaticText;
    GroupBox1: TGroupBox;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    ExcApp: TExcelApplication;
    GroupBox2: TGroupBox;
    ExcList: TListBox;
    CList: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn3: TBitBtn;
    Panel3: TPanel;
    MendTabl1: TMendTabl;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StaticText4: TStaticText;
    PetrList: TListBox;
    Button3: TButton;
    StaticText5: TStaticText;
    GroupBox3: TGroupBox;
    CheckListBox1: TCheckListBox;
    BitBtn6: TBitBtn;
    BitBtn8: TBitBtn;
    Label5: TLabel;
    EName: TDBEdit;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    AnType: TDBRadioGroup;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ESourceN: TDBEdit;
    ESourceA: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBNavigator11: TDBNavigator;
    BitBtn7: TBitBtn;
    BitBtn9: TBitBtn;
    PB1: TProgressBar;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label11: TLabel;
    ListBox1: TListBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    ListBox3: TListBox;
    StaticText6: TStaticText;
    BitBtn10: TBitBtn;
    DBGrid1: TDBGrid;
    SpeedButton5: TSpeedButton;
    BitBtn11: TBitBtn;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    Label12: TLabel;
    Panel4: TPanel;
    Label13: TLabel;
    PB2: TProgressBar;
    DBEdit2: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    NumInp1: TNumInp;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    eNumSearch: TEdit;
    EAuthSearch: TEdit;
    CheckBox3: TCheckBox;
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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure eNumSearchChange(Sender: TObject);
  private
    { Private declarations }
    BegCel: integer;
    CurSource: TDataSource;
    CurExcCol: integer;
    CurField: integer;
    Id: integer;
    procedure MakeDict;
    procedure MapField(FName: string; Num: Integer; Adr: string);
    function ValidateCell(X, Y: integer; FieldId: integer; PPM: Boolean;
      FName: string; AnNum: integer): Boolean;
  public
    { Public declarations }
    WasPost: Boolean;
    LCID: integer;
    Alfa: integer;
  end;

var
  WizForm: TWizForm;


resourcestring
  stErr = 'Error in the number cell';
  stRange = 'Value out of range for this field';
  stPromt = 'Input valid value of field ';
  stSelTable = 'Select table!';
  stLength = 'Length of line > field size(';
  stInteger = 'Error in the integer number cell';
  stNotEnablMulti = 'Only field "Description" enable to accept data from more then one source field';
  stCut = 'Line will be reduced to "';
  stExcErr = 'EXCEL connection error';


var
  CurIdents: TStringList;
  NewIdents: TStringList;



implementation

uses Main, DMod1, wait, ImpLookUps;

{$R *.DFM}

var FRow, ERow, FCol, ECol: integer;
  FieldsCount, AnalCount, DescCount: integer;
  Sell: ExcelRange;
  ValidData: Boolean;
  TitStr: string;
  DescFields: array[1..16] of integer;

procedure TWizForm.BitBtn1Click(Sender: TObject);
begin
  if Wizard1.ActivePage = '5' then begin
    DM1.TabEdBook.Cancel;
    DM1.TabM1.Cancel;
  end;
  ValidData := true;
  Close;
end;

procedure TWizForm.Wizard1ButtonFinishClick(Sender: TObject);
var i, j, k, l, k1, Comp, Beg, X, Y, F: integer;
  S, S1: string;
  R: Double;
  WasExcept: Boolean;
begin

  S := Trim(EName.Text);
  if s = '' then begin
    EName.SetFocus;
    ValidData := false;
    ShowMessage(stNoArrayName);
    exit;
  end;
  S := Trim(ESourceN.Text);
  if s = '' then begin
    ESourceN.SetFocus;
    ValidData := false;
    ShowMessage(stNoSourceNumber);
    exit;
  end;
  S := Trim(ESourceA.Text);
  if s = '' then begin
    ESourceA.SetFocus;
    ValidData := false;
    ShowMessage(stNoAuthor);
    exit;
  end;
  S := Trim(DbEdit4.Text);
  if s = '' then begin
    DbEdit4.SetFocus;
    ValidData := false;
    ShowMessage(stNoSourceTitle);
    exit;
  end;
  S := Trim(DbEdit5.Text);
  if s = '' then begin
    DbEdit5.SetFocus;
    ValidData := false;
    ShowMessage(stNoBibliography);
    exit;
  end;
  S := Trim(TitStr);

  if S[Length(s)] = ',' then
    System.delete(s, Length(s), 1);
  DM1.TabM1['Title1'] := S;
  Titles.Add(S);

  if DM1.TabEdBook.State <> dsBrowse then
    DM1.TabEdBook.Post;
  i := DM1.TabEdBook['Id'];
  DM1.TabM1['Source'] := DM1.TabEdBook['Id'];
  DM1.TabM1['NComp'] := AnalisTitle.Count;
  if Alfa > 0 then
    DM1.TabM1['Type'] := 'nc';
  DM1.TabM1['Alfa'] := Alfa;
  DM1.TabM1.Post;
  WasPost := True;

  OpenQr('Select * From RHADATA where ArrID=' + IntToStr(DM1.TabM1['Id']), DM1.TabD1);
  Screen.Cursor := crHourGlass;
  {WForm.Show;}
  Panel4.Visible := True;

  DeletedAn := 0;
  K := 1;
  PB2.Position := 0;
  Application.ProcessMessages;
  try
    if CheckBox1.Checked then
      Beg := 1
    else
      Beg := 0;
    Comp := -1;
    for j := 1 to AnalCount do begin
      PB2.Position := round(j / AnalCount * 100);
      Application.ProcessMessages;
      try
        Comp := 0;
        F := 0;
        WasExcept := False;
        DM1.TabD1.Insert;
        {DM1.TabD1['Num'] := k;}
        inc(K);
        for i := 1 to Clist.Items.Count do begin
          DM1.ImpFields.Locate('ID', TCorr(Clist.Items.Objects[i - 1]).ID, []);
          if TCorr(Clist.Items.Objects[i - 1]).N > 0 then begin
            if RadioGroup1.ItemIndex = 0 then begin
              X := j + beg;
              Y := TCorr(Clist.Items.Objects[i - 1]).N;
            end else begin
              X := TCorr(Clist.Items.Objects[i - 1]).N;
              Y := j + beg;
            end;
            S := Sell.Cells.Item[X, Y];
            if (TCorr(Clist.Items.Objects[i - 1]).Id < 0) then begin
              if (S <> '') then begin
                Inc(Comp);
                R := StrToFloat(S);
                if CheckListBox1.Checked[F] then
                  R := R / 10000;
                DM1.TabD1['N' + IntToStr(F + 1)] := R;
              end;
              Inc(F);
            end else begin
              if DM1.ImpFields['FName'] = 'LGid' then
                DM1.TabD1['GeolId'] := Dm1.GeolIds.Lookup('GeolId', S, 'ID')
              else
                if DM1.ImpFields['FName'] = 'LRoc' then
                  DM1.TabD1['Rock'] := Dm1.Rocks.Lookup('Rock', S, 'ID')
                else
                  if DM1.ImpFields['FName'] = 'LReg' then
                    DM1.TabD1['Region'] := Dm1.Regions.Lookup('Region', S, 'ID')
                  else
                    if DM1.ImpFields['FName'] = 'LGBod' then
                      DM1.TabD1['GBody'] := Dm1.GBodies.Lookup('GBody', S, 'ID')
                    else
                      DM1.TabD1[DM1.ImpFields['FName']] := S;
            end;
          end else begin
            S := '';
            for l := 1 to DescCount do begin
              if RadioGroup1.ItemIndex = 0 then begin
                X := j + beg;
                Y := DescFields[l];
              end else begin
                X := DescFields[l];
                Y := j + beg;
              end;
              S1 := Sell.Cells.Item[X, Y];
              S := S + S1 + ' ';
            end;
            Delete(S, Length(S), 1);

            if DM1.ImpFields.Locate('ID', TCorr(Clist.Items.Objects[i - 1]).Id, []) then begin
              k1 := DM1.ImpFields['Size'];

              if (K1 > 0) and (Length(S) > k1) then
                S := Copy(S, 1, k1);
            end;
            DM1.TabD1[DM1.ImpFields['FName']] := S;
          end;
        end;
        DM1.TabD1['Alfa'] := Alfa;
       { if (Comp <= MinCompCount) then begin
        ShowMessage(stAnNum + IntToStr(j) + stNotEnComp + IntToStr(MinCompCount)
          + ')' + stWillNotInsert);
        DM1.TabD1.Cancel;
        Inc(DeletedAn);
      end else }
        DM1.TabD1.Post;
      except
        on E: Exception do begin
          inc(DeletedAn);
          DM1.TabD1.Cancel;
          if not (E is EAbort) then
            ShowMessage(stErrorInData + stAnNum + intToStr(k) + '  -   ' + E.Message);
          WasExcept := True;
        end;
      end;

     // if (not WasExcept)and
    end;
    ChangedTitle := True;
    ModalResult := mrOK;
    CheckListBox1.Clear;
    DM1.TabD1.Active := False;
  {Close;}
  finally
    Screen.Cursor := crDefault;
    Panel4.Visible := false;
  end;
end;

procedure TWizForm.BitBtn2Click(Sender: TObject);
var ok: Boolean;
begin
  try
    ExcApp.Visible[LCID] := True;
    ok := ExcApp.Dialogs[xlDialogOpen].Show(EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam);
  {ExcApp.Visible[0] := True;}
    { Application.Dialogs(xlDialogOpen).Show}
    MainForm.Hide;
    Application.BringToFront;
  except
    on Exception do begin
      ShowMessage(stExcErr);
      ValidData := True;
      Close;
    end;
  end;
end;

procedure TWizForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  CurHelpContext := HelpContext;
  ENumSearch.Text := '';
  EAuthSearch.Text := '';
  try
    ExcApp.Connect;
    ExcApp.Visible[LCID] := True;
    BookEdits := Self;
    WasPost := False;

    DM1.ImpFields.Open;
    DM1.Sinonims.Open;
    DM1.Diction.Open;
    ValidData := true;
    Application.ProcessMessages;
    Wizard1.PageIndex := 0;
    Wizard1.AdjustButtonCaptions;
    MainForm.Hide;
    CheckListBox1.Clear;
    Application.BringToFront;
    Self.Repaint;
    Button2.Enabled := True;
  except
    on Exception do begin
      ShowMessage(stExcErr);
      ValidData := True;
      Close
    end;
  end;
end;

procedure TWizForm.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
begin
  MainForm.Visible := true;
  DM1.Diction.Close;
  DM1.Sinonims.Close;
  DM1.ImpFields.Close;

  for i := 0 to ListBox1.Items.Count - 1 do
    ListBox1.Items.Objects[i].Free;
  for i := 0 to ListBox3.Items.Count - 1 do
    ListBox3.Items.Objects[i].Free;
  ListBox1.Items.Clear;
  ListBox3.Items.Clear;
  if Assigned(CurIdents) then
    for i := 0 to CurIdents.Count - 1 do
      CurIdents.Objects[i].Free;
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
  S: string;
  Sl: ExcelRange;
  Err : Boolean;
begin
  try
    if CurrentPage = 1 then begin
      Alfa := Round(NumInp1.Value);
      MendTab.AlfaN := Alfa;
      if Alfa > 0 then
        AnType.ItemIndex := 2;
      Sl := ExcelRange(ExcApp.Selection[0]);
      Sell := ExcApp.Range[Sl.Cells.Item[1, 1], Sl.Cells.Item[Sl.Rows.Count, Sl.Columns.Count]];
      ERow := Sell.Rows.Count;
      ECol := Sell.Columns.Count;
      if ECol * ERow < 10 then begin
        ShowMessage(stSelTable);
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
      BegCel := 0;
      AllowMove := True;
      Button2.Enabled := False;
      MakeDict;
    end

    else if CurrentPage = 3 then begin
      TitStr := '';
      for i := 0 to CList.Items.Count - 1 do
        if TCorr(CList.Items.Objects[I]).Id < 0 then begin
          S := CList.Items[i];
          TitStr := TitStr + Copy(S, Pos(' -> ', S) + 4, Length(S)) + ',';
        end;
         {Titles.Add(S);
             DM1.TabM1['Title1']:=S;
          end; }
      if Trim(TitStr) = '' then begin
        AllowMove := False;
        ShowMessage(stNoCompList);
        exit;
      end;
      AnalisTitle.Free;
      AnalisTitle := TAnalisTitle.Create(TitStr, AnType.ItemIndex = 2);
      Err:=False;
      for i:=0 to AnalisTitle.Count-1 do
        if TFormula(AnalisTitle[i]).nhNumber<0 then begin
          ShowMessage(TFormula(AnalisTitle[i]).Symbol+ ' is not valid component for this alphabet');
          Err:=True;

        end;
      if Err then Exit;
      if AnalisTitle.Count < MinCompCount then begin
        ShowMessage(stNotEnComp + IntToStr(MinCompCount) + ')');
        AllowMove := False;
        Exit;
      end else if AnalisTitle.Count >= MaxCompCount then begin
        ShowMessage(stTooMany + IntToStr(AnalisTitle.Count) + ')');
        AllowMove := False;
        Exit;
      end;

      {TitleCombo.Items.Add(TitStr);
      Titles.Add(TitStr);
       i:=Table2['Id'];
       DM1.TabM1['Source']:=Table2['Id'];
       DM1.TabM1['NComp']:=AnalisTitle.Count;
       DM1.TabM1.Post;
       if Table2.State <>dsBrowse  then
            Table2.Post;   }
      CheckListBox1.Clear;
      for i := 0 to AnalisTitle.Count - 1 do begin
        CheckListBox1.Items.Add(TFormula(AnalisTitle[I]).Symbol);
        if (Alfa = 0) and (Length(TFormula(AnalisTitle[I]).Symbol) < 3) and
          (TFormula(AnalisTitle[I]).Symbol <> 'F') and (TFormula(AnalisTitle[I]).Symbol <> 'Cl')
          and (TFormula(AnalisTitle[I]).Symbol <> 'S') then
          CheckListBox1.Checked[i] := true;
      end;
      Button2.Enabled := False;
      PB1.Position := 0;
           {GroupBox2.Enabled:=true;
           GroupBox2.Visible:=true;}
          { BitBtn1.Enabled:=false;
           BitBtn2.Enabled:=false;}
    end
    else if CurrentPage = 4 then begin
      DM1.TabM1.Insert;
        {ChangedTitle:=false; !!!!!!!!!!}
      DM1.TabEdBook.Last;
      DM1.TabEdBook.Edit;
    end;
  except
    on E:Exception do begin
      ShowMessage(stExcErr+': '+E.Message);
      ValidData := True;
      Close;
    end;
  end;
end;

procedure TWizForm.MapField(FName: string; Num: Integer; Adr: string);
var i,k: integer;
  FFName: string;
label Ex;
begin
  if FName <> '' then begin
    FFName := Trim(FName);
    //StripChStr(FName, ' ');
    if FFName = 'Fe++' then
      CList.Items.AddObject(FFName + ' -> ' + 'Fe†', TCorr.Create(Num, -1))
    else
      if FFName = 'Fe+++' then
        CList.Items.AddObject(FFName + ' -> ' + 'Fe‡', TCorr.Create(Num, -1))
      else
        if ValidFormula(FFName, Alfa > 0) = 0 then
          CList.Items.AddObject(FFName + ' -> ' + FFName, TCorr.Create(Num, -1))
        else begin
          if OpenQr('select FieldID from Sinonims where Text=''' + FFName + ''' and FieldId in (select ID from ImpFields)', DM1.q1Time) then begin
             k:=DM1.q1Time['FieldID'];
             OpenQr('Select * from ImpFields where ID='+IntToStr(k),Dm1.q1Time);
             i:=PetrList.Items.IndexOf(Dm1.q1Time['Dname']);
             if i>=0 then begin
                CList.Items.AddObject(FFName + ' -> ' + DM1.q1Time['DName'],
                  TCorr.Create(Num, Tint(PetrList.Items.Objects[i]).N));
                PetrList.Items.Objects[i].Free;
                PetrList.Items.Delete(i);
             end else
                ExcList.Items.AddObject(FFName, TInt.Create(Num));
          end else
              ExcList.Items.AddObject(FFName, TInt.Create(Num));
          {for i := 0 to PetrList.Items.Count - 1 do begin
            DM1.ImpFields.Locate('ID', TInt(PetrList.Items.Objects[i]).N, []);
            DM1.Sinonims.First;
            while not DM1.Sinonims.Eof do begin
              if UpperCase(DM1.Sinonims['Text']) = UpperCase(FFName) then begin
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
        Ex: }end;
  end else
    ExcList.Items.AddObject(Adr, TInt.Create(Num));
end;


procedure TWizForm.BitBtn10Click(Sender: TObject);
var i, beg, X, Y: integer;
  S, S1: string;
begin
  if CheckBox1.Checked then
    Beg := 1
  else
    Beg := 0;
  try
    Screen.Cursor := crHourGlass;
    WForm.Show;
    for i := 0 to CurIdents.Count - 1 do
      CurIdents.Objects[i].Free;
    NewIdents.Clear;
    Application.ProcessMessages;
    for i := 0 to ListBox3.Items.Count - 1 do begin
      S := ListBox3.Items[i];
      S := Copy(S, Pos(' -> ', S) + 4, Length(S));
      NewIdents.Add(S);
      CurIdents.Objects[TCorr(ListBox3.Items.Objects[i]).N] := TInt.Create(i);
    end;
    for i := 1 to AnalCount do begin
      if RadioGroup1.ItemIndex = 0 then begin
        X := i + beg;
        Y := CurExcCol;
      end else begin
        X := CurExcCol;
        Y := i + beg;
      end;
      S := StripChStr(Sell.Cells.Item[X, Y], ' ');
      if (S <> '') then begin
        S1 := NewIdents[TInt(CurIdents.Objects[CurIdents.IndexOf(S)]).N];
        if S <> S1 then
          Sell.Cells.Item[X, Y] := S1;
      end else
        Sell.Cells.Item[X, Y] := '?';
    end;
    MakeDict;
  finally
    Screen.Cursor := crDefault;
    Wform.Close;
  end;
end;

procedure TWizForm.SpeedButton1Click(Sender: TObject);
var i, k: integer;
  S: string;
begin
  SpeedButton1.Enabled := false;
  if ExcList.SelCount > 1 then begin
    if PetrList.Items[PetrList.ItemIndex] <> 'Description' then begin
      ShowMessage(stNotEnablMulti);
      Exit;
    end else begin
      DescCount := ExcList.SelCount;
      k := 1;
      S := '';
      for i := 0 to ExcList.Items.Count - 1 do
        if ExcList.Selected[i] then begin
          DescFields[k] := Tint(ExcList.Items.Objects[i]).N;
          Inc(k);
          if S <> '' then S := S + ',';
          s := S + ExcList.Items[i];
        end;
      for i := ExcList.Items.Count - 1 downto 0 do
        if ExcList.Selected[i] then begin
          ExcList.Items.Objects[i].Free;
          ExcList.Items.Delete(i);
        end;

      CList.Items.Add(S + ' -> ' + PetrList.Items[PetrList.ItemIndex]);
      CList.Items.Objects[CList.Items.Count - 1] :=
        TCorr.Create(-1, Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N);
    end
  end else begin
    CList.Items.Add(ExcList.Items[ExcList.ItemIndex] + ' -> ' + PetrList.Items[PetrList.ItemIndex]);
    CList.Items.Objects[CList.Items.Count - 1] :=
      TCorr.Create(Tint(ExcList.Items.Objects[ExcList.ItemIndex]).N, Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N);
    if (Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N > 0) then begin
      DM1.ImpFields.Locate('ID', Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N, []);
      if not DM1.Sinonims.Locate('FieldID;Text',
        VarArrayof([Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N,
        ExcList.Items[ExcList.ItemIndex]]), []) then begin
       // ShowMessage('Locate OK');
        K := Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N;
        S := Trim(ExcList.Items[ExcList.ItemIndex]);
        ExecQr('Insert into Sinonims (FieldID,Text) Values(' + IntToStr(K) + ',''' + S + ''')', DM1.q1Time);
       // ShowMessage('Insert OK');
       { DM1.Sinonims.Insert;
        DM1.Sinonims['FieldId'] := Tint(PetrList.Items.Objects[PetrList.ItemIndex]).N;
        DM1.Sinonims['Text'] := ExcList.Items[ExcList.ItemIndex];
        DM1.Sinonims.Post; }
        DM1.Sinonims.Refresh;
       // ShowMessage('Refresh Ok');
      end;
    end;
    ExcList.Items.Objects[ExcList.ItemIndex].Free;
    ExcList.Items.Delete(ExcList.ItemIndex);
  end;
  ExcList.ItemIndex := -1;

  PetrList.Items.Objects[PetrList.ItemIndex].Free;
  PetrList.Items.Delete(PetrList.ItemIndex);
  PetrList.ItemIndex := -1;

end;

procedure TWizForm.ExcListClick(Sender: TObject);
begin
  if (ExcList.ItemIndex >= 0) and (PetrList.ItemIndex >= 0) then
    SpeedButton1.Enabled := true
  else
    SpeedButton1.Enabled := False;
end;

procedure TWizForm.CListClick(Sender: TObject);
begin
  if Clist.ItemIndex >= 0 then
    SpeedButton2.Enabled := true;
end;

procedure TWizForm.SpeedButton2Click(Sender: TObject);
var S: string;
  i, p: Integer;
begin
  SpeedButton2.Enabled := False;
  S := Clist.Items[CList.ItemIndex];
  if TCorr(Clist.Items.Objects[CList.ItemIndex]).Id > 0 then begin
    PetrList.Items.Add(Copy(S, Pos(' -> ', S) + 4, Length(S)));
    PetrList.Items.Objects[PetrList.Items.Count - 1] :=
      TInt.Create(TCorr(Clist.Items.Objects[CList.ItemIndex]).ID);
  end;
  if TCorr(Clist.Items.Objects[CList.ItemIndex]).N < 0 then begin
    S := Copy(S, 1, Pos(' -> ', S) - 1);
    i := 1;
    repeat
      p := Pos(',', S);
      if p > 0 then begin
        ExcList.Items.Add(Copy(S, 1, p));
        Delete(S, 1, p);
        ExcList.Items.Objects[ExcList.Items.Count - 1] :=
          TInt.Create(DescFields[i]);
        Inc(i);
      end;
    until p <= 0;
    ExcList.Items.Add(S);
    ExcList.Items.Objects[ExcList.Items.Count - 1] := TInt.Create(DescFields[i]);
  end else begin
    ExcList.Items.AddObject(Copy(S, 1, Pos(' -> ', S) - 1),
      TInt.Create(TCorr(Clist.Items.Objects[CList.ItemIndex]).N));
    if TCorr(Clist.Items.Objects[CList.ItemIndex]).Id > 0 then begin
      DM1.ImpFields.Locate('ID', TCorr(Clist.Items.Objects[CList.ItemIndex]).Id, []);
      DM1.Sinonims.First;
      while not DM1.Sinonims.Eof do begin
        if DM1.Sinonims['Text'] = ExcList.Items[ExcList.Items.Count - 1] then begin
          DM1.Sinonims.Delete;
          break;
        end;
        DM1.Sinonims.Next;
      end;

    end;
    {ExcList.Items.Objects[ExcList.Items.Count - 1] :=
      TInt.Create(TCorr(Clist.Items.Objects[CList.ItemIndex]).N);}
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
var i, j, k, l, Beg, Comp, X, Y: integer;
  S, S1: string;
  PPM: boolean;
begin
  try
    Screen.Cursor := crHourGlass;
    if CheckBox1.Checked then
      Beg := 1
    else
      Beg := 0;
    Comp := -1;
    ppm := false;
    for i := 1 to CList.Items.Count do begin
      if TCorr(Clist.Items.Objects[i - 1]).N > 0 then begin
        if TCorr(Clist.Items.Objects[i - 1]).Id < 0 then begin
          Inc(Comp);
          Ppm := CheckListBox1.Checked[Comp];
        end;
        S := Clist.Items[I - 1];
        s := Copy(S, 1, Pos(' -> ', S) - 1);
        for j := 1 to AnalCount do begin
          if RadioGroup1.ItemIndex = 0 then begin
            X := j + beg;
            Y := TCorr(Clist.Items.Objects[i - 1]).N;
          end else begin
            X := TCorr(Clist.Items.Objects[i - 1]).N;
            Y := j + beg;
          end;
          try
            repeat
              Application.ProcessMessages;
            until ValidateCell(X, Y, TCorr(Clist.Items.Objects[i - 1]).Id,
              ppm, S, j);
          except
            on EAbort do begin
              ValidData := True;
              Close;
              Exit;
            end;
          end;
        end;
      end else
        for j := 1 to AnalCount do begin
          S := '';
          for l := 1 to DescCount do begin
            if RadioGroup1.ItemIndex = 0 then begin
              X := j + beg;
              Y := DescFields[l];
            end else begin
              X := DescFields[l];
              Y := j + beg;
            end;
            S1 := Sell.Cells.Item[X, Y];
            S := S + S1 + ' ';
          end;
          Delete(S, Length(S), 1);

          DM1.ImpFields.Locate('ID', TCorr(Clist.Items.Objects[i - 1]).Id, []);
          k := DM1.ImpFields['Size'];

          if Length(S) > k then begin
            S := Copy(S, 1, k);
            ShowMessage(stLength + IntToStr(k) + ') :'
              + DM1.ImpFields['DName'] + '; N=' + IntToStr(j) + '. ' + stCut + S);
          end;
        end;
      PB1.Position := Trunc(i * 50 / CList.Items.Count);
    end;
    for j := 1 to AnalCount do begin
      Comp := 0;
      for i := 1 to CList.Items.Count do
        if TCorr(Clist.Items.Objects[i - 1]).N > 0 then begin
          if RadioGroup1.ItemIndex = 0 then begin
            X := j + beg;
            Y := TCorr(Clist.Items.Objects[i - 1]).N;
          end else begin
            X := TCorr(Clist.Items.Objects[i - 1]).N;
            Y := j + beg;
          end;
          S := Sell.Cells.Item[X, Y];
          if (TCorr(Clist.Items.Objects[i - 1]).Id < 0) and (S <> '') then
            Inc(Comp);
        end;
      if Comp < MinCompCount then begin
        ShowMessage(stAnNum + IntToStr(j) + ': ' + stNotEnComp + IntToStr(MinCompCount)
          + ')' + stWillNotInsert);
      end;
      PB1.Position := Trunc(j * 50 / AnalCount) + 50;
    end;
    Button2.Enabled := true;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TWizForm.ValidateCell(X, Y: integer; FieldId: integer; PPM: Boolean;
  FName: string; AnNum: integer): Boolean;
var R, M: extended;
  Inf, Cell: string;
  S, IR: integer;
  function ValidDesc(DS: TADOTable; FldName: string; Dsr: TDataSource): Boolean;
  begin
    Result := True;
    If length(Cell)>80 then begin
       ShowMessage('Length of descriptors must be less or equal to 80 symbols - '+Cell);
       Result:=False;
       Abort;
    end;
    if (StripChStr(Cell, ' ') = '') then  begin
        Cell := '?';
         Sell.Cells.Item[X, Y] := Cell;
    end;
    if (DS.Lookup(FldName, Cell, 'ID') = Null) then begin
     if CheckBox3.Checked then begin
       DS.Insert;
       DS.FieldByName(FldName).Value:=Cell;
       DS.Post;
       Exit;
     end else begin
      Result := False;
      ImpLookUpForm.Tabl := DS;
      ImpLookUpForm.Field := TStringField(DS.Fields.FieldByName(FldName));
      ImpLookUpForm.DBGrid1.DataSource := DSr;
        ImpLookUpForm.Edit1.Text := Cell;
      if ImpLookUpForm.ShowModal = mrOK then begin
        Sell.Cells.Item[X, Y] := ImpLookUpForm.Edit1.Text;
        Result:=True;
      end else
        Abort;
      end;
    end;
  end;
begin
  result := true;
  Cell := Sell.Cells.Item[X, Y];
  if (Cell = '') and ((FieldId <= 6) or (FieldId >= 9)) then
    Exit;
  {begin
    Cell := '0';
    Sell.Cells.Item[X, Y] := Cell;
  end; }
  if FieldId < 0 then begin
    if PPM then
      M := 1000000
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
      Abort;
  end else begin
    DM1.ImpFields.Locate('ID', FieldId, []);
    S := DM1.ImpFields['Size'];
    if S = 0 then begin
      if not ValidIntString(Cell) then begin
        Result := False;
        if InputQuery(stInteger, stPromt + FName + '; N=' + IntToStr(AnNum), Cell) then begin
          Sell.Cells.Item[X, Y] := Cell;
          Exit;
        end else
          Abort;
      end;

    end else begin
      if DM1.ImpFields['FName'] = 'Sample' then
        if (Cell <> '') and OpenQr('Select * from RHADATA where Sample=''' +
          Cell + '''', DM1.q1Time) then begin
          Result := False;
          if CheckBox2.Checked then begin
            Sell.Cells.Item[X, Y] := Cell + Edit1.Text;
            Exit;
          end else
            if InputQuery(stError, stDoubleID + stPromt, Cell) then begin
              Sell.Cells.Item[X, Y] := Cell;
              Exit;
            end else
              Abort;
        end;
      if DM1.ImpFields['FName'] = 'LGid' then begin
        Result := ValidDesc(DM1.GeolIds, 'Geolid', DM1.DSGId);
        if not Result then Exit;
      end else
        if DM1.ImpFields['FName'] = 'LRoc' then begin
          Result := ValidDesc(DM1.Rocks, 'Rock', DM1.DSRoc);
          if not Result then Exit;
        end else
          if DM1.ImpFields['FName'] = 'LReg' then begin
            Result := ValidDesc(DM1.Regions, 'Region', DM1.DSReg);
            if not Result then Exit;
          end else
            if DM1.ImpFields['FName'] = 'LGBod' then begin
              Result := ValidDesc(DM1.GBodies, 'GBody', DM1.DSGBod);
              if not Result then Exit;
            end;
      if Length(Cell) > S then begin
        Result := False;
        if InputQuery(stLength + IntToStr(S) + ')',
          stPromt + FName + '; N=' + IntToStr(AnNum), Cell) then begin
          Sell.Cells.Item[X, Y] := Cell;
          Exit;
        end else
          Abort;
      end;
    end;
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
  if (DataSet.State = dsInsert) and OpenQr('Select * from Source where Num=' +
    InttoStr(DataSet['Num']), DM1.q1Time) then begin
    ShowMessage(stDoubleSourceNumber);
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
var s: string;
begin
  if CurrentPage = 5 then begin
    S := Ename.Text;
    EName.SetFocus;
    EName.Text := s;
    if Alfa > 0 then
      AnType.DataSource.DataSet['Type'] := 'nc';
  end
end;

procedure TWizForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := ValidData;
end;

procedure TWizForm.FormCreate(Sender: TObject);
begin
  LCID := 0 {getuserdefaultlcid};
  CurIdents := TStringList.Create;
  NewIdents := TStringList.Create;
end;

procedure TWizForm.MakeDict;
var i, Beg: integer;
  procedure FillDict;
  var j, X, Y, k: integer;
    S: string;
    Tab: TADOTable;
    Found: Boolean;
  begin
    GroupBox5.Caption := DM1.ImpFields['DName'];
    DBGrid1.DataSource := CurSource;
    Tab := TADOTable(CurSource.DataSet);
    for j := 0 to ListBox1.Items.Count - 1 do
      ListBox1.Items.Objects[j].Free;
    for j := 0 to ListBox3.Items.Count - 1 do
      ListBox3.Items.Objects[j].Free;
    ListBox1.Clear;
    ListBox3.Clear;
    CurIdents.Clear;
    for j := 1 to AnalCount do begin
      if RadioGroup1.ItemIndex = 0 then begin
        X := j + beg;
        Y := CurExcCol;
      end else begin
        X := CurExcCol;
        Y := j + beg;
      end;
      S := StripChStr(Sell.Cells.Item[X, Y], ' ');
      if (S <> '') and (ListBox1.Items.IndexOf(S) < 0) then begin
        ListBox1.Items.Add(S);
        CurIdents.Add(S);
        ListBox1.Items.Objects[ListBox1.Items.Count - 1] :=
          TInt.Create(ListBox1.Items.Count - 1);
      end;
    end;
    k := 0;
    for j := 0 to ListBox1.Items.Count - 1 do begin
      try
        Tab.DisableControls;
        Tab.First;
        Found := False;
        while not Tab.Eof and not Found do begin
          if (Tab.Fields[1].Value = ListBox1.Items[k]) or
            DM1.Diction.Locate('FieldId;Desc;Word',
            VarArrayOf([CurField, Tab['Id'], ListBox1.Items[k]]), [])
            then begin
            Found := True;
            S := ListBox1.Items[k] + ' -> ' + Tab.Fields[1].Value;
            ListBox3.Items.Add(S);
            ListBox3.Items.Objects[ListBox3.Items.Count - 1] :=
              TCorr.Create(TInt(ListBox1.Items.Objects[k]).N, Tab['ID']);
            ListBox1.Items.Objects[k].Free;
            ListBox1.Items.Delete(k);
          end;
          Tab.Next;
        end;
        if not found then
          inc(k);
      finally
        Tab.EnableControls;
        Tab.First;
      end;
    end;
    ListBox1.ItemIndex := -1;
    if ListBox1.Items.Count > 0 then
      BitBtn10.Enabled := False
    else
      BitBtn10.Enabled := True;
    SpeedButton4.Enabled := False;
    SpeedButton5.Enabled := False;
    SpeedButton3.Enabled := False;
  end;

begin
  if CheckBox1.Checked then
    Beg := 1
  else
    Beg := 0;
  try
    Screen.Cursor := crHourGlass;

    for i := BegCel to CList.Items.Count - 1 do
      if TCorr(Clist.Items.Objects[i]).N > 0 then
        if TCorr(Clist.Items.Objects[i]).Id in [6, 7, 8, 9] then begin
          DM1.ImpFields.Locate('ID', TCorr(Clist.Items.Objects[i]).Id, []);
          CurField := DM1.ImpFields['Id'];
          CurExcCol := TCorr(Clist.Items.Objects[i]).N;
          if DM1.ImpFields['FName'] = 'LGid' then begin
            CurSource := DM1.DSGId;
            FillDict;
            BegCel := i + 1;
            Exit;
          end;
          if DM1.ImpFields['FName'] = 'LRoc' then begin
            CurSource := DM1.DSRoc;
            FillDict;
            BegCel := i + 1;
            Exit;
          end;
          if DM1.ImpFields['FName'] = 'LReg' then begin
            CurSource := DM1.DSReg;
            FillDict;
            BegCel := i + 1;
            Exit;
          end;
          if DM1.ImpFields['FName'] = 'LGBod' then begin
            CurSource := DM1.DSGBod;
            FillDict;
            BegCel := i + 1;
            Exit;
          end;
        end;
    BitBtn10.Enabled := False;
    Button2.Enabled := true;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TWizForm.SpeedButton5Click(Sender: TObject);
var Tab: TADOTable;
  S: string;
begin
  if ListBox1.ItemIndex >= 0 then begin
    Tab := TADOTable(CurSource.DataSet);
    Tab.Insert;
    S := Copy(ListBox1.Items[ListBox1.ItemIndex], 1, 20);
    Tab.Fields[1].Value := S;
    try
      Tab.Post;
      BitBtn11.Enabled := True;
      Id := Tab['ID'];
      S := ListBox1.Items[ListBox1.ItemIndex] + ' -> ' + Tab.Fields[1].Value;
      ListBox3.Items.Add(S);
      ListBox3.Items.Objects[ListBox3.Items.Count - 1] :=
        TCorr.Create(TInt(ListBox1.Items.Objects[ListBox1.ItemIndex]).N, Tab['ID']);
      ListBox1.Items.Objects[ListBox1.ItemIndex].Free;
      ListBox1.Items.Delete(ListBox1.ItemIndex);
      ListBox1.ItemIndex := -1;
      if ListBox1.Items.Count = 0 then
        BitBtn10.Enabled := True;
    except
      on Exception do begin
        ShowMessage(stDoubleVal);
        Tab.Cancel;
      end;
    end;
  end;
end;

procedure TWizForm.BitBtn11Click(Sender: TObject);
var Tab: TADOTable;
  i: integer;
begin
  for i := 0 to ListBox3.Items.Count - 1 do
    if TCorr(ListBox3.Items.Objects[i]).Id = ID then begin
      ListBox3.ItemIndex := i;
      SpeedButton3Click(Sender);
      break;
    end;
  Tab := TADOTable(CurSource.DataSet);
  Tab.Locate('ID', ID, []);
  Tab.Delete;
  BitBtn11.Enabled := False;
end;

procedure TWizForm.SpeedButton4Click(Sender: TObject);
var k: integer;
  S: string;
  Tab: TADOTable;
begin
  k := ListBox1.ItemIndex;
  Tab := TADOTable(CurSource.DataSet);
  if k >= 0 then begin
    S := ListBox1.Items[k] + ' -> ' + Tab.Fields[1].Value;
    ListBox3.Items.Add(S);
    ListBox3.Items.Objects[ListBox3.Items.Count - 1] :=
      TCorr.Create(TInt(ListBox1.Items.Objects[k]).N, Tab['ID']);
    if not Tab.Locate(Tab.Fields[1].FieldName, VarArrayOf([ListBox1.Items[k]]), []) then begin
      DM1.Diction.Insert;
      DM1.Diction['FieldID'] := CurField;
      DM1.Diction['Desc'] := Tab['Id'];
      DM1.Diction['Word'] := ListBox1.Items[k];
      DM1.Diction.Post;
    end;
    ListBox1.Items.Objects[k].Free;
    ListBox1.Items.Delete(k);
    ListBox1.ItemIndex := -1;
    SpeedButton4.Enabled := False;
    SpeedButton5.Enabled := False;
  end;
  if ListBox1.Items.Count = 0 then
    BitBtn10.Enabled := True;
end;

procedure TWizForm.SpeedButton3Click(Sender: TObject);
var S: string;
  i, p: Integer;
begin
  SpeedButton3.Enabled := False;
  S := ListBox3.Items[ListBox3.ItemIndex];
  S := Copy(S, 1, Pos(' -> ', S) - 1);
  ListBox1.Items.Add(S);
  ListBox1.Items.Objects[ListBox1.Items.Count - 1] :=
    TInt.Create(TCorr(ListBox3.Items.Objects[ListBox3.ItemIndex]).N);
  if DM1.Diction.Locate('FieldId;Desc;Word',
    VarArrayOf([CurField, TCorr(ListBox3.Items.Objects[ListBox3.ItemIndex]).Id, S]), []) then
    DM1.Diction.Delete;


  ListBox3.Items.Objects[ListBox3.ItemIndex].Free;
  ListBox3.Items.Delete(ListBox3.ItemIndex);
  if ListBox1.Items.Count > 0 then
    BitBtn10.Enabled := False;
end;

procedure TWizForm.ListBox3Click(Sender: TObject);
begin
  if (ListBox3.ItemIndex >= 0) and (ListBox3.ItemIndex <= ListBox3.Items.Count - 1) then
    SpeedButton3.Enabled := True;
end;

procedure TWizForm.ListBox1Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex >= 0) and (ListBox1.ItemIndex <= ListBox1.Items.Count - 1) then begin
    SpeedButton4.Enabled := True;
    SpeedButton5.Enabled := True;
  end;
end;

procedure TWizForm.FormDestroy(Sender: TObject);
begin
  CurIdents.Free;
  NewIdents.Free;
end;

procedure TWizForm.BitBtn9Click(Sender: TObject);
begin
  Application.HelpContext(CurHelpContext);
end;

procedure TWizForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

procedure TWizForm.eNumSearchChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> '' then begin
    if Sender = ENumSearch then
      DbNavigator11.DataSource.DataSet.Locate('Num', ENumSearch.Text, [loPartialKey])
    else
      DbNavigator11.DataSource.DataSet.Locate('Author', EAuthSearch.Text, [loPartialKey])
  end;
end;

end.

