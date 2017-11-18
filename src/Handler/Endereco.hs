{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Endereco where

import Import

getEnderecoCadastrarR :: Handler Html
getEnderecoCadastrarR = undefined

postEnderecoCadastrarR :: Handler Html
postEnderecoCadastrarR = undefined

getEnderecoListarR :: Handler Html
getEnderecoListarR = undefined

getEnderecoDetalharR :: EnderecoId -> Handler Html
getEnderecoDetalharR id = undefined

getEnderecoAlterarR :: EnderecoId -> Handler Html
getEnderecoAlterarR id = undefined

postEnderecoAlterarR ::EnderecoId -> Handler Html
postEnderecoAlterarR id = undefined