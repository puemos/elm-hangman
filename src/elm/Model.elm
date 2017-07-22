module Model exposing (Status(..), Model, initial)

import Set exposing (Set)
import Char exposing (..)
import Array exposing (Array, fromList)
import SentencesBank exposing (bank)


type Status
    = Play
    | Won
    | Lost


type alias Model =
    { pressed : Set KeyCode
    , sentencePos : Int
    , sentencePossBank : Array String
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
    , sentencePos = 0
    , sentencePossBank = fromList bank
    , answer = ""
    , letters = List.map (\c -> ( (toUpperCode c), False )) abc
    , strikes = 0
    , status = Play
    }
