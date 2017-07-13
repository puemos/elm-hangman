module Model exposing (Model, initial)

import Set exposing (Set)


type alias Model =
    { pressed : Set Int
    , sentence : String
    }


initial : Model
initial =
    { pressed = Set.empty
    , sentence = "Super wow"
    }
