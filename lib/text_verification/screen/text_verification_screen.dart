import 'package:contentscanner/text_verification/bloc/text_verification_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final TextEditingController _userInputController = TextEditingController();
  late TextVerificationScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TextVerificationScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TextVerificationScreenBloc,
        TextVerificationScreenState>(
      listener: (context, state) {
        if (state is TextVerified) {
          if (state.hasBadWords) {
            _showDialog(
              context,
            );
          } else {
            _showDialog(
              context,
              text: "The entered text does not contain bad words",
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Text Verification'),
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
                      onPressed: () => _bloc.add(
                        VerifyTextEvent(_userInputController.text),
                      ),
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, {String? text}) {
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
