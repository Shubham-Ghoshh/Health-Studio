// import 'package:flutter_apns/flutter_apns.dart';
// import 'package:get/get.dart';
// import 'package:health_studio_user/core/controllers/auth_controller.dart';

// class APNController extends GetxController {
//   PushConnector connector = createPushConnector();

//   void getToken() async {
//     print("CALLED CONFIGURE");
//     connector.configure(
//       onLaunch: handleAPNMessage,
//       onResume: handleAPNMessage,
//       onMessage: handleAPNMessage,
//     );
//     connector.requestNotificationPermissions();

//     connector.isDisabledByUser.addListener(() {
//       if (!(connector.isDisabledByUser.value ?? true)) {
//         print(connector.providerType);
//         print("ENABLED ${connector.token.value}");
//         if (connector.token.value != null) {
//           Get.find<AuthController>().addDevice(connector.token.value ?? "");
//         }
//         // connector.token.addListener(() {
//         //   print("TOKEN LISTENER");
//         //   if (connector.token.value != null) {
//         //     print("APN TOKEN =====  ${connector.token.value}");
//         //     Get.find<AuthController>().addDevice(connector.token.value ?? "");
//         //   }
//         // });
//       }
//     });
//   }

//   Future<void> handleAPNMessage(message) async {
//     print("MESSAGE!! $message");
//   }
// }
