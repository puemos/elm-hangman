module View exposing (view)

import Html exposing (div, Html, text, button)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Actions exposing (..)
import Set exposing (Set)
import Components.Hangman exposing (hangman)
import Char


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


allLetters : List Char
allLetters =
    (String.toList
        "abcdefghijklmnopqrstuvwxyz"
    )


isPressed : Set Int -> Char -> Bool
isPressed preesed letter =
    let
        char =
            (Char.toCode (Char.toUpper letter))
    in
        Set.member char preesed


letterClass : Bool -> String
letterClass pressed =
    if (pressed) then
        "button__selected"
    else
        ""


letterButton : Set Int -> Char -> Html Action
letterButton preesed letter =
    let
        className =
            letterClass (isPressed preesed letter)

        charCode =
            (Char.toCode (Char.toUpper letter))
    in
        div
            [ class ("letterButton " ++ className), onClick (Press charCode) ]
            [ text (String.fromChar (Char.toUpper letter)) ]


letterList : Set Int -> Html Action
letterList pressed =
    div
        [ class "letterList row" ]
        (List.map
            (letterButton pressed)
            allLetters
        )


box : Char -> Html Action
box letter =
    div
        [ class "box" ]
        [ text (String.fromChar (Char.toUpper letter)) ]


boxWord : String -> Html Action
boxWord word =
    div
        [ class "boxWord row" ]
        (List.map
            box
            (String.toList word)
        )


swapUnpresses : (Char -> Bool) -> Char -> Char
swapUnpresses checkFn letter =
    if (letter == ' ') then
        letter
    else if (checkFn letter) then
        letter
    else
        '_'


checkSentence : Set Int -> String -> String
checkSentence pressed sentence =
    let
        checkFn =
            (isPressed pressed)

        sentenceCharList =
            (String.toList sentence)
    in
        String.fromList (List.map (swapUnpresses checkFn) sentenceCharList)


boxList : String -> Html Action
boxList sentence =
    div
        [ class "boxList row center middle" ]
        (List.map
            boxWord
            (String.words sentence)
        )


calcStrikes : Set Int -> String -> Int
calcStrikes pressed sentence =
    let
        checkFn =
            (isPressed pressed)

        sentenceCharList =
            (String.toList sentence)

        sentenceCharListNoSpace =
            (List.filter (\c -> c /= ' ') sentenceCharList)

        numOfCorrect =
            (Set.fromList (List.filter checkFn sentenceCharListNoSpace))
    in
        (Set.size pressed) - (Set.size numOfCorrect)


counter : Int -> Html Action
counter strikes =
    div [ class "counter" ]
        [ text ("strikes: " ++ (toString strikes))
        ]


header : Int -> Html Action
header strikes =
    div [ class "header row between" ]
        [ text "Hangman"
        , counter strikes
        ]


view : Model -> Html Action
view model =
    let
        strikes =
            (calcStrikes model.pressed model.sentence)

        sentence =
            (checkSentence model.pressed model.sentence)
    in
        div
            [ class "app column between" ]
            [ header strikes
            , div [ class "main row around" ] [ boxList sentence, hangman strikes ]
            , letterList model.pressed
            ]
