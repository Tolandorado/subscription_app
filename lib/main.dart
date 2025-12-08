import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paywall_app/data/services/storage/storage_service.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/ui/screens/onboarding.dart';
import 'package:paywall_app/data/models/subscription_info_base.dart';
import 'package:paywall_app/ui/screens/home_screen.dart';
import 'package:paywall_app/data/services/api/api_service.dart';
import 'package:paywall_app/viewmodels/home_viewmodel.dart';
import 'package:paywall_app/viewmodels/onboarding_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final LocalStorageService localStorageService = LocalStorageService(prefs);
  final MockApiService apiService = MockApiService();
  final SubscriptionRepository subscriptionRepository = SubscriptionRepository(
    localStorageService,
    apiService,
  );

  await subscriptionRepository.loadSubscriptionStatus();

  runApp(MyApp(subscriptionRepository: subscriptionRepository));
}

class MyApp extends StatefulWidget {
  final SubscriptionRepository subscriptionRepository;

  const MyApp({super.key, required this.subscriptionRepository});

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
        valueListenable: widget.subscriptionRepository.subscriptionInfo,
        builder: (context, subscriptionInfo, child) {
          if (widget.subscriptionRepository.isCurrentlyActive) {
            return HomeScreen(
              viewModel: HomeViewModel(widget.subscriptionRepository),
            );
          } else {
            return OnboardingScreen(
              viewModel: OnboardingViewModel(widget.subscriptionRepository),
            );
          }
        },
      ),
    );
  }
}
