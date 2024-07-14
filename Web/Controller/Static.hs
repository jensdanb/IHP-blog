module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome
import Web.View.Static.Home

instance Controller StaticController where
    action WelcomeAction = do 
        games <- query @Game
            |> orderByDesc #createdAt
            |> fetch
        render WelcomeView {..}

    action HomeAction = do 
        games <- query @Game
            |> orderByDesc #createdAt
            |> fetch
        render HomeView {..}
