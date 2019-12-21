object ExptoTextForm: TExptoTextForm
  Left = 281
  Top = 139
  HelpContext = 53
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Export data to textfile'
  ClientHeight = 299
  ClientWidth = 296
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 36
    Width = 46
    Height = 13
    Caption = 'Separator'
  end
  object ComboBox1: TComboBox
    Left = 68
    Top = 32
    Width = 65
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'Tab'
      'Space'
      ','
      ';'
      '/')
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 272
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 120
    Top = 272
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object CheckBox1: TCheckBox
    Left = 152
    Top = 36
    Width = 137
    Height = 17
    Caption = 'With columns titles'
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 60
    Width = 293
    Height = 205
    Caption = 'Select data fields for export'
    TabOrder = 4
    object SpeedButton1: TSpeedButton
      Left = 132
      Top = 60
      Width = 23
      Height = 22
      Hint = 'Move selected'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 132
      Top = 92
      Width = 23
      Height = 22
      Hint = 'Move selected'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton2Click
    end
    object Label2: TLabel
      Left = 16
      Top = 20
      Width = 66
      Height = 13
      Caption = 'Enabled fields'
    end
    object Label3: TLabel
      Left = 172
      Top = 20
      Width = 69
      Height = 13
      Caption = 'Exported fields'
    end
    object SpeedButton3: TSpeedButton
      Left = 132
      Top = 164
      Width = 23
      Height = 22
      Hint = 'Move all'
      Caption = '>>'
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton3Click
    end
    object ListBox1: TListBox
      Left = 4
      Top = 36
      Width = 117
      Height = 165
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object ListBox2: TListBox
      Left = 168
      Top = 36
      Width = 121
      Height = 165
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 1
      OnClick = ListBox2Click
    end
  end
  object CheckBox2: TCheckBox
    Left = 4
    Top = 8
    Width = 285
    Height = 17
    Caption = 'Constant width columns'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = CheckBox2Click
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|Data files|*.dat|All files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoDereferenceLinks, ofEnableSizing]
    Title = 'Select file for export'
    Left = 244
    Top = 248
  end
end
