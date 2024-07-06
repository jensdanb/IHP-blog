module Web.Controller.Stocks where

import Web.Controller.Prelude
import Web.View.Stocks.Index
import Web.View.Stocks.New
import Web.View.Stocks.Edit
import Web.View.Stocks.Show

instance Controller StocksController where
    action StocksAction = do
        stocks <- query @Stock |> fetch
        render IndexView { .. }

    action NewStockAction = do
        let stock = newRecord
        render NewView { .. }

    action ShowStockAction { stockId } = do
        stock <- fetch stockId
        render ShowView { .. }

    action EditStockAction { stockId } = do
        stock <- fetch stockId
        render EditView { .. }

    action UpdateStockAction { stockId } = do
        stock <- fetch stockId
        stock
            |> buildStock
            |> ifValid \case
                Left stock -> render EditView { .. }
                Right stock -> do
                    stock <- stock |> updateRecord
                    setSuccessMessage "Stock updated"
                    redirectTo EditStockAction { .. }

    action CreateStockAction = do
        let stock = newRecord @Stock
        stock
            |> buildStock
            |> ifValid \case
                Left stock -> render NewView { .. } 
                Right stock -> do
                    stock <- stock |> createRecord
                    setSuccessMessage "Stock created"
                    redirectTo StocksAction

    action DeleteStockAction { stockId } = do
        stock <- fetch stockId
        deleteRecord stock
        setSuccessMessage "Stock deleted"
        redirectTo StocksAction

buildStock stock = stock
    |> fill @'["goodId", "locationId"]
