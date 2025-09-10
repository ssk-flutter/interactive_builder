part of 'interactive_builder.dart';

/// Represents the current interaction state of an [InteractiveBuilder].
///
/// This class contains boolean flags for different interaction states and
/// provides a convenient [resolve] method to select values based on the current state.
class InteractionState {
  /// Creates an [InteractionState] with the specified state flags.
  const InteractionState({required this.isDeactivated, required this.isHovering, required this.isPressed});

  /// Whether the widget is in a deactivated state.
  ///
  /// A widget is considered deactivated when its [InteractiveBuilder.onTap]
  /// callback is null, indicating it cannot respond to user interactions.
  final bool isDeactivated;

  /// Whether the widget is currently being hovered.
  ///
  /// This is only true when the mouse cursor is over the widget and the
  /// widget is not deactivated.
  final bool isHovering;

  /// Whether the widget is currently being pressed.
  ///
  /// This is true during the time between a tap down and tap up event,
  /// or when the tap is cancelled.
  final bool isPressed;

  /// Selects the appropriate value based on the current interaction state.
  ///
  /// Returns different values depending on the current state:
  /// - [deactivated]: Used when [isDeactivated] is true
  /// - [pressed]: Used when [isPressed] is true (and not deactivated)
  /// - [hovered]: Used when [isHovering] is true (and not pressed or deactivated)
  /// - [normal]: Used as the default value
  ///
  /// The [normal] value must be provided. Optional parameters that are not
  /// provided will fall back to other states in order of priority, or to [normal].
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   color: state.resolve(
  ///     Colors.blue,              // normal state
  ///     hovered: Colors.lightBlue,    // when hovering
  ///     pressed: Colors.blueAccent,   // when pressed
  ///     deactivated: Colors.grey,     // when disabled
  ///   ),
  /// )
  /// ```
  T resolve<T>(T normal, {T? deactivated, T? pressed, T? hovered}) {
    if (isDeactivated) return deactivated ?? normal;
    if (isPressed) return pressed ?? hovered ?? normal;
    if (isHovering) return hovered ?? normal;
    return normal;
  }
}

/// Signature for the builder function used by [InteractiveBuilder].
///
/// The builder receives the current [BuildContext], the [InteractionState]
/// containing the current interaction state, and an optional [child] widget.
typedef InteractionStateBuilder = Widget Function(BuildContext context, InteractionState state, Widget? child);
