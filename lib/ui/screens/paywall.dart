import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/ui/core/primary_button.dart';
import 'package:paywall_app/ui/core/card.dart';
import 'package:paywall_app/viewmodels/paywall_viewmodel.dart';

class PaywallScreen extends StatelessWidget {
  final PaywallViewModel viewModel;

  const PaywallScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оформите подписку')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Получите неограниченный доступ!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ValueListenableBuilder<SubscriptionDuration?>(
              valueListenable: viewModel.selectedDuration,
              builder: (context, selectedDuration, child) {
                return CardWidget(
                  duration: SubscriptionDuration.month,
                  title: 'Месячная подписка',
                  price: 'Всего \$9.99 в месяц',
                  isSelected: selectedDuration == SubscriptionDuration.month,
                  onTap: () =>
                      viewModel.selectSubscription(SubscriptionDuration.month),
                );
              },
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<SubscriptionDuration?>(
              valueListenable: viewModel.selectedDuration,
              builder: (context, selectedDuration, child) {
                return CardWidget(
                  duration: SubscriptionDuration.year,
                  title: 'Годовая подписка',
                  price: 'Всего \$99.99 в год (экономия 20%)',
                  isSelected: selectedDuration == SubscriptionDuration.year,
                  onTap: () =>
                      viewModel.selectSubscription(SubscriptionDuration.year),
                );
              },
            ),
            const SizedBox(height: 32),
            ValueListenableBuilder<SubscriptionDuration?>(
              valueListenable: viewModel.selectedDuration,
              builder: (context, selectedDuration, child) {
                return ValueListenableBuilder<bool>(
                  valueListenable: viewModel.isLoading,
                  builder: (context, isLoading, child) {
                    return PrimaryButton(
                      text: 'Продолжить',
                      onPressed: selectedDuration != null
                          ? () => viewModel.purchaseSubscription(
                              onSuccess: () {
                                GoRouter.of(context).go('/');
                              },
                              onError: (errorMessage) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              },
                            )
                          : null,
                      isLoading: isLoading,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
