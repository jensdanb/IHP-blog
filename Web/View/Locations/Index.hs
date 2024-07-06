module Web.View.Locations.Index where
import Web.View.Prelude

data IndexView = IndexView { locations :: [Location] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewLocationAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Location</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach locations renderLocation}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Locations" LocationsAction
                ]

renderLocation :: Location -> Html
renderLocation location = [hsx|
    <tr>
        <td>{location}</td>
        <td><a href={ShowLocationAction location.id}>Show</a></td>
        <td><a href={EditLocationAction location.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteLocationAction location.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]