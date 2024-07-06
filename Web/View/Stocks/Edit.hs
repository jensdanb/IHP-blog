module Web.View.Stocks.Edit where
import Web.View.Prelude

data EditView = EditView { stock :: Stock }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Stock</h1>
        {renderForm stock}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Stocks" StocksAction
                , breadcrumbText "Edit Stock"
                ]

renderForm :: Stock -> Html
renderForm stock = formFor stock [hsx|
    {(textField #goodId)}
    {(textField #locationId)}
    {submitButton}

|]