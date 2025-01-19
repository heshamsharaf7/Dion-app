import 'package:dionapplication/controller/add_wallet_controller.dart';
import 'package:dionapplication/data/model/wallet/wallet_get_model.dart';
import 'package:dionapplication/view/widgets/custom_input.dart';
import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWalletScreen extends GetView<AddWalletController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'إضافة محفظه'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "نوع المحفظه",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  GetBuilder<AddWalletController>(
                    builder: (c) => DropdownButtonFormField<WalletGetModel>(
                      padding: EdgeInsets.symmetric(vertical: 0.2),
                      // value: controller.storeTypeList != null? controller.storeTypeList![0].name:"",
                      items: controller.walletTypes != null
                          ? controller.walletTypes!
                              .map((WalletGetModel storeType) {
                              return DropdownMenuItem<WalletGetModel>(
                                value: storeType,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(storeType.name!),
                                      SizedBox(
                                        width: 24, // Adjust the width as needed
                                        height:
                                            24, // Adjust the height as needed
                                        child: Image.network(
                                          storeType.iconPath!,
                                          fit: BoxFit
                                              .cover, // Adjust how the image fits within the box
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          : [
                              DropdownMenuItem<WalletGetModel>(
                                value: null,
                                child: Text(
                                    'Loading...'), // Display loading message while data is being fetched
                              )
                            ],
                      onChanged: (WalletGetModel? newValue) {
                        if (newValue != null) {
                          controller.selectedWalletType = newValue;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'نوع المحفظه ',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى تحديد نوع المحفظه';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomInput(
                    controller: controller.accountNoController,
                    label: ' رقم الحساب*',
                    hint: '',
                    requiredField: true,
                    icno: Icon(Icons.account_balance),
                  ),
                  SizedBox(height: 20),
                  CustomInput(
                    controller: controller.detailsController,
                    label: 'ملاحظات',
                    hint: '',
                    requiredField: false,
                    icno: Icon(Icons.details),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.addWallet();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Create Wallet",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
