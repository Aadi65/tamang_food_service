class WalkthroughContents {
  String image;
  String title;
  String description;
  WalkthroughContents(
      {required this.image, required this.title, required this.description});
}

List<WalkthroughContents> contents = [
  WalkthroughContents(
      image: 'assets/Illustrations.png',
      title: 'All your favorites',
      description:
          'Order from the best local restaurants with easy, on-demand delivery.'),
  WalkthroughContents(
      image: 'assets/Illustrations (2).png',
      title: 'Choose your Food',
      description:
          'Easily find your type of food craving and you’ll get delivery in wide range.'),
  WalkthroughContents(
      image: 'assets/Illustrations (1).png',
      title: 'Free delivery offers',
      description:
          'Free delivery for new customers via Apple Pay and others payment methods.'),
];
