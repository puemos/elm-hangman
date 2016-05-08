module Game (..) where

import LetterButtonList exposing (update, view, init, Model)
import Hangman exposing (view, Model)
import Sentence
import String
import Html exposing (div, Html)
import Html.Attributes
import Html.Events exposing (..)
import Debug exposing (log)


-- MODEL


type alias Model =
  { letterList : LetterButtonList.Model
  , mistakes : Hangman.Model
  , sentence : Sentence.Model
  }


init : Model
init =
  { letterList = LetterButtonList.init
  , mistakes = 2
  , sentence = Sentence.init
  }



-- UPDATE


type Action
  = LetterPressed LetterButtonList.Action



-- update : Action -> Model


update action model =
  case action of
    LetterPressed act ->
      let
        letterList = LetterButtonList.update act model.letterList
      in
      { model
        | letterList = letterList
        , sentence = Sentence.update (List.map .letter (List.filter (\b -> b.isDisabled) letterList)) model.sentence
      }



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ LetterButtonList.view (Signal.forwardTo address LetterPressed) model.letterList
    , Hangman.view model.mistakes
    , Sentence.view model.sentence
    ]
