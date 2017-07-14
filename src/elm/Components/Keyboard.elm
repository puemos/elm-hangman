module Components.Keyboard exposing (keyboard)

import Html exposing (div, Html, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class)
import Actions exposing (..)
import Char

keyboardButton : ( Int, Bool ) -> Html Action
keyboardButton ( charCode, isPreesed ) =
    let
        className =
            if isPreesed then
                "keyboardButton__disabled"
            else
                ""

        letter =
            (String.fromChar (Char.toUpper (Char.fromCode charCode)))
    in
        div
            [ class ("keyboardButton " ++ className), onClick (Press charCode) ]
            [ text letter ]


keyboard : List ( Int, Bool ) -> Html Action
keyboard letters =
    div
        [ class "keyboard row center" ]
        (List.map
            keyboardButton
            letters
        )