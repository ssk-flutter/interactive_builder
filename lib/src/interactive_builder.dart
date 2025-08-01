import 'package:flutter/material.dart';

part 'interactive_builder.part.dart';

class InteractiveBuilder extends StatefulWidget {
  const InteractiveBuilder({super.key, required this.builder, this.onTap, this.child});

  final InteractionStateBuilder builder;
  final GestureTapCallback? onTap;
  final Widget? child;

  @override
  State<InteractiveBuilder> createState() => _InteractiveBuilderState();
}

class _InteractiveBuilderState extends State<InteractiveBuilder> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final currentState = InteractionState(
      isDeactivated: widget.onTap == null,
      isHovering: _isHovering,
      isPressed: _isPressed,
    );

    return InkWell(
      onTap: widget.onTap,
      onHover: (hovering) => setState(() => _isHovering = hovering),
      onHighlightChanged: (pressed) => setState(() => _isPressed = pressed),
      child: widget.builder(context, currentState, widget.child),
    );
  }
}
