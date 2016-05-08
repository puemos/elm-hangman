module LetterButton (Model, Action, update, view, Context) where

import String
import Html exposing (..)
import Html.Attributes exposing (style, class, disabled)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
  { letter : Char
  , isDisabled : Bool
  }



-- UPDATE


type Action
  = Pressed


update : Action -> Model -> Model
update action model =
  case action of
    Pressed ->
      { letter = model.letter
      , isDisabled = True
      }



-- VIEW


type alias Context =
  { actions : Signal.Address Action
  }


view : Context -> Model -> Html
view context model =
  button
    [ onClick context.actions Pressed
    , class "mdl-button mdl-js-button mdl-button--fab mdl-button--colored LetterButton"
    , disabled model.isDisabled
    ]
    [ text (String.fromChar model.letter) ]
