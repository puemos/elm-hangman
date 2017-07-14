module Components.Keyboard exposing (keyboard)

import Html exposing (div, Html, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class)
import Actions exposing (..)
import Char


keyboardButton : Bool -> ( Int, Bool ) -> Html Action
keyboardButton disable ( charCode, isPreesed ) =
    let
        className =
            if isPreesed then
                "keyboardButton__disabled"
            else
                ""

        letter =
            (String.fromChar (Char.toUpper (Char.fromCode charCode)))

        action =
            if (disable) then
                Noop
            else
                (Press charCode)
    in
        div
            [ class ("keyboardButton " ++ className), onClick action ]
            [ text letter ]


keyboard : Bool -> List ( Int, Bool ) -> Html Action
keyboard disable letters =
    div
        [ class "keyboard row center" ]
        (List.map
            (keyboardButton disable)
            letters
        )
