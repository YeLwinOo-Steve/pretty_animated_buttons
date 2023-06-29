 # Pretty Animated Buttons

 ### Pretty Animated Buttons is a package for a collection of beautiful animated buttons which are highly customizable too. Currently, a total of 12 animated buttons are available. More fancy buttons are coming soon...


### Pretty Animated Buttons List

| Index | Pretty Buttons | Example  
| --- | ------- | ------ |
| 1 | Pretty Shadow Button | ![Pretty Shadow Button](assets/pretty_shadow_button.gif) |
| 2 | Pretty Neumorphic Button | ![Pretty Neumorphic Button](assets/pretty_neumorphic_button.gif) |
| 3 | Pretty Slide Underline Button | ![Pretty Slide Underline Button](assets/pretty_slide_underline_button.gif) |
| 4 | Pretty Wave Button | ![Pretty Wave Button](assets/pretty_wave_button.gif) |
| 5 | Pretty Fuzzy Button | ![Pretty Fuzzy Button](assets/pretty_fuzzy_button.gif) |
| 6 | Pretty Slide Icon Button | ![Pretty Slide Icon Button](assets/pretty_slide_icon_button.gif) |
| 7 | Pretty Slide Up Button | ![Pretty Slide Up Button](assets/pretty_slide_up_button.gif) |
| 8 | Pretty Color Slide Button | ![Pretty Color Slide Button](assets/pretty_color_slide_button.gif) |
| 9 | Pretty Skew Button | ![Pretty Skew Button](assets/pretty_skew_button.gif) |
| 10 | Pretty Border Button | ![Pretty Border Button](assets/pretty_border_button.gif) |
| 11 | Pretty Bar Button | ![Pretty Bar Button](assets/pretty_bar_button.gif) |
| 12 | Pretty Capsule Button | ![Pretty Capsule Button](assets/pretty_capsule_button.gif) |


## Usage
___

The usage is pretty simple. Just use the button's name in Pascal Case. 

Eg. For Pretty Shadow Button, use like this.

```dart
    PrettyShadowButton(
      label: "Pretty Shadow Button",
      onPressed: () {},
      icon: Icons.arrow_forward,
      shadowColor: Colors.green,
    ),
```

You can play around with tons of parameters. 

### Pretty Slide Icon Button

___

`PrettySlideIconButton` has two icon slide positions - left or right.

From left to right slide, 

```dart 
  slidePosition: SlidePosition.left,
```

From right to left slide,

```dart 
  slidePosition: SlidePosition.right,
```

### Pretty Color Slide Button

___


`PrettyColorSlideButton` has special parameter for sliding direction which is `position` parameter.

For left to right slide,
```dart
  position: SlidePosition.left
```
For right to left slide,
```dart
  position: SlidePosition.right
```
For top to bottom slide,
```dart
  position: SlidePosition.top
```
For bottom to top slide,
```dart
  position: SlidePosition.bottom
```

### Pretty Skew Button

____

`PrettySkewButton` also has left & right slide positions which can be tweaked via `skewPosition` parameter.

For left to right slide,
```dart 
  skewPosition: SkewPositions.left,
```
For right to left slide,
```dart 
  skewPosition: SkewPositions.right,
```

## Suggestions are welcome! ☕

 🚧🏗️ The project is under development.

 Feel free to try this out and give it a ⭐.

 More button suggestions are warmly welcome!. 
