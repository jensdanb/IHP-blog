module Web.View.Games.Edit where
import Web.View.Prelude

data EditView = EditView { game :: Game }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Game</h1>
        {renderForm game}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Games" GamesAction
                , breadcrumbText "Edit Game"
                ]

renderForm :: Game -> Html
renderForm game = formFor game [hsx|
    
    {submitButton}

|]