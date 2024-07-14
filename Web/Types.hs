module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController 
    = WelcomeAction 
    | HomeAction
    deriving (Eq, Show, Data)

data PostsController
    = PostsAction
    | NewPostAction
    | ShowPostAction { postId :: !(Id Post) }
    | CreatePostAction
    | EditPostAction { postId :: !(Id Post) }
    | UpdatePostAction { postId :: !(Id Post) }
    | DeletePostAction { postId :: !(Id Post) }
    deriving (Eq, Show, Data)

data CommentsController
    = CommentsAction
    | NewCommentAction { postId :: !(Id Post) }
    | ShowCommentAction { commentId :: !(Id Comment) }
    | CreateCommentAction
    | EditCommentAction { commentId :: !(Id Comment) }
    | UpdateCommentAction { commentId :: !(Id Comment) }
    | DeleteCommentAction { commentId :: !(Id Comment) }
    deriving (Eq, Show, Data)

data CompaniesController
    = CompaniesAction
    | NewCompanyAction
    | ShowCompanyAction { companyId :: !(Id Company) }
    | CreateCompanyAction
    | EditCompanyAction { companyId :: !(Id Company) }
    | UpdateCompanyAction { companyId :: !(Id Company) }
    | DeleteCompanyAction { companyId :: !(Id Company) }
    deriving (Eq, Show, Data)

data GoodsController
    = GoodsAction
    | NewGoodAction
    | ShowGoodAction { goodId :: !(Id Good) }
    | CreateGoodAction
    | EditGoodAction { goodId :: !(Id Good) }
    | UpdateGoodAction { goodId :: !(Id Good) }
    | DeleteGoodAction { goodId :: !(Id Good) }
    deriving (Eq, Show, Data)

data LocationsController
    = LocationsAction
    | NewLocationAction
    | ShowLocationAction { locationId :: !(Id Location) }
    | CreateLocationAction
    | EditLocationAction { locationId :: !(Id Location) }
    | UpdateLocationAction { locationId :: !(Id Location) }
    | DeleteLocationAction { locationId :: !(Id Location) }
    deriving (Eq, Show, Data)

data StocksController
    = StocksAction
    | NewStockAction
    | ShowStockAction { stockId :: !(Id Stock) }
    | CreateStockAction
    | EditStockAction { stockId :: !(Id Stock) }
    | UpdateStockAction { stockId :: !(Id Stock) }
    | DeleteStockAction { stockId :: !(Id Stock) }
    deriving (Eq, Show, Data)

data RoutesController
    = RoutesAction
    | NewRouteAction
    | ShowRouteAction { routeId :: !(Id Route) }
    | CreateRouteAction
    | EditRouteAction { routeId :: !(Id Route) }
    | UpdateRouteAction { routeId :: !(Id Route) }
    | DeleteRouteAction { routeId :: !(Id Route) }
    deriving (Eq, Show, Data)

data GamesController
    = GamesAction
    | NewGameAction
    | ShowGameAction { gameId :: !(Id Game) }
    | PlayGameAction { gameId :: !(Id Game) }
    | CreateGameAction
    | EditGameAction { gameId :: !(Id Game) }
    | UpdateGameAction { gameId :: !(Id Game) }
    | DeleteGameAction { gameId :: !(Id Game) }
    deriving (Eq, Show, Data)
