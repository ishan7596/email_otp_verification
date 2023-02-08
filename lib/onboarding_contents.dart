class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to the app",
    image: "assets/image1.png",
    desc: "\"The journey of a thousand miles begins with a single step.\"",
  ),
  OnboardingContents(
    title: "Making things easier for you, always",
    image: "assets/image2.png",
    desc:
        "\"The purpose of our lives is to be happy.\"",
  ),
  OnboardingContents(
    title: "Get started with a seamless experience",
    image: "assets/image3.png",
    desc:
        "\"The best way to predict the future is to invent it.\"",
  ),
];
