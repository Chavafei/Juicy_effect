
This addon is made specifically to make adding juice into game easier.
plus some utilities

It is inspired FEEL unity asset by moremountain

The workflow include adding a Juicy_player and Juicy_effect as child, in which the juicy player will play them.


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

