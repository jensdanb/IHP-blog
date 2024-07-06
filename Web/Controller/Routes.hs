module Web.Controller.Routes where

import Web.Controller.Prelude
import Web.View.Routes.Index
import Web.View.Routes.New
import Web.View.Routes.Edit
import Web.View.Routes.Show

instance Controller RoutesController where
    action RoutesAction = do
        routes <- query @Route |> fetch
        render IndexView { .. }

    action NewRouteAction = do
        let route = newRecord
        render NewView { .. }

    action ShowRouteAction { routeId } = do
        route <- fetch routeId
        render ShowView { .. }

    action EditRouteAction { routeId } = do
        route <- fetch routeId
        render EditView { .. }

    action UpdateRouteAction { routeId } = do
        route <- fetch routeId
        route
            |> buildRoute
            |> ifValid \case
                Left route -> render EditView { .. }
                Right route -> do
                    route <- route |> updateRecord
                    setSuccessMessage "Route updated"
                    redirectTo EditRouteAction { .. }

    action CreateRouteAction = do
        let route = newRecord @Route
        route
            |> buildRoute
            |> ifValid \case
                Left route -> render NewView { .. } 
                Right route -> do
                    route <- route |> createRecord
                    setSuccessMessage "Route created"
                    redirectTo RoutesAction

    action DeleteRouteAction { routeId } = do
        route <- fetch routeId
        deleteRecord route
        setSuccessMessage "Route deleted"
        redirectTo RoutesAction

buildRoute route = route
    |> fill @'["fromStockId", "toStockId"]
