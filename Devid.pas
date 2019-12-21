unit Devid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db,  CheckLst, ExtCtrls,RHAGlobs, Variants,
  ADODB, ADOUtilsS;

type
  TDevForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ListBox1: TListBox;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ElLB: TCheckListBox;
    OrdLB: TListBox;
    Button3: TButton;
    Button4: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    RadioGroup1: TRadioGroup;
    Query1: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OrdLBClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ElLBClickCheck(Sender: TObject);
    procedure SpeedButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AnType : TDatType;
  end;

  TElemSeq = class
    Order: array[1..MendCount] of integer;
    Check: array[1..MendCount] of Boolean;
  end;

var
  DevForm: TDevForm;
  DevI: array[0..500] of integer;


resourcestring
  stQueryDev = 'Divider';
  stByDevider = 'as in divider';
  stNewSeq = 'New elements sequence';
  stSeqName = 'New sequence name';

var
  Butt: integer;

implementation

uses TaskSQL, DMod1, Chemist;

{$R *.DFM}


procedure TDevForm.FormClose(Sender: TObject; var Action: TCloseAction);
var F: TextFile;
  i: integer;
begin
  AssignFile(F, 'Devider.pti');
  Rewrite(F);
  for i := 0 to ListBox1.Items.Count - 2 do
    writeln(F, DevI[i]);
  CloseFile(F);

end;

procedure TDevForm.Button1Click(Sender: TObject);
begin
  TaskSQLForm.ForProject := False;
  TaskSQLForm.Edit1.Text := stQueryDev;
  TaskSQLForm.ShowModal;
  if TaskSQLForm.ModalResult = mrOK then begin
    Query1.SQL.Assign(TaskSQLForm.Memo1.Lines);
    Application.ProcessMessages;
    Query1.Open;
    if Query1.RecordCount > 0 then begin
      Query1.First;
      DevI[ListBox1.Items.Count - 1] := Query1['AnId'];
      ListBox1.Items.Add(Query1['Descript'])
    end else
      ShowMessage(stEmptyQuer);
    Query1.Close;
  end;
end;

procedure TDevForm.FormShow(Sender: TObject);
var F: TextFile;
  i: integer;
begin
  ListBox1.Items.Clear;
  ListBox1.Items.Add('None');
  if Fileexists('Devider.pti') then begin
    AssignFile(F, 'Devider.pti');
    Reset(F);
    i := 0;
    while not EOF(F) do begin
      readln(F, DevI[i]);
      if OpenQr('Select Descript from RHADATA where AnID='+IntToStr(DevI[i]),DM1.q1Time) then begin
        ListBox1.Items.Add(DM1.q1Time['Descript']);
        Inc(I);
      end;
    end;
    CloseFile(F);
  end;
  ListBox1.ItemIndex := 0;
  if OrdLb.Items.Count<=2 then
     Button4.Enabled:=false
  else
     Button4.Enabled:=True;
 { OrdLb.ItemIndex:=1;}
end;



procedure TDevForm.Button2Click(Sender: TObject);
var i: integer;
begin
  if ListBox1.ItemIndex > 0 then begin
    for i := ListBox1.ItemIndex + 1 to ListBox1.Items.Count - 1 do
      DevI[i - 1] := DevI[i];
    ListBox1.Items.Delete(ListBox1.ItemIndex);
  end;

end;

procedure TDevForm.ListBox1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
     {Close;}
end;

procedure TDevForm.FormCreate(Sender: TObject);
var F: TextFile;
  i, N: integer;
  S: string;
begin
  Timer1.Interval := 400;
  Timer2.Interval := 100;
  AnType:=dtAtomn;
  OrdLB.Items.Clear;
  OrdLB.Items.Add(stByDevider);
  OrdLB.Items.Objects[0] := TElemSeq.Create;
  if Fileexists(AppPath+'Order.pti') then begin
    AssignFile(F,AppPath+'Order.pti');
    Reset(F);
    while not EOF(F) do begin
      readln(F, s);
      if s = '' then break;
              {ReadLn(F,N);}
      OrdLB.Items.Add(S);
      OrdLB.Items.Objects[OrdLB.Items.Count - 1] := TElemSeq.Create;
      for i := 1 to MendCount do begin
        read(F, N);
        if N > 100 then begin
          N := N - 100;
          TElemSeq(OrdLB.Items.Objects[OrdLB.Items.Count - 1]).Check[i] := True;
        end;
        TElemSeq(OrdLB.Items.Objects[OrdLB.Items.Count - 1]).Order[i] :=N;
      end;
      if not Eof(F) then Readln(F);
    end;
    CloseFile(F);
  end;
      {OrdLB.ItemIndex:=0;}
end;

procedure TDevForm.OrdLBClick(Sender: TObject);
var i: integer;
  S: string;
begin
  if OrdLB.ItemIndex = 0 then begin
    if ListBox1.ItemIndex = 0 then begin
      OrdLB.ItemIndex := -1;
      Exit;
    end;
    {if OrdLB.ItemIndex >OrdLB.Items.Count-1 then
       OrdLB.ItemIndex:=OrdLB.Items.Count-1;}
    if DM1.GetAnal(DevI[ListBox1.ItemIndex - 1]) then begin
      ElLB.Items.Clear;
      for i := 1 to MendCount do begin
        TElemSeq(OrdLB.Items.Objects[0]).Order[i] :=i;
        ElLB.Items.Add(GetDataTitle(i,AnType,0));
        s := 'A' + IntToStr(i);
        if CanPresent(i,AnType,0)and(DM1.qAnal[s] <> null) and (DM1.qAnal[s] > 0) then begin
          TElemSeq(OrdLB.Items.Objects[0]).Check[i] := True;
          ElLB.Checked[i - 1] := True;
        end;
      end;
    end;
  end else begin
    ElLB.Items.Clear;
    for i := 1 to MendCount do begin
      ElLB.Items.Add(GetDataTitle(TElemSeq(OrdLB.Items.Objects[OrdLB.ItemIndex]).Order[i],AnType,0));
      ElLb.Checked[i - 1] := TElemSeq(OrdLB.Items.Objects[OrdLB.ItemIndex]).Check[i];
    end;
  end;
end;

procedure TDevForm.ListBox1Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex > 0) then begin
    if OrdLb.ItemIndex = 0 then OrdLBClick(Sender);
  end else begin
    OrdLB.ItemIndex := -1;
    ElLB.Items.Clear;
  end;
end;

procedure TDevForm.FormDestroy(Sender: TObject);
var i, J, N: integer;
  F: TextFile;
begin
  AssignFile(F,AppPath+'Order.pti');
  Rewrite(F);
  for i := 1 to OrdLB.Items.Count - 1 do begin
    WriteLn(F, OrdLB.Items[i]);
    for j := 1 to MendCount do begin
      N := TElemSeq(OrdLB.Items.Objects[i]).Order[j];
      if TElemSeq(OrdLB.Items.Objects[i]).Check[j] then
        inc(N, 100);
      write(F, N, ' ');
    end;
    if i < OrdLB.Items.Count - 1 then
      Writeln(F);
  end;
  CloseFile(F);
  for i := 0 to OrdLB.Items.Count - 1 do
    TElemSeq(OrdLB.Items.Objects[i]).Free;
end;

procedure TDevForm.SpeedButton1Click(Sender: TObject);
var i: integer;
begin
  if ElLB.ItemIndex > 0 then begin
    i := TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex + 1];
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex + 1] :=
      TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex];
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex] := i;

    ElLB.Items.Exchange(ElLB.ItemIndex, ElLB.ItemIndex - 1);
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Check[ElLB.ItemIndex + 1] :=
      ELLb.Checked[ElLB.ItemIndex];
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Check[ElLB.ItemIndex + 2] :=
      ELLb.Checked[ElLB.ItemIndex + 1];
  end;
end;

procedure TDevForm.SpeedButton2Click(Sender: TObject);
var i: integer;
begin
  if ElLB.ItemIndex < ElLB.Items.Count - 1 then begin
    i := TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex + 1];
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex + 1] :=
      TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex + 2];
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Order[ElLB.ItemIndex + 2] := i;

    ElLB.Items.Exchange(ElLB.ItemIndex, ElLB.ItemIndex + 1);
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Check[ElLB.ItemIndex + 1] :=
      ELLb.Checked[ElLB.ItemIndex];
    TElemSeq(OrdLB.Items.Objects[OrdLb.ItemIndex]).Check[ElLB.ItemIndex] :=
      ELLb.Checked[ElLB.ItemIndex - 1];
  end;
end;

procedure TDevForm.Button4Click(Sender: TObject);
var i: integer;
begin
  if OrdLB.ItemIndex > 1 then begin
    i := OrdLB.ItemIndex;
    TElemSeq(OrdLB.Items.Objects[i]).Free;
    OrdLb.Items.Delete(i);
    OrdLB.ItemIndex := i - 1;
    OrdLBClick(Sender);
    if OrdLb.Items.Count<=2 then
     Button4.Enabled:=false
  else
     Button4.Enabled:=True;
  end;
end;

procedure TDevForm.Button3Click(Sender: TObject);
var s: string;
  i: integer;
begin
  S := InputBox(stNewSeq, stSeqName, '');
  if s <> '' then begin
    OrdLB.Items.Add(S);
    OrdLB.ItemIndex := OrdLB.Items.Count - 1;
    OrdLB.Items.Objects[OrdLB.Items.Count - 1] := TElemSeq.Create;
    ElLb.Items.Clear;
    for i := 1 to MendCount do begin
      ElLb.Items.Add(GetDataTitle(I,AnType,0));
      TElemSeq(OrdLB.Items.Objects[OrdLB.Items.Count - 1]).Order[i] :=i;
    end;
    if OrdLb.Items.Count<=2 then
     Button4.Enabled:=false
  else
     Button4.Enabled:=True;
  end;
end;

procedure TDevForm.ElLBClickCheck(Sender: TObject);
begin
  TElemSeq(OrdLB.Items.Objects[OrdLB.ItemIndex]).Check[ElLB.ItemIndex + 1] :=
    ElLb.Checked[ElLB.ItemIndex];
end;

procedure TDevForm.SpeedButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := True;
  Butt := 1;
end;

procedure TDevForm.Timer1Timer(Sender: TObject);
begin
  Timer2.Enabled := true;
  Timer1.Enabled := False;
end;

procedure TDevForm.SpeedButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Butt := 0;
  Timer2.Enabled := False;
  Timer1.Enabled := False;
end;

procedure TDevForm.SpeedButton2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := True;
  Butt := 2;
end;



procedure TDevForm.Timer2Timer(Sender: TObject);
begin
  if Butt = 1 then SpeedButton1Click(Sender);
  if Butt = 2 then SpeedButton2Click(Sender);
end;

procedure TDevForm.BitBtn3Click(Sender: TObject);
begin
     Application.HelpContext(CurHelpContext);
end;

procedure TDevForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.

