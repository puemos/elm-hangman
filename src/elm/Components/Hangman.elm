module Components.Hangman exposing (hangman)

import Actions exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


toShow : Int -> Int -> String
toShow n strikes =
    if n > strikes then
        "hidden"
    else
        ""


hangman : Int -> Svg Action
hangman strikes =
    svg [ height "135", width "81" ]
        [ node "title"
            []
            [ text "Layer 1" ]
        , g [ id "base", visibility (toShow 1 strikes) ]
            [ node "line"
                [ fill "none", id "svg_1", stroke "#000", strokeWidth "5", x1 "11.1835", x2 "70.00333", y1 "123.35251", y2 "123.35251" ]
                []
            , text "  "
            ]
        , g [ id "poll", visibility (toShow 2 strikes) ]
            [ node "line"
                [ fill "none", id "svg_5", stroke "#000", strokeWidth "5", transform "rotate(90 56.118484497070305,64.44848632812501) ", x1 "-3.88497", x2 "116.12197", y1 "64.44849", y2 "64.44849" ]
                []
            , text "  "
            ]
        , g [ id "support", visibility (toShow 3 strikes) ]
            [ node "line"
                [ fill "none", id "svg_6", stroke "#000", strokeWidth "5", transform "rotate(-141 44.18540954589844,15.687820434570312) ", x1 "29.20883", x2 "59.162", y1 "15.68777", y2 "15.68777" ]
                []
            , text "  "
            ]
        , g [ id "above", visibility (toShow 4 strikes) ]
            [ node "line"
                [ fill "none", id "svg_7", stroke "#000", strokeWidth "5", x1 "16.55079", x2 "57.15915", y1 "6.96102", y2 "6.96102" ]
                []
            , text "  "
            ]
        , g [ id "rope", visibility (toShow 5 strikes) ]
            [ node "rect"
                [ fill "#999999", height "2.46019", id "svg_25", strokeWidth "5", transform "rotate(90 21.00877380371094,29.422645568847656) ", width "40.77304", x "0.62226", y "28.19256" ]
                []
            , text "   "
            , node "rect"
                [ fill "#999999", height "2.46019", id "svg_13", strokeWidth "5", width "11.59903", x "12.57304", y "48.2277" ]
                []
            , text "  "
            ]
        , g [ id "head", visibility (toShow 6 strikes) ]
            [ node "rect"
                [ fill "#000000", height "11.59903", id "svg_8", strokeWidth "5", width "11.59903", x "12.57304", y "36.6284" ]
                []
            , text "   "
            , node "rect"
                [ fill "#ffffff", height "3.69068", id "svg_26", strokeWidth "5", width "3.69068", x "12.44894", y "36.59328" ]
                []
            , text "   "
            , node "rect"
                [ fill "#ffffff", height "3.69068", id "svg_27", strokeWidth "5", width "3.69068", x "20.5333", y "36.59328" ]
                []
            , text "  "
            ]
        , g [ id "body", visibility (toShow 7 strikes) ]
            [ node "rect"
                [ fill "#000000", height "23.90158", id "svg_14", strokeWidth "5", width "18.80492", x "9.10975", y "50.65303" ]
                []
            , text "  "
            ]
        , g [ id "left-arm", visibility (toShow 8 strikes) ]
            [ node "rect"
                [ fill "#000000", height "3.86643", id "svg_17", strokeWidth "5", width "3.86643", x "5.24331", y "74.20312" ]
                []
            , text "  "
            ]
        , g [ id "right-arm", visibility (toShow 9 strikes) ]
            [ node "rect"
                [ fill "#000000", height "3.86643", id "svg_18", strokeWidth "5", width "3.86643", x "27.73892", y "74.55462" ]
                []
            , text "  "
            ]
        , g [ id "left-foot1", visibility (toShow 10 strikes) ]
            [ node "rect"
                [ fill "#000000", height "3.33919", id "svg_19", strokeWidth "5", width "12.12654", x "12.44893", y "74.73036" ]
                []
            , text "   "
            , node "rect"
                [ fill "#000000", height "3.33919", id "svg_21", strokeWidth "5", transform "rotate(90 14.11854553222655,87.38415527343751) ", width "18.62917", x "4.80395", y "85.71457" ]
                []
            , text "   "
            , node "rect"
                [ fill "#000000", height "3.86643", id "svg_23", strokeWidth "5", width "3.86643", x "8.75825", y "96.52298" ]
                []
            , text "  "
            ]
        , g [ id "right-foot", visibility (toShow 11 strikes) ]
            [ node "rect"
                [ fill "#000000", height "3.33919", id "svg_22", strokeWidth "5", transform "rotate(90 22.905868530273427,87.38415527343751) ", width "18.62917", x "13.59128", y "85.71456" ]
                []
            , text "   "
            , node "rect"
                [ fill "#000000", height "3.86643", id "svg_24", strokeWidth "5", width "3.86643", x "24.57547", y "96.69873" ]
                []
            , text "  "
            ]
        ]
