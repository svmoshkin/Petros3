object WForm: TWForm
  Left = 321
  Top = 159
  BorderIcons = []
  BorderStyle = bsSingle
  BorderWidth = 1
  Caption = 'Wait ...'
  ClientHeight = 31
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 130
    Height = 13
    Alignment = taCenter
    Caption = 'Long operation is executing'
  end
end
