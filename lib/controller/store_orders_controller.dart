import 'package:dionapplication/data/model/store_customers/store_customer_order_get.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/util/app_constants.dart';
import 'package:dionapplication/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreOrdersController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;

  StoreOrdersController({required this.storeCustomersRepo});

  List<StoreCustomerOrderGet>? orderList;

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  getOrders() async {
    int userId =
        Get.find<SharedPreferences>().getInt(AppConstants.CURRENT_USER_ID)!;
    if (orderList == null) {
      Response response = await storeCustomersRepo.getOrdersForUser(userId);
      if (response.statusCode == 200) {
        orderList = [];
        response.body.forEach((o) {
          orderList!.add(StoreCustomerOrderGet.fromJson(o));

          // orderList!.add(OrderInfo(o['id'], "f", o['enteredDate']));
        });
        print(orderList);
        update();
      }

      //  else {
      //   ApiChecker.checkApi(response);
      // }
    }
  }

  void showAcceptanceDialog(StoreCustomerOrderGet order) {
    Get.defaultDialog(
      title: 'قبول الطلب',
      content:
          Text('Do you accept ${order.storeName} on ${order.enteredDate}?'),
      textConfirm: 'Accept',
      // textCancel: 'Reject',
      onConfirm: () async {
        await acceptStore(order.id);
        // Get.back();
      },
      // onCancel: () {
      //   // Handle Reject action
      //   Get.back(); // Close the dialog
      // },
    );
  }

  acceptStore(int id) async {
    Get.back();

    Response response = await storeCustomersRepo.acceptedStore(id);
    if (response.statusCode == 200) {
      if (response.body) {
        var x = orderList!.where((element) => element.id == id).first;
        orderList!.remove(x);
        update();
        CustomSnackBar.showSuccessMessage(message: "تمت العمليه بنجاح");
      }
    } else {
      CustomSnackBar.showErrorMessage(message: "فشل الارسال");
    }
  }
}


