import 'package:flutter/material.dart';
import 'package:paywall_app/services/subscription_service.dart';
import 'package:paywall_app/widgets/primary_button.dart';
import 'package:paywall_app/widgets/card.dart';

class PaywallScreen extends StatefulWidget {
  final SubscriptionService subscriptionService;

  const PaywallScreen({super.key, required this.subscriptionService});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  SubscriptionDuration? _selectedDuration;
  bool _isLoading = false;

  void _selectSubscription(SubscriptionDuration duration) {
    setState(() {
      _selectedDuration = duration;
    });
  }

  Future<void> _purchaseSubscription() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.subscriptionService.purchaseSubscription(_selectedDuration!);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка при покупке: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
            CardWidget(
              subscriptionService: widget.subscriptionService,
              duration: SubscriptionDuration.month,
              title: 'Месячная подписка',
              price: 'Всего \$9.99 в месяц',
              isSelected: _selectedDuration == SubscriptionDuration.month,
              onTap: () => _selectSubscription(SubscriptionDuration.month),
            ),
            const SizedBox(height: 16),
            CardWidget(
              subscriptionService: widget.subscriptionService,
              duration: SubscriptionDuration.year,
              title: 'Годовая подписка',
              price: 'Всего \$99.99 в год (экономия 20%)',
              isSelected: _selectedDuration == SubscriptionDuration.year,
              onTap: () => _selectSubscription(SubscriptionDuration.year),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Продолжить',
              onPressed: _selectedDuration != null
                  ? _purchaseSubscription
                  : null,
              isLoading: _isLoading,
            )
          ],
        ),
      ),
    );
  }
}
