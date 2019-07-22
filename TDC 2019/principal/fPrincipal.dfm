object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  ActiveControl = btnProcessar
  Caption = 'TDC 2019'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menPrincipal
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnProcessar2: TButton
    Left = 8
    Top = 39
    Width = 201
    Height = 25
    Caption = 'Processar 2'
    TabOrder = 1
    OnClick = btnProcessar2Click
  end
  object btnProcessar: TButton
    Left = 8
    Top = 8
    Width = 201
    Height = 25
    Caption = 'Processar'
    TabOrder = 0
    OnClick = btnProcessarClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <
      item
        Width = 150
      end>
  end
  object menPrincipal: TMainMenu
    Left = 560
    Top = 24
    object mniCadastro: TMenuItem
      Caption = 'Cadastros'
      object mniAdicionar: TMenuItem
        Caption = 'Adicionar Rapidamente'
        object mniAdicionarProduto: TMenuItem
          Caption = 'Produto'
          OnClick = mniAdicionarProdutoClick
        end
      end
    end
    object mniEstoque: TMenuItem
      Caption = 'Estoque'
      object mniEstoqueProdutos: TMenuItem
        Caption = 'Estoque dos Produtos'
        OnClick = mniEstoqueProdutosClick
      end
    end
    object mniPedido: TMenuItem
      Caption = 'Pedido'
      object mniFazerPedido: TMenuItem
        Caption = 'Fazer Pedido'
        OnClick = mniFazerPedidoClick
      end
    end
  end
  object NotificationCenter: TNotificationCenter
    Left = 496
    Top = 24
  end
end
