unit TxtImpExp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, grids, dbgrids, db, RHAGlobs,esbrtns;

type
  TExptoTextForm = class(TForm)
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function DefExport(G: TDbGrid; S : TStringGrid; ForExc : boolean): Boolean;
    procedure ExpDbGrid(G: TDbGrid; GetText: TGetCellText; Frm: TForm);
    procedure ExpStringGrid(SG1 : TStringGrid);
  end;

var
  ExptoTextForm: TExptoTextForm;
  Delim: char;
  ConstW : Boolean;
  Ind: array[0..255] of Byte;

resourcestring
  stFileSaved = 'Data succesfully saved to file ';
  stToEx='Export data to EXCEL';
  stToTXT='Export data to textfile';

var
  NFields: integer;

implementation

uses ImpWiz;

{$R *.DFM}

function TExptoTextForm.DefExport(G: TDbGrid; S : TStringGrid; ForExc : boolean): Boolean;
var i: integer;
begin
     if ForExc then begin
       Caption:=stToEx;
     Label1.Visible:=False;
     ComboBox1.Visible:=False;
     CheckBox1.Checked:=True;
     checkBox2.Visible:=False;
     CheckBox2.Checked:=false;
     end else begin
     Caption:=stToTXT;
     Label1.Visible:=True;
     ComboBox1.Visible:=True;
     CheckBox1.Checked:=False;
     checkBox2.Visible:=True;
     CheckBox2.Checked:=True;
     end;
  if ForExc or SaveDialog1.Execute then begin
    if G = nil then begin
      for i := 0 to S.ColCount - 1 do
        ListBox1.Items.AddObject(S.Cells[i,0], TInt.Create(i))
    end else begin
      for i := 0 to G.Columns.Count - 1 do
          if G.Columns.Items[i].Visible then
        ListBox1.Items.AddObject(G.Columns.Items[i].Title.Caption, TInt.Create(i));
    end;
    Result := (ShowModal = mrOK);
  end else
    Result := false;
end;



procedure TExptoTextForm.ExpDbGrid(G: TDbGrid; GetText: TGetCellText; Frm: TForm);
var F: TextFile;
  i: integer;
  s: string;
  r: real;
  Fld : TField;
  Wd : array [0..200] of Integer;
begin
  try
    AssignFile(F, SaveDialog1.Filename);
    Rewrite(F);
    try
      G.DataSource.DataSet.DisableControls;
      G.DataSource.DataSet.First;
      if ConstW then begin
      for i := 0 to NFields - 1 do
        wd[i]:=Length(G.Columns.Items[ind[i]].Title.Caption)+2;
        while not G.DataSource.DataSet.Eof do begin
         for i := 0 to NFields - 1 do begin
         if not Assigned(GetText) then
                s:=G.DataSource.DataSet.FieldByName(G.Columns.Items[ind[i]].FieldName).AsString
         else
                s:=GetText(Frm, ind[i]);
         if Length(s)>WD[i]-2 then
                WD[i]:=Length(S)+2;
         end;
         G.DataSource.DataSet.Next;
        end;
        G.DataSource.DataSet.First;
      end;
      if CheckBox1.Checked then begin
        for i := 0 to NFields - 1 do begin
        if ConstW then
           write(F, PadRightStr(G.Columns.Items[ind[i]].Title.Caption,WD[i]))
        else begin
          write(F, G.Columns.Items[ind[i]].Title.Caption);
           if i<NFields - 1 then
          write(F, Delim);
        end;
        end;
        writeln(F);
      end;
      while not G.DataSource.DataSet.Eof do begin
        for i := 0 to NFields - 1 do begin
          if not Assigned(GetText) then begin
             Fld:=G.DataSource.DataSet.FieldByName(G.Columns.Items[ind[i]].FieldName);
            if not(Fld is TFloatField)or
            (TFloatField(Fld).DisplayFormat = '') then begin
            if ConstW then
           write(F, PadRightStr(G.DataSource.DataSet.FieldByName(G.Columns.Items[ind[i]].FieldName).AsString,WD[i]))
                 else
              write(F, G.DataSource.DataSet.FieldByName(G.Columns.Items[ind[i]].FieldName).AsString)
            end
            else begin
                 r := G.DataSource.DataSet.FieldByName(G.Columns.Items[ind[i]].FieldName).AsFloat;
              s := TFloatField(Fld).DisplayFormat;
              if ConstW then
           write(F, PadRightStr(FormatFloat(S,R),WD[i]))
                 else
              write(F, FormatFloat(S,R))
            end
          end else
          if ConstW then
           write(F, PadRightStr(GetText(Frm, ind[i]),WD[i]))
        else begin
            write(F, GetText(Frm, ind[i]));

          end;
          if (i<NFields - 1)and not ConstW then
          write(F, Delim);
        end;
        G.DataSource.DataSet.Next;
        writeln(F);
      end;
      ShowMessage(stFileSaved + SaveDialog1.Filename);
    finally
      G.DataSource.DataSet.First;
      G.DataSource.DataSet.EnableControls;
    end;
  finally
    CloseFile(F);
  end;
end;

procedure TExptoTextForm.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
  SpeedButton2.Enabled:=False;
end;




procedure TExptoTextForm.BitBtn1Click(Sender: TObject);
var i: integer;
begin
   ConstW:=CheckBox2.Checked;
  case ComboBox1.ItemIndex of
    0: Delim := #9;
    1: Delim := ' ';
  else
    delim := ComboBox1.Items[ComboBox1.ItemIndex][1];
  end;
  if ListBox2.Items.Count= 0 then begin
      for i := 0 to ListBox1.Items.Count - 1 do
        ListBox2.Items.AddObject(ListBox1.Items[i], ListBox1.Items.Objects[i]);
      for i := ListBox1.Items.Count - 1 downto 0 do
        ListBox1.Items.Delete(i);
  end;
  NFields := ListBox2.Items.Count;
  for i := 0 to NFields - 1 do
    Ind[i] := Byte(TInt(ListBox2.Items.Objects[i]).N);
end;

procedure TExptoTextForm.SpeedButton1Click(Sender: TObject);
var i: integer;
begin
  SpeedButton1.Enabled := false;
  if ListBox1.SelCount > 1 then begin
    for i := 0 to ListBox1.Items.Count - 1 do
      if ListBox1.Selected[i] then
        ListBox2.Items.AddObject(ListBox1.Items[i], ListBox1.Items.Objects[i]);
    for i := ListBox1.Items.Count - 1 downto 0 do
      if ListBox1.Selected[i] then begin
               {ListBox1.Items.Objects[i].Free;}
        ListBox1.Items.Delete(i);
      end;

  end else begin
    ListBox2.Items.AddObject(ListBox1.Items[ListBox1.ItemIndex],
      ListBox1.Items.Objects[ListBox1.ItemIndex]);
     {ListBox1.Items.Objects[ListBox1.ItemIndex].Free;}
    ListBox1.Items.Delete(ListBox1.ItemIndex);
  end;
  ListBox1.ItemIndex := -1;
  ListBox2.ItemIndex := -1;
  SpeedButton2.Enabled:=False;
end;

procedure TExptoTextForm.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex >= 0 then
    SpeedButton1.Enabled := True;
end;

procedure TExptoTextForm.ListBox2Click(Sender: TObject);
begin
  if ListBox2.ItemIndex >= 0 then
    SpeedButton2.Enabled := True;
end;

procedure TExptoTextForm.SpeedButton2Click(Sender: TObject);
var i: integer;
begin
  SpeedButton2.Enabled := false;
  if ListBox2.SelCount > 1 then begin
    for i := 0 to ListBox2.Items.Count - 1 do
      if ListBox2.Selected[i] then
        ListBox1.Items.AddObject(ListBox2.Items[i], ListBox2.Items.Objects[i]);
    for i := ListBox2.Items.Count - 1 downto 0 do
      if ListBox2.Selected[i] then begin
               {ListBox2.Items.Objects[i].Free;}
        ListBox2.Items.Delete(i);
      end;

  end else begin
    ListBox1.Items.AddObject(ListBox2.Items[ListBox2.ItemIndex],
      ListBox2.Items.Objects[ListBox2.ItemIndex]);
     {ListBox2.Items.Objects[ListBox2.ItemIndex].Free;}
    ListBox2.Items.Delete(ListBox2.ItemIndex);
  end;
  ListBox1.ItemIndex := -1;
  ListBox2.ItemIndex := -1;
  SpeedButton1.Enabled:=False;
end;

procedure TExptoTextForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i: integer;
begin
  for i := 0 to ListBox1.Items.Count - 1 do
    ListBox1.Items.Objects[i].Free;
  for i := 0 to ListBox2.Items.Count - 1 do
    ListBox2.Items.Objects[i].Free;
  ListBox1.Clear;
  ListBox2.Clear;
end;

procedure TExptoTextForm.ExpStringGrid(SG1: TStringGrid);
var F: TextFile;
  i, j: integer;
begin
        try
    AssignFile(F, SaveDialog1.Filename);
    Rewrite(F);
     if CheckBox1.Checked then begin
        for i := 0 to NFields - 1 do begin
        if ConstW then
           write(F, PadRightStr(SG1.Cells[ind[i],0],SG1.ColWidths[ind[i]]+1))
        else begin
          write(F, SG1.Cells[ind[i],0]);
          if i<NFields - 1 then
          write(F, Delim);
          end;
        end;
        writeln(F);
      end;
      for j:=1 to SG1.RowCount - 1 do begin
       for i := 0 to NFields - 1 do begin
       if ConstW then
           write(F, PadRightStr(SG1.Cells[ind[i],j],SG1.ColWidths[ind[i]]+1))
        else begin
          Write(F,Sg1.Cells[ind[i], j]);
           if i<NFields - 1 then
          write(F, Delim);
          end;
       end;
        writeln(F);
       end;
       ShowMessage(stFileSaved + SaveDialog1.Filename);
     finally
    CloseFile(F);
  end;
end;

procedure TExptoTextForm.SpeedButton3Click(Sender: TObject);
var i: integer;
begin
  SpeedButton1.Enabled := false;
  SpeedButton2.Enabled := false;
    for i := 0 to ListBox1.Items.Count - 1 do
        ListBox2.Items.AddObject(ListBox1.Items[i], ListBox1.Items.Objects[i]);
    for i := ListBox1.Items.Count - 1 downto 0 do
        ListBox1.Items.Delete(i);
  ListBox1.ItemIndex := -1;
  ListBox2.ItemIndex := -1;

end;

procedure TExptoTextForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

procedure TExptoTextForm.CheckBox2Click(Sender: TObject);
begin
   ComboBox1.Enabled:=not CheckBox2.Checked;
   ConstW:=CheckBox2.Checked;
end;

end.

