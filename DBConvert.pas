unit DBConvert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DbTables, ADODB, ADOUtilsS, StdCtrls, ComCtrls, ExtCtrls,
  EsbRtns;

type
  TfDBConvert = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Label6: TLabel;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   ItWas : Boolean;
  end;

var
  fDBConvert: TfDBConvert;
  AlParams: TStringList;
  Aliases: TStringList;
  RHAAliases: TStringList;
  Alias: string;
  AliasPath: string;

function OpenBDEQr(SQL: string; Q: TQuery): boolean;
function ExecBDEQr(SQL: string; Q: TQuery): Integer;
function InitMainAlias: boolean;
procedure ChangeAlias(Alias: string);
function ConvertRang(ROld: string; NewLen: Integer = 5): string;

function GetAliasDir(Alias: string): string;

resourcestring
  stAliasNotFound = 'Alias "PetrosBase" not found on this computer.';

implementation

uses DMod1, DModOld, RHAGlobs, wait, Options;


{$R *.dfm}

function ConvertRang(ROld: string; NewLen: Integer = 5): string;
var i: integer;
begin
  Result := '';
  for i := 1 to length(ROld) div 3 do
    Result := Result + PadLeftStr(Copy(ROld, i * 3 - 2, 3), NewLen);
end;

function GetId(TableName, KeyField, Val: string; IDName: string = 'ID'): Integer;
begin
  if OpenQr('Select ' + IDName + ' from ' + TableName + ' where ' + KeyField + '=''' + Val + '''', DM1.q1Time) then
    Result := DM1.q1Time[IDName]
  else
    Result := 0;
end;

function GetId2(TableName, MasterField, KeyField, Val: string; MasterVal: integer; IDName: string = 'ID'): Integer;
begin

  if OpenQr('Select ' + IDName + ' from ' + TableName + ' where ' + KeyField + '=''' + Val + ''' and ' +
    MasterField + '=' + IntToStr(MasterVal), DM1.q1Time) then
    Result := DM1.q1Time[IDName]
  else
    Result := 0;
end;

function GetNewID(TableName, KeyField: WideString; ID: integer): integer;
begin
  if OpenBDEQr('Select ' + KeyField + ' from ' + TableName + '.DB where id=' +
    IntToStr(ID), DMOld.q1time) and not VarIsNull(DMOld.q1time[KeyField]) then
    Result := GetID(TableName, KeyField, DMOld.q1time[KeyField])
  else Result := 0
end;

function GetId2XY(TableName, MasterField, ValX, ValY: string; MasterVal: integer; IDName: string = 'ID'): Integer;
begin
  if OpenQr('Select ' + IDName + ' from ' + TableName + ' where abs(X- (' + ValX + '))<0.001 and abs(y-(' + ValY + '))<0.001 and ' +
    MasterField + '=' + IntToStr(MasterVal), DM1.q1Time) then
    Result := DM1.q1Time[IDName]
  else
    Result := 0;
end;

procedure Put1Field(TableName, IDName: string; IdnotIdent: Boolean = False);
var i: integer;
begin
  OpenQr('Select * from ' + TableName + ' where ' + IDName + '=0', DM1.q2Time);
  DM1.q2Time.Insert;
  for i := 0 to DMOld.qLongTime.FieldCount - 1 do
    if IdnotIdent or (UpperCase(DMOld.qLongTime.Fields[i].FieldName) <> UpperCase(IDName)) then begin
      if (TableName = 'MainRHA') and (DMOld.qLongTime.Fields[i].FieldName = 'Title2') then
        DM1.q2Time['Title1'] := DM1.q2Time['Title1'] + DMOld.qLongTime.fieldByName('Title2').AsString
      else if not (DMOld.qLongTime.Fields[i] is TBooleanField) then begin
        if (TableName = 'RHADATA') and (DMOld.qLongTime.Fields[i].FieldName = 'R') then
          DM1.q2Time.FieldByName(DMOld.qLongTime.Fields[i].FieldName).Value := ConvertRang(DMOld.qLongTime.Fields[i].AsString)
        else
          if not (DMOld.qLongTime.Fields[i] is TStringField) or (DMOld.qLongTime.Fields[i].Value <> Null) then
            DM1.q2Time.FieldByName(DMOld.qLongTime.Fields[i].FieldName).Value := DMOld.qLongTime.Fields[i].Value
          else
            DM1.q2Time.FieldByName(DMOld.qLongTime.Fields[i].FieldName).Value := '';
      end else if DMOld.qLongTime.Fields[i].Value = True then
        DM1.q2Time.FieldByName(DMOld.qLongTime.Fields[i].FieldName).Value := 1
      else
        DM1.q2Time.FieldByName(DMOld.qLongTime.Fields[i].FieldName).Value := 0;
    end;
end;

procedure AddDict(qr: TADOQuery; OldQr: TQuery);
begin
  qr['Desc'] := GetNewId('Sinonims', 'Text', OldQr['Desc']);
end;

procedure AddAnal(qr: TADOQuery; OldQr: TQuery);
begin
  if OldQr['Rock'] <> Null then
    qr['Rock'] := GetNewId('Rocks', 'Rock', OldQr['Rock']);
  if OldQr['Source'] <> Null then
    qr['Source'] := GetNewId('Source', 'Num', OldQr['Source']);
  if OldQr['Region'] <> Null then
    qr['Region'] := GetNewId('Regions', 'Region', OldQr['Region']);
  if OldQr['GeolId'] <> Null then
    qr['GeolId'] := GetNewId('GeolIds', 'GeolId', OldQr['GeolId']);
  if OldQr['GBody'] <> Null then
    qr['GBody'] := GetNewId('GBodies', 'GBody', OldQr['GBody']);
end;



function OpenBDEQr(SQL: string; Q: TQuery): boolean;
begin
  q.Active := False;
  q.SQL.Clear;
  q.SQL.Add(SQL);
  q.Open;
  Result := q.RecordCount > 0;
end;



function ExecBDEQr(SQL: string; Q: TQuery): Integer;
begin
  q.Active := False;
  q.SQL.Clear;
  q.SQL.Add(SQL);
  q.ExecSQL;
  Result := q.RowsAffected;
end;

function InitMainAlias;
var
  i, j: integer;
  Exist: Boolean;

begin

  Aliases := TStringList.Create;
  AlParams := TStringList.Create;
  RHAAliases := TStringList.Create;
  Session.ConfigMode := [cfmPersistent];
  Session.GetAliasNames(Aliases);
  for i := 0 to Aliases.Count - 1 do
    if Aliases[i] = 'PetrosBase' then begin
      Exist := true;
      Alias := 'PetrosBase';
      break;
    end;
  if exist then begin
    AliasPath := GetAliasDir(Alias);
    ChangeAlias(Alias);
    Result := True;

   { try
      RHAAliases.LoadFromFile(MainPath + 'Petros.als');
    except
      on Exception do begin
        Application.MessageBox('File "Petros.als" not found. Created new file',
          '', MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
        RHAAliases.Add('PetrosBase');
        RHAAliases.SaveToFile(MainPath + 'Petros.als');
      end;
    end; }
  end else
    Result := False;


end;


procedure ChangeAlias(Alias: string);
begin
  DMOld.Database1.Connected := False;
  DMOld.Database1.AliasName := Alias;
  DMOld.Database1.Open;
end;

function GetAliasDir(Alias: string): string;
begin
  Session.GetAliasParams(Alias, AlParams);
  Result := Copy(AlParams[0], 6, Length(AlParams[0]) - 5) + '\';
end;


procedure TfDBConvert.FormShow(Sender: TObject);
begin
  DMOld := TDMOld.Create(Application);
  if not InitMainAlias then begin
    Application.MessageBox(PChar(stAliasNotFound),
      '', MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
    Button2.Enabled := False;

    Label3.Caption := 'alias "PetrosBase" not exists'
  end;
  if DMOld.Database1.Connected then begin
    DMOld.TabMain.Open;
    Label4.Caption := 'Data arrays count: ' + IntToStr(DMOld.TabMain.RecordCount);
    OpenBDEQr('Select Count(*) as c from RHADATA.DB ', DMOld.q1time);
    Label5.Caption := 'Analyzes count: ' + IntToStr(DMOld.q1time['c']);
  end else begin
    Label4.Caption := '';
    Label5.Caption := '';
  end;
  ItWas:=False;
end;

procedure TfDBConvert.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
  DMOld.Database1.Connected := False;
  FreeAndNil(DMOld);
  AlParams.Free;
  Aliases.Free;
  RHAAliases.Free;
  except
  end;
end;

procedure TfDBConvert.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then begin
    CheckBox2.Checked := True;
    CheckBox2.Enabled := True;
  end else
    CheckBox2.Enabled := False;
end;

procedure TfDBConvert.Button2Click(Sender: TObject);
type
  TQrProc = procedure(Qr: TADOQuery; OldQr: TQuery);
var OFName, NFName: string;
  id, IDm, IDA, Counter, i, k: integer;
  Step: real;
  V, VM, S: string;
  QFile1: TextFile;
  L: TstringList;

  procedure ImportNewData(TableName, MasterTable: string; KeyField, MasterField,
    MasterKeyField: string; IDName: string = 'ID'; qProc: TqrProc = nil; IdnotIdent: Boolean = False);
  begin
    OpenBDEQr('Select * from ' + TableName + '.DB', DMOld.qLongTime);
    Counter := 0;
   { try
    if IdnotIdent then
      ExecQr('Set IDENTITY_INSERT '+TableName+' ON',DM1.q1time); }
    if DMOld.qLongTime.RecordCount > 0 then begin
      Step := 100 / DMOld.qLongTime.RecordCount;
      DMOld.qLongTime.First;
      k := 0;
      Label2.Caption := 'Current object: ' + TableName;
      ProgressBar1.Position := 0;
      Application.ProcessMessages;
      while not DMOld.qLongTime.Eof do begin
        if KeyField <> 'XY' then begin
          if DMOld.qLongTime[KeyField] <> Null then
            V := DMOld.qLongTime[KeyField]
          else
            V := '';
        end;
        if MasterTable = '' then begin
          ID := GetID(TableName, KeyField, V, IDName);
          if id = 0 then begin
            Put1Field(TableName, IDName, IdnotIdent);
            if Assigned(qProc) then
              qProc(DM1.q2Time, DMOld.qLongTime);
            DM1.q2Time.Post;
            inc(Counter);
          end;
        end else begin
          if not OpenBDEQr('Select ' + MasterKeyField + ' from ' + MasterTable + '.DB where id=' +
            IntToStr(DMOld.qLongTime[MasterField]), DMOld.q1time) then begin
            ShowMessage('ID=' + IntToStr(DMOld.qLongTime[MasterField]) + ' referenced by ' + TableName + ' not found in '
              + MasterTable + ' in Petros 2 database');
            Abort;
          end;
          if TableName = 'FPoints' then
            openBDEQr('Select Name From Diagrams where ID=(Select DiagrID from Fields where Id=' +
              IntToStr(DMOld.qLongTime['FieldID']) + ')', DMOld.q2Time);
          if DMOld.q1time[MasterKeyField] <> Null then
            VM := DMOld.q1time[MasterKeyField]
          else
            VM := '';
          if TableName = 'FPoints' then begin
            IDM := GetID('Diagrams', 'Name', DMOld.q2Time['Name']);
            IDM := GetId2('Fields', 'DiagrID', 'Name1', VM, IDM, IDName);
          end else
            IDM := GetID(MasterTable, MasterKeyField, VM);
          if IDM = 0 then begin
            ShowMessage(MasterKeyField + '= ' + VM + ' not found in '
              + MasterTable + ' in Petros 3 database');
            Abort;
          end;
          if KeyField <> 'XY' then
            ID := GetId2(TableName, MasterField, KeyField, V, IDM, IDName)
          else if MasterField = 'FieldId' then
            ID := 0
          else
            ID := GetId2XY(TableName, MasterField, DMOld.qLongTime['X'], DMOld.qLongTime['Y'], IDM, IDName);
          if id = 0 then begin
            Put1Field(TableName, IDName, IdnotIdent);
            DM1.q2Time.FieldByName(MasterField).Value := IDM;
            if Assigned(qProc) then
              qProc(DM1.q2Time, DMOld.qLongTime);
            DM1.q2Time.Post;
            inc(Counter);
          end;
        end;
        inc(k);
        if Round(K * Step) - 1 > ProgressBar1.Position then begin
          ProgressBar1.Position := Round(K * Step);
          Application.ProcessMessages;
        end;
        DMOld.qLongTime.Next;
      end;
    end;
    if TableName = 'MainRHA' then
      ProgressBar2.StepBy(8)
    else if TableName = 'RHADATA' then
      ProgressBar2.StepBy(16)
    else
      ProgressBar2.StepBy(4);
    Memo1.Lines.Add(TableName + ':  ' + InttoStr(Counter) + ' new values');
    Application.ProcessMessages;
   { finally
    if IdnotIdent then
      ExecQr('Set IDENTITY_INSERT '+TableName+' OFF',DM1.q1time);
    end; }
  end;
begin
  Memo1.Lines.Clear;
  ItWas:=True;
  try
    if CheckBox1.Checked then begin
      WForm.Label1.Caption := 'Long time operation:Clearing of database';
      WForm.Show;
      Application.ProcessMessages;
      if CheckBox2.Checked then begin
        DM1.ADOConnection1.BeginTrans;
        DM1.prClearData.ExecProc;
        DM1.ADOConnection1.CommitTrans;
        WForm.Close;
      end else begin
        DM1.ADOConnection1.BeginTrans;
        DM1.prClearAll.ExecProc;
        DM1.ADOConnection1.CommitTrans;
        WForm.Close;

      end;
    end;
  except
    if DM1.ADOConnection1.InTransaction then
      DM1.ADOConnection1.RollbackTrans;
    if WForm.Visible then
      WForm.Close;
    exit;
  end;

  ImportNewData('GBodies', '', 'GBody', '', '');
  ImportNewData('GeolIDS', '', 'GeolID', '', '');
  ImportNewData('Rocks', '', 'Rock', '', '');
  ImportNewData('Regions', '', 'Region', '', '');

  ImportNewData('Source', '', 'Num', '', '');
  ImportNewData('MainRHA', 'Source', 'ArrayName', 'Source', 'Num');

  ImportNewData('ImpFields', '', 'DName', '', '');
  ImportNewData('Sinonims', 'ImpFields', 'Text', 'FieldId', 'DName');
   //ImportNewData('Dictionar', 'ImpFields', 'Word', 'FieldId', 'DName'); Descript - integer Don't convert/

  ImportNewData('Recalcs', '', 'Name', '', '', 'ID', nil, True);
  ImportNewData('Vars', 'Recalcs', 'Name', 'RecID', 'Name');

  ImportNewData('RHADATA', 'MainRHA', 'Sample', 'ArrID', 'ArrayName', 'AnId', AddAnal);
  ExecQr('Update  mainRHA set Alfa=0,NAnal=(Select Count(*) from Rhadata where' +
  ' ArrId=mainRHA.id), maxnum=isNull((select max(IsNull(Num,0)) from Rhadata where' +
    ' ArrId=mainRHA.id),0)', DM1.q1Time);
  ExecQr('update RHADATA set Alfa=0,ArrNum=(Select (Convert(VarChar(50),Num)) from Source ' +
    'where Id=(Select Source from MainRHA where id=ArrId))', DM1.q1Time);
  ExecQr('update RHADATA set ArrNum=Substring(''     '',1,5-Len(ArrNum))+ArrNum+''-''+Convert(varchar(10),ArrID)', DM1.q1Time);
  if CheckBox1.Checked and not CheckBox2.Checked then begin
    ImportNewData('Diagrams', '', 'Name', '', '');
    ImportNewData('Intervals', 'Diagrams', 'XY', 'DiagId', 'Name');
    ImportNewData('Points', 'Diagrams', 'XY', 'DiagId', 'Name');
    ImportNewData('Fields', 'Diagrams', 'Name1', 'DiagrId', 'Name');

    ImportNewData('FPoints', 'Fields', 'XY', 'FieldId', 'Name1');

    ImportNewData('Lines', 'Diagrams', 'Name1', 'DiagId', 'Name');
    ImportNewData('LPoints', 'Lines', 'XY', 'LineId', 'Name1');
  end;
   //---------------ListData
  OpenBDEQr('Select * from ListData.DB', DMOld.qLongTime);
  Counter := 0;
  if DMOld.qLongTime.RecordCount > 0 then begin
    Step := 100 / DMOld.qLongTime.RecordCount;
    DMOld.qLongTime.First;
    k := 0;
    Label2.Caption := 'Current object: ListData';
    ProgressBar1.Position := 0;
    Application.ProcessMessages;
    while not DMOld.qLongTime.Eof do begin
      if (DMOld.qLongTime['List'] <> Null) and OpenBDEQr('Select Name from Lists.DB where id=' +
        IntToStr(DMOld.qLongTime['List']), DMOld.q1time) then begin

        if DMOld.q1time['Name'] <> Null then
          VM := DMOld.q1time['Name']
        else
          VM := '';
        IDM := GetID('Lists', 'Name', VM);
        if IDM > 0 then begin
          IDA := 0;
          if OpenBDEQr('Select (Select ArrayName from MainRHA.DB  where id=ArrId) as ArrayName,Sample from RHADATA.DB r where Anid=' +
            IntToStr(DMOld.qLongTime['Anal']), DMOld.q1time) and not VarIsNull(DMOld.q1time['Sample']) then begin
            if OpenQr('Select AnId  from  RHADATA  where Sample=''' + DMOld.q1time['Sample'] +
              ''' and ArrId =(Select id  from MainRHA  where ArrayName=''' + DMOld.q1time['ArrayName'] + ''')', DM1.q1Time) then
              IDA := DM1.q1Time['AnId'];
          end;
          if IDA > 0 then begin

            if not Openqr('Select * from ListData where List=' + IntToStr(IDM) + ' and Anal=' +
              IntToStr(IDA), DM1.q2Time) then begin
              DM1.q2Time.Insert;
              DM1.q2Time['List'] := IDM;
              DM1.q2Time['Anal'] := IDA;
              DM1.q2Time.Post;
              inc(Counter);
            end;
          end;
        end;
      end;
      inc(k);
      if Round(K * Step) - 1 > ProgressBar1.Position then begin
        ProgressBar1.Position := Round(K * Step);
        Application.ProcessMessages;
      end;
      DMOld.qLongTime.Next;
    end;
  end;
  ProgressBar2.StepBy(4);
  Memo1.Lines.Add('ListData:  ' + InttoStr(Counter) + ' new values');
  Application.ProcessMessages;
  //--------------- end   ListData

  //-----------------Classif
  OpenBDEQr('Select * from Classif.DB', DMOld.qLongTime);
  Counter := 0;
  if DMOld.qLongTime.RecordCount > 0 then begin
    Step := 100 / DMOld.qLongTime.RecordCount;
    DMOld.qLongTime.First;
    k := 0;
    Label2.Caption := 'Current object: Classif';
    ProgressBar1.Position := 0;
    Application.ProcessMessages;
    while not DMOld.qLongTime.Eof do begin
      if OpenBDEQr('Select Name from Diagrams.DB where id=' +
        IntToStr(DMOld.qLongTime['Diagr']), DMOld.q1time) then begin
        if DMOld.q1time['Name'] <> Null then
          VM := DMOld.q1time['Name']
        else
          VM := '';
        IDM := GetID('Diagrams', 'Name', VM);
        if IDM > 0 then begin
          IDA := 0;
          if OpenBDEQr('Select (Select ArrayName from MainRHA.DB  where id=r.ArrId) as ArrayName,Sample from RHADATA.DB r where Anid=' +
            IntToStr(DMOld.qLongTime['Anal']), DMOld.q1time) and not VarIsNull(DMOld.q1time['Sample']) then begin
            if OpenQr('Select AnId  from  RHADATA  where Sample=''' + DMOld.q1time['Sample'] +
              ''' and ArrId =(Select id  from MainRHA  where ArrayName=''' + DMOld.q1time['ArrayName'] + ''')', DM1.q1Time) then
              IDA := DM1.q1Time['AnId'];
          end;
          if IDA > 0 then begin
            if not Openqr('Select * from Diagrams where Diagr=' + IntToStr(IDM) + ' and Anal=' +
              IntToStr(IDA), DM1.q2Time) then begin
              DM1.q2Time.Insert;
              DM1.q2Time['Diagr'] := IDM;
              DM1.q2Time['Anal'] := IDA;
              DM1.q2Time['Class'] := DMOld.qLongTime['Class'];
              DM1.q2Time.Post;
              inc(Counter);
            end;
          end;
        end;
      end;
      inc(k);
      if Round(K * Step) - 1 > ProgressBar1.Position then begin
        ProgressBar1.Position := Round(K * Step);
        Application.ProcessMessages;
      end;
      DMOld.qLongTime.Next;
    end;
  end;
  ProgressBar2.StepBy(4);
  Memo1.Lines.Add('Classif:  ' + InttoStr(Counter) + ' new values');
  Application.ProcessMessages;
  //------ end Classif

  OFName := AliasPath + 'Diagrams.txt';
  NFName := MainPath + 'Diagrams.txt';
  CopyFile(PChar(OFName), PChar(NFName), False);
  OFName := AliasPath + 'Petros.rcl';
  NFName := MainPath + 'Petros.rcl';
  CopyFile(PChar(OFName), PChar(NFName), False);

  L := TStringList.Create;
  L.LoadFromFile(AliasPath + 'Queries.ptr');
  for i := 0 to L.Count - 1 do begin
    L[i] := ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(ReplaceSymbol(L[i], '= "', '= ''')
      , '.DB', ''), '")', ''')'), '%"', '%'''), 'LIKE "', 'LIKE ''');
    L[i] := ReplaceSymbol(ReplaceSymbol(L[i], '"', ''), 'rhadata.*', '*');
    L[i] := ReplaceSymbol(L[i], 'ORDER BY rhadata.Sample', 'ORDER BY rhadata.ArrNum, rhadata.num');
    ID := Pos('ArrId =', L[i]);
    if ID > 0 then begin
      S := L[i];
      L[i] := '';
      while id > 0 do begin
        L[i] := L[i] + Copy(S, 1, ID + 7);
        Delete(S, 1, ID + 7);
        IDM := Pos(')', S);
        try
          k := StrToInt(Copy(S, 1, IDM - 1));
          k := GetNewID('MainRHA', 'ArrayName', K);
          L[i] := L[i] + IntToStr(K) + Copy(S, IDM, 1000);
          Delete(S, 1, IDM);
        except
          id := 0;
          continue;
        end;
        ID := Pos('ArrId =', S);
      end;
      L[i] := L[i] + S;
    end;
  end;
  L.SaveToFile(MainPath + 'Queries.ptr');
  L.Free;
  ShowMessage('Operation complete');
  ModalResult := mrOK;
 // DM1.DataBaseChange;
end;

procedure TfDBConvert.Button3Click(Sender: TObject);
var i, N: integer;
begin
  ProgressBar1.Position := 0;
  ProgressBar2.Position := 0;
  i := 0;
  openQr('Select AnID,R from RHAData', DM1.qLongTime1);
  N := DM1.qLongTime1.RecordCount div 100;
  while not DM1.qLongTime1.Eof do begin
    DM1.qLongTime1.Edit;
    DM1.qLongTime1['R'] := ConvertRang(DM1.qLongTime1.FieldByName('R').AsString, 5);
    DM1.qLongTime1.Post;
    inc(i);
    if i >= n then begin
      ProgressBar1.Position := ProgressBar1.Position + 1;
      i := 1;
      Application.ProcessMessages;
    end;
    DM1.qLongTime1.Next;
  end;

end;

end.

