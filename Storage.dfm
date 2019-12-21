object StorageForm: TStorageForm
  Left = 154
  Top = 67
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Storage structure'
  ClientHeight = 322
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Tree: TTreeView
    Left = 0
    Top = 21
    Width = 281
    Height = 301
    Align = alLeft
    Indent = 19
    TabOrder = 0
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 370
    Height = 21
    Align = alTop
    Caption = 'pnlHeader'
    TabOrder = 1
  end
  object FileOpen1: TButton
    Left = 288
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 2
    OnClick = FileOpen1Click
  end
  object Compress1: TButton
    Left = 288
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Compress'
    Enabled = False
    TabOrder = 3
    OnClick = Compress1Click
  end
  object BitBtn1: TBitBtn
    Left = 292
    Top = 276
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkOK
  end
  object OpenDialog1: TOpenDialog
    Left = 232
    Top = 224
  end
end
