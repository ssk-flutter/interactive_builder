part of 'interactive_builder.dart';

class InteractionState {
  const InteractionState({required this.isDeactivated, required this.isHovering, required this.isPressed});

  final bool isDeactivated;
  final bool isHovering;
  final bool isPressed;

  /// Selects the appropriate value based on the state.
  ///
  /// The [normal] value must be provided.
  /// [deactivated], [hovered], [pressed] are optional.
  /// If not provided, they are replaced by values of other states in order of priority.
  T resolve<T>(T normal, {T? deactivated, T? pressed, T? hovered}) {
    if (isDeactivated) return deactivated ?? normal;
    if (isPressed) return pressed ?? hovered ?? normal;
    if (isHovering) return hovered ?? normal;
    return normal;
  }
}

typedef InteractionStateBuilder = Widget Function(BuildContext context, InteractionState state, Widget? child);
