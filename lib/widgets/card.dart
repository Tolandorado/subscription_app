import 'package:flutter/material.dart';
import 'package:paywall_app/services/subscription_service.dart';

class CardWidget extends StatelessWidget {
  final SubscriptionService subscriptionService;
  final SubscriptionDuration duration;
  final String title;
  final String price;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;

  const CardWidget({
    super.key,
    required this.subscriptionService,
    required this.duration,
    required this.title,
    required this.price,
    required this.isSelected,
    this.onTap,
    this.padding,
    this.color,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : color ?? Theme.of(context).cardColor,
        elevation: elevation ?? 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
          side: isSelected
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : BorderSide.none,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(price, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
