module Sentence (Model, update, view, init) where

import String
import Html exposing (..)
import Html.Attributes exposing (style, class, hidden)
import Debug exposing (log)


-- MODEL


type alias Letter =
  { letter : Char
  , isVisible : Bool
  }


type alias Model =
  List Letter


init : Model
init =
  List.map
    (\l ->
      { letter = l
      , isVisible = False
      }
    )
    (String.toList
      "as"
    )



-- UPDATE


update : List Char -> Model -> Model
update pressed model =
  List.map (isPressed pressed) model


isPressed : List Char -> Letter -> Letter
isPressed pressed c =
  if List.member c.letter pressed then
    { c | isVisible = True }
  else
    { c | isVisible = False }


toShow : Letter -> String
toShow c =
  if c.isVisible then
    String.fromChar c.letter
  else
    " "



-- VIEW


view : Model -> Html
view model =
  div [ class "Sentence mdl-grid" ] (List.map (\l -> div [class "mdl-shadow--3dp"] [ span [ hidden (not l.isVisible) ] [ text (String.fromChar l.letter) ] ]) model)
