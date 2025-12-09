import 'package:flutter/material.dart';
import 'package:paywall_app/ui/widgets/primary_button.dart';
import 'package:go_router/go_router.dart';
import 'package:paywall_app/viewmodels/onboarding_viewmodel.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingViewModel viewModel;

  const OnboardingScreen({super.key, required this.viewModel});

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
                viewModel.navigateToPaywall(onNavigationRequested: () {
                  GoRouter.of(context).go('/paywall'); // Навигация происходит в UI
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
