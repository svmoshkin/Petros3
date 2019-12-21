object GroupForm: TGroupForm
  Left = 205
  Top = 138
  HelpContext = 96
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Selection of grouping characteristic'
  ClientHeight = 269
  ClientWidth = 351
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
  object Label23: TLabel
    Left = 188
    Top = 4
    Width = 161
    Height = 29
    Alignment = taCenter
    AutoSize = False
    Caption = 'Available classification diagrams'
    Enabled = False
    WordWrap = True
  end
  object RadioGroup1: TRadioGroup
    Left = 4
    Top = 32
    Width = 185
    Height = 185
    Caption = 'Group by'
    ItemIndex = 0
    Items.Strings = (
      'None'
      'Geological identificators'
      'Geological body'
      'Region'
      'Rock'
      'Classification results')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object HLB1: THListBox
    Left = 192
    Top = 36
    Width = 153
    Height = 225
    Enabled = False
    ItemHeight = 13
    TabOrder = 1
    OnClick = HLB1Click
    SpHint = True
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 236
    Width = 73
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 92
    Top = 236
    Width = 73
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
