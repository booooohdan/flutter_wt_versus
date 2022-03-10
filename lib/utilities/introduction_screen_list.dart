import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getIntroductionPages() {
  return [
    PageViewModel(
        image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
        title: 'Welcome',
        body: 'to War Thunder Versus 3',
        decoration: PageDecoration()),
    PageViewModel(
      image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
      title: 'All vehicles available',
      body: 'Even a bombers and boats. Premium, rare, platform exclusive, deleted vehicle, all of them in the app',
    ),
    PageViewModel(
      image: Image.network('https://i.redd.it/uzghzqp9c4e81.png'),
      title: "It's not final data",
      body: 'Another characteristics will be add some later, approximately at this spring',
    ),
  ];
}