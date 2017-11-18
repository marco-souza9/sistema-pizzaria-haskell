{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Produto where

import Import

getProdutoListarR :: Handler Html
getProdutoListarR = undefined

getProdutoDetalharR :: ProdutoId -> Handler Html
getProdutoDetalharR id = undefined

getAdmProdutoCadastrarR :: Handler Html
getAdmProdutoCadastrarR = undefined

postAdmProdutoCadastrarR :: Handler Html
postAdmProdutoCadastrarR = undefined

getAdmProdutoListarR :: Handler Html
getAdmProdutoListarR = undefined

postAdmProdutoListarR :: Handler Html
postAdmProdutoListarR = undefined

getAdmProdutoAlterarR :: ProdutoId -> Handler Html
getAdmProdutoAlterarR id = undefined

postAdmProdutoAlterarR :: ProdutoId -> Handler Html
postAdmProdutoAlterarR id = undefined