module Actions exposing (Action(..))

type Action
    = Init
    | Load String
    | Press Int
    | Noop