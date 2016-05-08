module Hangman (Model, Action, update, view) where

import String
import Html exposing (..)
import Html.Attributes exposing (style, class, disabled)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- MODEL


type alias Model =
  Int



-- UPDATE


type Action
  = Add


update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      model + 1



-- VIEW


toShow : Int -> Model -> String
toShow n model =
  if n > model then
    "hidden"
  else
    ""


hangman : Model -> Html
hangman model =
  Svg.svg
    [ version "1.1", x "0", y "0", height "350px", width "300px" ]
    [ line [ visibility (toShow 1 model), strokeLinecap "undefined", strokeLinejoin "undefined", id "svg_1", y2 "331", x2 "252.50237", y1 "331", x1 "41.5", strokeWidth "6", stroke "#7f3f00", fill "none" ] []
    , line [ visibility (toShow 2 model), strokeLinecap "undefined", strokeLinejoin "undefined", id "svg_2", y2 "44.09583", x2 "181.5", y1 "331", x1 "181.5", strokeWidth "6", stroke "#7f3f00", fill "none" ] []
    , line [ visibility (toShow 3 model), stroke "#7f3f00", strokeLinecap "undefined", strokeLinejoin "undefined", id "svg_3", y2 "45.11628", x2 "34.01934", y1 "45.11628", x1 "184.6", strokeWidth "6", fill "none" ] []
    , line [ visibility (toShow 4 model), strokeLinecap "undefined", strokeLinejoin "undefined", id "svg_4", y2 "140.93023", x2 "182.09302", y1 "45.11628", x1 "96.51163", strokeWidth "6", stroke "#7f3f00", fill "none" ] []
    , line [ visibility (toShow 5 model), stroke "#7f3f00", strokeLinecap "undefined", strokeLinejoin "undefined", id "svg_5", y2 "106.9355", x2 "45.96898", y1 "45.11628", x1 "45.96898", strokeWidth "6", fill "none" ] []
    , ellipse [ visibility (toShow 6 model), stroke "#000", ry "25.5814", rx "22.09302", id "svg_6", cy "115.76228", cx "47.13178", strokeWidth "1.5", fill "#eaa981" ] []
    , rect [ visibility (toShow 7 model), id "svg_8", height "78.33332", width "58.33332", y "145.55553", x "20.27779", fillOpacity "null", strokeOpacity "null", strokeWidth "1.5", stroke "#000", fill "#5f00bf" ] []
    , rect [ visibility (toShow 8 model), id "svg_9", height "54.99999", width "23.88888", y "229.44441", x "20.27779", fillOpacity "null", strokeOpacity "null", strokeWidth "1.5", stroke "#000", fill "#200142" ] []
    , rect [ visibility (toShow 9 model), id "svg_10", height "54.99999", width "23.88888", y "229.44441", x "54.16667", fillOpacity "null", strokeOpacity "null", strokeWidth "1.5", stroke "#000", fill "#200142" ] []
    , rect [ visibility (toShow 10 model), stroke "#000", id "svg_11", height "54.99999", width "15.55555", y "145.55553", x "1.94446", fillOpacity "null", strokeOpacity "null", strokeWidth "1.5", fill "#5f00bf" ] []
    , rect [ visibility (toShow 11 model), stroke "#000", id "svg_12", height "54.99999", width "15.55555", y "145.55553", x "81.38889", fillOpacity "null", strokeOpacity "null", strokeWidth "1.5", fill "#5f00bf" ] []
    ]


view : Model -> Html
view model =
  hangman model
