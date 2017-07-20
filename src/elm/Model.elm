module Model exposing (Status(..), Model, initial)

import Set exposing (Set)
import Char exposing (..)
import Array exposing (Array, fromList)


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
    , sentencePossBank = fromList [ "A slap on the wrist", "Bite your tongue", "Can't keep a good dog down", "Bull in a china store", "Over the top", "On the fence", "Head over heels in love", "Knee jerk reaction", "A dime a dozen", "Bite off more than you can chew", "Steal my thunder", "Keep your chin up", "Go out on a limb", "Go for broke", "A fly on the wall", "Let bygones be bygones", "Bouncing off the walls", "All greek to me", "Sick as a dog", "A taste of your own medicine", "Knock on wood", "When pigs fly", "Put your foot in your mouth", "You are what you eat", "Hit the road", "In the same boat", "Feeling under the weather", "One smart cookie", "Loose cannon", "A dime a dozen", "The whole nine yards", "Smell something fishy", "Rule of thumb", "The whole nine yards", "Frog in your throat", "Hat trick", "Caught red-handed", "Wake up on the wrong side of the bed", "Why the long face?", "One leg in the door", "Raining cats and dogs", "Everything but the kitchen sink", "Get over it", "Hit the sack", "A blessing in disguise", "New york minute", "Add fuel to the fire", "The bigger they are the harder they fall", "A penny saved is a penny earned", "Apple of my eye" ]
    , answer = ""
    , letters = List.map (\c -> ( (toUpperCode c), False )) abc
    , strikes = 0
    , status = Play
    }
