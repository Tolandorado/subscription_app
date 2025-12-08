import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paywall_app/storage/storage.dart';
import 'package:paywall_app/services/subscription_service.dart';
import 'package:paywall_app/screens/onboarding.dart';
import 'package:paywall_app/models/subscription_info_base.dart';
import 'package:paywall_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final LocalStorageRepository localStorageRepository = LocalStorageRepository(
    prefs,
  );
  final SubscriptionService subscriptionService = SubscriptionService(
    localStorageRepository,
  );

  await subscriptionService.loadSubscriptionStatus();

  runApp(MyApp(subscriptionService: subscriptionService));
}

class MyApp extends StatefulWidget {
  final SubscriptionService subscriptionService;

  const MyApp({super.key, required this.subscriptionService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ValueListenableBuilder<SubscriptionInfoBase>(
        valueListenable: widget.subscriptionService.subscriptionInfo,
        builder: (context, subscriptionInfo, child) {
          if (widget.subscriptionService.isCurrentlyActive) {
            return HomeScreen(subscriptionService: widget.subscriptionService);
          } else {
            return OnboardingScreen(
              subscriptionService: widget.subscriptionService,
            );
          }
        },
      ),
    );
  }
}
