unit Registrat;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, xRegistr, Clipbrd, Dialogs, ExtCtrls, registry,
  JCLSysInfo;

type
  TRegistrForm = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    RegName: TxRegistry;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure PasswordChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TREGData = record
    Days: Byte;
    FirstDay: LongInt;
    PRID: Longword;
    IsRegistered: boolean;
    RKey: string[20];
    TwoTimes: Boolean;
  end;

var
  RegistrForm: TRegistrForm;
  PID: string;
  RKey: string;
  RegD: TREGData;
  Reg1: TRegistry;

resourcestring
  stNoName = 'Indefinite user name. Registration impossible. Reinstall PETROS, please';
  stInvKey = 'Invalid registration key!';
  stReinst = 'Important information in system files is corrupted.' +
    ' You have to reinstall PETROS.';

procedure DoReg;
function ReadRI(Reg: TRegistry): Boolean;
function dayof: boolean;

implementation

uses RHAGlobs;

{$R *.DFM}

procedure TRegistrForm.FormCreate(Sender: TObject);
var i, M, j: integer;
  R: Longword;
  S: string;
begin
  Edit1.Text := RegName.ReadString;
  if Edit1.Text = '' then begin
    ShowMessage(stNoName);
    Edit2.Text := '';
    Exit;
  end;
  R := 0;
  S := Edit1.Text;
  M := Length(S);
  if M > 7 then
    m := 7;
  j := 1;
  for i := 1 to M do begin
    R := R + Byte(S[i]) * j;
    J := J * 9;
  end;
  S := GetVolumeSerialNumber('C');
  M := Length(S);
  if M > 7 then
    m := 7;
  j := 1;
  for i := 1 to M do begin
    R := R + Byte(S[i]) * j;
    J := J * 9;
  end;
  PID := IntToStr(R);
  Edit2.Text := PID;
  RegD.PRID := R;
  Reg1 := TRegistry.Create;
  Reg1.RootKey := HKEY_LOCAL_MACHINE;
  Reg1.OpenKey('\Software\CLASSES\CLSID\' + PCLSID + '\Info', False);
  Reg1.WriteBinaryData('DATA', RegD, SizeOf(TRegData));
end;

procedure TRegistrForm.OKBtnClick(Sender: TObject);
begin
  Application.ProcessMessages;
  if Edit1.Text = '' then begin
    Close;
    Exit;
  end;
  if (PID = RKEY) and (RegD.TwoTimes) then begin
    RegD.TwoTimes := False;
    Reg1.WriteBinaryData('DATA', RegD, SizeOf(TRegData));
    ShowMessage('Спасибо! До полной регистрации программы осталось ' +
      IntToStr(DaysForExp - DayFromFirst) + ' дней');
    DayOff := False;
    Close;
    Exit;
  end;
  Timer1.Enabled := True;
end;

procedure TRegistrForm.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TRegistrForm.PasswordChange(Sender: TObject);
begin
  RKey := Password.Text;
end;

procedure TRegistrForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Application.ProcessMessages;
  if RK(Pid, RKey) then begin
    Registered := True;
    DoReg;
    Close;
  end else
    ShowMessage(stInvKey);
end;

procedure DoReg;
begin
  RegD.IsRegistered := True;
  REGD.RKey := RKEY;
  DayOff := False;
  Reg1.WriteBinaryData('DATA', RegD, SizeOf(TRegData));
end;

function ReadRI(Reg: TRegistry): Boolean;
begin
  if protect then begin
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Result := Reg.OpenKey('\Software\CLASSES\CLSID\' + PCLSID + '\Info', False);
    if Result then begin
      if Reg.ValueExists('RWord') and not Reg.ValueExists('Data') then begin
        with REGD do begin
          IsRegistered := Registered;
          Days := DaysForExp;
          PrID := 9708642;
          FirstDay := Trunc(Date);
          RKey := 'DACGHFRYE68';
          TwoTimes := False;
        //(Reg.ReadInteger('RWORD') = 1);
        end;
        Reg.WriteBinaryData('DATA', RegD, SizeOf(TRegData));
        Reg.DeleteValue('RWord');
      end else begin
        if Reg.ValueExists('RWord') then
          Reg.DeleteValue('RWord');
        if Reg.ValueExists('Data') then begin
          Reg.ReadBinaryData('DATA', RegD, SizeOf(TRegData));
          Registered := REGD.IsRegistered;
          RegD.TwoTimes := False;
          DayOFF := DayOF;
        end else begin
          ShowMessage(stReinst);
          Exit;
        end;
      end;
    end else begin
      ShowMessage(stReinst);
    end;
    Reg.CloseKey;
  end else result := True;
end;


function dayof: boolean;
begin
  DayFromFirst := Trunc(Date) - RegD.FirstDay;
  Result := DayFromFirst > RegD.Days;
  if RegD.TwoTimes and (DayFromFirst > 30) then
    Result := True;
end;

procedure TRegistrForm.FormDestroy(Sender: TObject);
begin
  Reg1.CloseKey;
  Reg1.Free;
end;

procedure TRegistrForm.BitBtn1Click(Sender: TObject);
begin
  Application.HelpContext(CurHelpContext);
end;

procedure TRegistrForm.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

end.

