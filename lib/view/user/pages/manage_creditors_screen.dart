import 'package:dionapplication/view/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/manage_creditors_controller.dart';
import '../widgets/addCreditorsWidget.dart';
import '../widgets/creditorsListWidget.dart';
import '../../../util/fonts.dart';

class ManageCreditorsScreen extends GetView<ManageCreditorsController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'الصلاحيات'),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: controller.formKey,
                  child: addCreditorsWidget(
                    title: "إضافة أشخاص",
                    inputLabel: "الاسم",
                    inputHint: "",
                    buttonText: "إضافة",
                    controller: controller.nameC,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addParticipant();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "إضافة",
                        style: robotoHugeWhite,
                      ),
                      if (controller.isLoading.isTrue)
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "الاشخاص المسموح لهم بالتدين",
                  style: robotoHuge,
                ),
                GetBuilder<ManageCreditorsController>(
                  builder: (controller) {
                    return controller.participantsList == null
                        ? Center(child: CircularProgressIndicator())
                        : controller.participantsList!.isEmpty
                            ? Center(
                                child: Text("لا توجد بيانات"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.participantsList!.length,
                                itemBuilder: (context, index) {
                                  final item = controller.participantsList![index];
                                  return CreditorsListWidget(
                                    personName: item.name,
                                  );
                                },
                              );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}