import 'package:flutter/material.dart';

class OnboardingViewModel {

  void navigateToPaywall({required VoidCallback onNavigationRequested}) {
    onNavigationRequested();
  }
}
