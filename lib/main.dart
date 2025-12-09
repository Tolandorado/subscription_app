import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paywall_app/data/services/storage/storage_service.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/data/services/api/api_service.dart';
import 'package:paywall_app/router/app_router.dart'; // Импортируем наш роутер
import 'package:provider/provider.dart';

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

  runApp(
    ChangeNotifierProvider<SubscriptionRepository>.value(
      value: subscriptionRepository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionRepository = Provider.of<SubscriptionRepository>(context);
    return MaterialApp.router(
      routerConfig: buildRouter(
        subscriptionRepository,
      ), // Используем buildRouter
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
