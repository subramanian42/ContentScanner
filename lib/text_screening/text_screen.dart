import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final TextEditingController _userInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profanity check'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFieldWidget(
                  userInputController: _userInputController,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () =>
                        _onPressed(_userInputController.text, context),
                    child: const Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _onPressed(String text, BuildContext context) {
  final filter = ProfanityFilter();
  final containsBadWords = filter.hasProfanity(text);
  final badwords = filter.getAllProfanity(text);
  if (containsBadWords) {
    _showDialog(
      context,
      badWords: badwords,
    );
  } else {
    _showDialog(
      context,
      text: "The entered text does not contain bad words",
    );
  }
}

void _showDialog(BuildContext context, {List<String>? badWords, String? text}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: text != null ? null : const Text('Error'),
      content: Text(
        text ?? 'Please enter appropriate text',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({required this.userInputController, super.key});
  final TextEditingController userInputController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 250,
        ),
        height: 50,
        child: TextField(
          controller: userInputController,
          decoration: InputDecoration(
            hintText: 'Enter your message',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            height: 1.5,
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
