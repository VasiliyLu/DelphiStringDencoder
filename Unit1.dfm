object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'TextProccessDelphi'
  ClientHeight = 443
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 153
    Width = 564
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 526
  end
  object mIn: TMemo
    Left = 0
    Top = 0
    Width = 564
    Height = 153
    Align = alTop
    TabOrder = 0
    OnClick = mInClick
    OnExit = Button1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 158
    Width = 564
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 159
    object Button1: TButton
      Left = 8
      Top = 6
      Width = 89
      Height = 25
      Caption = 'ToDelphiString'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 103
      Top = 6
      Width = 114
      Height = 25
      Caption = 'ResultToClipboard'
      TabOrder = 1
      OnClick = Button2Click
    end
    object btnToSimpleString: TButton
      Left = 223
      Top = 6
      Width = 89
      Height = 25
      Caption = 'ToSimpleString'
      TabOrder = 2
      OnClick = btnToSimpleStringClick
    end
  end
  object mOut: TMemo
    Left = 0
    Top = 199
    Width = 564
    Height = 244
    Align = alClient
    TabOrder = 2
    OnClick = mInClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 264
    Top = 182
  end
end
