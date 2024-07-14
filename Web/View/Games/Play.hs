module Web.View.Games.Play where
import Web.View.Prelude
import IHP.HSX.ToHtml (toHtml)

data PlayView = PlayView { game :: Game }

instance View PlayView where
    html PlayView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Game</h1>
        <p>{game}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Games" HomeAction
                            , breadcrumbText $ toHtml game.title
                            ]