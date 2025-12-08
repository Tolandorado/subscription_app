import 'package:shared_preferences/shared_preferences.dart';

// Модель данных для информации о подписке
import 'package:paywall_app/models/subscription_info_base.dart';

class SubscriptionInfo implements SubscriptionInfoBase {
  @override
  final bool isActive;
  @override
  final DateTime? endDate;

  SubscriptionInfo({required this.isActive, this.endDate});

  factory SubscriptionInfo.fromPrefs(bool isActive, String? endDateString) {
    DateTime? parsedEndDate;
    if (endDateString != null) {
      try {
        parsedEndDate = DateTime.parse(endDateString);
      } catch (e) {
        print('Error parsing end date: $e');
      }
    }
    return SubscriptionInfo(isActive: isActive, endDate: parsedEndDate);
  }
}

class LocalStorageRepository {
  final SharedPreferences _prefs;

  LocalStorageRepository(this._prefs);

  static const String _isActiveKey = 'is_subscription_active';
  static const String _endDateKey = 'subscription_end_date';

  Future<SubscriptionInfo> getSubscriptionInfo() async {
    final isActive = _prefs.getBool(_isActiveKey) ?? false;
    final endDateString = _prefs.getString(_endDateKey);
    return SubscriptionInfo.fromPrefs(isActive, endDateString);
  }

  Future<void> setSubscriptionInfo(SubscriptionInfo info) async {
    await _prefs.setBool(_isActiveKey, info.isActive);
    if (info.endDate != null) {
      await _prefs.setString(_endDateKey, info.endDate!.toIso8601String());
    } else {
      await _prefs.remove(_endDateKey);
    }
  }
}
