module Components.Header exposing (header)

import Html exposing (div, Html, text, button)
import Html.Attributes exposing (style, class)
import Actions exposing (..)


counter : Int -> Html Action
counter strikes =
    div [ class "counter" ]
        [ text ("strikes: " ++ (toString strikes))
        ]


header : Int -> Html Action
header strikes =
    div [ class "header row between" ]
        [ text "Hangman"
        , counter strikes
        ]
