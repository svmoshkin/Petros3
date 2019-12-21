unit VesProc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, Grids, DBGrids, RHAGlobs, Chemist,DMod1,
  ESBRtns, Qrctrls, quickrpt, ExtCtrls;

type
  TVesForm = class(TForm)
    Sg1: TDBGrid;
    BitBtn1: TBitBtn;
    DataSource2: TDataSource;
    QR: TQuickRep;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRTitle: TQRLabel;
    QRCTitle: TQRLabel;
    QRLabel2: TQRLabel;
    QRt1: TQRDBText;
    QRDBText1: TQRDBText;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn2: TBitBtn;
    SaveDialog1: TSaveDialog;
    BitBtn4: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Table2CalcFields(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Sg1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TitleS : string;
    Pres : array[1..MendCount] of boolean;
    AnW : boolean;
    Atomn: boolean;
    Quer: TQuery;
  end;

var
  VesForm: TVesForm;

implementation
{#ToDo1 Restore}
{uses AnData;}

{$R *.DFM}

procedure TVesForm.BitBtn1Click(Sender: TObject);
begin
     Close;
end;


procedure TVesForm.FormCreate(Sender: TObject);
begin
     Quer:=SelQuery;
     Qr.Visible:=false;
end;

procedure TVesForm.FormShow(Sender: TObject);
Var j,i,Col : integer;
begin
     DataSource2.DataSet:=Quer;
     for i:=1 to MendCount do
         Pres[i]:=false;
     TitleS:='';
      Try
       with Quer do begin
            DisableControls;
            first;
            While not EOF do begin
                  for i:=1 to MendCount do
                      if not Pres[i] then
                      if (Quer['A'+IntToStr(i)]>0)and((i>1)or not AnW) then
                         Pres[i]:=true;
                      next;
            end;
            first;
       end;
       Col:=0;
      with Sg1 Do begin
           Visible:=false;
          Columns.Clear;
          Columns.Add;
          Columns.Items[0].Title.Caption:='N';
          Columns.Items[0].FieldName:='N';
           Columns.Items[0].Width:=24;
             for j:=1 to MendCount do begin
                 i:=MendTab.Order[j];
                 if (Pres[i])and((i<>8)or Atomn) then begin
                    Columns.Add;
                    Inc(Col);
                    Columns.Items[Col].FieldName:='V'+IntToStr(i);
                    if atomn then
                       Columns.Items[Col].Title.Caption:='   '+MendTab.GetSymbol(i)
                    else
                    Columns.Items[Col].Title.Caption:=' '+MendTab.GetPetroSym(i);
                    Columns.Items[Col].Width:=48;
                    if atomn then
                       TitleS:=TitleS+PadLeftStr (MendTab.GetSymbol(i)+'  ', 7)
                    else
                    TitleS:=TitleS+PadLeftStr (MendTab.GetPetroSym(i)+' ', 7);
                 end;
              end;
             { Columns.Items[AnalisTitle.Count+2].Title.Caption:='X';
              Columns.Items[AnalisTitle.Count+2].FieldName:='X';}
              {Columns.Items[AnalisTitle.Count+2].Width:=88;}
               {Columns.Items[AnalisTitle.Count+3].Title.Caption:='Y';
              Columns.Items[AnalisTitle.Count+3].FieldName:='Y';
              Columns.Items[AnalisTitle.Count+2].Width:=88;}
              Columns.Add;
              Columns.Items[Col+1].Title.Caption:=
                    'Описание анализа';
                   { Columns.Items[2].Width:=256;}
              Columns.Items[Col+1].FieldName:='Descript';
     end;
     finally
     Sg1.Visible:=true;
      Quer.EnableControls;
     Sg1.SetFocus;
     end;
     QRTitle.Caption:=Caption;
     {DM1.TabM1['ArrayName']+
                '.  Расчетные весовые проценты компонентов.';}
     QRCTitle.Caption:=Titles+'  Описание';
end;

procedure TVesForm.Table2CalcFields(DataSet: TDataSet);
Var i : integer;
    S : string;
begin
      if Quer.RecNo>0 then
        Quer['N']:=Quer.RecNo;
      s:='';
      for i:=1 to MendCount do
          if (Pres[i])and ((i<>8)or Atomn) then begin
          if AnW then begin
             if Atomn then begin
                Quer['V'+IntToStr(i)]:=Quer['A'+IntToStr(i)]*
                 Quer['AWA'];
                if i=8 then
                   if Quer['A1']>0 then
                      Quer['V8']:=Quer['V8']-0.5*Quer['A1']*Quer['AWA'];
             end else
             Quer['V'+IntToStr(i)]:=Quer['A'+IntToStr(i)]*
                 MendTab.GetPetroVes(i)/Quer['AW']
          end else
          Quer['V'+IntToStr(i)]:=Quer['A'+IntToStr(i)]*
                 MendTab.GetPetroVes(i)/Quer['Ox'];
             S:=S+ Double2Str(Quer['V'+IntToStr(i)],7,3);
          end;
      Quer['DSting']:=S+Quer['Descript'];
end;

procedure TVesForm.BitBtn3Click(Sender: TObject);
begin
     QR.Preview;
end;

procedure TVesForm.BitBtn5Click(Sender: TObject);
begin
     QR.Print;
end;

procedure TVesForm.BitBtn2Click(Sender: TObject);
var F : TextFile;
    i : integer;
    R : real;
begin
     if SaveDialog1.Execute then begin
        AssignFile(F,SaveDialog1.FileName);
        Rewrite(F);
        Writeln(F,Caption);
        Writeln(F);
        Write(F,' No ');
        for i:=1 to SG1.Columns.Count-2 do
            Write(F,CentreStr (Sg1.Columns.Items[i].Title.Caption,8));
        WriteLn(F,'   Описание');
        With Quer do begin
             DisableControls;
             First ;
             While not EOF do begin
                   r:=Quer['N'];
                   Write(F,R:4:0);
                   for i:=1 to SG1.Columns.Count-2 do begin
                       R:=Quer[Sg1.Columns.Items[i].FieldName];
                       Write(F,R:8:4);
                   end;
                   WriteLn(F,' ',Quer['Descript']);
                   Next;
             end;
             EnableControls;
        end;
        CloseFile(F);
     end;
end;

procedure TVesForm.BitBtn4Click(Sender: TObject);
begin
     Application.HelpFile := 'RHA.HLP';
     Application.HelpCommand(HELP_CONTEXT ,40);
end;

procedure TVesForm.Sg1DblClick(Sender: TObject);
begin
    {#ToDo1 Restore}
     {CurID:=Quer['AnID'];
      AnalForm.ShowModal;}
end;

end.
