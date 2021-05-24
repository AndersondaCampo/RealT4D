object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'RealT4D'
  ClientHeight = 617
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MaxHeight = 656
  Constraints.MaxWidth = 800
  Constraints.MinHeight = 656
  Constraints.MinWidth = 790
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 33
    Top = 38
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object Label2: TLabel
    Left = 396
    Top = 38
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label3: TLabel
    Left = 39
    Top = 65
    Width = 18
    Height = 13
    Caption = 'Key'
  end
  object Label4: TLabel
    Left = 28
    Top = 92
    Width = 29
    Height = 13
    Caption = 'Token'
  end
  object Label5: TLabel
    Left = 12
    Top = 119
    Width = 45
    Height = 13
    Caption = 'Resource'
  end
  object Label6: TLabel
    Left = 9
    Top = 315
    Width = 48
    Height = 13
    Caption = 'Resultado'
  end
  object Label7: TLabel
    Left = 12
    Top = 11
    Width = 45
    Height = 13
    Caption = 'Base URL'
  end
  object edtEmail: TEdit
    Left = 63
    Top = 35
    Width = 306
    Height = 21
    TabOrder = 0
  end
  object edtSenha: TEdit
    Left = 432
    Top = 35
    Width = 145
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtKey: TEdit
    Left = 63
    Top = 62
    Width = 514
    Height = 21
    TabOrder = 2
  end
  object btnAuth: TButton
    Left = 583
    Top = 35
    Width = 190
    Height = 21
    Caption = 'Sign In'
    TabOrder = 3
    OnClick = btnAuthClick
  end
  object edtToken: TEdit
    Left = 63
    Top = 89
    Width = 514
    Height = 21
    TabOrder = 4
  end
  object edtResource: TEdit
    Left = 63
    Top = 116
    Width = 514
    Height = 21
    TabOrder = 5
  end
  object btnExec: TButton
    Left = 583
    Top = 116
    Width = 190
    Height = 21
    Caption = 'Executar'
    TabOrder = 6
    OnClick = btnExecClick
  end
  object Button1: TButton
    Left = 583
    Top = 250
    Width = 190
    Height = 21
    Caption = 'Salvar Registro'
    TabOrder = 7
    OnClick = Button1Click
  end
  object btnNewAccount: TButton
    Left = 583
    Top = 62
    Width = 190
    Height = 21
    Caption = 'New Account'
    TabOrder = 8
    OnClick = btnNewAccountClick
  end
  object edtBaseURL: TEdit
    Left = 63
    Top = 8
    Width = 514
    Height = 21
    TabOrder = 9
  end
  object Button2: TButton
    Left = 583
    Top = 277
    Width = 190
    Height = 21
    Caption = 'Editar Registro'
    TabOrder = 10
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 63
    Top = 143
    Width = 514
    Height = 155
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 11
    object mmData: TMemo
      Left = 0
      Top = 0
      Width = 514
      Height = 155
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitTop = -115
      ExplicitWidth = 185
      ExplicitHeight = 165
    end
  end
  object Panel2: TPanel
    Left = 63
    Top = 312
    Width = 514
    Height = 298
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 12
    object mmResult: TMemo
      Left = 0
      Top = 0
      Width = 514
      Height = 298
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = -51
      ExplicitHeight = 320
    end
  end
end
