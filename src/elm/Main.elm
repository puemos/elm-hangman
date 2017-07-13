module Main exposing (..)

import Model exposing (Model)
import Update
import View
import Keyboard exposing (KeyCode)
import Html
import Actions exposing (Action(..))
import Task exposing (Task)


subscriptions : Model -> Sub Action
subscriptions model =
    Sub.batch
        [ Keyboard.downs Press
        ]


main : Program Never Model Action
main =
    Html.program
        { init = ( Model.initial, Task.perform (always Init) (Task.succeed 0) )
        , update = Update.update
        , view = View.view
        , subscriptions = subscriptions
        }
