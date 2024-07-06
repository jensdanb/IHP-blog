module Web.View.Goods.Edit where
import Web.View.Prelude

data EditView = EditView { good :: Good }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Good</h1>
        {renderForm good}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Goods" GoodsAction
                , breadcrumbText "Edit Good"
                ]

renderForm :: Good -> Html
renderForm good = formFor good [hsx|
    {(textField #name)}
    {(textField #forSale)}
    {(textField #cost)}
    {(textField #price)}
    {submitButton}

|]