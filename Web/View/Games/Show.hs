module Web.View.Games.Show where
import Web.View.Prelude
import IHP.HSX.ToHtml (toHtml)

data ShowView = ShowView { game :: Game }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Game</h1>
        <p>{game}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Games" GamesAction
                            , breadcrumbText $ toHtml game.title
                            ]