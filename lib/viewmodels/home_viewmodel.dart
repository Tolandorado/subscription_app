import 'package:flutter/foundation.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/data/models/subscription_info_base.dart';

class HomeViewModel {
  final SubscriptionRepository _subscriptionRepository;

  ValueListenable<SubscriptionInfoBase> get subscriptionInfo =>
      _subscriptionRepository.subscriptionInfo;

  HomeViewModel(this._subscriptionRepository);

  Future<void> resetSubscription({required VoidCallback onNavigationRequested}) async {
    await _subscriptionRepository.resetSubscription();
    onNavigationRequested();
  }
}
