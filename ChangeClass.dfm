object ChangeClForm: TChangeClForm
  Left = 192
  Top = 151
  HelpContext = 83
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Change class of point'
  ClientHeight = 238
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 217
    Height = 13
    AutoSize = False
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 152
    Top = 44
    Width = 77
    Height = 17
    AutoSize = False
    Caption = 'Label2'
  end
  object ListBox1: TListBox
    Left = 0
    Top = 20
    Width = 149
    Height = 217
    ItemHeight = 13
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 156
    Top = 164
    Width = 73
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 156
    Top = 200
    Width = 73
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
