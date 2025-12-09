import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel {

  void navigateToPaywall(BuildContext context) {
    context.go('/paywall');
  }
}
