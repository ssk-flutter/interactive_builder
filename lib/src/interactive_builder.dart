import 'package:flutter/widgets.dart';

part 'interactive_builder.part.dart';

class InteractiveBuilder extends StatefulWidget {
  const InteractiveBuilder({super.key, required this.builder, this.onTap, this.onHover, this.child});

  final InteractionStateBuilder builder;
  final GestureTapCallback? onTap;
  final ValueChanged<bool>? onHover;
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
    setState(() => _isHovering = isHovering);
    widget.onHover?.call(isHovering);
  }
}
