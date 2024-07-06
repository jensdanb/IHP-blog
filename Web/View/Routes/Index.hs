module Web.View.Routes.Index where
import Web.View.Prelude

data IndexView = IndexView { routes :: [Route] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewRouteAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Route</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach routes renderRoute}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Routes" RoutesAction
                ]

renderRoute :: Route -> Html
renderRoute route = [hsx|
    <tr>
        <td>{route}</td>
        <td><a href={ShowRouteAction route.id}>Show</a></td>
        <td><a href={EditRouteAction route.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteRouteAction route.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]