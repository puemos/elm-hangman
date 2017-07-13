module Update exposing (update)

import Set exposing (..)
import Model exposing (..)
import Actions exposing (..)
import Char exposing (..)


update : Action -> Model -> ( Model, Cmd Action )
update action model =
    case action of
        Init ->
            ( Model.initial
            , Cmd.none
            )

        Load string ->
            ( { model
                | sentence = string
              }
            , Cmd.none
            )

        Press char ->
            ( { model
                | pressed = onKeyPress char model.pressed
              }
            , Cmd.none
            )

        Noop ->
            ( model, Cmd.none )


onKeyPress : KeyCode -> Set Int -> Set Int
onKeyPress current pressed =
    let
        char =
            (Char.fromCode current)
    in
        if (Char.isLower char || Char.isUpper char) then
            Set.insert current pressed
        else
            pressed
