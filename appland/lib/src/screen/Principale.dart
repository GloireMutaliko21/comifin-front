// ignore_for_file: library_private_types_in_public_api, prefer_final_fields
import 'package:animations/animations.dart';
import 'package:app/src/screen/Contribuable.dart';
import 'package:app/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'Historique.dart';
import 'Home.dart';
import 'Contribution.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }
}

class _StateBody extends State<Principal> {
  int _selectedIndex = 0;

  static const List<Widget> _windowsItem = <Widget>[
    Constribution(),
    Contribuable(),
    Historique(),
    // Home(),
    // Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: buildNavigar(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _windowsItem.elementAt(_selectedIndex),
      ),
    );
  }

  Widget buildNavigar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          haptic: true,
          curve: Curves.easeOutExpo,
          activeColor: Colors.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: color_green,
          color: color_green,
          style: GnavStyle.google,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          tabs: const [
            GButton(
              icon: LineIcons.commentDollar,
              text: 'Mensuelle',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Journalière',
            ),
            GButton(
              icon: LineIcons.history,
              text: 'Historique',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget iconData;

  const NavigationScreen(this.iconData, {Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
    _controller!.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.iconData;
  }
}
