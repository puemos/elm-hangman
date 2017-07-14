module View exposing (view)

import Html exposing (div, Html, text, button)
import Html.Attributes exposing (style, class)
import Model exposing (Model)
import Set exposing (Set)
import Components.Hangman exposing (hangman)
import Components.Header exposing (header)
import Components.Keyboard exposing (keyboard)
import Components.BoxList exposing (boxList)
import Actions exposing (..)
import Char


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


view : Model -> Html Action
view model =
    div
        [ class "app column between" ]
        [ header model.strikes
        , div [ class "main column around" ]
            [ div [ class "hangman row middle center" ]
                [ hangman model.strikes ]
            , boxList model.answer
            ]
        , keyboard model.letters
        ]
