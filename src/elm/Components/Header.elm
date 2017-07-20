module Components.Header exposing (header)

import Html exposing (div, Html, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class)
import Actions exposing (..)


counter : Int -> Html Action
counter strikes =
    div [ class "counter" ]
        [ text ("strikes: " ++ (toString strikes))
        ]


header : Int -> Int -> Int -> Html Action
header currPos maxPos strikes =
    div [ class "header row between" ]
        [ text "Hangman"
        , div [ class "header-nav row between middle"]
            [ button [ onClick Prev ] [ text "<" ]
            , div []
                [ text
                    ((toString currPos) ++ "/" ++ (toString maxPos))
                ]
            , button [ onClick Next ] [ text ">" ]
            ]
        , counter strikes
        ]
