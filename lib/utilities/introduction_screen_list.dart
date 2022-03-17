import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getIntroductionPages() {
  return [
    PageViewModel(
        image: Image.network('https://fabulousmasterpieces-blog.co.uk/wp-content/uploads/mona-lisa-original.jpg'),
        title: 'Welcome',
        body: 'to War Thunder Versus 3',
        decoration: PageDecoration()),
    PageViewModel(
      image: Image.network('https://fabulousmasterpieces-blog.co.uk/wp-content/uploads/mona-lisa-original.jpg'),
      title: 'All vehicles available',
      body: 'Even a bombers and boats. Premium, rare, platform exclusive, deleted vehicle, all of them in the app',
    ),
    PageViewModel(
      image: Image.network('https://fabulousmasterpieces-blog.co.uk/wp-content/uploads/mona-lisa-original.jpg'),
      title: "It's not final data",
      body: 'Another characteristics will be add some later, approximately at this spring',
    ),
  ];
}