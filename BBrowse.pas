unit BBrowse;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, Buttons, Grids, ExtCtrls,
 Qrctrls, quickrpt, qrexport ,qrextra, Dialogs, ADODB, RXDBCtrl;

type
  TBiblBrouse = class(TForm)
    DataSource1: TDataSource;
    Panel2: TPanel;
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRDBText3: TQRDBText;
    cc: TQRChildBand;
    QRDBText4: TQRDBText;
    SaveDialog1: TSaveDialog;
    QRLabel2: TQRLabel;
    BitBtn1: TBitBtn;
    BitBtn5: TBitBtn;
    DBNavigator: TDBNavigator;
    BFile: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Query1: TADOQuery;
    Query1Id: TAutoIncField;
    Query1Num: TIntegerField;
    Query1Author: TStringField;
    Query1Title: TStringField;
    Query1Bibl: TStringField;
    Query1N: TIntegerField;
    Query1Full: TStringField;
    DBGrid1: TRxDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Query1CalcFields(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  BiblBrouse: TBiblBrouse;

implementation

uses RHAGlobs,Biblio, DMod1;


{$R *.DFM}

procedure TBiblBrouse.FormCreate(Sender: TObject);
begin
  //Query1.Open;
  QuickRep1.Visible:=false;
  if books.Table1.IndexFieldNames<>'Author' then
     QRDBText1.DataField:='Num';
end;

procedure TBiblBrouse.BitBtn1Click(Sender: TObject);
begin
     Query1.Close;
     Close;
end;

procedure TBiblBrouse.Query1CalcFields(DataSet: TDataSet);
begin
   if (DataSet.Eof) and (DBGrid1.Row > 2) then
    DataSet['N'] := DataSet.RecordCount
  else if DataSet.RecNo > 0 then
    DataSet['N'] := DataSet.RecNo
  else
    DataSet['N'] := 1;
     if DataSet.RecordCount>0 then begin
        DataSet['Full']:=DataSet.FieldByName('Author').AsString+'. '+DataSet['Title']+' // '+
            DataSet.FieldByName('Bibl').AsString;
     end;
end;

procedure TBiblBrouse.BitBtn2Click(Sender: TObject);
begin
     if SaveDialog1.Execute then
        QuickRep1.ExportToFilter(TQRASCIIExportFilter.Create
                                          (SaveDialog1.FileName));
end;

procedure TBiblBrouse.BitBtn4Click(Sender: TObject);
begin
     QuickRep1.Print;
end;

procedure TBiblBrouse.BitBtn3Click(Sender: TObject);
begin
     QuickRep1.PreView;
end;

procedure TBiblBrouse.BitBtn5Click(Sender: TObject);
begin
     Application.HelpContext(CurHelpContext);
end;

procedure TBiblBrouse.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.
