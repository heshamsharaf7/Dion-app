import 'package:dionapplication/controller/store_details_controller.dart';
import 'package:dionapplication/data/model/customer_paricipants/customer_paricipants_add_moedl.dart';
import 'package:dionapplication/data/model/customer_paricipants/customer_paricipants_get_moedl.dart';
import 'package:dionapplication/data/repository/store_customers_repo.dart';
import 'package:dionapplication/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCreditorsController extends GetxController {
  final StoreCustomersRepo storeCustomersRepo;
  ManageCreditorsController({required this.storeCustomersRepo});

  TextEditingController nameC = TextEditingController();

  var isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();

  List<CustomerParticipantGetDto>? participantsList;

  @override
  void onInit() {
    super.onInit();
    getCustomerParticipants();
  }

  getCustomerParticipants() async {
    int customerId = Get.find<StoreDetailsController>().storeCustomer!.id;
    if (participantsList == null) {
      Response response =
          await storeCustomersRepo.getCustomerParticipant(customerId);
      if (response.statusCode == 200) {
        participantsList = [];
        response.body.forEach((o) {
          participantsList!.add(CustomerParticipantGetDto.fromJson(o));
        });
        print(participantsList);
      }
      update();

      //  else {
      //   ApiChecker.checkApi(response);
      // }
    }
  }

  addParticipant() async {
    isLoading.value = true;
    int customerId = Get.find<StoreDetailsController>().storeCustomer!.id;
    CustomerParticipantAddDto customerParticipantAddDto =
        CustomerParticipantAddDto(
            customerId: customerId,
            enteredDate: DateTime.now().toString(),
            isActive: true,
            name: nameC.text,
            id: 0);
    Response response = await storeCustomersRepo
        .addCustomerParticipant(customerParticipantAddDto);

    if (response.statusCode == 200) {
     await getCustomerParticipants();

      print("prticipant added");
      nameC.clear();
      // CustomToast.successToast("  تم ارسال الطلب الى العميل");
    } else {
      CustomToast.errorToast(" حدث خطأ");
    }
    isLoading.value = false;
  }
}
