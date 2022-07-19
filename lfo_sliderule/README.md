# LFO SlideRule

This seems like a doable flutter programming challenge, making some sliders and displaying some values based on slider position. There is also a lot of room for fancying it up! I'll be starting by targeting the Octatrack's LFO so I don't have to worry about fractional rates.

## Goals

- ~~Display 1 slider for BPM (fixed LFO rate and multiplier of 32 and 1 respectively)~~

  - ~~Range of 30-300bpm (ignore fractional BPM for now)~~

  - Add fractional BPM

- Print LFO Cycle duration in steps, bars/beats/steps/remainder, and seconds

  - ~~First implement steps~~
  
  - ~~then seconds~~
  
  - then beats (in order of complexity)

    - All the pieces are there for this, just gotta format and display it

- ~~Add two more sliders (Rate 1-127 and Multiplier 1-64 in powers of 2)~~

  - ~~Make it so adjusting one slider causes the others to change so the calculated values remain constant~~

- Make the calculated values adjustable

  - Make other calculated values update to reflect the user-input calculated value

- Make the sliders update to suggest settings that achieve the user-input calculated value

  - Prefer changing rate first, then multiplier, and finally BPM

  - This will be much more logic-y and much less Flutter-y than the other stuff so it is pretty unlikely

- Add a toggle or row of tabs at the top for selecting different devices

  - Maybe make the page theme reflect the selected device's livery
