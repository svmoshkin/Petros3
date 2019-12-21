object ImpLookUpForm: TImpLookUpForm
  Left = 173
  Top = 239
  Width = 675
  Height = 333
  HelpContext = 33
  BorderIcons = [biSystemMenu]
  Caption = 'ERROR: Unknown descriptor in importing table'
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
  object SpeedButton1: TSpeedButton
    Left = 358
    Top = 124
    Width = 23
    Height = 22
    Hint = 'Replace text in Excel table'#13#10'with selected value from list'
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
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 358
    Top = 92
    Width = 23
    Height = 22
    Hint = 'Add new value to list'
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
  object Label1: TLabel
    Left = 4
    Top = 40
    Width = 160
    Height = 13
    Caption = 'Current list of designations for field'
  end
  object Label2: TLabel
    Left = 418
    Top = 48
    Width = 233
    Height = 39
    AutoSize = False
    Caption = 
      'Select designation to replace text in Excel table (->) or add ne' +
      'w designation to List (<-)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 416
    Top = 104
    Width = 122
    Height = 13
    Caption = 'Designation in Excel table'
  end
  object Label4: TLabel
    Left = 0
    Top = 8
    Width = 553
    Height = 25
    AutoSize = False
    Caption = 
      'Designation in table is not in the list of possible designations' +
      ' for this field!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object DBGrid1: TDBGrid
    Left = 4
    Top = 56
    Width = 335
    Height = 229
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Edit1: TEdit
    Left = 412
    Top = 124
    Width = 241
    Height = 21
    TabOrder = 1
    Text = ' '
  end
  object BitBtn1: TBitBtn
    Left = 380
    Top = 258
    Width = 69
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 460
    Top = 258
    Width = 65
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object BitBtn3: TBitBtn
    Left = 436
    Top = 160
    Width = 53
    Height = 21
    Caption = 'Undo'
    Enabled = False
    TabOrder = 4
    OnClick = BitBtn3Click
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777777777777777777707777777777077700077777777777770000777777
      7077777000777777077777770007777007777777700077007777777777000007
      7777777777700077777777777700000777777777700077007777777000077770
      0777770000777777007777000777777777077777777777777777}
  end
end
