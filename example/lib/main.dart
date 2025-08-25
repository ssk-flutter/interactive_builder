import 'package:flutter/material.dart';
import 'package:interactive_builder/interactive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isActive = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleActive() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _toggleActive,
              child: Text('Toggle Active State: ${_isActive ? 'Activated' : 'Deactivated'}'),
            ),
            const SizedBox(height: 20),
            Text('Counter: $_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            InteractiveBuilder(
              onTap: _isActive ? () => setState(() => _counter = 0) : null,
              onHover: (isHovering) => print('Clear button hovering: $isHovering'),
              builder: (context, state, child) => Text(
                'Clear',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: state.resolve(
                    Colors.blue[300],
                    hovered: Colors.blue[600]!,
                    pressed: Colors.blue[900]!,
                    deactivated: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InteractiveBuilder(
              onTap: _isActive ? _incrementCounter : null,
              onHover: (isHovering) => print('Add button hovering: $isHovering'),
              builder: (context, state, child) => AnimatedScale(
                scale: state.resolve(1.0, pressed: 1.0, hovered: 1.1),
                duration: const Duration(milliseconds: 200),
                child: Padding(padding: const EdgeInsets.all(8.0), child: const Icon(Icons.add)),
              ),
            ),
          ],
        ),
      ),
    );
}
