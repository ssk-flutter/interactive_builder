import 'package:flutter/widgets.dart';

part 'interactive_builder.part.dart';

/// A widget that provides interaction state information to its builder.
///
/// The [InteractiveBuilder] tracks hover, press, and deactivated states,
/// providing them through an [InteractionState] object to the builder function.
///
/// Example:
/// ```dart
/// InteractiveBuilder(
///   onTap: () => print('Tapped!'),
///   onHover: (isHovering) => print('Hovering: $isHovering'),
///   builder: (context, state, child) => Container(
///     color: state.resolve(
///       Colors.blue,
///       hovered: Colors.lightBlue,
///       pressed: Colors.blueAccent,
///       deactivated: Colors.grey,
///     ),
///     child: Text('Interactive Widget'),
///   ),
/// )
/// ```
class InteractiveBuilder extends StatefulWidget {
  /// Creates an [InteractiveBuilder].
  ///
  /// The [builder] parameter is required and will be called with the current
  /// interaction state whenever the state changes.
  const InteractiveBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.onHover,
    this.child,
  });

  /// The builder function that creates the widget based on the interaction state.
  ///
  /// Called whenever the interaction state changes (hover, press, deactivated).
  final InteractionStateBuilder builder;

  /// Callback invoked when the widget is tapped.
  ///
  /// If null, the widget is considered deactivated and will not respond to
  /// hover or press interactions.
  final GestureTapCallback? onTap;

  /// Callback invoked when the hover state changes.
  ///
  /// The callback receives a boolean indicating whether the widget is currently
  /// being hovered. Only called when [onTap] is not null.
  final ValueChanged<bool>? onHover;

  /// Optional child widget to pass to the builder.
  ///
  /// This can be used for optimization when the child widget doesn't need
  /// to be rebuilt on state changes.
  final Widget? child;

  @override
  State<InteractiveBuilder> createState() => _InteractiveBuilderState();
}

class _InteractiveBuilderState extends State<InteractiveBuilder> {
  bool get _isDeactivated => widget.onTap == null;
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final currentState = InteractionState(
      isDeactivated: _isDeactivated,
      isHovering: _isHovering,
      isPressed: _isPressed,
    );

    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        behavior: HitTestBehavior.opaque,
        child: widget.builder(context, currentState, widget.child),
      ),
    );
  }

  void _onHoverChanged(bool isHovering) {
    if (_isDeactivated) return;
    setState(() => _isHovering = isHovering);
    widget.onHover?.call(isHovering);
  }
}
