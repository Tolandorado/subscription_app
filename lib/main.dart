import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paywall_app/data/services/storage/storage_service.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/data/services/api/api_service.dart';
import 'package:paywall_app/router/app_router.dart'; // Импортируем наш роутер

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

  // Присваиваем глобальный репозиторий для использования в GoRouter
  globalSubscriptionRepository = subscriptionRepository;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter, // Используем routerConfig
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
