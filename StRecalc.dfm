object RecForm: TRecForm
  Left = 246
  Top = 56
  HelpContext = 88
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Normative recalculations'
  ClientHeight = 463
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 320
    Top = 44
    Width = 55
    Height = 25
    Caption = 'New'
    TabOrder = 0
    OnClick = Button1Click
  end
  object HDBGrid2: THDBGrid
    Left = 0
    Top = 0
    Width = 305
    Height = 463
    Align = alLeft
    DataSource = DM1.DSRec
    DefaultDrawing = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = HDBGrid2DrawColumnCell
    OnDblClick = HDBGrid2DblClick
    SpHint = True
    Columns = <
      item
        Expanded = False
        FieldName = 'Name'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descript'
        Width = 161
        Visible = True
      end>
  end
  object Button2: TButton
    Left = 320
    Top = 76
    Width = 57
    Height = 25
    Caption = 'Edit'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 320
    Top = 160
    Width = 57
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = Button3Click
  end
  object BitBtn1: TBitBtn
    Left = 312
    Top = 368
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 312
    Top = 404
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
end
