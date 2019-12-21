object SQView: TSQView
  Left = 101
  Top = 96
  Width = 597
  Height = 369
  HelpContext = 35
  Caption = 'View SQL text'
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
  object BitBtn1: TBitBtn
    Left = 40
    Top = 316
    Width = 73
    Height = 25
    TabOrder = 0
    Kind = bkClose
  end
  object BitBtn2: TBitBtn
    Left = 404
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 589
    Height = 313
    Align = alTop
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 2
  end
  object BitBtn3: TBitBtn
    Left = 488
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Accept'
    TabOrder = 3
    OnClick = BitBtn3Click
  end
end
