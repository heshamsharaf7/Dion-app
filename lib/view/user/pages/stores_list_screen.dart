import 'package:dionapplication/controller/store_lists_controller.dart';
import 'package:dionapplication/routes/app_pages.dart';
import 'package:dionapplication/view/user/widgets/stores_list_item.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoresListScreen extends GetView<StoreListsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'البقالات المتوفره  '),
        body: GetBuilder<StoreListsController>(
          builder: (controller) {
            return controller.storeList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.storeList.length,
                    itemBuilder: (context, index) {
                      final store = controller.storeList[index];
                      return InkWell(
                        onTap: () {
                        
                                  Get.toNamed(Routes.STOREDETAILS  ,arguments: {'storeId':controller.storeList[index].id!});

                        },
                        child: StoreListItem(
                          storeName: store.name!,
                          iconData: Icons.store,
                        ),
                      );
                    },
                  );
          },
        ));
  }
}

// class StoresListScreen extends GetView<StoreListsController> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//           appBar: CustomAppBar(title: 'البقالات المتوفرة'),
//           body: GetBuilder<StoreListsController>(
//             builder: (controller) {
//               return controller.storeList == null
//                   ? Center(child: CircularProgressIndicator())
//                   : controller.storeList!.isEmpty
//                       ? Center(
//                           child: Text("لا توجد بيانات"),
//                         )
//                       : ListView.builder(
//                           itemCount: controller.storeList!.length,
//                           itemBuilder: (context, index) {
//                             final store = controller.storeList![index];
//                             return StoreListItem(
//                               storeName: store.name!,
//                               iconData: Icons.store,
//                             );
//                           },
//                         );
//             },
//           )),
//     );
//   }
// }
