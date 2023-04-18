import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  int _specificWordCount = 0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      decoration: const InputDecoration(
        hintText: 'Enter your text here',
      ),
      onChanged: (value) {
        final filter = ProfanityFilter();
        setState(() {
          List<String> words = value.split(' ');

          List<String> specificWords =
              words.where((word) => filter.hasProfanity(word)).toList();

          _specificWordCount = specificWords.length;
        });
      },
      maxLength: 100,
      buildCounter: (BuildContext context,
          {int? currentLength, int? maxLength, bool? isFocused}) {
        return Text(
          'bad word count: $_specificWordCount',
        );
      },
    );
  }
}
