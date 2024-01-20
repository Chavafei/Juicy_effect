
This addon is made specifically to make adding juice into game easier.
plus some utilities

It is inspired FEEL unity asset by moremountain

The workflow include adding a Juicy_player and Juicy_effect as child, in which the juicy player will play them.

> If you have cool idea you want or you have made a custom Juicy effect, feel free to do a Pull request, I would really appreciate it


> This addon is made with 3D first in mind, although some effect do support both 2D and 3D, some effect may only works for 3D 

> The Documentation is currently work in progress, so there are a lot of missing infomation


## Getting Started
the effect for making a box pulse as an example
- Add a `CSGbox`
- Add a `Juicy_player`
- Add a `Juicy_effect_scale` as a child of `Juicy_player`
- Assign `CSGbox` to `Juicy_effect_scale`'s `Target node`
- set `Target scale` to X = 1.5, Y = 1.5, Z = 1.5
- set the Curve, 1 is the target value
- set `Juicy player` 's autoplay to `true`
- Run the scene, you will see that the box will pulse once
- to make it loop, set the `loop` in `Juicy_effect_scale` to `true` and set `Loop Infinite` to `true`
- the box will now pulse repeatedly

## Juicy Effect's feature

### Active
if this is false, Juicy effect will not play.

### Duration
how long the juicy effect will play, this value will be used in most calculation of the effect

### Intensity
Is Currently unused,

### Stopper
if this is true, the juicy effect after will need to wait for this effect to finished first to play.

### Loop
the Juicy effect will play again after it is finished, (I'm not sure how this will work with `Stopper` yet)





## Here are guide on how to do specific things
### Start the Juicy_player in code
You can do it by accessing the `Juicy_player` node then call `Play()`
for example

```
extends Node
@export var juicy : Juicy_player


func _ready():
	juicy.Play()

```

