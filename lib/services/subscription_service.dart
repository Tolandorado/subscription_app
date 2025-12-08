import 'package:flutter/foundation.dart';
import 'package:paywall_app/models/subscription_info_base.dart';
import 'package:paywall_app/storage/storage.dart';

enum SubscriptionDuration { month, year }

class SubscriptionService {
  final LocalStorageRepository _localStorageRepository;

  final ValueNotifier<SubscriptionInfoBase> _subscriptionInfoNotifier =
      ValueNotifier<SubscriptionInfo>(SubscriptionInfo(isActive: false));
  ValueListenable<SubscriptionInfoBase> get subscriptionInfo =>
      _subscriptionInfoNotifier;

  SubscriptionService(this._localStorageRepository);

  bool get isCurrentlyActive {
    final info = _subscriptionInfoNotifier.value;
    if (!info.isActive) return false;
    if (info.endDate == null) return false;
    return info.endDate!.isAfter(DateTime.now());
  }

  Future<void> loadSubscriptionStatus() async {
    final info = await _localStorageRepository.getSubscriptionInfo();
    _subscriptionInfoNotifier.value = info;
  }

  Future<void> purchaseSubscription(SubscriptionDuration duration) async {
    // Имитация асинхронного запроса к платежному шлюзу
    try {
      await Future.delayed(const Duration(seconds: 1));

      DateTime endDate;
      if (duration == SubscriptionDuration.month) {
        endDate = DateTime.now().add(const Duration(days: 30));
      } else {
        endDate = DateTime.now().add(const Duration(days: 365));
      }

      final newInfo = SubscriptionInfo(isActive: true, endDate: endDate);
      _subscriptionInfoNotifier.value = newInfo;
      await _localStorageRepository.setSubscriptionInfo(newInfo);
    } catch (e) {
      throw Exception(
        'Ошибка покупки: Не удалось подтвердить платеж. Попробуйте позже.',
      );
    }
  }

  Future<void> resetSubscription() async {
    final newInfo = SubscriptionInfo(isActive: false, endDate: null);
    _subscriptionInfoNotifier.value = newInfo;
    await _localStorageRepository.setSubscriptionInfo(newInfo);
  }
}
