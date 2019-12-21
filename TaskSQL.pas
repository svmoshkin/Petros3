unit TaskSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons,  StdCtrls, Grids, DBGrids, NumInp, StrHlder, ColorBtns,
  Analise, ArtLabel, TabMend, Chemist, ESBRtns, ExtCtrls, ComCtrls,
  RHAGlobs, RxGrdCpt, Mask, ToolEdit, CurrEdit, ADODB, Hintctrl;

type
  TTaskSQLForm = class(TForm)
    BOr: TButton;
    BAnd: TButton;
    Button1: TButton;
    GroupBox6: TGroupBox;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Color95Button1: TColor95Button;
    StrHolder1: TStrHolder;
    Button8: TButton;
    BitBtn3: TBitBtn;
    BSave: TBitBtn;
    BLoad: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    BitBtn5: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    EAuthor: TEdit;
    Add1: TButton;
    Button12: TButton;
    GroupBox2: TGroupBox;
    ETitle: TEdit;
    Add2: TButton;
    Button13: TButton;
    GroupBox5: TGroupBox;
    Add4: TButton;
    NameGrid: TDBGrid;
    Button15: TButton;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    EBibl: TEdit;
    Add3: TButton;
    Button14: TButton;
    TabSheet3: TTabSheet;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    BR1: TButton;
    BR3: TButton;
    BR2: TButton;
    BR4: TButton;
    ER1: TEdit;
    ER2: TEdit;
    BTab1: TBitBtn;
    BTabl2: TBitBtn;
    GroupBox7: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    NumInp1: TNumInp;
    NumInp2: TNumInp;
    GroupBox8: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Button6: TButton;
    Button5: TButton;
    Button7: TButton;
    NumInp3: TNumInp;
    NumInp4: TNumInp;
    StrHolder2: TStrHolder;
    StrHolder3: TStrHolder;
    Bevel2: TBevel;
    Edit1: TEdit;
    Label10: TLabel;
    GroupBox10: TGroupBox;
    Edit2: TEdit;
    Button16: TButton;
    Button17: TButton;
    GroupBox11: TGroupBox;
    GIGrid: TDBGrid;
    Button18: TButton;
    Button19: TButton;
    GroupBox12: TGroupBox;
    RockGrid: TDBGrid;
    Button20: TButton;
    Button21: TButton;
    GroupBox13: TGroupBox;
    RegionGrid: TDBGrid;
    Button22: TButton;
    Button23: TButton;
    TabSheet4: TTabSheet;
    GroupBox9: TGroupBox;
    Bevel1: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ArtLabel1: TArtLabel;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    NumInp5: TNumInp;
    NumInp6: TNumInp;
    BitBtn4: TBitBtn;
    GroupBox14: TGroupBox;
    GBodyGrid: TDBGrid;
    Button24: TButton;
    Button25: TButton;
    GroupBox16: TGroupBox;
    Bevel4: TBevel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ArtLabel3: TArtLabel;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    NumInp9: TNumInp;
    NumInp10: TNumInp;
    BitBtn7: TBitBtn;
    GroupBox15: TGroupBox;
    Bevel3: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ArtLabel2: TArtLabel;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    NumInp7: TNumInp;
    NumInp8: TNumInp;
    BitBtn6: TBitBtn;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    Bevel5: TBevel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ArtLabel4: TArtLabel;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    NumInp11: TNumInp;
    NumInp12: TNumInp;
    BitBtn8: TBitBtn;
    GroupBox19: TGroupBox;
    Bevel6: TBevel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    ArtLabel5: TArtLabel;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    NumInp13: TNumInp;
    NumInp14: TNumInp;
    BitBtn9: TBitBtn;
    TabSheet5: TTabSheet;
    Label23: TLabel;
    HLB1: THListBox;
    GroupBox20: TGroupBox;
    Label26: TLabel;
    ClassGrid: TDBGrid;
    ClassGridInt: TDBGrid;
    Button39: TButton;
    Button38: TButton;
    Label25: TLabel;
    GroupBox21: TGroupBox;
    CheckBox1: TCheckBox;
    Label24: TLabel;
    Edit3: TEdit;
    BitBtn10: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Color95Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure BOrClick(Sender: TObject);
    procedure BAndClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Add3Click(Sender: TObject);
    procedure Add4Click(Sender: TObject);
    procedure BR1Click(Sender: TObject);
    procedure BTab1Click(Sender: TObject);
    procedure BTabl2Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Add2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure BLoadClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure HLB1Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TabSheet1Enter(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure TabSheet4Enter(Sender: TObject);
    procedure TabSheet5Enter(Sender: TObject);
    procedure TabSheet3Enter(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
  private
    { Private declarations }
    procedure EnabButtons;
    procedure DisButtons;
    procedure CheckAlfabet;
  public
    { Public declarations }
    ForProject: Boolean;
    AllBase: boolean;
    MemBeg: integer;
    MemEnd: integer;
    AtNum, Wnum, AtnotWnum, WnotWnum, W100num: integer;
  end;

var
  TaskSQLForm: TTaskSQLForm;

resourcestring
  stWhBase = 'Whole base';
  stAllData = 'All data';
  stElem = 'Selection of element';
  stNotSelElem = 'Element is not selected!';
  stRange='Input of rank formula';

implementation

uses DMod1, SelPoint, StDiagrams, DModOld, PView;

{$R *.DFM}


procedure TTaskSQLForm.DisButtons;
begin
  Add1.Enabled := false;
  Add2.Enabled := false;
  Add3.Enabled := false;
  Add4.Enabled := false;
  BR1.Enabled := false;
  BR2.Enabled := false;
  BR3.Enabled := false;
  BR4.Enabled := false;
  Button2.Enabled := false;
  Button3.Enabled := false;
  Button4.Enabled := false;
  Button5.Enabled := false;
  Button6.Enabled := false;
  Button7.Enabled := false;
  Button9.Enabled := false;
  Button11.Enabled := false;
  Button10.Enabled := false;
  Button12.Enabled := false;
  Button13.Enabled := false;
  Button14.Enabled := false;
  Button15.Enabled := false;
  Button18.Enabled := false;
  Button19.Enabled := false;
  Button20.Enabled := false;
  Button21.Enabled := false;

  Button16.Enabled := false;
  Button17.Enabled := false;
  Button22.Enabled := false;
  Button23.Enabled := false;
  Button24.Enabled := false;
  Button25.Enabled := false;
  Button26.Enabled := false;
  Button27.Enabled := false;
  Button28.Enabled := false;
  Button29.Enabled := false;
  Button30.Enabled := false;
  Button31.Enabled := false;
  Button32.Enabled := false;
  Button33.Enabled := false;
  Button34.Enabled := false;
  Button35.Enabled := false;
  Button36.Enabled := false;
  Button37.Enabled := false;

  BOr.Enabled := true;
  BAnd.Enabled := true;
  BitBtn1.Enabled := true;
  BitBtn5.Enabled := true;
  BSave.Enabled := True;
end;


procedure TTaskSQLForm.EnabButtons;
begin
  Add1.Enabled := True;
  Add2.Enabled := True;
  Add3.Enabled := True;
  Add4.Enabled := True;
  BR1.Enabled := true;
  BR2.Enabled := true;
  BR3.Enabled := true;
  BR4.Enabled := true;
  Button2.Enabled := true;
  Button3.Enabled := true;
  Button4.Enabled := true;
  Button5.Enabled := true;
  Button6.Enabled := true;
  Button7.Enabled := true;
  Button9.Enabled := true;
  Button11.Enabled := true;
  Button10.Enabled := true;
  Button12.Enabled := true;
  Button13.Enabled := true;
  Button14.Enabled := true;
  Button15.Enabled := true;
  Button18.Enabled := true;
  Button19.Enabled := true;
  Button20.Enabled := true;
  Button21.Enabled := true;
  Button16.Enabled := true;
  Button17.Enabled := true;
  Button22.Enabled := true;
  Button23.Enabled := true;
  Button24.Enabled := true;
  Button25.Enabled := true;
  Button26.Enabled := true;
  Button27.Enabled := true;
  Button28.Enabled := true;
  Button29.Enabled := true;
  Button30.Enabled := true;
  Button31.Enabled := true;
  Button32.Enabled := true;
  Button33.Enabled := true;
  Button34.Enabled := true;
  Button35.Enabled := true;
  Button36.Enabled := true;
  Button37.Enabled := true;

  BSave.Enabled := false;
  BOr.Enabled := false;
  BAnd.Enabled := false;
  BitBtn1.Enabled := false;
  BitBtn5.Enabled := false;
  PageControl1.ActivePage.SetFocus;
end;

procedure TTaskSQLForm.FormShow(Sender: TObject);
var i : integer;
begin
 { if ForProject then begin}
  Memo1.Lines.Assign(StrHolder2.Strings);
  MemEnd := 2;
  CheckBox1.Checked:=False;
  SaveDialog1.Filter := 'Project SQL files|*.PSQ';
  OpenDialog1.Filter := 'Project SQL files|*.PSQ';
 { end else begin
    MemEnd := 16;
    Memo1.Lines.Assign(SQL0.Strings);
    Memo1.Lines.Delete(MemEnd - 1);
    SaveDialog1.Filter := 'Petros SQL files|*.TSQ';
    OpenDialog1.Filter := 'Petros SQL files|*.TSQ';
  end;  }

  EnabButtons;
  Color95Button1.Enabled := true;

  ArtLabel1.Caption := '?';
 (* if ForProject then begin
     {Color95Button1.Caption:=stWhBase;}
    Color95Button1.Enabled := False;
    NameGrid.DataSource := DMOLD.DSMain;
    DMOld.TMain.Open;
  end else begin  *)
      {Color95Button1.Caption :=stAllData;}
    Color95Button1.Enabled := true;
    DM1.dsMain.DataSet.Close;
    DM1.dsMain.DataSet.Open;
    NameGrid.DataSource := DM1.dsMain;
    DM1.TabM2.Open;
    DM1.TabM2.First;

 // end;
  
  for i:=0 to StDiaForm.HListBox2.Items.Count-1 do
      if TDiagram(StDiaForm.HListBox2.Items.Objects[i]).Classification then
         HLB1.Items.AddObject(StDiaForm.HListBox2.Items[i],StDiaForm.HListBox2.Items.Objects[i]);
  HLB1.ItemIndex:=0;
  HLB1Click(Sender);
  AllBase := False;
     {if Sender<>Button8 then
          Edit1.Text:='Запрос';
     Edit1.SetFocus; }
end;

procedure TTaskSQLForm.Color95Button1Click(Sender: TObject);
begin
  Memo1.Lines.Assign(StrHolder3.Strings);
  AllBase := True;
  CheckAlfabet;
  Close;
  ModalResult := mrOK;

end;

procedure TTaskSQLForm.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.AN >= ' +
    NumInp1.Text + ')');
  NumInp1.Text := '0';
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.Button3Click(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.AN <= ' +
    NumInp1.Text + ')');
  NumInp1.Text := '0';
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.Button4Click(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.AN >= ' +
    NumInp1.Text + ') AND (rhadata.AN <= ' +
    NumInp2.Text + ')');
  NumInp1.Text := '0';
  NumInp2.Text := '0';
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.Button6Click(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.E >= ' +
    NumInp3.Text + ')');
  NumInp3.Text := '0';
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.Button5Click(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.E <= ' +
    NumInp3.Text + ')');
  NumInp3.Text := '0';
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.Button7Click(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.E >= ' +
    NumInp3.Text + ') AND (rhadata.E <= ' +
    NumInp4.Text + ')');
  NumInp3.Text := '0';
  NumInp4.Text := '0';
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.BOrClick(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, ')OR(');
  EnabButtons;
end;

procedure TTaskSQLForm.BAndClick(Sender: TObject);
begin
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, ')AND(');
  EnabButtons;
end;

procedure TTaskSQLForm.Button1Click(Sender: TObject);
var
  S: string;
begin
  if Memo1.Lines.Count > MemEnd then begin
    S := Memo1.Lines[Memo1.Lines.Count - 2];
    if s[1] = ')' then DisButtons
    else EnabButtons;
    Memo1.Lines.Delete(Memo1.Lines.Count - 2);
    if Memo1.Lines.Count = MemEnd then
      Color95Button1.Enabled := true;
  end;
end;

procedure TTaskSQLForm.Add3Click(Sender: TObject);
begin
  if EBibl.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.DESCRIPT LIKE ''%' +
      EBibl.Text + '%'')');
    EBibl.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.Add4Click(Sender: TObject);
var
  S: string;
  i: integer;
  Tabl: TADOTable;
begin
  if ForProject then
    //Tabl := DMOld.TMain
  else
    Tabl := DM1.TabM2;
  s := '(rhadata.ArrId IN (';
  if Sender = Button15 then S := 'NOT' + S;
  if NameGrid.SelectedRows.Count > 0 then begin
    try
      Tabl.DisableControls;

      for i := 0 to NameGrid.SelectedRows.Count - 1 do begin
        Tabl.Bookmark := NameGrid.SelectedRows[i];
        s := S + IntToStr(Tabl['ID']) + ', ';
      end;
      System.Delete(S, Length(S) - 1, 2);
      Memo1.Lines.Insert(Memo1.Lines.Count - 1, S + '))');
      NameGrid.SelectedRows.Clear;
      DisButtons;
      Color95Button1.Enabled := false;
    finally
     // Tabl.First;
      Tabl.EnableControls;
    end;
  end;
end;

procedure TTaskSQLForm.BR1Click(Sender: TObject);
var
  R1, R2: string;
  EP: Byte;
begin

  if ER1.Text = '' then exit;
  if not TranslateR(ER1.Text, R1, EP) then begin
    ShowMessage('Ошибка в записи ранговой формулы');
    Er1.SetFocus;
    Er1.SelStart := EP;
    ER1.SelLength := 1;
    exit;
  end;
  case TButton(Sender).Tag of
    1: Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.R >= ''' +
        R1 + ''')');
    2: Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(Substring(rhadata.R,1,'+IntToStr(5*MaxHALen)+') = ''' +
        R1 + ''')');
    3: Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.R <= ''' +
        R1 + '*'')');
    4: begin
        if ER2.Text = '' then exit;
        if not TranslateR(ER2.Text, R2, EP) then begin
          ShowMessage('Ошибка в записи ранговой формулы');
          Er2.SetFocus;
          Er2.SelStart := EP;
          ER2.SelLength := 1;
          exit;
        end;

        Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.R >= ''' +
          R1 + ''') AND (rhadata.R <= ''' + R2 + '*'')');
      end;
  end;
  DisButtons;
  Color95Button1.Enabled := False;
end;

procedure TTaskSQLForm.BTab1Click(Sender: TObject);
begin
  MendForm.MendTabl1.Oxide := False;
  MendForm.MendTabl1.OnlyOne:=False;
  MendForm.MendTabl1.EnableType := False;
  MendForm.MendTabl1.EnableMath := False;
  MendForm.MendTabl1.Text := ER1.Text;
  MendForm.MendTabl1.Comma := true;
  MendForm.Caption := stRange;
  if MendForm.ShowModal = mrOK then
    ER1.Text := MendForm.MendTabl1.Text;
end;

procedure TTaskSQLForm.BTabl2Click(Sender: TObject);
begin
  MendForm.MendTabl1.Oxide := False;
   MendForm.MendTabl1.OnlyOne:=False;
  MendForm.MendTabl1.EnableType := False;
  MendForm.MendTabl1.EnableMath := False;
  MendForm.MendTabl1.Comma := True;
  MendForm.MendTabl1.Text := ER2.Text;
  MendForm.Caption := stRange;
  if MendForm.ShowModal = mrOK then
    ER2.Text := MendForm.MendTabl1.Text;
end;

procedure TTaskSQLForm.Add1Click(Sender: TObject);
begin
  if EAuthor.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, StrHolder1.Strings[0]);
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, StrHolder1.Strings[1]);
    Memo1.Lines[Memo1.Lines.Count - 2] := Memo1.Lines[Memo1.Lines.Count - 2] +
      'ArrayName LIKE ''%' + EAuthor.Text + '%''))';
    EAuthor.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.Add2Click(Sender: TObject);
begin
  if ETitle.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, StrHolder1.Strings[0]);
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, StrHolder1.Strings[1]);
    Memo1.Lines[Memo1.Lines.Count - 2] := Memo1.Lines[Memo1.Lines.Count - 2] +
      'Descript LIKE ''%' + ETitle.Text + '%''))';
    ETitle.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;


procedure TTaskSQLForm.BitBtn3Click(Sender: TObject);
begin
     Application.HelpContext(HelpContext);
end;

procedure TTaskSQLForm.BitBtn4Click(Sender: TObject);
var
  r: string;
  i: integer;
begin
  MendForm.MendTabl1.Oxide := False;
  MendForm.MendTabl1.OnlyOne:=True;
  MendForm.MendTabl1.EnableType := False;
  MendForm.MendTabl1.EnableMath := False;
  MendForm.MendTabl1.Text := '';
  MendForm.MendTabl1.Comma := false;
  MendForm.Caption := stElem;
  MendForm.MendTabl1.Caption:='';
  if MendForm.ShowModal = mrOK then
    r := StripChStr(MendForm.MendTabl1.Text, ',')
  else Exit;
  i := MendTab.GetNumber(R);
  if i <= 0 then begin
    ShowMessage(stChemElError);
    Exit;
  end;
  if Sender = BitBtn4 then begin
    ArtLabel1.Caption := r;
    AtNum := i;
    if r='Fe' then AtNum:=126;
  end else if Sender = BitBtn8 then begin
    ArtLabel4.Caption := r;
    AtnotWNum := i;
    if r='Fe' then AtNotWNum:=126;
  end else if Sender = BitBtn6 then begin
    ArtLabel2.Caption := MendTab.GetPetroSym(i);
    WNum := i;
  end else if Sender = BitBtn7 then begin
    ArtLabel3.Caption := MendTab.GetPetroSym(i);
    W100Num := i;
  end else if Sender = BitBtn9 then begin
    ArtLabel5.Caption := MendTab.GetPetroSym(i);
    WnotWNum := i;
  end;
  MendForm.MendTabl1.OnlyOne:=false;
end;

procedure TTaskSQLForm.Button10Click(Sender: TObject);
var
  SField: string;
  S, A1, A2: string;
begin
  SField := 'rhadata.A';
  if (Sender = Button10) or (Sender = Button9) or (Sender = Button11) then begin
    if ArtLabel1.Caption = '?' then begin
      ShowMessage(stNotSelElem);
      exit;
    end else begin
    if AtNum=126 then
    SField := 'rhadata.A26+rhadata.A93'
     else
      SField := sField + IntToStr(AtNum) + '';
      a1 := NumInp5.Text;
      A2 := NumInp6.Text;
      NumInp5.Text := '0';
      NumInp6.Text := '0';
    end;
  end else if (Sender = Button27) or (Sender = Button26) or (Sender = Button28) then begin
    if ArtLabel2.Caption = '?' then begin
      ShowMessage(stNotSelElem);
      exit;
    end else begin
      SField := sField + IntToStr(WNum) + '' +
        '*rhadata.Summa*' + FloatToStr(MendTab.GetPetroVes(WNum)) +
        '/(rhadata.Ox*100)';
      a1 := NumInp7.Text;
      A2 := NumInp8.Text;
      NumInp7.Text := '0';
      NumInp8.Text := '0';
    end;
  end else if (Sender = Button29) or (Sender = Button30) or (Sender = Button31) then begin
    if ArtLabel3.Caption = '?' then begin
      ShowMessage(stNotSelElem);
      exit;
    end else begin
      SField := sField + IntToStr(W100Num) + '' +
        '*' + FloatToStr(MendTab.GetPetroVes(W100Num)) +
        '/rhadata.Ox';
      a1 := NumInp9.Text;
      A2 := NumInp10.Text;
      NumInp9.Text := '0';
      NumInp10.Text := '0';
    end;
  end else if (Sender = Button32) or (Sender = Button33) or (Sender = Button34) then begin
    if ArtLabel4.Caption = '?' then begin
      ShowMessage(stNotSelElem);
      exit;
    end else if AtnotWNum = 1 then begin
      ShowMessage(stHforAw);
      exit;
    end else begin
      if AtnotWNum = 8 then
        SField := '(' + sField + IntToStr(AtnotWNum) + '-0.5 * rhadata.A1' +
          ')*rhadata.AWA'
      else
      if AtNum=126 then
    SField := '(rhadata.A26+rhadata.A93)'+
           '*' + 'rhadata.AWA'
       else SField := sField + IntToStr(AtnotWNum) + '' +
          '*' + 'rhadata.AWA';
      a1 := NumInp11.Text;
      A2 := NumInp12.Text;
      NumInp11.Text := '0';
      NumInp12.Text := '0';
    end;
  end else if (Sender = Button35) or (Sender = Button36) or (Sender = Button37) then begin
    if ArtLabel5.Caption = '?' then begin
      ShowMessage(stNotSelElem);
      exit;
    end else begin
      SField := sField + IntToStr(WnotWNum) + '' +
        '*' + FloatToStr(MendTab.GetPetroVes(WnotWNum)) +
        '/rhadata.AW)';
      a1 := NumInp13.Text;
      A2 := NumInp14.Text;
      NumInp13.Text := '0';
      NumInp14.Text := '0';
    end;
  end;
  {Memo1.Lines[1] := Memo1.Lines[1] + ',' + SField;}
  case TButton(Sender).Tag of
    1: S := '(' + SField + '<=' + A1 + ')';
    2: S := '(' + SField + '>=' + A1 + ')';
    3: S := '((' + SField + '>=' + A1 + ')AND(' + SField + '<=' + A2
      + '))';
  end;
  Memo1.Lines.Insert(Memo1.Lines.Count - 1, S);
  DisButtons;
  Color95Button1.Enabled := false;
end;

procedure TTaskSQLForm.Button12Click(Sender: TObject);
begin
  if EAuthor.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, 'NOT(' + StrHolder1.Strings[0]);
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, StrHolder1.Strings[1]);
    Memo1.Lines[Memo1.Lines.Count - 2] := Memo1.Lines[Memo1.Lines.Count - 2] +
      'ArrayName LIKE ''%' + EAuthor.Text + '%'')))';
    EAuthor.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.Button13Click(Sender: TObject);
begin
  if ETitle.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, 'NOT(' + StrHolder1.Strings[0]);
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, StrHolder1.Strings[1]);
    Memo1.Lines[Memo1.Lines.Count - 2] := Memo1.Lines[Memo1.Lines.Count - 2] +
      'Descript LIKE ''%' + ETitle.Text + '%'')))';
    ETitle.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.Button14Click(Sender: TObject);
begin
  if EBibl.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, 'NOT(rhadata.DESCRIPT LIKE ''%' +
      EBibl.Text + '%'')');
    EBibl.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.BSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then begin
  CheckAlfabet ;
    Memo1.Lines.Insert(0, DataDes);
        {#ToDo2 SQL Name for not ForProject}
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
    Memo1.Lines.Delete(0);
  end;
  PageControl1.ActivePage.SetFocus;
end;

procedure TTaskSQLForm.BLoadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Memo1.Lines.Clear;
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    DataDes := Memo1.Lines[0];
        {#ToDo3 Edit1.Text for not ForProject}
    Memo1.Lines.Delete(0);
   { if not ForProject then begin
      Memo1.Lines[2] := SQL0.Strings[2];
      Memo1.Lines[3] := SQL0.Strings[3];
      Memo1.Lines[4] := SQL0.Strings[4];
      Memo1.Lines[5] := SQL0.Strings[5];
      Memo1.Lines[6] := SQL0.Strings[6];
      Memo1.Lines[7] := SQL0.Strings[7];
      Memo1.Lines[9] := SQL0.Strings[9];
      Memo1.Lines[11] := SQL0.Strings[11];
      Memo1.Lines[13] := SQL0.Strings[13];
    end;        }
    DisButtons;
  end;
  PageControl1.ActivePage.SetFocus;
end;

procedure TTaskSQLForm.BitBtn5Click(Sender: TObject);
begin
  SelForm.Query1.Close;
  SelForm.Query1.SQL.Clear;
  CheckAlfabet;
  SelForm.Query1.Sql.Assign(Memo1.Lines);

  SelForm.Query1.Sql.Add(' ORDER BY rhadata.ArrNum, rhadata.Num');
    {SelForm.Query1.Prepare;}
  SelForm.Query1.Open;
  SelForm.ShowModal;
  Close;
  ModalResult := mrOK;
end;



procedure TTaskSQLForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i : integer;
begin
  if ForProject then
    DMOld.TMain.Close;
 {for i:=0 to HLB1.Items.Count-1 do
    HLB1.Items.Objects[i].Free;}
 HLB1.Clear;
end;


procedure TTaskSQLForm.Button16Click(Sender: TObject);
begin
  if Edit2.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, '(rhadata.Sample LIKE ''%' +
      Edit2.Text + '%'')');
    Edit2.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.Button17Click(Sender: TObject);
begin
  if Edit2.Text <> '' then begin
    Memo1.Lines.Insert(Memo1.Lines.Count - 1, 'NOT(rhadata.Sample LIKE ''%' +
      Edit2.Text + '%'')');
    Edit2.Text := '';
    DisButtons;
    Color95Button1.Enabled := false;
  end;
end;

procedure TTaskSQLForm.Button19Click(Sender: TObject);
var S: string;
  i: integer;
begin
  s := '(rhadata.GeolId IN (';
  if Sender = Button18 then S := 'NOT' + S;
  if GiGrid.SelectedRows.Count > 0 then begin
    try
      DM1.GeolIDs.DisableControls;

      for i := 0 to GiGrid.SelectedRows.Count - 1 do begin
        DM1.GeolIDs.Bookmark := GiGrid.SelectedRows[i];
        s := S + IntToStr(DM1.GeolIDs['ID']) + ', ';
      end;
      System.Delete(S, Length(S) - 1, 2);
      Memo1.Lines.Insert(Memo1.Lines.Count - 1, S + '))');
      GiGrid.SelectedRows.Clear;
      DisButtons;
      Color95Button1.Enabled := false;
    finally
      DM1.GeolIDs.First;
      DM1.GeolIDs.EnableControls;
    end;
  end;
end;

procedure TTaskSQLForm.Button21Click(Sender: TObject);
var S: string;
  i: integer;
begin
  s := '(rhadata.Rock IN (';
  if Sender = Button20 then S := 'NOT' + S;
  if RockGrid.SelectedRows.Count > 0 then begin
    try
      DM1.Rocks.DisableControls;

      for i := 0 to RockGrid.SelectedRows.Count - 1 do begin
        DM1.Rocks.Bookmark := RockGrid.SelectedRows[i];
        s := S + IntToStr(DM1.Rocks['ID']) + ', ';
      end;
      System.Delete(S, Length(S) - 1, 2);
      Memo1.Lines.Insert(Memo1.Lines.Count - 1, S + '))');
      RockGrid.SelectedRows.Clear;
      DisButtons;
      Color95Button1.Enabled := false;
    finally
      DM1.Rocks.First;
      DM1.Rocks.EnableControls;
    end;
  end;
end;

procedure TTaskSQLForm.Button23Click(Sender: TObject);
var S: string;
  i: integer;
begin
  s := '(rhadata.Region IN (';
  if Sender = Button22 then S := 'NOT' + S;
  if RegionGrid.SelectedRows.Count > 0 then begin
    try
      DM1.Regions.DisableControls;

      for i := 0 to RegionGrid.SelectedRows.Count - 1 do begin
        DM1.Regions.Bookmark := RegionGrid.SelectedRows[i];
        s := S + IntToStr(DM1.Regions['ID']) + ', ';
      end;
      System.Delete(S, Length(S) - 1, 2);
      Memo1.Lines.Insert(Memo1.Lines.Count - 1, S + '))');
      RegionGrid.SelectedRows.Clear;
      DisButtons;
      Color95Button1.Enabled := false;
    finally
      DM1.Regions.First;
      DM1.Regions.EnableControls;
    end;
  end;
end;


procedure TTaskSQLForm.Button25Click(Sender: TObject);
var S: string;
  i: integer;
begin
  s := '(rhadata.GBody IN (';
  if Sender = Button24 then S := 'NOT' + S;
  if GBodyGrid.SelectedRows.Count > 0 then begin
    try
      DM1.GBodies.DisableControls;

      for i := 0 to GBodyGrid.SelectedRows.Count - 1 do begin
        DM1.GBodies.Bookmark := GBodyGrid.SelectedRows[i];
        s := S + IntToStr(DM1.GBodies['ID']) + ', ';
      end;
      System.Delete(S, Length(S) - 1, 2);
      Memo1.Lines.Insert(Memo1.Lines.Count - 1, S + '))');
      GBodyGrid.SelectedRows.Clear;
      DisButtons;
      Color95Button1.Enabled := false;
    finally
      DM1.GBodies.First;
      DM1.GBodies.EnableControls;
    end;
  end;

end;

procedure TTaskSQLForm.HLB1Click(Sender: TObject);
var Id : integer;
begin
    Id:=TDiagram(HLB1.Items.Objects[HLB1.ItemIndex]).ID;
    try
    DM1.TbDiagr.DisableControls;
    DM1.TbDiagr.Locate('Id',Id,[]);
    finally
    DM1.TbDiagr.EnableControls;
    end;
end;

procedure TTaskSQLForm.Button39Click(Sender: TObject);
var S: string;
  i: integer;
begin
      S :=
      '(Select Anal from Classif  WHERE (Diagr='+
      IntToStr(TDiagram(HLB1.Items.Objects[HLB1.ItemIndex]).ID)+
      ')and';
       if (Sender = Button38) then S := S+ ' NOT ';
      S:=S+'(Class IN(';

  if (ClassGrid.SelectedRows.Count > 0)or(ClassGridInt.SelectedRows.Count > 0) then begin
    try
      DM1.TbFields.DisableControls;
      DM1.TbInterv.DisableControls;
      for i := 0 to ClassGrid.SelectedRows.Count - 1 do begin
        DM1.TbFields.Bookmark := ClassGrid.SelectedRows[i];
        s := S + ''''+DM1.TbFields['ClassID']+''',';
      end;
      for i := 0 to ClassGridInt.SelectedRows.Count - 1 do begin
        DM1.TbInterv.Bookmark := ClassGridInt.SelectedRows[i];
        s := S + ''''+DM1.TbInterv['ClassID']+''',';
      end;
      System.Delete(S, Length(S), 1);
      Memo1.Lines.Insert(Memo1.Lines.Count - 1,'(rhadata.AnId IN '+ S + '))))');
      ClassGrid.SelectedRows.Clear;
      ClassGridInt.SelectedRows.Clear;
      DisButtons;
      Color95Button1.Enabled := false;
    finally
      DM1.TbFields.First;
      DM1.TbFields.EnableControls;
      DM1.TbInterv.First;
      DM1.TbInterv.EnableControls;
    end;
  end;
end;

procedure TTaskSQLForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
     PageControl1.ActivePage.SetFocus;
end;

procedure TTaskSQLForm.TabSheet1Enter(Sender: TObject);
begin
     CurHelpContext := TabSheet1.HelpContext;
end;

procedure TTaskSQLForm.TabSheet2Enter(Sender: TObject);
begin
     CurHelpContext := TabSheet2.HelpContext;
end;

procedure TTaskSQLForm.TabSheet4Enter(Sender: TObject);
begin
     CurHelpContext := TabSheet4.HelpContext;
end;

procedure TTaskSQLForm.TabSheet5Enter(Sender: TObject);
begin
     CurHelpContext := TabSheet5.HelpContext;
end;

procedure TTaskSQLForm.TabSheet3Enter(Sender: TObject);
begin
     CurHelpContext := TabSheet3.HelpContext;
end;

procedure TTaskSQLForm.PageControl1Change(Sender: TObject);
begin
     CurHelpContext := PageControl1.ActivePage.HelpContext;
end;

procedure TTaskSQLForm.CheckAlfabet;
begin
      if CheckBox1.Checked then begin
      try
        StrToInt(Edit3.Text)
      except
        ShowMessage('Alphabet number must be integer between 0 and 99');
        Abort;
      end;
        if AllBase then
        Memo1.Lines.Add(' where Alfa='+Edit3.Text)
        else
        Memo1.Lines.Add(' and Alfa='+Edit3.Text);
      end;
end;

procedure TTaskSQLForm.BitBtn1Click(Sender: TObject);
begin
    CheckAlfabet;
end;

procedure TTaskSQLForm.BitBtn10Click(Sender: TObject);
begin
  try
  Screen.Cursor:=crHourGlass;
  fPView.Query1.Close;
  fPView.Query1.SQL.Clear;
  CheckAlfabet;
  fPView.Query1.Sql.Assign(Memo1.Lines);
  fPView.Query1.Sql[0]:='select Alfa,Num,Sample,Descript,'+
    ' (Select ArrayName from MainRHA where id=ArrId)As ArrayName from RHADATA where (';
  fPView.Query1.Sql.Add(' ORDER BY rhadata.ArrNum, rhadata.Num');
    {fPView.Query1.Prepare;}
  fPView.Query1.Open;
  finally
    Screen.Cursor:=crDefault;
  end;
  fPView.ShowModal;
end;

end.

