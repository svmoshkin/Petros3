object NewProject: TNewProject
  Left = 96
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'New project'
  ClientHeight = 453
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 4
    Width = 545
    Height = 413
  end
  object Label1: TLabel
    Left = 12
    Top = 20
    Width = 62
    Height = 13
    Caption = 'Project name'
  end
  object IDLab: TArtLabel
    Left = 452
    Top = 20
    Width = 67
    Height = 22
    ArtStyle = [as3DRaise, asShadow]
    Caption = 'Art Label'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Transparent = False
    Color = clBtnFace
    ShadowColor = clGray
    OutlineColor = clWhite
    AutoSize = True
    ShadowLength = 0
    Gradient.GradientStyle = gsLine
    Gradient.LineSize = 2
    Gradient.Color1 = clSilver
    Gradient.Color2 = clGray
    Gradient.Color3 = clBlack
    Gradient.Color4 = clWhite
    Gradient.Color5 = clBlack
    Gradient.ColorCount = 3
    Gradient.LineDirection = diHorizonal
    TextAlign = taLeftJustify
  end
  object Label2: TLabel
    Left = 392
    Top = 24
    Width = 47
    Height = 13
    Caption = 'Project ID'
  end
  object Button1: TButton
    Left = 24
    Top = 425
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 425
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 184
    Top = 425
    Width = 75
    Height = 25
    HelpContext = 14
    Caption = '&Help'
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 80
    Top = 20
    Width = 281
    Height = 21
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 537
    Height = 353
    Caption = 'Data set definition'
    TabOrder = 4
    object Label3: TLabel
      Left = 288
      Top = 16
      Width = 77
      Height = 13
      Caption = 'Existing data set'
    end
    object Label4: TLabel
      Left = 8
      Top = 332
      Width = 525
      Height = 13
      AutoSize = False
    end
    object Memo1: TMemo
      Left = 4
      Top = 76
      Width = 525
      Height = 249
      TabOrder = 0
    end
    object Button4: TButton
      Left = 12
      Top = 44
      Width = 97
      Height = 25
      Caption = 'Create new query'
      TabOrder = 1
      OnClick = Button4Click
    end
    object ComboBox1: TComboBox
      Left = 136
      Top = 36
      Width = 389
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox1Change
    end
    object GroupBox2: TGroupBox
      Left = 152
      Top = 128
      Width = 245
      Height = 109
      Caption = 'Copy tables'
      TabOrder = 3
      Visible = False
      object Label5: TLabel
        Left = 16
        Top = 48
        Width = 32
        Height = 13
        Caption = 'Label5'
      end
      object ProgressBar1: TProgressBar
        Left = 16
        Top = 72
        Width = 209
        Height = 17
        TabOrder = 0
      end
    end
  end
end
