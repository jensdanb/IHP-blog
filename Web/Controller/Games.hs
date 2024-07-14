module Web.Controller.Games where

import Web.Controller.Prelude
import Web.View.Games.Index
import Web.View.Games.New
import Web.View.Games.Edit
import Web.View.Games.Show
import Web.View.Games.Play

instance Controller GamesController where
    action GamesAction = do
        games <- query @Game |> fetch
        render IndexView { .. }

    action NewGameAction = do
        let game = newRecord
        render NewView { .. }

    action ShowGameAction { gameId } = do
        game <- fetch gameId
        render ShowView { .. }
    
    action PlayGameAction { gameId } = do
        game <- fetch gameId
        render PlayView { .. }

    action EditGameAction { gameId } = do
        game <- fetch gameId
        render EditView { .. }

    action UpdateGameAction { gameId } = do
        game <- fetch gameId
        game
            |> buildGame
            |> ifValid \case
                Left game -> render EditView { .. }
                Right game -> do
                    game <- game |> updateRecord
                    setSuccessMessage "Game updated"
                    redirectTo EditGameAction { .. }

    action CreateGameAction = do
        let game = newRecord @Game
        game
            |> buildGame
            |> ifValid \case
                Left game -> render NewView { .. } 
                Right game -> do
                    game <- game |> createRecord
                    company <- addDefaultCompany game.id
                    setSuccessMessage "Game created"
                    redirectTo GamesAction

    action DeleteGameAction { gameId } = do
        game <- fetch gameId
        deleteRecord game
        setSuccessMessage "Game deleted"
        redirectTo GamesAction

buildGame game = game
    |> fill @'["title"]
    |> validateField #title nonEmpty

addDefaultCompany gameID = newRecord @Company 
    |> set #gameId gameID 
    |> set #name "Gentian"
    |> createRecord