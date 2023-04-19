import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../.env.dart';

import '../../image_verification/bloc/image_bloc.dart';
import '../../image_verification/screen/image_verification_screen.dart';
import '../../core/repositories/image_screening_provider.dart';
import '../../text_verifcation/screen/text_verification_screen.dart';

import '../bloc/landing_screen_bloc.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LandingState();
}

class _LandingState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingScreenBloc(),
      child: const LandingScreenBody(),
    );
  }
}

class LandingScreenBody extends StatefulWidget {
  const LandingScreenBody({super.key});

  @override
  State<LandingScreenBody> createState() => _LandingScreenBodyState();
}

class _LandingScreenBodyState extends State<LandingScreenBody> {
  int _selectedIndex = 0;
  late LandingScreenBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LandingScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageBloc>(
          create: (context) => ImageBloc(ImageScreeningRepository(api_key)),
        ),
        // BlocProvider<TextBloc>(
        //   create: (context) => TextBloc(),
        // ),
      ],
      child: BlocBuilder<LandingScreenBloc, LandingScreenState>(
        buildWhen: (prevState, state) {
          return state is BottomTabChangeState;
        },
        builder: (context, state) {
          if (state is BottomTabChangeState) {
            _selectedIndex = state.selectedIndex;
          }

          return Scaffold(
            body: _addWidgetBasedOnIndex(),
            bottomNavigationBar: _bottomNavigationBar(),
          );
        },
      ),
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
          label: 'image',
          icon: Icon(Icons.image),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (value) {
        _bloc.add(
          BottomTabChangeEvent(value),
        );
      },
    );
  }
}
