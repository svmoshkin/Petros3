object ExcF: TExcF
  Left = 273
  Top = 303
  HelpContext = 54
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Export to EXCEL'
  ClientHeight = 196
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    216
    196)
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 4
    Top = 166
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 92
    Top = 166
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 8
    Width = 201
    Height = 85
    Caption = 'Top-left corner of table'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 28
      Width = 35
      Height = 13
      Caption = 'Column'
    end
    object Label2: TLabel
      Left = 8
      Top = 60
      Width = 22
      Height = 13
      Caption = 'Row'
    end
    object NumInp1: TNumInp
      Left = 76
      Top = 20
      Width = 45
      Height = 21
      Datatype = dtInteger
      Decimals = 2
      Digits = 12
      Max = 32000.000000000000000000
      Min = 1.000000000000000000
      TabOrder = 0
      Value = 1.000000000000000000
      Validate = True
    end
    object NumInp2: TNumInp
      Left = 76
      Top = 52
      Width = 45
      Height = 21
      Datatype = dtInteger
      Decimals = 2
      Digits = 12
      Max = 32000.000000000000000000
      Min = 1.000000000000000000
      TabOrder = 1
      Value = 1.000000000000000000
      Validate = True
    end
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 104
    Width = 153
    Height = 17
    Caption = 'New sheet'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 136
    Width = 187
    Height = 17
    Caption = 'All data as text'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object ExcApp: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 180
    Top = 100
  end
end
