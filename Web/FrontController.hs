module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Routes
import Web.Controller.Stocks
import Web.Controller.Locations
import Web.Controller.Goods
import Web.Controller.Companies
import Web.Controller.Comments
import Web.Controller.Posts
import Web.Controller.Static

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @RoutesController
        , parseRoute @StocksController
        , parseRoute @LocationsController
        , parseRoute @GoodsController
        , parseRoute @CompaniesController
        , parseRoute @CommentsController
        , parseRoute @PostsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
