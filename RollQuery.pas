unit RollQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MROLLUP, StdCtrls, CheckLst, ADODB, DMod1, DB, RHAGlobs, ADOUtilsS,
  Buttons;

type
  TQueryRolls = class(TRollsUp)
    QueryChLBox: TCheckListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Button2: TBitBtn;
    Button1: TBitBtn;
    BitBtn1: TBitBtn;
    procedure QueryChLBoxClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure CheckBtn;
  public
    { Public declarations }
    CurQCount : integer;
    procedure AddSql;
  end;

var
  QueryRolls: TQueryRolls;
  LQueries: TList;
const
  stQuery = 'Query';
  stGID = 'Geological ident.';

procedure OpenSq(Sq: TAdoQuery);
procedure CloseSq(Sq: TAdoQuery);

implementation
uses TaskSQL, ViewSQ, Main;
var
  QueryUse: array[0..1000] of Byte;

{$R *.dfm}

procedure OpenSq(Sq: TAdoQuery);
var i, Ind: integer;
begin
  Ind := LQueries.IndexOf(Sq);
  Inc(QueryUse[Ind]);
  if not Sq.Active then begin
    Sq.Open;
    if Sq.Active then
      for i := 1 to MendCount do
        TFloatField(Sq.FieldByName('A' + IntToStr(i))).DisplayFormat := '#0.###';
  end
end;


procedure CloseSq(Sq: TAdoQuery);
var Ind: integer;
begin
  Ind := LQueries.IndexOf(Sq);
  if QueryUse[Ind] > 0 then
    Dec(QueryUse[Ind]);
  if QueryUse[Ind] = 0 then
    Sq.Close;
end;

{ TQueryRolls }

procedure TQueryRolls.AddSql;
var Sq: TAdoQuery;
  S: string;
begin
  Sq := TAdoQuery.Create(Self);
  Sq.Connection := DM1.ADOConnection1;
  Sq.SQL.Assign(TaskSQLForm.Memo1.Lines);
  S := 'ORDER BY rhadata.' + DefaultOrdField + '';
  if DefaultOrdField = 'R' then
    S := S + ', H';
  Sq.Sql.Add(S);
  LQueries.Add(Sq);
  Application.ProcessMessages;
  QueryChLBox.Items.Add(TaskSQLForm.Edit1.Text);
  QueryChlBox.ItemIndex := QueryChLBox.Items.Count - 1;
  QueryChLBoxClick(nil);

end;

procedure TQueryRolls.QueryChLBoxClick(Sender: TObject);
var S: string;
  i: integer;
begin
  inherited;
  SelSQLName := QueryCHLBox.Items[QueryCHLBox.ItemIndex];
  SelQuery := LQueries[QueryCHLBox.ItemIndex];
  CurQr := SelQuery.SQL.Text;
  CheckBtn;
  S := ReplaceSymbol(SelQuery.SQL.Text, '*', 'Count(*) as CC');
  I := Pos('ORDER BY', UpperCase(S));
  if I > 0 then
    Delete(S, i, 800);
  if OpenQr(s, DM1.q1Time) then begin
    CurQCount:=DM1.q1Time['CC'];
    Label1.Caption := InttoStr(DM1.q1Time['CC']) + ' analyzes in result set'
  end else begin
    Label1.Caption := '';
    CurQCount:=0;
  end;
  MainForm.StatusLine.Panels[1].Text := stCurQuery + SelSQLName;

end;


procedure TQueryRolls.Button2Click(Sender: TObject);
begin
  inherited;
  TaskSQLForm.ForProject := False;
  TaskSQLForm.Edit1.Text := stQuery + IntToStr(QueryChLBox.Items.Count);
  TaskSQLForm.ShowModal;
  if TaskSQLForm.ModalResult = mrOK then begin
    AddSql;
  end;
end;

procedure TQueryRolls.Button1Click(Sender: TObject);
var i: integer;
begin
  inherited;
  if QueryChLBox.ItemIndex < 0 then Exit;
  for i := QueryChLBox.Count - 1 downto 0 do
    if QueryChLBox.Checked[i] then begin
      TAdoQuery(LQueries[i]).Close;
      TAdoQuery(LQueries[i]).Free;
      LQueries.Delete(i);
      QueryChLBox.Items.Delete(i);
    end;
end;

procedure TQueryRolls.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if QueryCHLBox.ItemIndex >= 0 then begin
    SQView.Close;
    SQView.Sq := SelQuery;
    SQView.Caption := SelSQLName;
    SQView.Show;
  end;
end;

procedure TQueryRolls.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if QueryChLBox.ItemIndex > 0 then begin
    LQueries.Exchange(QueryChLBox.ItemIndex, QueryChLBox.ItemIndex - 1);
    QueryChLBox.Items.Exchange(QueryChLBox.ItemIndex, QueryChLBox.ItemIndex - 1);
    QueryChLBoxClick(Sender);
  end;
  CheckBtn;
end;

procedure TQueryRolls.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if QueryChLBox.ItemIndex < QueryChLBox.Count - 1 then begin
    LQueries.Exchange(QueryChLBox.ItemIndex, QueryChLBox.ItemIndex + 1);
    QueryChLBox.Items.Exchange(QueryChLBox.ItemIndex, QueryChLBox.ItemIndex + 1);
    QueryChLBoxClick(Sender);
  end;
  CheckBtn;
end;

procedure TQueryRolls.CheckBtn;
begin
  if QueryCHLBox.ItemIndex = 0 then
    SpeedButton1.Enabled := false
  else
    SpeedButton1.Enabled := true;
  if QueryCHLBox.ItemIndex = QueryCHLBox.Items.Count - 1 then
    SpeedButton2.Enabled := false
  else
    SpeedButton2.Enabled := true;
end;

initialization
  begin
    LQueries := TList.Create;
  end;

finalization
  begin
     {for i:=LQueries.Count-1 downto 0 do begin
        TAdoQuery(LQueries[i]).Close;
        {TAdoQuery(LQueries[i]).Free;
        LQueries.Delete(i);
  end; }
    LQueries.Free;
  end;

end.

