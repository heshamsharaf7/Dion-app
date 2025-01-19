import 'package:get/get.dart';

class TimeGreetingController extends GetxController {
  var greeting = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _updateGreeting();
    // Update the greeting every minute
    _updateGreetingEveryMinute();
  }

  void _updateGreetingEveryMinute() {
    Future.delayed(Duration(minutes: 1), () {
      _updateGreeting();
      _updateGreetingEveryMinute();
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'صباح الخير';
    } else {
      greeting.value = 'مساء الخير';
    }
  }
}
