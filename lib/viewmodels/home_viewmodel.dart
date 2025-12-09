import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/data/models/subscription_info_base.dart';

class HomeViewModel {
  final SubscriptionRepository _subscriptionRepository;

  ValueListenable<SubscriptionInfoBase> get subscriptionInfo =>
      _subscriptionRepository.subscriptionInfo;

  HomeViewModel(this._subscriptionRepository);

  Future<void> resetSubscription(BuildContext context) async {
    await _subscriptionRepository.resetSubscription();
    context.go('/onboarding');
  }
}
