import 'package:dionapplication/controller/add_dept_controller.dart';
import 'package:dionapplication/data/model/customer_paricipants/customer_paricipants_get_moedl.dart';
import 'package:dionapplication/util/fonts.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDeptScreen extends GetView<AddDeptController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'إضافة دين'),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Obx(() {
                              return Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors.blue;
                                      }
                                      return Colors.transparent;
                                    },
                                  ),
                                  checkColor: Colors.white,
                                  value: controller.isChecked.value,
                                  onChanged: (value) {
                                    controller.isChecked.value = value!;
                                  },
                                ),
                              );
                            }),
                            Text(
                              "العميل شخصياً",
                              style: robotoMediumBold,
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return controller.isChecked.value
                            ? SizedBox()
                            : Text(
                                "أشخاص يمكنهم التدين بحساب هذا العميل",
                                style: robotoMedium,
                              );
                      }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Obx(() {
                          return controller.isChecked.value
                              ? SizedBox()
                              : GetBuilder<AddDeptController>(
                                  builder: (c) => controller
                                                  .customerParticipantList ==
                                              null ||
                                          controller
                                              .customerParticipantList!.isEmpty
                                      ? Center(
                                          child: Text(
                                              "لا يوجد مشتريين من قبل العميل"),
                                        )
                                      : DropdownButtonFormField<
                                          CustomerParticipantGetDto>(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.2),
                                          // value: controller.storeTypeList != null? controller.storeTypeList![0].name:"",
                                          items: controller
                                                      .customerParticipantList !=
                                                  null
                                              ? controller
                                                  .customerParticipantList!
                                                  .map(
                                                      (CustomerParticipantGetDto
                                                          participant) {
                                                  return DropdownMenuItem<
                                                      CustomerParticipantGetDto>(
                                                    value: participant,
                                                    child:
                                                        Text(participant.name),
                                                  );
                                                }).toList()
                                              : [
                                                  DropdownMenuItem<
                                                      CustomerParticipantGetDto>(
                                                    value: null,
                                                    child: Text(
                                                        'Loading...'), // Display loading message while data is being fetched
                                                  )
                                                ],
                                          onChanged: (CustomerParticipantGetDto?
                                              newValue) {
                                            if (newValue != null) {
                                              controller.selectedParticipant =
                                                  newValue;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'المشتري ',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          // validator: (value) {
                                          //   if (value == null) {
                                          //     return 'يرجى تحديد نوع المشتري';
                                          //   }
                                          //   return null;
                                          // },
                                        ),
                                );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: Obx(
                                    () => Radio(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Colors.blue;
                                          }
                                          return Colors.grey;
                                        },
                                      ),
                                      value: 'بيان عادي',
                                      groupValue:
                                          controller.selectedValue.value,
                                      onChanged: (value) {
                                        controller.changeInvoiceType(value!);
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "بيان عادي",
                                  style: robotoMediumBold,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: Obx(
                                    () => Radio(
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Colors.blue;
                                          }
                                          return Colors.grey;
                                        },
                                      ),
                                      value: 'تفصيلي',
                                      groupValue:
                                          controller.selectedValue.value,
                                      onChanged: (value) {
                                        controller.changeInvoiceType(value!);
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "تفصيلي",
                                  style: robotoMediumBold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          return controller.selectedValue.value == 'بيان عادي'
                              ? ShortStatementFormWidget(
                                  amountController: controller.amountC,
                                  detailsController: controller.detailsC,
                                  formKey: controller.formKey,
                                  onPressed: () {
                                    if (controller.isLoading.isFalse) {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.addInvoice1Item();
                                      }
                                    }
                                  },
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => ListView.builder(
                                            itemCount:
                                                controller.invoiceItems.length,
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ItemContainer(
                                                  controller: controller,
                                                  index: index
                                                  // index: index,
                                                  // // onUpdate:
                                                  // //     (String key, String value) {
                                                  // //   // Handle the update logic here
                                                  // //   // For example, update the itemController[index] with the new value
                                                  // // },
                                                  // itemController:
                                                  //     itemControllers[index],
                                                  );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () {
                  return controller.selectedValue.value == 'تفصيلي'
                      ? Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // _printAndUploadData();
                                      // controller.retrieveListViewData(
                                      //     itemControllers);

                                      controller.addMultiInvoiceItems();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                    ),
                                    child: Text(
                                      "حفظ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                return controller.invoiceItems.length < 20
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 8.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: controller.ddContainer,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.amber[900],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                              ),
                                              child: Text(
                                                "إضافة سلعة",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox();
                              },
                            ),
                          ],
                        )
                      : SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// final itemControllers = [Get.find<AddDeptController>()].obs;

// void _printAndUploadData() {
//   itemControllers.asMap().forEach((index, itemController) {
//     final name = itemController.nameC.text;
//     final price = itemController.priceC.text;
//     final amount = itemController.amountC.text;
//     if (name.isNotEmpty && price.isNotEmpty && amount.isNotEmpty) {
//       print(
//         'Container $index - Name: $name, Price: $price,  amount: $amount',
//       );
//     }
//   });
// }
class ItemContainer extends StatelessWidget {
  final AddDeptController controller;
  final int index;

  ItemContainer({required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${index + 1} ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(8.0),
                    // ),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'البيان'),
                      onChanged: (value) {
                        controller.updateItemData(index, 'name', value);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 2.0),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(8.0),
                    // ),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'العدد'),
                      onChanged: (value) {
                        controller.updateItemData(index, 'amount', value);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 2.0),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(8.0),
                    // ),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'السعر'),
                      onChanged: (value) {
                        controller.updateItemData(index, 'price', value);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 2.0),

                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey),
                    //   borderRadius: BorderRadius.circular(8.0),
                    // ),
                    child: TextFormField(
                      controller: TextEditingController(
                          text: controller.invoiceItems[index]?['total'] ??
                              '0.00'),
                      readOnly: true,
                      // initialValue:
                      //     controller.invoiceItems[index]?['total'] ?? '0.00',

                      decoration: InputDecoration(labelText: 'الاجمالي'),
                      // onChanged: (value) {
                      //   controller.updateItemData(index, 'price', value);
                      // },
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                //     // decoration: BoxDecoration(
                //     //   border: Border.all(color: Colors.grey),
                //     //   borderRadius: BorderRadius.circular(8.0),
                //     // ),
                //     child: TextFormField(
                //       decoration: InputDecoration(
                //           labelText:
                //               'الاجمالي: ${controller.invoiceItems[index]!['total'] ?? '0.00'}'),
                //       // onChanged: (value) {
                //       //   controller.updateItemData(index, 'total', value);
                //       // },
                //     ),
                //   ),
                // ),
                // IconButton(
                //   icon: Icon(Icons.close),
                //   onPressed: () {
                //     controller.deleteItem(index);
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class ItemContainer extends StatelessWidget {
//   final int index;
//   final Function(String key, String value) onUpdate;

//   ItemContainer({required this.index, required this.onUpdate, Key? key})
//       : super(key: key ?? UniqueKey());

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4.0),
//       padding: EdgeInsets.all(2.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 '${index + 1} ',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.1),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'البيان'),
//                     onChanged: (value) {
//                       onUpdate('name', value);
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: 2.0),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.1),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'العدد'),
//                     onChanged: (value) {
//                       onUpdate('amount', value);
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: 2.0),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.1),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'السعر'),
//                     onChanged: (value) {
//                       onUpdate('price', value);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ShortStatementFormWidget extends StatelessWidget {
  final TextEditingController amountController;
  final TextEditingController detailsController;
  final Key formKey;
  final String amountLabel;
  final String detailsLabel;
  final VoidCallback onPressed;

  const ShortStatementFormWidget({
    required this.amountController,
    required this.detailsController,
    required this.formKey,
    required this.onPressed,
    this.amountLabel = "المبلغ",
    this.detailsLabel = "البيان",
  });

  String? amountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال المبلغ';
    }
    return null;
  }

  String? detailsValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البيان';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                validator: amountValidator,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.payments_rounded),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: amountLabel,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 4,
                controller: detailsController,
                validator: detailsValidator,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: detailsLabel,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "إضافة",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class DetailedStatementFormWidget extends StatelessWidget {
//   final List<TextEditingController> controllers;
//   final List<String> hintTexts;
//   final List<String> labels;
//   final VoidCallback onAddPressed;
//   final VoidCallback onConfirmPressed;

//   const DetailedStatementFormWidget({
//     required this.controllers,
//     required this.hintTexts,
//     required this.labels,
//     required this.onAddPressed,
//     required this.onConfirmPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: _buildTextField(0),
//               ),
//               SizedBox(width: 2.0),
//               Expanded(
//                 child: _buildTextField(1),
//               ),
//               SizedBox(width: 2.0),
//               Expanded(
//                 child: _buildTextField(2),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: Colors.blue,
//                   ),
//                   child: IconButton(
//                     onPressed: onAddPressed,
//                     icon: Icon(Icons.add),
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 4),
//               Expanded(
//                 flex: 7,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: onConfirmPressed,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 30),
//                     ),
//                     child: Text(
//                       "إضافة",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           labels[index],
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//         SizedBox(height: 4),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: TextFormField(
//             controller: controllers[index],
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: hintTexts[index],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final selectedValue = 'بيان عادي'.obs;

//   final itemControllers = <AddDeptController>[].obs;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Obx(
//             () => ListView.builder(
//               itemCount: itemControllers.length,
//               itemBuilder: (context, index) {
//                 return ItemContainer(
//                   index: index,
//                   itemController: itemControllers[index],
//                 );
//               },
//             ),
//           ),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 8.0, right: 4.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     child: Text(
//                       "حفظ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Obx(() {
//               return itemControllers.length < 20
//                   ? Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 4.0, right: 8.0),
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _addContainer,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.amber[900],
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 8),
//                             ),
//                             child: Text(
//                               "إضافة سلعة",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : SizedBox();
//             }),
//           ],
//         )
//       ],
//     );
//   }

//   void _addContainer() {
//     if (itemControllers.length < 20) {
//       itemControllers.add(Get.find<AddDeptController>());
//     }
//   }

//   void _printAndUploadData() {
//     itemControllers[0].itemDataList.asMap().forEach((index, data) {
//       final name = data['name'] ?? '';
//       final price = data['price'] ?? '';
//       final amount = data['amount'] ?? '';

//       if (name.isNotEmpty && price.isNotEmpty && amount.isNotEmpty) {
//         print('Container $index - Name: $name, Price: $price, Amount: $amount');
//       }
//     });
//   }
// }
