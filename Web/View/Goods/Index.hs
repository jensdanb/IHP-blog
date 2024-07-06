module Web.View.Goods.Index where
import Web.View.Prelude

data IndexView = IndexView { goods :: [Good] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewGoodAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Good</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach goods renderGood}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Goods" GoodsAction
                ]

renderGood :: Good -> Html
renderGood good = [hsx|
    <tr>
        <td>{good}</td>
        <td><a href={ShowGoodAction good.id}>Show</a></td>
        <td><a href={EditGoodAction good.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteGoodAction good.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]