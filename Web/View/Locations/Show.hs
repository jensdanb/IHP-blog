module Web.View.Locations.Show where
import Web.View.Prelude

data ShowView = ShowView { location :: Location }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Location</h1>
        <p>{location}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Locations" LocationsAction
                            , breadcrumbText "Show Location"
                            ]