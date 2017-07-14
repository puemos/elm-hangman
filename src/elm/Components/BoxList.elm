module Components.BoxList exposing (boxList)

import Html exposing (div, Html, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class)
import Actions exposing (..)
import Char


box : Char -> Html Action
box letter =
    div
        [ class "box" ]
        [ text (String.fromChar (Char.toUpper letter)) ]


boxWord : String -> Html Action
boxWord word =
    div
        [ class "boxWord row" ]
        (List.map
            box
            (String.toList word)
        )





boxList : String -> Html Action
boxList sentence =
    div
        [ class "boxList row center middle last-sm" ]
        (List.map
            boxWord
            (String.words sentence)
        )