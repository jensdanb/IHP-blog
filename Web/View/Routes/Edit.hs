module Web.View.Routes.Edit where
import Web.View.Prelude

data EditView = EditView { route :: Route }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Route</h1>
        {renderForm route}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Routes" RoutesAction
                , breadcrumbText "Edit Route"
                ]

renderForm :: Route -> Html
renderForm route = formFor route [hsx|
    {(textField #fromStockId)}
    {(textField #toStockId)}
    {submitButton}

|]