module Main (..) where

import Game exposing (init, update, view)
import StartApp.Simple exposing (start)



main =
  start
    { model = init
    , update = update
    , view = view
    }
