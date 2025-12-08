import 'package:flutter/material.dart';
import 'package:paywall_app/services/subscription_service.dart';
import 'package:paywall_app/widgets/primary_button.dart';
import 'package:paywall_app/screens/paywall.dart';

class OnboardingScreen extends StatelessWidget {
  final SubscriptionService subscriptionService;

  const OnboardingScreen({super.key, required this.subscriptionService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добро пожаловать!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Откройте мир эксклюзивного контента с нашей подпиской!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const Text(
              'Получите полный доступ ко всем функциям и материалам.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 64),
            PrimaryButton(
              text: 'Продолжить',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PaywallScreen(subscriptionService: subscriptionService),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
