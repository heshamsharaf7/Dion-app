import 'package:dionapplication/util/app_color.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/auth/pages/merchant_auth/merhcant_login_screen.dart';
import 'package:dionapplication/view/auth/pages/merchant_auth/merchant_signUp_screen.dart';
import 'package:flutter/material.dart';


class MerchantAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primaryExtraSoft,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: robotoHugeWhite,
                    labelColor: Colors.blue,
                    unselectedLabelColor: AppColor.blackColor,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    tabs: [
                      Tab(
                        text: 'تسجيل الدخول',
                      ),
                      Tab(
                        text: 'إنشاء حساب',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              MerchantLoginScreen(),
              MerchantSignUpScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
