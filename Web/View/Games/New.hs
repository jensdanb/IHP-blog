module Web.View.Games.New where
import Web.View.Prelude

data NewView = NewView { game :: Game }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Game</h1>
        {renderForm game}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Games" GamesAction
                , breadcrumbText "New Game"
                ]

renderForm :: Game -> Html
renderForm game = formFor game [hsx|
    {((textField #title))}
    {submitButton}

|]