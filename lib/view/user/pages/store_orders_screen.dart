import 'package:dionapplication/controller/store_orders_controller.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreOrdersScreen extends GetView<StoreOrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ادارة الطلبات'),
      body: GetBuilder<StoreOrdersController>(
        builder: (controller) {
          return controller.orderList == null
              ? Center(child: CircularProgressIndicator())
              : controller.orderList!.isEmpty
                  ? Center(child: Text("لا توجد طلبات"))
                  : ListView.builder(
                      itemCount: controller.orderList!.length,
                      itemBuilder: (context, index) {
                        final order = controller.orderList![index];
                        return Card(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              title: Text(order.storeName),
                              subtitle: Text(order.enteredDate),
                              onTap: () =>
                                  controller.showAcceptanceDialog(order),
                            ),
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
