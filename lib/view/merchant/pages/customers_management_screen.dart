import 'package:dionapplication/controller/customer_management_controller.dart';
import 'package:dionapplication/data/model/store_customers/store_customer_get.dart';
import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/merchant/widgets/searchFieldWidget.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomersManagementScreen extends GetView<CustomerManagementController> {
  const CustomersManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: "إدارة العملاء"),
        body: RefreshIndicator(
          onRefresh: () => controller.getCustomers(),
          child: Column(
            children: [
              // Search Field
              SearchFieldWidget(controller: controller),

              const SizedBox(height: 10),

              // Filters Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Locked Filter Toggle
                    Obx(() => Row(
                          children: [
                            Switch(
                              value: controller.showLockedOnly.value,
                              onChanged: (value) {
                                controller.showLockedOnly.value = value;
                                controller.filterCustomers();
                              },
                            ),
                            const Text("عرض المقفلين فقط"),
                          ],
                        )),

                    // Notification Filter Toggle
                    Obx(() => Row(
                          children: [
                            Switch(
                              value: controller.showNotificationOnly.value,
                              onChanged: (value) {
                                controller.showNotificationOnly.value = value;
                                controller.filterCustomers();
                              },
                            ),
                            const Text("عرض العملاء بتنبيه"),
                          ],
                        )),

                    // // Store Dropdown Filter
                    // Obx(() => DropdownButton<String>(
                    //       value: controller.selectedStoreName.value.isEmpty
                    //           ? null
                    //           : controller.selectedStoreName.value,
                    //       hint: const Text("تصفية حسب المتجر"),
                    //       items: controller.storeNames
                    //           .map((store) => DropdownMenuItem(
                    //                 value: store,
                    //                 child: Text(store),
                    //               ))
                    //           .toList(),
                    //       onChanged: (value) {
                    //         controller.selectedStoreName.value = value ?? '';
                    //         controller.filterCustomers();
                    //       },
                    //     )),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Customers List
              Expanded(
                child: Obx(() {
                  if (controller.isLoadingCustomers.value) {
                    // Show CircularProgressIndicator while data is loading
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.filteredCustomersList.isEmpty) {
                    return const Center(
                        child: Text("لا يوجد نتائج مطابقة للبحث"));
                  }

                  return ListView.builder(
                    itemCount: controller.filteredCustomersList.length,
                    itemBuilder: (context, index) {
                      final customer = controller.filteredCustomersList[index];
                      return CustomerCard(
                        customer: customer,
                        controller: controller,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(Routes.ADDCUSTOMERSCREEN);
          },
          backgroundColor: Colors.blue,
          tooltip: 'إضافة',
          label: const Text(
            "إضافة",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final StoreCustomersGetDto customer;
  final CustomerManagementController controller;

  const CustomerCard({required this.customer, required this.controller});
  Future<void> launchPhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        customer.cuName, // Customer name
                        style: robotoHuge,
                      ),
                    ),
                    customer.userId == 0
                        ? Icon(
                            Icons.offline_pin,
                            color: Colors.red,
                          )
                        : Container(),
                    customer.isLock
                        ? Icon(
                            Icons.lock,
                            color: Colors.red,
                          )
                        : Container(),
                    customer.payNotification
                        ? Icon(
                            Icons.notifications,
                            color: Colors.red,
                          )
                        : Container(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            launchPhoneCall(customer.userPhoneNo.toString());
                          },
                          icon: Icon(Icons.call, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.DEBTDETAILSSCREEN,
                                arguments: customer);
                          },
                          icon: Icon(Icons.receipt_long_rounded,
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.EDITCUSTOMERSCREEN,
                                arguments: customer);
                          },
                          icon: Icon(Icons.edit, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.getMoney(customer);
                          },
                          icon: Icon(Icons.money_off, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Account Information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "سقف الحساب",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${customer.accountCapacity}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "إجمالي الدين",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          customer.totalDebt.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        controller.refreshCustomerData(customer);
                      },
                      icon: Icon(Icons.refresh, color: Colors.black),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.toNamed(Routes.ADDDEPTSCREEN, arguments: customer);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(Icons.add, color: Colors.white),
                      label: Text(
                        "تسجيل دين",
                        style: robotoMediumWhite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
