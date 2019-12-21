unit PetDBUtils;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, DistBar, VCLUnZip, VCLZip, DB, ComCtrls,
  Variants;

type
  TDbUtil = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Zip1: TVCLZip;
    Bevel1: TBevel;
    procedure FormActivate(Sender: TObject);
  end;

var
  DbUtil: TDbUtil;

procedure RestoreBase(ZName, Dir: string; DistrBar: TDistractBar);
{Восстановление базы из архива в каталог Dir. DistBar - если не nil,
показывает, что идет разархивирование}

procedure UpdateBase(DSetData, DSetMain, DSetSource, DSetClass: TDataSet; New: boolean;
  Lab: TLabel; Progres: TProgressBar);
{Пополняет базу, заданную в DM1.Database1 данными из DataSet's. If New then
данные добавляются без проверки их наличия в приемнике. Caption и Progres если
не nil показывают ход операции}

implementation

uses DMod1, RHAGlobs, DModOld;

{$R *.DFM}

procedure RestoreBase(ZName, Dir: string; DistrBar: TDistractBar);
begin
  with DBUtil.Zip1 do begin
    ZipName := ZName;
    FilesList.Clear;
    FilesList.Add('*.*');
    DestDir := Dir;
    Screen.Cursor := crHourglass;
    try
      if DistrBar <> nil then begin
        DistrBar.Caption := 'Decompression';
        DistrBar.Visible := true;
        DistrBar.Animated := true;
      end;
      UnZip;
    finally
      if DistrBar <> nil then begin
        DistrBar.Animated := false;
        DistrBar.Visible := false;
      end;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure UpdateBase(DSetData, DSetMain, DSetSource, DSetClass: TDataSet; New: boolean;
  Lab: TLabel; Progres: TProgressBar);
var
  SId, ArrId, OldSID, OldArrID, DataId, i, j, RCount: integer;
  Changed: boolean;
begin
  Screen.Cursor := crHourglass;
  with DMOld do begin
    try (*
      if Progres <> nil then Progres.Position := 0;
      if Lab <> nil then Lab.Caption := 'Prepare source tables';
      Application.ProcessMessages;
      TabMain.Open;
      if Progres <> nil then Progres.Position := 20;
      TabData.Open;
      if Progres <> nil then Progres.Position := 40;
      TabSource.Open;
      if Progres <> nil then Progres.Position := 60;

      TabClass.Open;
      if Progres <> nil then Progres.Position := 80;
      RCount := DSetMain.RecordCount;
      if RCount > 0 then begin
        J := 0;
        DSetSource.First;
        while not DSetSource.Eof do begin
          OldSID := DSetSource['Id'];
          if not New and TabSource.Locate('Num',DSetSource.FieldByName('Num').AsInteger,[]) then begin
            Changed := false;
            for i := 2 to DSetSource.Fields.Count - 1 do
              if TabSource.FieldByName(TabSource.Fields[i].FieldName).Value <>
                DSetSource.FieldByName(DSetSource.Fields[i].FieldName).Value
                then Changed := true;
            if Changed then begin
              TabSource.Edit;
              for i := 1 to DSetSource.Fields.Count - 1 do
                TabSource.FieldByName(TabSource.Fields[i].FieldName).Value :=
                  DSetSource.FieldByName(DSetSource.Fields[i].FieldName).Value;
              TabSource.Post;
            end;
            SId := TabSource['Id'];
          end else begin
            TabSource.Insert;
            for i := 1 to DSetSource.Fields.Count - 1 do
              TabSource.FieldByName(TabSource.Fields[i].FieldName).Value :=
                DSetSource.FieldByName(DSetSource.Fields[i].FieldName).Value;
            TabSource.Post;
            SId := TabSource['Id'];
          end;
          DSetMain.Filtered := False;
          DSetMain.Filter := 'Source = ' + IntToStr(OldSID);
          DSetMain.Filtered := true;
          DSetMain.FindFirst;
          while DSetMain.Found do begin
            OldArrId := DSetMain['Id'];
            if Progres <> nil then Progres.Position := round(j * 100 / RCount);
            Inc(j);
            if Lab <> nil then Lab.Caption := DSetMain['ArrayName'];
            Application.ProcessMessages;
            if not New and TabMain.Locate('ArrayName',DSetMain.FieldByName('ArrayName').AsString,[])
            then begin
              Changed := false;
              for i := 2 to DSetMain.Fields.Count - 1 do
                if TabMain.FieldByName(DSetMain.Fields[i].FieldName).Value <>
                  DSetMain.FieldByName(DSetMain.Fields[i].FieldName).Value
                  then Changed := true;
              if Changed then begin
                TabMain.Edit;
                for i := 1 to DSetMain.Fields.Count - 1 do
                  if i <> 2 then
                    TabMain.FieldByName(DSetMain.Fields[i].FieldName).Value :=
                      DSetMain.FieldByName(DSetMain.Fields[i].FieldName).Value;
                TabMain['Source'] := SId;
                TabMain.Post;
              end;
              ArrId := TabMain['Id'];
            end else begin
              TabMain.Insert;
              for i := 1 to DSetMain.Fields.Count - 1 do
                if i <> 2 then
                  TabMain.FieldByName(DSetMain.Fields[i].FieldName).Value :=
                    DSetMain.FieldByName(DSetMain.Fields[i].FieldName).Value;
              TabMain['Source'] := SId;
              TabMain.Post;
              ArrId := TabMain['Id'];
            end;
            Application.ProcessMessages;
            DSetData.Filtered := False;
            DSetData.Filter := 'ArrId = ' + IntToStr(OldArrID);
            DSetData.Filtered := true;
            DSetData.FindFirst;
            while DSetData.Found do begin
              if not New and TabData.Locate('Descript',DSetData.FieldByName('Descript').AsString,[])
              then begin
                Changed := false;
                for i := 2 to DSetData.Fields.Count - 1 do
                  if TabData.FieldByName(DSetData.Fields[i].FieldName).Value <>
                    DSetData.FieldByName(DSetData.Fields[i].FieldName).Value
                    then Changed := true;
                if Changed then begin
                  TabData.Edit;
                  for i := 2 to DSetData.Fields.Count - 1 do
                    TabData.FieldByName(DSetData.Fields[i].FieldName).Value :=
                      DSetData.FieldByName(DSetData.Fields[i].FieldName).Value;
                  TabData['ArrId'] := ArrId;
                  TabData.Post;
                end;
              end else begin
                TabData.Insert;
                for i := 2 to DSetData.Fields.Count - 1 do
                  TabData.FieldByName(DSetData.Fields[i].FieldName).Value :=
                    DSetData.FieldByName(DSetData.Fields[i].FieldName).Value;
                TabData['ArrId'] := ArrId;
                TabData.Post;
              end;
           { TabData.ApplyUpdates;
            TabData.CommitUpdates; }
             DataID:=TabData['AnID'];
             DSetClass.First;
              while not DSetClass.Eof do begin
                if not New and TabClass.Locate('Diagr;Anal',
                  VarArrayOf([DSetClass['Diagr'], DataID]), []) then begin
                  if TabClass['Class'] <> DSetClass['Class'] then begin
                    TabClass.Edit;
                    TabClass['Class'] := DSetClass['Class'];
                    TabClass.Post;
                  end;
                end else begin
                  TabClass.Insert;
                  for i := 1 to DSetClass.Fields.Count - 1 do
                    TabClass.FieldByName(DSetClass.Fields[i].FieldName).Value :=
                      DSetClass.FieldByName(DSetClass.Fields[i].FieldName).Value;
                  TabClass['Anal'] := DataId;
                  TabClass.Post;
                end;
                DSetClass.Next;
              end;
              DSetData.FindNext
            end;

            DSetMain.FindNext
          end;
          DSetSource.Next
        end;
      end;

    finally
      try
        DSetMain.Filtered := False;
        DSetData.Filtered := False;
        TabClass.Close;
        TabSource.Close;
        TabData.Close;
        TabMain.Close; *)
    finally
      Screen.Cursor := crDefault;
    end;
  end;
//end;
end;

procedure TDbUtil.FormActivate(Sender: TObject);
begin
  CurHelpContext := HelpContext;
end;

end.

