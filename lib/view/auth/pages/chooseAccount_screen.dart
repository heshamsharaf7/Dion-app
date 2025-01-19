import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -5,
            left: -5,
            child: Image.asset(
              Images.bottom,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -5,
            right: -5,
            child: Image.asset(
              Images.top,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'حدد إستخدامك',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: 400,
                  child: Image.asset(
                    Images.accounts,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                  
                        Get.find<SharedPreferences>()
                                    .getBool(AppConstants.MERCHANT_LOGINED) ==
                                true
                            ? Get.toNamed(Routes.MERCHANTHOME)
                            : Get.toNamed(Routes.MERCHANTAUTHSCREEN);
                      },
                      icon: Icon(
                        Icons.store,
                        color: Colors.white,
                      ),
                      label: Text(
                        'صاحب متجر',
                        style: robotoMediumWhiteBold,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                                  print(Get.find<SharedPreferences>()
                            .getBool(AppConstants.USER_LOGINED));
                        Get.find<SharedPreferences>()
                                    .getBool(AppConstants.USER_LOGINED) ==
                                true
                            ? Get.toNamed(Routes.USERHOMESCREEN)
                            : Get.toNamed(Routes.USERAUTHSCREEN);
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        'عميل',
                        style: robotoMediumWhiteBold,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
