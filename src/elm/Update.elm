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
            let
                normalizeChar =
                    Char.toCode (Char.toUpper (Char.fromCode char))

                nextPressed =
                    onKeyPress char model.pressed

                nextStrikes =
                    calcStrikes nextPressed model.sentence

                nextAnswer =
                    checkSentence nextPressed model.sentence

                nextLetters =
                    (calcLetters nextPressed model.letters)

                nextStatus = 
                    if (nextStrikes >= 10) then
                        Lost
                    else if (nextAnswer == model.sentence) then
                        Won
                    else
                        model.status
            in
                if (model.status == Play) then
                    ( { model
                        | pressed = nextPressed
                        , strikes = nextStrikes
                        , answer = nextAnswer
                        , letters = nextLetters
                        , status = nextStatus
                      }
                    , Cmd.none
                    )
                else
                    ( model, Cmd.none )

        Noop ->
            ( model, Cmd.none )


onKeyPress : KeyCode -> Set KeyCode -> Set KeyCode
onKeyPress current pressed =
    let
        char =
            (Char.fromCode current)
    in
        if (Char.isLower char || Char.isUpper char) then
            Set.insert current pressed
        else
            pressed


calcLetters : Set KeyCode -> List ( KeyCode, Bool ) -> List ( KeyCode, Bool )
calcLetters pressed letters =
    let
        checkFn =
            (didPressed pressed)
    in
        List.map (\( c, _ ) -> ( c, checkFn (Char.fromCode c) )) letters


calcStrikes : Set Int -> String -> Int
calcStrikes pressed sentence =
    let
        checkFn =
            (didPressed pressed)

        sentenceCharList =
            (String.toList sentence)

        sentenceCharListNoSpace =
            (List.filter (\c -> c /= ' ') sentenceCharList)

        numOfCorrect =
            (Set.fromList (List.filter checkFn sentenceCharListNoSpace))
    in
        (Set.size pressed) - (Set.size numOfCorrect)


didPressed : Set KeyCode -> Char -> Bool
didPressed preesed letter =
    let
        char =
            (Char.toCode (Char.toUpper letter))
    in
        Set.member char preesed


swapUnpresses : (Char -> Bool) -> Char -> Char
swapUnpresses checkFn letter =
    if (letter == ' ') then
        letter
    else if (checkFn letter) then
        letter
    else
        '_'


checkSentence : Set KeyCode -> String -> String
checkSentence pressed sentence =
    let
        checkFn =
            (didPressed pressed)

        sentenceCharList =
            (String.toList sentence)
    in
        String.fromList (List.map (swapUnpresses checkFn) sentenceCharList)
