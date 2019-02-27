module Main exposing (..)

import Browser
import Html exposing (Html, p, div, input, button, label, h1, text, strong)
import Html.Attributes exposing (style, disabled, value)
import Html.Events exposing (onInput, onClick)


main =
    Browser.document
        { subscriptions = (\_ -> Sub.none)
        , view = view
        , update = update
        , init = init
        }


type alias Model =
    { morseCode : String
    , english : String
    , mode : Mode
    }


type Mode
    = EnglishToMorseCode
    | MorseCodeToEnglish


initialModel : Model
initialModel =
    { morseCode = ""
    , english = ""
    , mode = EnglishToMorseCode
    }


init () =
    ( initialModel, Cmd.none )


type Msg
    = NoOp
    | UpdateMorseCode String
    | UpdateEnglish String
    | SwitchMode


update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateMorseCode morseCode ->
            ( { model | morseCode = morseCode }, Cmd.none )

        UpdateEnglish english ->
            ( { model | english = english }, Cmd.none )

        SwitchMode ->
            case model.mode of
                EnglishToMorseCode ->
                    ( { model | mode = MorseCodeToEnglish }, Cmd.none )

                MorseCodeToEnglish ->
                    ( { model | mode = EnglishToMorseCode }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Morse Code Converter"
    , body =
        [ h1 [] [ text "Morse Code Converter" ]
        , div []
            [ div [ style "margin-bottom" "1rem" ]
                [ text "Currently translating "
                , strong [] [ text <| modeToString model.mode ]
                , button [ onClick SwitchMode ] [ text "Switch Mode" ]
                ]
            , label [ style "display" "block", style "margin-bottom" "1rem" ]
                [ text "English"
                , input
                    [ style "display" "block"
                    , style "width" "20rem"
                    , onInput UpdateEnglish
                    , disabled <| model.mode == MorseCodeToEnglish
                    , value model.english
                    ]
                    []
                ]
            , label [ style "display" "block" ]
                [ text "Morse code"
                , input
                    [ style "display" "block"
                    , style "width" "20rem"
                    , onInput UpdateMorseCode
                    , disabled <| model.mode == EnglishToMorseCode
                    , value model.morseCode
                    ]
                    []
                ]
            ]
        ]
    }


modeToString : Mode -> String
modeToString mode =
    case mode of
        EnglishToMorseCode ->
            "English to Morse Code"

        MorseCodeToEnglish ->
            "Morse Code to English"
