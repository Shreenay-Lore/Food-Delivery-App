import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/firebase_options.dart';
import 'package:get_storage/get_storage.dart';

class Global {
  static Future<void> init() async {
    await _initializeDotenv();
    _initializeStripe();
    await _initializeFirebase();
    await _initializeAppCheck();
    await _initializeStorage();
  }

  static Future<void> _initializeDotenv() async {
    await dotenv.load(fileName: ".env");
  }

  static void _initializeStripe() {
    Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    Stripe.instance.applySettings();
  }

  static Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  static Future<void> _initializeAppCheck() async {
    if (!kDebugMode) {
      await FirebaseAppCheck.instance.activate(
        androidProvider: AndroidProvider.playIntegrity,
        appleProvider: AppleProvider.appAttest,
        webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      );
    } else {
      await FirebaseAppCheck.instance.activate(
        androidProvider: AndroidProvider.debug,
        appleProvider: AppleProvider.debug,
      );
    }
  }

  static Future<void> _initializeStorage() async {
    await GetStorage.init();
  }
}
