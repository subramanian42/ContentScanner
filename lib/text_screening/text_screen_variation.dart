import 'package:contentscanner/widget/text_field_widget.dart';
import 'package:flutter/material.dart';

class TextScreening extends StatefulWidget {
  const TextScreening({super.key});

  @override
  State<StatefulWidget> createState() => _TextScreeningState();
}

class _TextScreeningState extends State<TextScreening> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profanity check variation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: CustomTextField(),
          ),
        ],
      ),
    );
  }
}
