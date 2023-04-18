import 'package:flutter/material.dart';

import 'image_screening/image_screen.dart';
import 'text_screening/text_screen.dart';
import 'text_screening/text_screen_variation.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPageScreen> {
  int _selectedIndex = 0;

  bool shouldShowBottomTab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _addWidgetBasedOnIndex(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _addWidgetBasedOnIndex() {
    return Container(
      child: _getChildBasedOnTab(),
    );
  }

  Widget _getChildBasedOnTab() {
    switch (_selectedIndex) {
      case 0:
        return const TextScreen();

      case 1:
        return const TextScreening();
      case 2:
        return const ImageScreen();
      default:
        return const Scaffold(
          body: Center(
            child: Text('error'),
          ),
        );
    }
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          label: 'message',
          icon: Icon(Icons.message_rounded),
        ),
        BottomNavigationBarItem(
          label: 'text screening',
          icon: Icon(Icons.message_outlined),
        ),
        BottomNavigationBarItem(
          label: 'image',
          icon: Icon(Icons.image),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
    );
  }
}
