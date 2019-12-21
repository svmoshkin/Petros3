object EdBookForm: TEdBookForm
  Left = 335
  Top = 288
  Width = 392
  Height = 318
  HelpContext = 44
  Caption = 'EdBookForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 3
    Top = 2
    Width = 378
    Height = 255
    Caption = 'Bibliography of data source'
    TabOrder = 0
    object Label3: TLabel
      Left = 20
      Top = 156
      Width = 57
      Height = 13
      Caption = 'Bibliography'
      Transparent = True
    end
    object Label5: TLabel
      Left = 24
      Top = 16
      Width = 37
      Height = 13
      Caption = 'Number'
      Transparent = True
    end
    object Label6: TLabel
      Left = 20
      Top = 60
      Width = 36
      Height = 13
      Caption = 'Authors'
      Transparent = True
    end
    object Label7: TLabel
      Left = 16
      Top = 108
      Width = 20
      Height = 13
      Caption = 'Title'
    end
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 220
      Width = 200
      Height = 25
      DataSource = DM1.DSEdBook
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbCancel]
      Hints.Strings = (
        #1042' '#1085#1072#1095#1072#1083#1086
        #1055#1088#1077#1076#1099#1076#1091#1097#1080#1081
        #1057#1083#1077#1076#1091#1102#1097#1080#1081
        #1042' '#1082#1086#1085#1077#1094
        #1044#1086#1073#1072#1074#1080#1090#1100
        ''
        ''
        ''
        #1054#1090#1084#1077#1085#1080#1090#1100)
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object BitBtn4: TBitBtn
      Left = 272
      Top = 220
      Width = 25
      Height = 25
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = BitBtn4Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object ESourceN: THDBEdit
      Left = 12
      Top = 32
      Width = 65
      Height = 21
      DataField = 'Num'
      DataSource = DM1.DSEdBook
      ReadOnly = True
      TabOrder = 0
      SpHint = True
    end
    object ESourceA: THDBEdit
      Left = 8
      Top = 79
      Width = 361
      Height = 21
      DataField = 'Author'
      DataSource = DM1.DSEdBook
      ReadOnly = True
      TabOrder = 1
      SpHint = True
    end
    object DBEdit4: THDBEdit
      Left = 8
      Top = 124
      Width = 361
      Height = 21
      DataField = 'Title'
      DataSource = DM1.DSEdBook
      ReadOnly = True
      TabOrder = 2
      SpHint = True
    end
    object DBEdit5: THDBEdit
      Left = 8
      Top = 180
      Width = 361
      Height = 21
      DataField = 'Bibl'
      DataSource = DM1.DSEdBook
      ReadOnly = True
      TabOrder = 3
      SpHint = True
    end
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 108
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
