unit AnData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DMod1, StdCtrls, Grids, DBGrids, DBCtrls, Buttons, Analise, ExtCtrls,
  Chemist, ESBRtns, RHAGlobs, EdCoefs, Math, DB, Hintctrl, Variants,
  ADOUtilsS, ComCtrls;

type
  TAnalForm = class(TForm)
    Rang: TStaticText;
    Label1: TLabel;
    Sg1: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SG2: TStringGrid;
    SG3: TStringGrid;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    SG4: TStringGrid;
    ArrName: THLabel;
    Label14: THLabel;
    HLabel1: THLabel;
    HLabel2: THLabel;
    HLabel3: THLabel;
    HLabel4: THLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    SaveDialog1: TSaveDialog;
    Memo1: TRichEdit;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ID: integer;
  end;

var
  AnalForm: TAnalForm;
  Cur: TAnalis;
  AnalisTitl: TAnalisTitle;

implementation

uses Koeff;

{$R *.DFM}

procedure TAnalForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TAnalForm.FormCreate(Sender: TObject);
begin
  Cur := nil;
  AnalisTitl := nil;
  ID := CurID;
end;

procedure TAnalForm.FormActivate(Sender: TObject);
var i, J, W: integer;
  Text, S, TitleS, Cap: string;
  Sum: real;
const Emp20='                    ';
begin
  CurHelpContext := HelpContext;
  if Id > 0 then begin
    Cur.Free;
    if not DM1.GetFullAnal(Id) then
      Close;
    Cap := '';
    if DM1.qAnal.FieldByName('Alfa').AsInteger=0 then
    with SG1 do begin
      ColCount := Coefs.Count;
      j := 0;
      for i := 0 to Coefs.Count - 1 do begin
        if TStKoef(Coefs.Items[i]).Ident[Length(TStKoef(Coefs.Items[i]).Ident)]
          <> '_' then begin
          W := Max(Length(TStKoef(Coefs.Items[i]).DFormat) + 1,
            Length(TStKoef(Coefs.Items[i]).Title) + 1);
          Cap := Cap + PadLeftStr(TStKoef(Coefs.Items[i]).Title, W);
          ColWidths[j] := W * Sg1.Canvas.TextWidth('s');
          Cells[j, 0] := TStKoef(Coefs.Items[i]).Title;
          AnW := TStKoef(Coefs.Items[i]).AnW;
          try
            Cells[j, 1] := FormatFloat(TStKoef(Coefs.Items[i]).DFormat,
              Interprete(TStKoef(Coefs.Items[i]).Formula, DM1.qAnal));
          except
            on Exception do begin
              ShowMessage('Ошибка в формуле для расчета '
                + TStKoef(Coefs.Items[i]).Name);
              Cells[j, 1] := '****';
            end;
          end;
          inc(J);
        end;
      end;
      ColCount := j;
    end;
    OpenQr('Select * From MainRHA where Id=' + IntToStr(DM1.qAnal['ArrID']), DM1.q1Time);

    ArrName.Caption := DM1.q1Time['ArrayName'];
    Text := DM1.q1Time['Title1'];
    AnalisTitl.Free;
    AnalisTitl := TAnalisTitle.Create(Text, DM1.q1Time['Type'] = 'nc');
            {Cur:=TAnalis.CreateT(DM1.qAnal,DM1.q1Time);}
    S := '';
    with Sg2 do begin
      ColCount := AnalisTitl.Count + 1;
      Sum := 0;
      for I := 0 to AnalisTitl.Count - 1 do begin
        Cells[i, 0] := TFormula(AnalisTitl[I]).Symbol;
        if DM1.qAnal['N' + IntToStr(I + 1)] <> null then begin
          Sum := Sum + DM1.qAnal['N' + IntToStr(I + 1)];
          Cells[i, 1] := FloatToStrF(DM1.qAnal['N' + IntToStr(I + 1)], ffFixed, 6, 3);
        end;
        ColWidths[i] := Canvas.TextWidth('S') * 7;
        S := S + PadLeftStr(Cells[i, 0] + ' ', 6);
      end;
      Cells[AnalisTitl.Count, 0] := 'Sum';
      Cells[AnalisTitl.Count, 1] := FloatToStrF(Sum, ffFixed, 7, 3);
    end;
    if DM1.qAnal['Eq'] <> Null then
      Rang.Caption := MakeRStr(DM1.qAnal['R'], DM1.qAnal['Eq'])
    else Rang.Caption := MakeRStr(DM1.qAnal['R'], ' ');

    TitleS := '';
    j := 0;

    with SG3 do begin
      if DM1.qAnal['Alfa'] = 0 then
        ColCount := 94
      else
        ColCount := MendCount;
      for i := 1 to MendCount do
        if DM1.qAnal['A' + IntToStr(i)] > 0 then begin
          Cells[j, 0] := '  ' + MendTab.GetFieldTitle(i);
          Cells[j, 1] := FloatToStrF
            (DM1.qAnal['A' + IntToStr(I)], ffFixed, 6, 4);
          ColWidths[j] := Canvas.TextWidth('S') * 7;
          Inc(j);
          TitleS := TitleS + PadLeftStr(MendTab.GetFieldTitle(i) + '   ', 7);
        end;
      ColCount := j;
    end;


    if VarIsNull(DM1.q1Time['MaxHA']) then
      Label21.Caption := '?'
    else
      Label21.Caption := IntToStr(DM1.q1Time['MaxHA']);

    if VarIsNull(DM1.qAnal['H']) then
      Label11.Caption := '?'
    else
      Label11.Caption := FormatFloat(EnFormat,DM1.qAnal['H']);
    if VarIsNull(DM1.qAnal['A']) then
      Label12.Caption := '?'
    else
      Label12.Caption := FloatToStrF(DM1.qAnal['A'], ffFixed, 6, 3);
    if VarIsNull(DM1.qAnal['T']) then
      Label22.Caption := '?'
    else
      Label22.Caption := FloatToStrF(DM1.qAnal['T'], ffFixed, 6, 3);

    if VarIsNull(DM1.qAnal['E']) then
      Label29.Caption := '?'
    else
      Label29.Caption := FloatToStrF(DM1.qAnal['E'], ffFixed, 6, 3);
    if VarIsNull(DM1.qAnal['Tn']) then
      Label25.Caption := '?'
    else
      Label25.Caption := FloatToStrF(DM1.qAnal['Tn'], ffFixed, 6, 3);
    if VarIsNull(DM1.qAnal['An']) then
      Label13.Caption := '?'
    else
      Label13.Caption := FloatToStrF(DM1.qAnal['An'], ffFixed, 6, 3);
    Label14.Caption := DM1.qAnal['Descript'];
    HLabel1.Caption := DM1.qAnal['GeolIDVal'];
    HLabel2.Caption := DM1.qAnal['RockVal'];
    HLabel3.Caption := DM1.qAnal['RegionVal'];
    HLabel4.Caption := DM1.qAnal['GBodyVal'];
    if DM1.qAnal['Sample'] <> null then
      Label15.Caption := DM1.qAnal['Sample']
    else
      Label15.Caption := ' - ';
    OpenQr('Select *,(Select isNull(Name,''?'') from Diagrams where id=c.Diagr) as DName from Classif c where Anal=' + IntToStr(DM1.qAnal['AnId']), DM1.q1Time);
    i := 0;
    while not DM1.q1Time.EOF do begin
      Inc(I);
      SG4.ColCount := i;

      SG4.Cells[i - 1, 0] := DM1.q1Time['DName'];

      SG4.Cells[i - 1, 1] := DM1.q1Time['Class'];
      DM1.q1Time.Next;
    end;
  end;
  with Memo1 do begin
    Lines.Clear;
    Lines.Add('');
    Lines.Add('  Data set: ' + ArrName.Caption);
    Lines.Add('  Sample: ' + Label14.Caption);
    Lines.Add('  Sample ID: ' + Label15.Caption+';   Alphabet '+IntToStr(DM1.qAnal.FieldByName('Alfa').AsInteger));
    S := '  ';
    if GID in UsedFields then
      S := S + GeolIdTit + ': ' + HLabel1.Caption + ';  ';
    if ROC in UsedFields then
      S := S + RockTit + ': ' + HLabel2.Caption + ';  ';
    if RGN in UsedFields then
      S := S + RegionTit + ': ' + HLabel3.Caption + ';  ';
    if GBD in UsedFields then
      S := S + GBodyTit + ': ' + HLabel4.Caption;
    Lines.Add(S);
    if OpenQr('Select Convert(varchar(6),Num) +IsNull('', ''+Author,'''')+ISNull('', ''+Title,'''')as S from Source where ID='
      + intToStr(DM1.qAnal['Source']), DM1.q1Time) then begin
      S := '  '+DM1.q1Time.FieldByName('S').AsString;
      Lines.Add('');
      Lines.Add('    Bibliography');
      Lines.Add(S);
    end;
    Lines.Add('');
    Lines.Add('    Rank formula');
    Lines.Add('  '+Rang.Caption);
    S := '  RHA elem.number: ' + Label21.Caption + ';  En=' +  FormatFloat('###'+EnFormat, DM1.qAnal.FieldByName('E').AsFloat)
     + '; E=' +Label11.Caption + ';  An=' + Label13.Caption +
      ';  A=' + Label12.Caption + ';  T=' + FormatFloat('###'+EnFormat, DM1.qAnal.FieldByName('T').AsFloat)
      + ';  Tn=' + FormatFloat('###'+EnFormat, DM1.qAnal.FieldByName('Tn').AsFloat);
    Lines.Add(S);
    Lines.Add('');
    S:='   Analitical data         At% of elem.      Standard coeff.     Classification results';
    Lines.Add(S);
    W:=SG1.ColCount;
    if W<SG2.ColCount then
      W:=SG2.ColCount;
    if W<SG3.ColCount then
      W:=SG3.ColCount;
    if W<SG4.ColCount then
      W:=SG4.ColCount;
    for i:=0 to W-1 do begin
      if i<SG2.ColCount then
        S:=PadLeftStr(Sg2.Cells[i,0],9)+PadLeftStr(Sg2.Cells[i,1],8) +'   '
      else
        S:=Emp20;
       if i<SG3.ColCount then
        S:=S+PadLeftStr(Sg3.Cells[i,0],9)+PadLeftStr(Sg3.Cells[i,1],8) +'   '
      else
        S:=S+Emp20;
      if i<SG1.ColCount then
        S:=S+PadLeftStr(Sg1.Cells[i,0],9)+PadLeftStr(Sg1.Cells[i,1],10)+' '
      else
        S:=S+Emp20;
      if i<SG4.ColCount then
        S:=S+' '+PadLeftStr(Sg4.Cells[i,0],20)+PadLeftStr(Sg4.Cells[i,1],10);
       Lines.Add(S);
    end;
  end;
  Memo1.Align:=alClient;
end;



procedure TAnalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAnalForm.BitBtn2Click(Sender: TObject);
begin
      Memo1.Print(Caption);
end;

procedure TAnalForm.BitBtn3Click(Sender: TObject);
begin
     if SaveDialog1.Execute then begin
        Memo1.Lines.SaveToFile(SaveDialog1.FileName);
     end;
end;

end.

