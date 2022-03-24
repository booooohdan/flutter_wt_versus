import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../screens/feedback_screen.dart';
import '../screens/select_screen.dart';
import '../utilities/constants.dart';

class BottomNavBar extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      SelectScreen(),
      FeedbackScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.compare_arrows),
          title: localizations.compare,
          activeColorPrimary: Colors.redAccent,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          title: localizations.feedback,
          activeColorPrimary: Colors.redAccent,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      backgroundColor: kLightGreyColor,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style1,
      resizeToAvoidBottomInset: true,
    );
  }
}
