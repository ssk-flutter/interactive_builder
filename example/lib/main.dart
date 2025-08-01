import 'package:flutter/material.dart';
import 'package:interactive_builder/interactive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            TextButton(onPressed: _toggleActive, child: Text(_isActive ? 'Deactivate' : 'Activate')),
          ],
        ),
      ),
      floatingActionButton: InteractiveBuilder(
        onTap: _isActive ? _incrementCounter : null,
        builder: (context, state, child) => AnimatedScale(
          scale: state.resolve(1.0, pressed: 1.0, hovered: 1.1),
          duration: const Duration(milliseconds: 200),
          child: Material(
            child: FloatingActionButton(
              onPressed: null,
              tooltip: state.resolve('Increment', deactivated: 'Activate me first!'),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
