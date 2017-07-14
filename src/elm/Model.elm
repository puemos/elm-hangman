module Model exposing (Model, initial)

import Set exposing (Set)
import Char exposing (..)


abc : List Char
abc =
    (String.toList "abcdefghijklmnopqrstuvwxyz")


toUpperCode : Char -> KeyCode
toUpperCode char =
    Char.toCode (Char.toUpper char)


type alias Model =
    { pressed : Set KeyCode
    , sentence : String
    , answer : String
    , letters : List ( KeyCode, Bool )
    , strikes : Int
    }


initial : Model
initial =
    { pressed = Set.empty
    , sentence = "Super wow"
    , answer = "_____ ___"
    , letters = List.map (\c -> ( (toUpperCode c), False )) abc
    , strikes = 0
    }
