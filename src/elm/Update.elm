module Update exposing (update)

import Task
import Set exposing (..)
import Model exposing (..)
import Actions exposing (..)
import Char exposing (..)
import Array exposing (Array)


nextKeyCode : Char.KeyCode
nextKeyCode =
    39


prevKeyCode : Char.KeyCode
prevKeyCode =
    37


maxStrikes : Int
maxStrikes =
    11


update : Action -> Model -> ( Model, Cmd Action )
update action model =
    case action of
        Init ->
            ( loadSentence model.sentencePos model, Cmd.none )

        Next ->
            ( onNext model, Cmd.none )

        Prev ->
            ( onPrev model, Cmd.none )

        Press char ->
            let
                normalizeChar =
                    Char.toCode (Char.toUpper (Char.fromCode char))

                maybeSentence =
                    Array.get model.sentencePos model.sentencePossBank

                sentence =
                    case maybeSentence of
                        Just sentenceString ->
                            sentenceString

                        Nothing ->
                            ("")

                nextPressed =
                    onKeyPress char model.pressed

                nextStrikes =
                    calcStrikes nextPressed sentence

                nextAnswer =
                    checkSentence nextPressed sentence

                nextLetters =
                    (calcLetters nextPressed model.letters)

                nextStatus =
                    if (nextStrikes >= maxStrikes) then
                        Lost
                    else if (nextAnswer == sentence) then
                        Won
                    else
                        model.status
            in
                if (char == nextKeyCode) then
                    ( onNext model, Cmd.none )
                else if (char == prevKeyCode) then
                    ( onPrev model, Cmd.none )
                else if (model.status == Play) then
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


loadSentence : Int -> Model -> Model
loadSentence pos model =
    let
        intiModel =
            Model.initial

        maybeSentence =
            Array.get pos model.sentencePossBank

        sentencePos =
            case maybeSentence of
                Just sentencePosString ->
                    sentencePosString

                Nothing ->
                    ("")

        nextPressed =
            onKeyPress 0 intiModel.pressed

        nextAnswer =
            checkSentence nextPressed sentencePos
    in
        ({ intiModel
            | answer = nextAnswer
            , sentencePos = pos
         }
        )


onNext : Model -> Model
onNext model =
    let
        sentencePosBankLength =
            Array.length model.sentencePossBank
    in
        (loadSentence (min (model.sentencePos + 1) (sentencePosBankLength - 1))) model


onPrev : Model -> Model
onPrev model =
    loadSentence (max (model.sentencePos - 1) 0) model


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
checkSentence pressed sentencePos =
    let
        checkFn =
            (didPressed pressed)

        sentencePosCharList =
            (String.toList sentencePos)
    in
        String.fromList (List.map (swapUnpresses checkFn) sentencePosCharList)
