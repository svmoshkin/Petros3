unit LoadPr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, DMod1, Mask, DBCtrls, Hintctrl, Grids, DBGrids,
  Dialogs, ADODB;

type
  TLoadPrForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    HDBGrid1: THDBGrid;
    HDBEdit1: THDBEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  public
    Action: integer;
  end;

resourcestring
  stDefProjDelet = 'Default project can not be deleted!';

const
  aLoad = 0;
  aDelete = 1;

var
  LoadPrForm: TLoadPrForm;

implementation

uses RHAGlobs, Main, Options, DBConvert;

{$R *.DFM}

procedure TLoadPrForm.Button1Click(Sender: TObject);
var
  Alias: string;
  PrID: string;
  PrPath: string;
  Sg: TSearchRec;
begin
  if Action = aLoad then begin
     CurProject.SaveProject;
    CurProject.LoadProject(DM1.TTasks['Id'])
  end else begin
    if DM1.TTasks['Id'] = 1 then begin
      ShowMessage(stDefProjDelet);
      exit;
    end else begin
     Alias := DM1.TTasks['Alias'];
      PrId := DM1.TTasks['PrID'];
      PrPath := GetAliasDir(Alias);
      if CurProject.TableId = DM1.TTasks['Id'] then begin
        MainForm.Caption := 'PETROS 3.2.0';
        CurProject.LoadProject(1)
      end;
       DM1.TTasks.Locate('Alias', Alias, []);
	{ChangeAlias('PetrosBase');}
      DM1.TTasks.Edit;
      DM1.TTasks['Alias'] := '##1##';
      DM1.TTasks.Post;
      if not DM1.TTasks.Locate('Alias', Alias, []) then begin
        RHAAliases.Delete(RHAAliases.IndexOf(Alias));
        RHAAliases.SaveToFile(MainPath + 'Petros.als');
      {  Session.DeleteAlias(Alias);
        Session.SaveConfigFile;  }
        if FindFirst(PrPath + '*.*', faAnyFile, Sg) = 0 then begin
          SysUtils.DeleteFile(PrPath +Sg.Name);
          while FindNext(Sg) = 0 do
            SysUtils.DeleteFile(PrPath +Sg.Name);
        end;
        RemoveDir(System.Copy(PrPath, 1, Length(PRPath) - 1));
      end else begin
        if FindFirst(PrPath + PrID + '.*', faAnyFile, Sg) = 0 then begin
          SysUtils.DeleteFile(PrPath +Sg.Name);
          while FindNext(Sg) = 0 do
            SysUtils.DeleteFile(PrPath +Sg.Name);
        end;
      end;
      DM1.TTasks.Locate('Alias', '##1##', []);
      DM1.TTasks.Delete;
      DM1.TTasks.First;
    end;
  end;

  ModalResult := mrOK;
end;

procedure TLoadPrForm.FormActivate(Sender: TObject);
begin
     CurHelpContext := HelpContext;
end;

end.

