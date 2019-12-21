unit RHAExcel;

interface

uses Windows, SysUtils, Dialogs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, OkCancl1, Excels;

type
  TExcForm = class(TOKBottomDlg)
    Excel: TExcel;
    RDis: TRadioGroup;
    RAn: TRadioGroup;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ExcIsOpen: boolean;
    procedure ExcelOpen(Sender: TObject);
    procedure ExcelClose(Sender: TObject);
    function GetSelection(var Row, Col, RowEnd, ColEnd: integer): boolean;
    procedure Connect;
  end;

var
  ExcForm: TExcForm;
  Vert, Discr: integer;
  Geo, HaveID: Boolean;
resourcestring
  stLoad = ' is loaded';
  stError = 'Error';
  stClosed = ' is closed';
  stNotTable = 'Where is no loaded table in EXCEL!';
  stDiap = 'Incorrectly selected cells in EXCEL!';

implementation

{$R *.DFM}

procedure TExcForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpFile := 'RHA.HLP';
  Application.HelpCommand(HELP_CONTEXT, 190);
end;


procedure TExcForm.ExcelOpen(Sender: TObject);
  {var
      MacroFile : TFileName;  }
begin
  {cmTable  .Enabled := True;
  cmCommand.Enabled := True;
  cmRequest.Enabled := True;
  cmGetData.Enabled := True;
  cmBook   .Enabled := True;
  MacroFile := ExtractFilePath(ParamStr(0))+'Excel.xls';
  if FileExists(Macrofile) then
  begin
    Excel.OpenMacroFile(MacroFile, True);
    cmRun.Enabled := True;
  end;}
  ShowMessage('Excel' + stLoad);
  ExcIsOpen := true;
end;

procedure TExcForm.ExcelClose(Sender: TObject);
begin
  {cmTable  .Enabled := False;
  cmCommand.Enabled := False;
  cmRequest.Enabled := False;
  cmGetData.Enabled := False;
  cmBook   .Enabled := False;
  cmRun    .Enabled := False;}
  ExcIsOpen := false;
  ShowMessage('Excel' + stClosed);
end;

function TExcForm.GetSelection(var Row, Col, RowEnd, ColEnd: integer): boolean;
var
  i, J: Integer;
  Reply, r, Num: string;
  Bad: boolean;
  function GetNum(var j: integer): integer;
  begin
    Num := '';
    repeat
      Num := Num + Reply[j];
      inc(j);
    until (j > Length(Reply)) or (Char(Reply[j]) in ['R', 'C', ':']);
    try
      Result := StrToInt(Num);
    except
      on EXception do Bad := true;
    end;
  end;
begin
  Reply := Excel.Request('Selection');
  bad := false;
  i := Pos('!', Reply);
  if i = 0 then begin
    Application.MessageBox(PChar(stNotTable), PChar(stError),
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
    Result := False;
    exit;
  end;
  reply := Copy(Reply, i + 1, Length(Reply) - 1);
  {Edit1.Text:=Reply;}

  if Reply[1] = 'R' then begin
    j := 2;
    Row := GetNum(j);
    if Reply[j] = 'C' then begin
      inc(j);
      Col := GetNum(j);
      inc(j);
      if Length(Reply) < j - 1 then begin
        RowEnd := Row;
        ColEnd := Col;
      end else begin
        if Reply[j] = 'R' then begin
          inc(j);
          RowEnd := GetNum(j);
          if Reply[j] = 'C' then begin
            inc(j);
            ColEnd := GetNum(j);
          end else bad := true;
        end else bad := true;
      end
    end else bad := true;
  end else bad := true;
  if bad then begin
    Application.MessageBox(
      PChar(stDiap),
      PChar(stError), MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
    Result := False;
    EXIT;
  end else Result := True; ;
end;


procedure TExcForm.Connect;
begin
  if not Excel.Connected then begin
    {Timer1.Enabled := True;}
    Screen.Cursor := crHourGlass;
    try
  {Timer1.Enabled := False;}
      Excel.OnOpen := ExcelOpen;
      Excel.OnClose := ExcelClose;
      Excel.Connect; { Same as Excel.Connected := True; }
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TExcForm.FormCreate(Sender: TObject);
begin
  inherited;
  ExcIsOpen := false;
  vert := 0;
  Discr := 0;
end;

procedure TExcForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Vert := RAn.ItemIndex;
  Discr := RDis.ItemIndex;
  Geo := CheckBox1.Checked;
  HaveID := CheckBox2.Checked;
end;

procedure TExcForm.FormShow(Sender: TObject);
begin
  inherited;
  RAn.ItemIndex := Vert;
  RDis.ItemIndex := Discr;
end;

end.

