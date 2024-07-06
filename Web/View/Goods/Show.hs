module Web.View.Goods.Show where
import Web.View.Prelude

data ShowView = ShowView { good :: Good }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Good</h1>
        <p>{good}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Goods" GoodsAction
                            , breadcrumbText "Show Good"
                            ]