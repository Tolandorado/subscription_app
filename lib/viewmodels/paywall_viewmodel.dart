import 'package:flutter/foundation.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';

class PaywallViewModel {
  final SubscriptionRepository _subscriptionRepository;

  final ValueNotifier<SubscriptionDuration?> _selectedDuration = ValueNotifier(
    null,
  );
  ValueListenable<SubscriptionDuration?> get selectedDuration =>
      _selectedDuration;

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueListenable<bool> get isLoading => _isLoading;

  PaywallViewModel(this._subscriptionRepository);

  void selectSubscription(SubscriptionDuration duration) {
    _selectedDuration.value = duration;
  }

  Future<void> purchaseSubscription({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    if (_selectedDuration.value == null) return;

    _isLoading.value = true;
    try {
      await _subscriptionRepository.purchaseSubscription(
        _selectedDuration.value!,
      );
      onSuccess();
    } catch (e) {
      onError('Ошибка при покупке: $e');
    } finally {
      _isLoading.value = false;
    }
  }
}
