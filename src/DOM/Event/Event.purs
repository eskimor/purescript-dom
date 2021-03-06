module DOM.Event.Event
  ( bubbles
  , cancelable
  , currentTarget
  , defaultPrevented
  , eventPhase
  , eventPhaseIndex
  , target
  , timeStamp
  , type_
  , preventDefault
  , stopImmediatePropagation
  , stopPropagation
  ) where

import Prelude

import Control.Monad.Eff (Eff())

import Data.Enum (toEnum)
import qualified Data.Maybe.Unsafe as U

import DOM
import DOM.Event.EventPhase
import DOM.Event.Types
import DOM.Node.Types

-- | The event type.
foreign import type_ :: Event -> EventType

-- | The element that was the source of the event.
foreign import target :: Event -> Node

-- | The element that the event listener was added to.
foreign import currentTarget :: Event -> Node

-- | Indicates which phase of the event flow that is currently being processed
-- | for the event.
eventPhase :: Event -> EventPhase
eventPhase = U.fromJust <<< toEnum <<< eventPhaseIndex

-- | The integer value for the current event phase.
foreign import eventPhaseIndex :: Event -> Int

-- | Prevents the event from bubbling up to futher event listeners. Other event
-- | listeners on the current target will still fire.
foreign import stopPropagation :: forall eff. Event -> Eff (dom :: DOM | eff) Unit

-- | Prevents all other listeners for the event from being called. This includes
-- | event listeners added to the current target after the current listener.
foreign import stopImmediatePropagation :: forall eff. Event -> Eff (dom :: DOM | eff) Unit

-- | Indicates whether the event will bubble up through the DOM or not.
foreign import bubbles :: Event -> Boolean

-- | Indicates whether the event can be cancelled.
foreign import cancelable :: Event -> Boolean

-- | Cancels the event if it can be cancelled.
foreign import preventDefault :: forall eff. Event -> Eff (dom :: DOM | eff) Unit

-- | Indicates whether `preventDefault` was called on the event.
foreign import defaultPrevented :: Event -> Boolean

-- | The time in milliseconds between 01/01/1970 and when the event was
-- | dispatched.
foreign import timeStamp :: Event -> Number
