module Web.View.Locations.New where
import Web.View.Prelude

data NewView = NewView { location :: Location }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Location</h1>
        {renderForm location}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Locations" LocationsAction
                , breadcrumbText "New Location"
                ]

renderForm :: Location -> Html
renderForm location = formFor location [hsx|
    {(textField #companyId)}
    {submitButton}

|]