import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseController extends GetxController {
  bool isNotification = false;
  void Function()? screenNavigation;

  @override
  void onInit() {
    super.onInit();
    setupInteractedMessage();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    await messaging.requestPermission();
    String? fcmToken = await messaging.getToken();
    return fcmToken;
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

  void _handleMessage(RemoteMessage message, {bool terminateState = false}) {
    if (message.data['screen'] != null) {}
  }
}
