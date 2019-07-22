inherited frmAdicionarProduto: TfrmAdicionarProduto
  Caption = 'Adicionar Produto'
  ClientHeight = 219
  ClientWidth = 890
  ExplicitWidth = 906
  ExplicitHeight = 258
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 40
    Top = 40
    Width = 217
    Height = 41
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lblNome
        Row = 0
      end
      item
        Column = 0
        Control = edtNome
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 21.000000000000000000
      end>
    TabOrder = 0
    object lblNome: TLabel
      Left = 0
      Top = 7
      Width = 217
      Height = 13
      Align = alBottom
      Caption = 'Nome'
      ExplicitLeft = 17
      ExplicitTop = 1
    end
    object edtNome: TEdit
      Left = 0
      Top = 20
      Width = 217
      Height = 21
      Align = alClient
      TabOrder = 0
    end
  end
  object GridPanel2: TGridPanel
    Left = 280
    Top = 40
    Width = 113
    Height = 41
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lblValorInicial
        Row = 0
      end
      item
        Column = 0
        Control = edtValorInicial
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 21.000000000000000000
      end>
    TabOrder = 1
    object lblValorInicial: TLabel
      Left = 0
      Top = 7
      Width = 113
      Height = 13
      Align = alBottom
      Caption = 'Valor Inicial'
      ExplicitLeft = -16
      ExplicitTop = 15
    end
    object edtValorInicial: TEdit
      Left = 0
      Top = 20
      Width = 113
      Height = 21
      Align = alClient
      TabOrder = 0
      Text = '10'
    end
  end
  object GridPanel3: TGridPanel
    Left = 399
    Top = 40
    Width = 113
    Height = 41
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lblValorFinal
        Row = 0
      end
      item
        Column = 0
        Control = edtValorFinal
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 21.000000000000000000
      end>
    TabOrder = 2
    object lblValorFinal: TLabel
      Left = 0
      Top = 7
      Width = 113
      Height = 13
      Align = alBottom
      Caption = 'Valor Final'
      ExplicitWidth = 49
    end
    object edtValorFinal: TEdit
      Left = 0
      Top = 20
      Width = 113
      Height = 21
      Align = alClient
      TabOrder = 0
      Text = '50'
    end
  end
  object GridPanel4: TGridPanel
    Left = 532
    Top = 40
    Width = 113
    Height = 41
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lblEstoqueInicial
        Row = 0
      end
      item
        Column = 0
        Control = edtEstoqueInicial
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 21.000000000000000000
      end>
    TabOrder = 3
    object lblEstoqueInicial: TLabel
      Left = 0
      Top = 7
      Width = 113
      Height = 13
      Align = alBottom
      Caption = 'Estoque Inicial'
      ExplicitWidth = 69
    end
    object edtEstoqueInicial: TEdit
      Left = 0
      Top = 20
      Width = 113
      Height = 21
      Align = alClient
      TabOrder = 0
      Text = '50'
    end
  end
  object GridPanel5: TGridPanel
    Left = 660
    Top = 40
    Width = 113
    Height = 41
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = lblEstoqueFinal
        Row = 0
      end
      item
        Column = 0
        Control = edtEstoqueFinal
        Row = 1
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 21.000000000000000000
      end>
    TabOrder = 4
    object lblEstoqueFinal: TLabel
      Left = 0
      Top = 7
      Width = 113
      Height = 13
      Align = alBottom
      Caption = 'Estoque Final'
      ExplicitWidth = 64
    end
    object edtEstoqueFinal: TEdit
      Left = 0
      Top = 20
      Width = 113
      Height = 21
      Align = alClient
      TabOrder = 0
      Text = '500'
    end
  end
  object btnAdicionar: TButton
    Left = 779
    Top = 58
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    Default = True
    TabOrder = 5
    OnClick = btnAdicionarClick
  end
  object mmoLog: TMemo
    Left = 40
    Top = 112
    Width = 814
    Height = 73
    TabOrder = 6
  end
  object qryAdicionarProduto: TFDQuery
    Connection = dmdConexao.FDConnection
    SQL.Strings = (
      'insert into produto ('
      '  nome'
      ' ,valor_unitario'
      ' ,estoque_local)'
      'values ('
      '  :nome'
      ' ,:valor_unitario'
      ' ,:estoque_local)')
    Left = 216
    Top = 8
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'VALOR_UNITARIO'
        ParamType = ptInput
      end
      item
        Name = 'ESTOQUE_LOCAL'
        ParamType = ptInput
      end>
  end
end
