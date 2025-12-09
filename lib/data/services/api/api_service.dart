abstract class BaseApi {
  Future<void> getSubscriptionStatus();
}

class MockApiService implements BaseApi {
  @override
  Future<void> getSubscriptionStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    // В реальном приложении здесь была бы логика получения статуса подписки
  }
}
