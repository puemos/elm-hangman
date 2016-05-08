module LetterButtonList (..) where

import LetterButton exposing (..)
import Hangman exposing (..)
import String
import Html exposing (div, Html)
import Html.Attributes
import Html.Events exposing (..)


-- MODEL


type alias ID =
  Char


type alias Model =
  List LetterButton.Model



init : Model
init =
      List.map
        (\l ->
          { letter = l
          , isDisabled = False
          }
        )
        (String.toList
          "abcdefghijklmnopqrstuvwxyz"
        )



-- UPDATE


type Action
  = Modify ID LetterButton.Action



-- update : Action -> Model


update action model =
  case action of
    Modify id letterButtonAction ->
      let
        updateLetterButton letterButtonModel =
          if letterButtonModel.letter == id then
            LetterButton.update letterButtonAction letterButtonModel
          else
            letterButtonModel
      in
        List.map updateLetterButton model



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ div
        [ Html.Attributes.class "LettersPanel" ]
        (List.map (viewLetterButton address) model)
    ]


viewLetterButton : Signal.Address Action -> LetterButton.Model -> Html
viewLetterButton address model =
  let
    context =
      LetterButton.Context
        (Signal.forwardTo address (Modify model.letter))
  in
    LetterButton.view context model
