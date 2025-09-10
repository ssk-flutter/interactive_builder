# Interactive Builder

A Flutter widget that simplifies building interactive UI elements by providing the current interaction state to its builder.

<p align="center">
  <img src="https://github.com/ssk-flutter/interactive_builder/blob/main/interactive_builder_demo.gif" alt="Interactive Builder Demo" />
</p>

## Features

*   **Easy to Use:** Simply wrap your widget with `InteractiveBuilder` and use the provided state to customize your UI.
*   **Declarative State Handling:** Easily define UI for different interaction states (hover, press, deactivate) in a clean and readable way using `state.resolve`.
*   **Flexible:** Can be used to create a wide variety of interactive widgets.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:interactive_builder/interactive_builder.dart';

...
    InteractiveBuilder(
      onTap: () {
        print('Tapped!');
      },
      onHover: (isHovering) {
        print('Hovering: $isHovering');
      },
      builder: (context, state, child) => Container(
        decoration: BoxDecoration(
          color: state.resolve(
            Colors.blue,
            hovered: Colors.lightBlue,
            pressed: Colors.blueAccent,
            deactivated: Colors.grey,
          ),
        ),
        child: const Text('Click Me'),
      ),
    )
...

```

## `InteractionState`

The `InteractionState` has a `resolve` method to easily choose a value based on the current state.

### `resolve<T>`

The `resolve` method takes a default value and optional values for `hovered`, `pressed`, and `deactivated` states. It returns the value that corresponds to the current state.

The `deactivated` state is triggered when the `onTap` callback is `null`.

```dart
Container(
    color: state.resolve(
        Colors.blue, // Default color
        hovered: Colors.lightBlue,
        pressed: Colors.blueAccent,
        deactivated: Colors.grey,
    ),
    child: const Text('Click Me'),
)
```
