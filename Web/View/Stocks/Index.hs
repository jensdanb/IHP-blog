module Web.View.Stocks.Index where
import Web.View.Prelude

data IndexView = IndexView { stocks :: [Stock] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewStockAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Stock</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach stocks renderStock}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Stocks" StocksAction
                ]

renderStock :: Stock -> Html
renderStock stock = [hsx|
    <tr>
        <td>{stock}</td>
        <td><a href={ShowStockAction stock.id}>Show</a></td>
        <td><a href={EditStockAction stock.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteStockAction stock.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]