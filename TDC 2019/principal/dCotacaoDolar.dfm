object dmdCotacaoDolar: TdmdCotacaoDolar
  OldCreateOrder = False
  Height = 307
  Width = 303
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/datasnap/rest/api'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 56
    Top = 24
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'CotacaoDolar'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 56
    Top = 80
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 56
    Top = 136
  end
end
