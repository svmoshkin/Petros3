object DeletDial: TDeletDial
  Left = 192
  Top = 152
  HelpContext = 24
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Referential integrity limitation'
  ClientHeight = 307
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 253
    Height = 45
    AutoSize = False
    Caption = 
      'You try delete item, which used in database. Select item from li' +
      'st for replace deleting item  or cancel operation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 148
    Top = 76
    Width = 121
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 12
    Top = 72
    Width = 125
    Height = 225
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 212
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 268
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
