module View exposing (view)

import Html exposing (div, Html, text, button)
import Html.Attributes exposing (style, class)
import Model exposing (Model, Status)
import Components.Hangman exposing (hangman)
import Components.Header exposing (header)
import Components.Keyboard exposing (keyboard)
import Components.BoxList exposing (boxList)
import Html.Events exposing (onClick)
import Actions exposing (..)
import Array


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


renderLostScreen : Bool -> Html Action
renderLostScreen lost =
    let
        className =
            if lost then
                "lost column middle center"
            else
                "lost transparent column middle center"
    in
        div [ class className ]
            [ div [ class "lost_caption" ] [ text "Lost" ]
            , div [ class "lost_actions" ]
                [ button [ onClick Init ] [ text "Replay" ]
                ]
            ]


renderWonScreen : Bool -> Html Action
renderWonScreen won =
    let
        className =
            if won then
                "won column middle center"
            else
                "won transparent column middle center"
    in
        div [ class className ]
            [ div [ class "won_caption" ] [ text "Won" ]
            , div [ class "won_actions" ]
                [ button [ onClick Init ] [ text "Replay" ]
                ]
            ]


view : Model -> Html Action
view model =
    let
        sentencePosBankLength =
            Array.length model.sentencePossBank
    in
         div
        [ class "app column between" ]
        [ header model.sentencePos sentencePosBankLength model.strikes 
        , renderLostScreen (model.status == Model.Lost)
        , renderWonScreen (model.status == Model.Won)
        , div [ class "main column around" ]
            [ div [ class "hangman row middle center" ]
                [ hangman model.strikes ]
            , boxList model.answer
            ]
        , keyboard (model.status == Model.Lost) model.letters
        ]
