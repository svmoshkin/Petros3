object DevForm: TDevForm
  Left = 481
  Top = 99
  HelpContext = 95
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Divider for spider diagram selection'
  ClientHeight = 412
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 4
    Width = 269
    Height = 249
  end
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 33
    Height = 13
    Caption = 'Divider'
  end
  object Bevel2: TBevel
    Left = 280
    Top = 8
    Width = 241
    Height = 365
  end
  object SpeedButton1: TSpeedButton
    Left = 492
    Top = 104
    Width = 23
    Height = 22
    Hint = 'Move selected element up'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
      3333333333777F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
      3333333777737777F333333099999990333333373F3333373333333309999903
      333333337F33337F33333333099999033333333373F333733333333330999033
      3333333337F337F3333333333099903333333333373F37333333333333090333
      33333333337F7F33333333333309033333333333337373333333333333303333
      333333333337F333333333333330333333333333333733333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
    OnMouseDown = SpeedButton1MouseDown
    OnMouseUp = SpeedButton1MouseUp
  end
  object SpeedButton2: TSpeedButton
    Left = 492
    Top = 152
    Width = 23
    Height = 22
    Hint = 'Move selected element down'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333337F33333333333333033333333333333373F333333333333090333
      33333333337F7F33333333333309033333333333337373F33333333330999033
      3333333337F337F33333333330999033333333333733373F3333333309999903
      333333337F33337F33333333099999033333333373333373F333333099999990
      33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333300033333333333337773333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton2Click
    OnMouseDown = SpeedButton2MouseDown
    OnMouseUp = SpeedButton1MouseUp
  end
  object Label2: TLabel
    Left = 284
    Top = 12
    Width = 106
    Height = 13
    Caption = 'Sequence of elements'
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 384
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 368
    Top = 384
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtn3: TBitBtn
    Left = 448
    Top = 384
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = BitBtn3Click
    Kind = bkHelp
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 193
    Height = 225
    ItemHeight = 13
    TabOrder = 3
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
  end
  object Button1: TButton
    Left = 204
    Top = 28
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 204
    Top = 60
    Width = 65
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = Button2Click
  end
  object ElLB: TCheckListBox
    Left = 424
    Top = 24
    Width = 65
    Height = 313
    OnClickCheck = ElLBClickCheck
    ItemHeight = 13
    TabOrder = 6
  end
  object OrdLB: TListBox
    Left = 284
    Top = 24
    Width = 137
    Height = 313
    ItemHeight = 13
    TabOrder = 7
    OnClick = OrdLBClick
  end
  object Button3: TButton
    Left = 292
    Top = 344
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 368
    Top = 344
    Width = 65
    Height = 25
    Caption = 'Delete'
    TabOrder = 9
    OnClick = Button4Click
  end
  object RadioGroup1: TRadioGroup
    Left = 4
    Top = 256
    Width = 269
    Height = 153
    Caption = 'Concentrations'
    ItemIndex = 0
    Items.Strings = (
      'Atomic %'
      'Atomic % without H2O'
      'Molecular %'
      'Molecular % without H2O'
      'Weight %'
      'Weight % recalc. to 100%'
      'Weight % without H2O')
    TabOrder = 10
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 400
    OnTimer = Timer1Timer
    Left = 236
    Top = 128
  end
  object Timer2: TTimer
    Interval = 100
    OnTimer = Timer2Timer
    Left = 232
    Top = 172
  end
  object Query1: TADOQuery
    Connection = DM1.ADOConnection1
    Parameters = <>
    Left = 225
    Top = 210
  end
end
