# Documentation

This file only offers documentation for the additional properties of components given by the Qooey theme.<br>
On [doc.qt.io](https://doc.qt.io/qt-6/qtquick-controls2-qmlmodule.html), you can find the documentation for the remaining components.

## Table Of Content
- [Documentation](#documentation)
  - [Table Of Content](#table-of-content)
  - [Quick Start](#quick-start)
  - [Change Color Theme](#change-color-theme)
  - [Components](#components)
    - [Dashed Ring](#dashed-ring)
    - [Liquid](#liquid)
    - [Dial](#dial)
    - [ProgressBar](#progressbar)

## Quick Start

See the <em>Usage</em> section of the main [README](../README.md#usage) page.

## Change Color Theme

To alter the color scheme of a component, update the palette properties on the <em>parent component</em> so that all children are affected.

**button**:
+ `palette.button`
+ `palette.buttonText`

**window & base**:
+ `palette.base`
+ `palette.text`
+ `palette.window`
+ `palette.windowText`

**highlights**:
+ `palette.highlight`
+ `palette.highlightedText`

## Components

### Dashed Ring

This is a basic component which generates a dashed ring.

**Component properties:**<br>
+ `[property]` `[real]` dashCount: 2
The number of dashes on the ring is specified by this property.
+ `[property]` `[real]` borderWidth: 2
This property specifies the width of the border, which can range from $0$ to $\dfrac{width}{2}$.
+ `[property]` `[real]` dashWidth: 2
This property specifies the width of dashes.
+ `[property]` `[color]` palette.base
    This property derives from the `Control` component, which specifies the `color` of the dashes.

    ```qml
    DashedRing {
        width: 100
        height: 100

        borderWidth: 2
        dashWidth: 2
        dashCount: 25
        palette.base: 'blue'
    }
    ```
---
### Liquid

This is a basic component which generates a luquid like circle.

**Component properties:**<br>
+ `[property]` `[bool]` fill: false
    The number of dashes on the ring is specified by this property.
+ `[property]` `[real]` seed: 0
    This property specifies seed value used for random function used in `Shader`.
+ `[property]` `[color]` color: '#000'
    This property specifies the `color` of the dashes.
+ `[property]` `[real]` distorted: 3
    This property specifies amount distortion.
+ `[property]` `[real]` strokeWidth: 1
    This property specifies the stroke width.

    ```qml
    Liquid {
        width: 100
        height: 100

        strokeWidth: 2
        distorted: 3
        color: 'blue'
        fill: true
        seed: 20
    }
    ```
----
### Dial
**Component properties:**<br>
+ `[property]` `[DashedRing]` dottedRing
    This property refers to the [DashedRing](#dashed-ring) component used in the Dial component.

----
### ProgressBar
**Component properties:**<br>
+ `[property]` `[int]` orientation: Qt.Horizontal
    This property determines the orientation of the ProgressBar component.<br>
    Either `Qt.Horizontal` or `Qt.Vertical` can be the value.
