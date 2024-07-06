module Web.Controller.Goods where

import Web.Controller.Prelude
import Web.View.Goods.Index
import Web.View.Goods.New
import Web.View.Goods.Edit
import Web.View.Goods.Show

instance Controller GoodsController where
    action GoodsAction = do
        goods <- query @Good |> fetch
        render IndexView { .. }

    action NewGoodAction = do
        let good = newRecord
        render NewView { .. }

    action ShowGoodAction { goodId } = do
        good <- fetch goodId
        render ShowView { .. }

    action EditGoodAction { goodId } = do
        good <- fetch goodId
        render EditView { .. }

    action UpdateGoodAction { goodId } = do
        good <- fetch goodId
        good
            |> buildGood
            |> ifValid \case
                Left good -> render EditView { .. }
                Right good -> do
                    good <- good |> updateRecord
                    setSuccessMessage "Good updated"
                    redirectTo EditGoodAction { .. }

    action CreateGoodAction = do
        let good = newRecord @Good
        good
            |> buildGood
            |> ifValid \case
                Left good -> render NewView { .. } 
                Right good -> do
                    good <- good |> createRecord
                    setSuccessMessage "Good created"
                    redirectTo GoodsAction

    action DeleteGoodAction { goodId } = do
        good <- fetch goodId
        deleteRecord good
        setSuccessMessage "Good deleted"
        redirectTo GoodsAction

buildGood good = good
    |> fill @'["name", "forSale", "cost", "price"]
