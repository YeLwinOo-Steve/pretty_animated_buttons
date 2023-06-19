import 'package:flutter/material.dart';
import 'package:pretty_buttons/pretty_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const PrettyButtonsExample(),
    );
  }
}

class PrettyButtonsExample extends StatefulWidget {
  const PrettyButtonsExample({super.key});

  @override
  State<PrettyButtonsExample> createState() => _PrettyButtonsExampleState();
}

class _PrettyButtonsExampleState extends State<PrettyButtonsExample> {
  final Color? scaffoldBg = Colors.grey[300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pretty Buttons Example'),
        elevation: 0.0,
      ),
      backgroundColor: scaffoldBg,
      body: Padding(
        padding: const EdgeInsets.all(
          25.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrettyShadowButton(
                label: "Pretty Shadow Button",
                onPressed: () {},
                icon: Icons.arrow_forward,
              ),
              PrettyNeumorphicButton(
                label: 'Pretty Neumorphic Button',
                onPressed: () {},
              ),
              PrettyUnderlineButton(
                label: 'Pretty Underline Button',
                onPressed: () {},
                secondSlideColor: scaffoldBg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
