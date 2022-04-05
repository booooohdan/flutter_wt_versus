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
        title: localizations.introduction_title1,
        body: localizations.introduction_body1,
        decoration: PageDecoration()),
    PageViewModel(
      image: Image.asset(
        'assets/icons/icon.png',
        width: 144,
      ),
      title: localizations.introduction_title2,
      body: localizations.introduction_body2,
    ),
    PageViewModel(
      image: Image.asset(
        'assets/icons/icon.png',
        width: 144,
      ),
      title: localizations.introduction_title3,
      body: localizations.introduction_body3,
    ),
    PageViewModel(
      image: Image.asset(
        'assets/icons/icon.png',
        width: 144,
      ),
      title: localizations.introduction_title4,
      body: localizations.introduction_body4,
    ),
    //TODO: Update introduction screens.
  ];
}
