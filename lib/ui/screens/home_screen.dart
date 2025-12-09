import 'package:flutter/material.dart';
import 'package:paywall_app/ui/widgets/primary_button.dart';
import 'package:paywall_app/utils/date_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:paywall_app/viewmodels/home_viewmodel.dart';
import 'package:paywall_app/data/models/subscription_info_base.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

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
              ValueListenableBuilder<SubscriptionInfoBase>(
                valueListenable: viewModel.subscriptionInfo,
                builder: (context, subscriptionInfo, child) {
                  return Text(
                    dateFormatter(subscriptionInfo.endDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
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
                  await viewModel.resetSubscription(
                    onNavigationRequested: () {
                      // GoRouter.of(
                      //   context,
                      // ).go('/onboarding'); // Навигация происходит в UI
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
