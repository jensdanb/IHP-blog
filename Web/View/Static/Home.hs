module Web.View.Static.Home where
import Web.View.Prelude
import Web.View.Games.Index ( gamesTable )

data HomeView = HomeView {games :: [Game]}

instance View HomeView where
    html HomeView {..} = [hsx|

         <div style="max-width: 800px; margin-left: auto; margin-right: auto; margin-top: 4rem">
              <img src="/ihp-Home-icon.svg" alt="/ihp-Home-icon" style="width:100%;">
              <p style="color: hsla(196, 13%, 50%, 1); margin-top: 4rem">
                 You can modify this start page by making changes to "./Web/View/Static/Home.hs".
              </p>
         </div> 
         
         <div style="margin-top: 2rem">
            {gamesTable games} 
        </div>
         
|]