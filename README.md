# Interactive Builder

A Flutter widget that simplifies building interactive UI elements by providing the current interaction state to its builder.

## Features

*   **Easy to Use:** Simply wrap your widget with `InteractiveBuilder` and use the provided state to customize your UI.
*   **Declarative State Handling:** Easily define UI for different interaction states (hover, press, deactivate) in a clean and readable way using `state.resolve`.
*   **Flexible:** Can be used to create a wide variety of interactive widgets.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:interactive_builder/interactive_builder.dart';

class MyInteractiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InteractiveBuilder(
      onTap: () {
        print('Tapped!');
      },
      builder: (context, state, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: state.resolve(
              Colors.blue,
              hovered: Colors.lightBlue,
              pressed: Colors.blueAccent,
              deactivated: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text('Click Me'),
        );
      },
    );
  }
}
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
