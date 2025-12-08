import 'package:flutter/material.dart';
import 'package:paywall_app/services/subscription_service.dart';
import 'package:paywall_app/widgets/primary_button.dart';
import 'package:paywall_app/utils/date_formatter.dart';

class HomeScreen extends StatelessWidget {
  final SubscriptionService subscriptionService;

  const HomeScreen({super.key, required this.subscriptionService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Добро пожаловать! Ваша подписка активна до ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                dateFormatter(
                  subscriptionService.subscriptionInfo.value.endDate,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Text(
                'Наслаждайтесь полным доступом ко всему контенту.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 64),
              PrimaryButton(
                text: 'Сбросить подписку (для тестирования)',
                onPressed: () async {
                  await subscriptionService.resetSubscription();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
