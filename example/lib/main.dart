import 'package:flutter/material.dart';
import 'package:interactive_builder/interactive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'InteractiveBuilder Demo',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    home: const DemoPage(),
  );
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _counter = 0;
  bool _buttonEnabled = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('InteractiveBuilder Demo'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Tap the button to increase counter:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Text('$_counter', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          InteractiveBuilder(
            onTap: _buttonEnabled
                ? () {
                    setState(() => _counter++);
                  }
                : null,
            onHover: (isHovering) {
              print('Button hovering: $isHovering');
            },
            builder: (context, state, child) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: state.resolve(
                  Colors.blue,
                  hovered: Colors.lightBlue,
                  pressed: Colors.blueAccent,
                  deactivated: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: state.isDeactivated
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: state.resolve(4.0, pressed: 2.0, hovered: 6.0),
                          offset: state.resolve(
                            const Offset(0, 2),
                            pressed: const Offset(0, 1),
                            hovered: const Offset(0, 3),
                          ),
                        ),
                      ],
              ),
              child: Text(
                state.resolve('Tap Me!', deactivated: 'Disabled'),
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Switch(value: _buttonEnabled, onChanged: (value) => setState(() => _buttonEnabled = value)),
          Text(_buttonEnabled ? 'Button Enabled' : 'Button Disabled'),
        ],
      ),
    ),
  );
}
