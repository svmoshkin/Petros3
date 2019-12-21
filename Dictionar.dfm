object SinonimForm: TSinonimForm
  Left = 447
  Top = 61
  HelpContext = 26
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Edit synonyms dictionary'
  ClientHeight = 449
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 4
    Width = 269
    Height = 409
  end
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 22
    Height = 13
    Caption = 'Field'
  end
  object Label2: TLabel
    Left = 8
    Top = 124
    Width = 81
    Height = 77
    AutoSize = False
    Caption = 'Values of field currently used in database'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 12
    Top = 300
    Width = 48
    Height = 26
    Caption = 'Synonyms dictionary'
    WordWrap = True
  end
  object DBGrid1: TDBGrid
    Left = 92
    Top = 96
    Width = 173
    Height = 145
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object ListBox1: TListBox
    Left = 92
    Top = 16
    Width = 173
    Height = 73
    ItemHeight = 13
    Items.Strings = (
      'Geolog. body'
      'Geolog. identifier'
      'Region'
      'Rock')
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object BitBtn1: TBitBtn
    Left = 100
    Top = 420
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object DBNavigator1: TDBNavigator
    Left = 25
    Top = 384
    Width = 224
    Height = 25
    DataSource = DataSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
    TabOrder = 4
  end
  object DBGrid2: THDBGrid
    Left = 92
    Top = 248
    Width = 173
    Height = 133
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    SpHint = True
    Columns = <
      item
        Expanded = False
        FieldName = 'Word'
        Title.Caption = 'Synonym'
        Width = 139
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 128
    Top = 328
  end
  object ADOQuery1: TADOQuery
    Connection = DM1.ADOConnection1
    AfterInsert = ADOQuery1AfterInsert
    Parameters = <>
    Left = 184
    Top = 304
  end
end
