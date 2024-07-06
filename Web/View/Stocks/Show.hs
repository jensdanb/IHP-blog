module Web.View.Stocks.Show where
import Web.View.Prelude

data ShowView = ShowView { stock :: Stock }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Stock</h1>
        <p>{stock}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Stocks" StocksAction
                            , breadcrumbText "Show Stock"
                            ]