module Web.View.Locations.Edit where
import Web.View.Prelude

data EditView = EditView { location :: Location }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Location</h1>
        {renderForm location}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Locations" LocationsAction
                , breadcrumbText "Edit Location"
                ]

renderForm :: Location -> Html
renderForm location = formFor location [hsx|
    {(textField #companyId)}
    {submitButton}

|]