{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.FormaPagamento where

import Import

formCadastro :: Form (Text)
formCadastro = renderDivs $ areq textField formaSettings Nothing
    where formaSettings = FieldSettings{fsId= Nothing,
                           fsLabel= "",
                           fsTooltip= Nothing,
                           fsName= Nothing,
                           fsAttrs=[("class","form-control"),("placeholder","Forma de pagamento"),("maxlength","30")]}

verificarStatusFormaPagamento :: Bool -> Text
verificarStatusFormaPagamento True = "Desabilitar" 
verificarStatusFormaPagamento _ = "Habilitar"

postAdmFormPagCadastrarR :: Handler Html
postAdmFormPagCadastrarR = do 
    ((res,_),_) <- runFormPost formCadastro
    case res of 
        FormSuccess (formaF) -> do 
            _ <- runDB $ insert (FormaPagamento formaF True)  
            redirect $ AdmFormPagGerenciarR
        _ -> redirect $ AdmFormPagGerenciarR

postAdmFormPagAlterarR :: Handler Html
postAdmFormPagAlterarR = undefined

getAdmFormPagGerenciarR :: Handler Html
getAdmFormPagGerenciarR = do
    formas <- runDB $ selectList ([] :: [Filter FormaPagamento]) []
    (widget, enctype) <- generateFormPost formCadastro
    defaultLayout $ do
        setTitle "Gerenciar Forma de Pagamento"
        --css estático
        addStylesheet $ (StaticR css_bootstrap_css)
        addStylesheet $ (StaticR css_font_awesome_min_css)
        addStylesheet $ (StaticR css_jquery_ui_css)
        addStylesheet $ (StaticR css_main_css)
        addStylesheet $ (StaticR css_normalize_css)
        addStylesheet $ (StaticR css_picto_foundry_food_css)
        addStylesheet $ (StaticR css_style_portfolio_css)
        --corpo html
        $(whamletFile "templates/commons/navbaradm.hamlet")
        $(whamletFile "templates/gerenciarFormaPagamento.hamlet")
        --javascript estátic7o
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_jquery_mask_js)
        addScript $ (StaticR js_jquery_mask_min_js)
        addScript $ (StaticR js_mascaras_js)
        addScript $ (StaticR js_main_js) 
