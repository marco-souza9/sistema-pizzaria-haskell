{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.Login where


import Import
import Yesod.Form.Bootstrap3
import Database.Persist.Postgresql

formLogin :: Form (Text,Text)
formLogin = renderBootstrap3 BootstrapBasicForm $ (,)
    <$> areq emailField emailSettings Nothing
    <*> areq passwordField senhaSettings Nothing
        where emailSettings = FieldSettings{fsId= Nothing,
                    fsLabel= "",
                    fsTooltip= Nothing,
                    fsName= Nothing,
                    fsAttrs=[("class","form-control"),("placeholder","E-mail"),("maxlength","255")]}
              senhaSettings = FieldSettings{fsId= Nothing,
                    fsLabel= "",
                    fsTooltip= Nothing,
                    fsName= Nothing,
                    fsAttrs=[("class","form-control"),("placeholder","Senha"),("maxlength","16")]}

autenticar :: Text -> Text -> HandlerT App IO (Maybe (Entity Usuario))
autenticar email senha = runDB $ selectFirst [UsuarioEmail ==. email
                                             ,UsuarioSenha ==. senha] []


controlarRedirecionamento :: Int -> Route App
controlarRedirecionamento 1 = AdmPedidoListarR
controlarRedirecionamento 2 = ProdutoListarR
controlarRedirecionamento _ = HomeR

getLoginR :: Handler Html
getLoginR =  do 
    (widget, enctype) <- generateFormPost formLogin
    msg <- getMessage
    defaultLayout $ do
        setTitle "Entrar"
        --css estático
        addStylesheet $ (StaticR css_bootstrap_css)
        addStylesheet $ (StaticR css_font_awesome_min_css)
        addStylesheet $ (StaticR css_jquery_ui_css)
        addStylesheet $ (StaticR css_main_css)
        addStylesheet $ (StaticR css_normalize_css)
        addStylesheet $ (StaticR css_picto_foundry_food_css)
        addStylesheet $ (StaticR css_style_portfolio_css)
        --corpo html
        $(whamletFile "templates/login.hamlet")
        --javascript estático
        addScript $ (StaticR js_jquery_1_10_2_min_js) 
        addScript $ (StaticR js_jquery_1_10_2_js)        
        addScript $ (StaticR js_jquery_mixitup_min_js)
        addScript $ (StaticR js_bootstrap_min_js)
        addScript $ (StaticR js_main_js) 
     

postLoginR :: Handler Html
postLoginR = do
    ((res,_),_) <- runFormPost formLogin
    case res of 
        FormSuccess (email,senha) -> do 
            usuario <- autenticar email senha 
            case usuario of 
                Nothing -> do 
                    setMessage $ [shamlet| Usuario e/ou senha invalido. |]
                    redirect LoginR 
                Just (Entity usuid usuario) -> do
                    setSession "usuId" $ pack $ show $ fromSqlKey usuid
                    setSession "usuTipo" $ pack $ show (usuarioTipo usuario)
                    redirect $ controlarRedirecionamento $ usuarioTipo usuario
        _ -> redirect HomeR

getLogoutR :: Handler Html
getLogoutR = do 
    deleteSession "usuCpf"
    deleteSession "usuTipo"
    redirect HomeR