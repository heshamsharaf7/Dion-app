import 'package:dionapplication/controller/wallet_controller.dart';
import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletManagementScreen extends GetView<WalletController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'اداره المحافظ الالكترونيه'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  // Show CircularProgressIndicator while data is loading
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.storeWallets!.isEmpty) {
                  return const Center(child: Text("لا يوجد محافظ مسجله حاليا"));
                } else {
                  return ListView.builder(
                    itemCount: controller.storeWallets!.length,
                    itemBuilder: (context, index) {
                      var wallet = controller.storeWallets![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:NetworkImage(wallet.iconPath!) ,
                          ),
                          title: Text(
                            "Account No: ${wallet.accountNo}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                wallet.details!,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                // Handle edit action
                              } else if (value == 'delete') {
                                // Handle delete action
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to add wallet screen
                Get.toNamed(Routes.ADDWALLET);
              },
              icon: Icon(Icons.add),
              label: Text('Add Wallet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
