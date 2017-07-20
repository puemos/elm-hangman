module Actions exposing (Action(..))

type Action
    = Init
    | Press Int
    | Next
    | Prev
    | Noop