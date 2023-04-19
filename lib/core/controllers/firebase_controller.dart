import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:health_studio_user/core/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseController extends GetxController {
  bool isNotification = false;
  void Function()? screenNavigation;

  @override
  void onInit() {
    super.onInit();
    // if (!Platform.isIOS) {
    setupInteractedMessage();
    // }
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void getToken() async {
    // if (!Platform.isIOS) {
    await messaging.requestPermission();
    String? fcmToken = await messaging.getToken();
    Get.find<AuthController>().addDevice(fcmToken ?? "");
    // }
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage, terminateState: true);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message, {bool terminateState = false}) {}
}
