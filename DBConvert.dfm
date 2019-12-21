object fDBConvert: TfDBConvert
  Left = 360
  Top = 297
  Width = 683
  Height = 376
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1073#1072#1079' '#1076#1072#1085#1085#1099#1093' Petros 2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 308
    Width = 675
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 62
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 675
    Height = 308
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 180
      Width = 36
      Height = 13
      Caption = 'Overall '
    end
    object Label2: TLabel
      Left = 20
      Top = 220
      Width = 66
      Height = 13
      Caption = 'Current object'
    end
    object Label3: TLabel
      Left = 4
      Top = 4
      Width = 202
      Height = 13
      Caption = 'Connected to database alias "PetrosBase"'
    end
    object Label4: TLabel
      Left = 12
      Top = 34
      Width = 32
      Height = 13
      Caption = 'Label4'
    end
    object Label5: TLabel
      Left = 12
      Top = 54
      Width = 32
      Height = 13
      Caption = 'Label5'
    end
    object Label6: TLabel
      Left = 14
      Top = 274
      Width = 263
      Height = 16
      Caption = 'The operation may take several hours'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button2: TButton
      Left = 300
      Top = 270
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = Button2Click
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 236
      Width = 655
      Height = 16
      TabOrder = 1
    end
    object ProgressBar2: TProgressBar
      Left = 6
      Top = 198
      Width = 657
      Height = 16
      TabOrder = 2
    end
    object CheckBox1: TCheckBox
      Left = 30
      Top = 96
      Width = 251
      Height = 17
      Caption = 'Clear destination database before import'
      TabOrder = 3
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 92
      Top = 118
      Width = 113
      Height = 17
      Caption = 'Clear data only'
      Enabled = False
      TabOrder = 4
    end
    object Memo1: TMemo
      Left = 306
      Top = 6
      Width = 363
      Height = 185
      ScrollBars = ssVertical
      TabOrder = 5
    end
    object Button3: TButton
      Left = 558
      Top = 268
      Width = 75
      Height = 25
      Caption = 'Recalc R'
      TabOrder = 6
      Visible = False
      OnClick = Button3Click
    end
  end
end
