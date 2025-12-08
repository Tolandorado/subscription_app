import 'package:flutter/material.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/ui/screens/paywall.dart';
import 'package:paywall_app/viewmodels/paywall_viewmodel.dart';

class OnboardingViewModel {
  final SubscriptionRepository _subscriptionRepository;

  OnboardingViewModel(this._subscriptionRepository);

  void navigateToPaywall(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            PaywallScreen(viewModel: PaywallViewModel(_subscriptionRepository)),
      ),
    );
  }
}
