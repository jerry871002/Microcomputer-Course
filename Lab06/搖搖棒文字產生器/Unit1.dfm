object Form1: TForm1
  Left = 310
  Top = 143
  Width = 638
  Height = 457
  Caption = #25622#25622#26834#25991#23383#29986#29983#22120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 288
    Top = 48
    Width = 24
    Height = 24
  end
  object Label1: TLabel
    Left = 136
    Top = 144
    Width = 7
    Height = 13
    Caption = 'X'
  end
  object Label2: TLabel
    Left = 208
    Top = 144
    Width = 7
    Height = 13
    Caption = 'Y'
  end
  object Label3: TLabel
    Left = 112
    Top = 48
    Width = 27
    Height = 13
    Caption = #22823#23567' '
  end
  object Label4: TLabel
    Left = 112
    Top = 80
    Width = 27
    Height = 13
    Caption = #23383#39636' '
  end
  object Label5: TLabel
    Left = 112
    Top = 112
    Width = 27
    Height = 13
    Caption = #25991#23383' '
  end
  object Button1: TButton
    Left = 16
    Top = 48
    Width = 75
    Height = 25
    Caption = #29986#29983'Table'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 152
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 152
    Top = 48
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = '18'
    Items.Strings = (
      '8'
      '10'
      '12'
      '14'
      '16'
      '17'
      '18')
  end
  object ComboBox2: TComboBox
    Left = 152
    Top = 80
    Width = 121
    Height = 21
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 3
    Text = #27161#26999#39636
    Items.Strings = (
      #26032#32048#26126#39636
      #27161#26999#39636)
  end
  object Edit1: TEdit
    Left = 152
    Top = 144
    Width = 49
    Height = 21
    TabOrder = 4
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit3: TEdit
    Left = 224
    Top = 144
    Width = 49
    Height = 21
    TabOrder = 5
    Text = '0'
    OnChange = Edit3Change
  end
  object Button2: TButton
    Left = 16
    Top = 88
    Width = 75
    Height = 25
    Caption = #32080#26463#31243#24335
    TabOrder = 6
    OnClick = Button2Click
  end
  object RichEdit1: TRichEdit
    Left = 336
    Top = 16
    Width = 273
    Height = 393
    Font.Charset = CHINESEBIG5_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    TabOrder = 7
  end
end
