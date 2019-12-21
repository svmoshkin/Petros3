object DbUtil: TDbUtil
  Left = 268
  Top = 64
  BorderStyle = bsDialog
  Caption = 'DbUtil'
  ClientHeight = 357
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 4
    Width = 469
    Height = 313
  end
  object Button1: TButton
    Left = 196
    Top = 325
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 276
    Top = 325
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 356
    Top = 325
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 2
  end
  object Zip1: TVCLZip
    OverwriteMode = Always
    FilesList.Strings = (
      '')
    PackLevel = 7
    Left = 72
    Top = 320
  end
end
