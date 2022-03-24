import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getIntroductionPages(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;
  return [
    PageViewModel(
        image: Image.asset(
          'assets/icons/icon.png',
          width: 144,
        ),
        title: localizations.introd_title1,
        body: localizations.introd_body1,
        decoration: PageDecoration()),
    PageViewModel(
      image: Image.asset(
        'assets/icons/icon.png',
        width: 144,
      ),
      title: localizations.introd_title2,
      body: localizations.introd_body2,
    ),
    PageViewModel(
      image: Image.asset(
        'assets/icons/icon.png',
        width: 144,
      ),
      title: localizations.introd_title3,
      body: localizations.introd_body3,
    ),
    PageViewModel(
      image: Image.asset(
        'assets/icons/icon.png',
        width: 144,
      ),
      title: localizations.introd_title4,
      body: localizations.introd_body4,
    ),
  ];
}
