// // import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/ads_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/consumer_well_request_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/meter_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/tansaction_data_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/transaction_details_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/water_provider_invoice_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/water_provider_order_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/waterprovider_consumer_finicial_report_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/well_account_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/well_consumer_invoice_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/well_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/unitOfWork/unit_of_work.dart';
// import 'package:water_services_system/core/interfaces/ads_repo.dart';
// import 'package:water_services_system/core/interfaces/compliance_repo.dart';
// import 'package:water_services_system/core/interfaces/consumer_well_requests_repo.dart';
// import 'package:water_services_system/core/interfaces/iunit_of_work.dart';
// import 'package:water_services_system/core/interfaces/meter_repo.dart';
// import 'package:water_services_system/core/interfaces/notification_repo.dart';
// import 'package:water_services_system/core/interfaces/tansaction_data_repo.dart';
// import 'package:water_services_system/core/interfaces/transaction_details_repo.dart';
// import 'package:water_services_system/core/interfaces/user_repo.dart';
// import 'package:water_services_system/core/interfaces/vehicle_repo.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/compliance_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/notification_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/user_repo_imp.dart';
// import 'package:water_services_system/Infrastructure/repositories/firebase/vehicle_repo_imp.dart';
// import 'package:water_services_system/core/interfaces/water_provider_invoice_repo.dart';
// import 'package:water_services_system/core/interfaces/water_provider_order_repo.dart';
// import 'package:water_services_system/core/interfaces/waterprovider_consumer_finicial_report_repo.dart';
// import 'package:water_services_system/core/interfaces/well_account_repo.dart';
// import 'package:water_services_system/core/interfaces/well_consumer_invoice_repo.dart';
// import 'package:water_services_system/core/interfaces/well_repo.dart';
// import 'package:water_services_system/presentation/view_model/notification_view_model.dart';
// import 'package:water_services_system/presentation/view_model/vehicle_view_model.dart';
// import 'package:water_services_system/presentation/view_model/water_provider/consumer_management_view_model.dart';
// import 'package:water_services_system/presentation/view_model/water_provider/consumer_order_view_model.dart';

// import '../../view_model/accounting_entiry_view_model.dart';
// import '../../view_model/ads_view_model.dart';
// import '../../view_model/compliance_view_model.dart';
// import '../../view_model/consumer_well_request_view_model.dart';
// import '../../view_model/meter_view_model.dart';
// import '../../view_model/user_view_model.dart';
// import '../../view_model/waerpoider_cnosumer_finicaial_report_view_model.dart';
// import '../../view_model/water_provider_invoice_view_model.dart';
// import '../../view_model/water_provider_order_view_model.dart';
// import '../../view_model/well_account_view_model.dart';
// import '../../view_model/well_consumer_invoice_view_model.dart';
// import '../../view_model/well_view_model.dart';
// import 'firebase_options.dart';

// import 'package:provider/single_child_widget.dart';

// final GetIt locator = GetIt.instance;

// void init() {
//   // firebaseConnection();
//   setupLocator();
// }

// void setupLocator() {
//   // locator.registerLazySingleton(() => NavigationService());
//   // locator.registerFactory<UserRepo>(() => UserRepoImp());
//   // locator.registerFactory<ConsumerWellRequesrRepo>(
//   //     () => ConsumerWellRequesrRepoImp());
//   // locator.registerFactory<MeterRepo>(() => MeterRepoImp());
//   locator.registerLazySingleton<WellRepo>(() => WellRepoImp());
//   locator.registerLazySingleton<VehicleRepo>(() => VehicleRepoImp());
//   locator.registerLazySingleton<WaterProviderInvoiceRepo>(
//       () => WaterProviderInvoiceRepoImp());
//   locator.registerLazySingleton<TransactionDataRepo>(() => TransactionDataRepoImp());
//   locator.registerLazySingleton<TransactionDetailsRepo>(
//       () => TransactionDetailsRepoImp());
//   // locator.registerLazySingleton<WellConsumerInvoiceRepo>(
//   //     () => WellConsumerInvoiceRepoImp());
//   locator.registerLazySingleton<WellAccountRepo>(() => WellAccountRepoImp());
//   locator.registerLazySingleton<WaterProviderOrderRepo>(
//       () => WaterProviderOrderRepoImp());
//   locator.registerLazySingleton<WaterProviderConsumerFinicailReportRepo>(
//       () => WaterProviderConsumerFinicailReportRepoImp());
//   locator.registerLazySingleton<ComplaintRepo>(() => ComplaintRepoImp());
//   locator.registerLazySingleton<NotificationRepo>(() => NotificationRepoImp());
//   locator.registerLazySingleton<AdsRepo>(() => AdsRepoImp());

//   //unit of work
//   WriteBatch batchWriter = FirebaseFirestore.instance.batch();

//   locator.registerLazySingleton<IUnitOfWork>(() => UnitOfWork());
// }

// void firebaseConnection() async {
//   // try {
//   //   WidgetsFlutterBinding.ensureInitialized();
//   //   await Firebase.initializeApp(
//   //     options: DefaultFirebaseOptions.currentPlatform,
//   //   );
//   // } catch (e) {}
// }

// List<SingleChildWidget> providerRegstreation() {
//   return [
//     ChangeNotifierProvider(
//       create: (_) => UserViewModel(locator<IUnitOfWork>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => ConsumerOrderViewModel(locator<IUnitOfWork>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => ConsumerManagementViewModel(locator<IUnitOfWork>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => ConsumerWellRequestViewModel(
//           locator<IUnitOfWork>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => MeterViewModel(locator<IUnitOfWork>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => WellViewModel(locator<WellRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => VehicleViewModel(locator<VehicleRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) =>
//           WaterProviderInvoiceViewModel(locator<WaterProviderInvoiceRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => AccountingEntiryViewModel(
//           locator<TransactionDataRepo>(), locator<TransactionDetailsRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) =>
//           WellConsumerInvoiceViewModel(locator<IUnitOfWork>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => WellAccountViewModel(locator<WellAccountRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) =>
//           WaterProviderOrderViewModel(locator<WaterProviderOrderRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => WaterproviderConsumerFiniscialReportViewModel(
//           locator<WaterProviderConsumerFinicailReportRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => ComplaintViewModel(locator<ComplaintRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => NotificationViewModel(locator<NotificationRepo>()),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => AdsViewModel(locator<AdsRepo>()),
//     ),
//     // ChangeNotifierProvider(
//     //   create: (context) => AuthViewModel(),
//     // )
//   ];
// }
