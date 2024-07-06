module Web.View.Goods.New where
import Web.View.Prelude

data NewView = NewView { good :: Good }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Good</h1>
        {renderForm good}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Goods" GoodsAction
                , breadcrumbText "New Good"
                ]

renderForm :: Good -> Html
renderForm good = formFor good [hsx|
    {(textField #name)}
    {(textField #forSale)}
    {(textField #cost)}
    {(textField #price)}
    {submitButton}

|]