import 'package:dionapplication/util/images.dart';

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
    title: "الإدارة السهلة للديون",
    image: Images
        .onboarding1, // You may replace Images.onboarding1 with the appropriate image for your app
    desc:
        "تطبيق \"ديون\" يُسهل عليك إدارة الديون التي تدينها للآخرين بشكل فعال ومنظم، مع إمكانية الدفع باستخدام المحافظ الإلكترونية الشهيرة.",
  ),
  OnboardingContents(
    title: "تسديد الديون بسهولة",
    image: Images
        .onboarding3, // You may replace Images.onboarding3 with the appropriate image for your app
    desc:
        "اكتشف كيف يمكن لتطبيق \"ديون\" مساعدتك في تسديد الديون الخاصة بك بطريقة مبسطة ومريحة، مع خيارات دفع متنوعة تشمل المحافظ الإلكترونية الرائجة.",
  ),
  OnboardingContents(
    title: "إدارة مالية فعّالة",
    image: Images
        .onboarding2, // You may replace Images.onboarding2 with the appropriate image for your app
    desc:
        "استفد من تطبيق \"ديون\" لتحقيق إدارة مالية متقنة، حيث يسهل عليك تتبع الديون الخاصة بك وتسديدها بطريقة مريحة وآمنة، مع خيارات الدفع الإلكتروني المتطورة.",
  ),
];
