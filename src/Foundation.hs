{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Foundation where

import Import.NoFoundation
import Database.Persist.Sql (ConnectionPool, runSqlPool)
import Yesod.Core.Types     (Logger)

data App = App
    { appSettings    :: AppSettings
    , appStatic      :: Static 
    , appConnPool    :: ConnectionPool 
    , appHttpManager :: Manager
    , appLogger      :: Logger
    }

mkYesodData "App" $(parseRoutesFile "config/routes")

type Form a = Html -> MForm Handler (FormResult a, Widget)

instance Yesod App where
    makeLogger = return . appLogger
    authRoute _ = Just $ LoginR
    isAuthorized HomeR _ = return Authorized
    isAuthorized LoginR _ = return Authorized
    isAuthorized LogoutR _ = return Authorized
    isAuthorized CadastroR _ = return Authorized    
    isAuthorized (StaticR _) _ = return Authorized
    isAuthorized FaviconR _ = return Authorized
    isAuthorized RobotsR _ = return Authorized
    isAuthorized AdmPedidoListarR _ = verificaAdmin
    isAuthorized (AdmPedidoDetalharR _) _ = verificaAdmin
    isAuthorized (AdmPedidoAlterarR _) _ = verificaAdmin
    isAuthorized AdmProdutoGerenciarR _ = verificaAdmin
    isAuthorized AdmProdutoCadastrarR _ = verificaAdmin
    isAuthorized AdmProdutoAlterarR _ = verificaAdmin
    isAuthorized AdmFormPagGerenciarR _ = verificaAdmin
    isAuthorized AdmFormPagCadastrarR _ = verificaAdmin
    isAuthorized AdmFormPagAlterarR _ = verificaAdmin
    isAuthorized _ _ = verificaUsuario

verificaAdmin :: Handler AuthResult
verificaAdmin = do
    sessao <- lookupSession "usuTipo"
    case sessao of 
        Nothing -> return AuthenticationRequired
        (Just "2") -> return $ Unauthorized "Apenas administradores" 
        (Just _ ) -> return Authorized
    
verificaUsuario :: Handler AuthResult
verificaUsuario = do
    sessao <- lookupSession "usuTipo"
    case sessao of 
        Nothing -> return AuthenticationRequired
        (Just "2") -> return Authorized
        (Just _) -> return $ Unauthorized "Apenas usuários" 

removeCaracteres :: String -> String -> String
removeCaracteres original removidos = [char | char <- original, notElem char removidos]

instance YesodPersist App where
    type YesodPersistBackend App = SqlBackend
    runDB action = do
        master <- getYesod
        runSqlPool action $ appConnPool master

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

instance HasHttpManager App where
    getHttpManager = appHttpManager
