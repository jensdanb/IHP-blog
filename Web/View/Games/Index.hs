module Web.View.Games.Index where
import Web.View.Prelude

data IndexView = IndexView { games :: [Game] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}
        {gamesTable games}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Games" GamesAction
                ]

gamesTable :: [Game] -> Html
gamesTable games = [hsx| 
    <h1>Games<a href={pathTo NewGameAction} class="btn btn-primary ms-4">+ New</a></h1>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>Game</th>
                    <th>Score</th>
                    <th></th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>{forEach games renderGame}</tbody>
        </table>
        
    </div>
|]

renderGame :: Game -> Html
renderGame game = [hsx|
    <tr>
        <td>{game.title}</td>
        <td>{game.score}</td>
        <td><a href={ShowGameAction game.id}>Play</a></td>
        <td><a href={EditGameAction game.id} class="">Edit</a></td>
        <td><a href={DeleteGameAction game.id} class="js-delete">Delete</a></td>
    </tr>
|]