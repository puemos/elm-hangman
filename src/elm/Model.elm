module Model exposing (Status(..), Model, initial)

import Set exposing (Set)
import Char exposing (..)


type Status
    = Play
    | Won
    | Lost


type alias Model =
    { pressed : Set KeyCode
    , sentence : String
    , answer : String
    , letters : List ( KeyCode, Bool )
    , strikes : Int
    , status : Status
    }


abc : List Char
abc =
    (String.toList "abcdefghijklmnopqrstuvwxyz")


toUpperCode : Char -> KeyCode
toUpperCode char =
    Char.toCode (Char.toUpper char)


initial : Model
initial =
    { pressed = Set.empty
    , sentence = "Super wow"
    , answer = "_____ ___"
    , letters = List.map (\c -> ( (toUpperCode c), False )) abc
    , strikes = 0
    , status = Play
    }
