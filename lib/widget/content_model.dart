class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description: 'Pick your item from our Land',
      image: "images/screen1.png",
      title: 'Select from Our\n       Best Menu'),
  UnboardingContent(
      description:
          'You can pay cash on app and\n     Card payment is available',
      image: "images/screen2.png",
      title: 'Easy and Online Payment'),
  UnboardingContent(
      description: 'Deliver your item at your\n               Doorstep',
      image: "images/screen3.png",
      title: 'Quick Delivery')
];
