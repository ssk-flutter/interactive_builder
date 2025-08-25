import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_builder/interactive_builder.dart';

void main() {
  testWidgets('InteractiveBuilder rebuilds with correct state on tap',
      (WidgetTester tester) async {
    InteractionState? interactionState;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InteractiveBuilder(
            onTap: () {},
            builder: (context, state, child) {
              interactionState = state;
              return Container();
            },
          ),
        ),
      ),
    );

    // Initial state
    expect(interactionState?.isPressed, isFalse);

    // Tap down
    final gesture = await tester.startGesture(tester.getCenter(find.byType(InteractiveBuilder)));
    await tester.pumpAndSettle();
    expect(interactionState?.isPressed, isTrue);

    // Tap up
    await gesture.up();
    await tester.pumpAndSettle();
    expect(interactionState?.isPressed, isFalse);
  });

  testWidgets('InteractiveBuilder rebuilds with correct state on hover',
      (WidgetTester tester) async {
    InteractionState? interactionState;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: InteractiveBuilder(
                onTap: () {},
                builder: (context, state, child) {
                  interactionState = state;
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );

    // Initial state
    expect(interactionState?.isHovering, isFalse);

    // Hover
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer();
    await gesture.moveTo(tester.getCenter(find.byType(InteractiveBuilder)));
    await tester.pumpAndSettle();
    expect(interactionState?.isHovering, isTrue);

    // Unhover
    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();
    expect(interactionState?.isHovering, isFalse);
  });

  testWidgets('InteractiveBuilder is deactivated when onTap is null',
      (WidgetTester tester) async {
    InteractionState? interactionState;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InteractiveBuilder(
            builder: (context, state, child) {
              interactionState = state;
              return Container();
            },
          ),
        ),
      ),
    );

    expect(interactionState?.isDeactivated, isTrue);
  });

  testWidgets('InteractiveBuilder calls onHover callback correctly',
      (WidgetTester tester) async {
    bool? lastHoverValue;
    int hoverCallCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: InteractiveBuilder(
                onTap: () {},
                onHover: (isHovering) {
                  lastHoverValue = isHovering;
                  hoverCallCount++;
                },
                builder: (context, state, child) {
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );

    // Initial state - no callback called yet
    expect(lastHoverValue, isNull);
    expect(hoverCallCount, 0);

    // Hover
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer();
    await gesture.moveTo(tester.getCenter(find.byType(InteractiveBuilder)));
    await tester.pumpAndSettle();
    
    expect(lastHoverValue, isTrue);
    expect(hoverCallCount, 1);

    // Unhover
    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();
    
    expect(lastHoverValue, isFalse);
    expect(hoverCallCount, 2);
  });
}
