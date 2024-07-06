module Web.View.Stocks.New where
import Web.View.Prelude

data NewView = NewView { stock :: Stock }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Stock</h1>
        {renderForm stock}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Stocks" StocksAction
                , breadcrumbText "New Stock"
                ]

renderForm :: Stock -> Html
renderForm stock = formFor stock [hsx|
    {(textField #goodId)}
    {(textField #locationId)}
    {submitButton}

|]