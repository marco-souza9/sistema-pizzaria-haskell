{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Telefone where

import Import

getTelefoneCadastrarR :: Handler Html
getTelefoneCadastrarR = undefined

postTelefoneCadastrarR :: Handler Html
postTelefoneCadastrarR = undefined

getTelefoneListarR :: Handler Html
getTelefoneListarR = undefined

getTelefoneAlterarR :: TelefoneId -> Handler Html
getTelefoneAlterarR id = undefined

postTelefoneAlterarR :: TelefoneId -> Handler Html
postTelefoneAlterarR id = undefined