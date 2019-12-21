unit ImportAn;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, Db, ADODB, RHAGlobs, StrUtils,
  DMod1,
  {RHAExcel, } ComCtrls;

type
  TImportDialog = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    RadioGroup2: TRadioGroup;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    Label2: TLabel;
    PB1: TProgressBar;
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    valid: boolean;
  end;

var
  ImportDialog: TImportDialog;
  ImportType: integer;
  DescrLen: integer;
  CharType: integer;
  DeletedAn: integer;
resourcestring
  stFileError = 'Read error in file ';
  stLengthError = 'Incorrect lenghth of description!';

function ImportAnalise(FileName: string): boolean;

implementation

uses NewArr, Analise, Chemist, wait, ADOUtilsS;

{$R *.DFM}

function ImportAnalise(FileName: string): boolean;
var
  F: Text;
  i, j, k, JBeg, JEnd: integer;
  FName, Descr, S: string;
  Ch: Char;
  R: real;
  GGG: extended;
  CType: integer;
  Row, Col, RowEnd, ColEnd, NRow, NCol: Integer;
  RR: TStringList;
  Bad: boolean;
  Accepted: array[1..1024] of Boolean;
begin
  Result := false;
  if importType = 3 then begin

  end else begin
    if FileName = '' then begin
      if ImportDialog.OpenDialog1.Execute then
        FName := ImportDialog.OpenDialog1.FileName
      else exit;
    end else FName := FileName;
    try
      Assign(F, FName);
      Reset(F);
      K := 1;
      DeletedAn := 0;
      OpenQr('Select * From RHADATA where ArrID='+IntToStr(DM1.TabM1['Id']),DM1.TabD1);
      while not EOF(F) do begin
        DM1.TabD1.Insert;
        DM1.TabD1['Num'] := k;
        DM1.TabD1['ArrID']:=DM1.TabM1['Id'];
        DM1.TabD1['Descript'] := intToStr(K)
          + '-'
          + DM1.TabM1['ArrayName'] + ', ';
        DM1.TabD1['Sample'] := IntToStr(DM1.TabM1['Id']) + '-' + IntToStr(k);
        inc(K);
        if ImportType = 2 then begin
          S := '';
          for i := 1 to DescrLen do begin
            Read(F, Ch);
            S := S + Ch;
          end;
          Descr := S;
          if CharType = 0 then OemToChar(PChar(S), PChar(Descr));
          DM1.TabD1['Descript'] :=
            DM1.TabD1['Descript'] + Descr;
        end;
        for i := 1 to AnalisTitle.Count do begin
          Read(F, R);
          {s := FloatToStrF(R, ffFixed, 4, 6);}
          DM1.TabD1['N' + IntToStr(i)] := R /
            TFormula(AnalisTitle[i - 1]).Delit;
        end;
        if ImportType = 1 then begin
          Readln(F, S);
          Descr := S;
          if CharType = 0 then OemToChar(PChar(S), PChar(Descr));
          DM1.TabD1['Descript'] :=
            DM1.TabD1['Descript'] + Descr;
        end else Readln(F);
        try
          DM1.TabD1.Post;
        except
          on EAbort do begin
            DM1.TabD1.Cancel;
            Result := true;
          end;
        end;
      end;
      if DeletedAn < k - 1 then begin
        Result := True;
        {DM1.TabD1.ApplyUpdates;
      DM1.TabD1.CommitUpdates; }
      end else begin
        ShowMessage(stNotAnal);
        Result := false;
        DM1.TabD1.CancelUpdates;
      end;
      CloseFile(F);
    except
      on EInOutError do begin
        ShowMessage(stFileError + FName);
{$I-}
        CloseFile(F);
        i := IOResult;
{$I+}
      end else
      CloseFile(F);
    end;
  end;
  ChangedTitle := false;
  DM1.TabD1.Active:=False;
end;

procedure TImportDialog.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 2 then Edit1.Enabled := true
  else Edit1.Enabled := false;
  if (RadioGroup1.ItemIndex = 0) or (RadioGroup1.ItemIndex = 4) or
    (RadioGroup1.ItemIndex = 3) or (RadioGroup1.ItemIndex = 5)
    then RadioGroup2.Enabled := false
  else RadioGroup2.Enabled := true;
end;

procedure TImportDialog.BitBtn1Click(Sender: TObject);
begin
  Valid := true;
  ImportType := RadioGroup1.ItemIndex;
  CharType := RadioGroup2.ItemIndex;
  {if importType = 5 then begin
      AccForm:=TAccForm.Create(Application);
      try
     AccForm.ShowModal;
     finally
     AccForm.Free;
     end;
  end; }
  if ImportType = 2 then begin
    try
      DescrLen := StrToInt(Edit1.Text);
    except
      on EConvertError do begin
        Valid := false;
        ShowMessage(stLengthError);
        Edit1.SetFocus;
      end;
    end;
  end;
end;

procedure TImportDialog.BitBtn2Click(Sender: TObject);
begin
  Valid := True;
end;

procedure TImportDialog.FormCreate(Sender: TObject);
begin
  Valid := True;
end;

procedure TImportDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := Valid;
end;


procedure TImportDialog.BitBtn3Click(Sender: TObject);
begin
  Application.HelpFile := 'PETROS.HLP';
  Application.HelpCommand(HELP_CONTEXT, 110);
end;

procedure TImportDialog.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.

