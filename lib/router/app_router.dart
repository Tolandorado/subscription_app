import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/ui/screens/home_screen.dart';
import 'package:paywall_app/ui/screens/onboarding.dart';
import 'package:paywall_app/ui/screens/paywall.dart';
import 'package:paywall_app/viewmodels/home_viewmodel.dart';
import 'package:paywall_app/viewmodels/onboarding_viewmodel.dart';
import 'package:paywall_app/viewmodels/paywall_viewmodel.dart';

// Временная заглушка для SubscriptionRepository, пока не настроим DI
// В реальном приложении здесь будет использоваться Service Locator (get_it) или Provider
// для получения экземпляра SubscriptionRepository
// ignore: prefer_typing_uninitialized_variables
late SubscriptionRepository globalSubscriptionRepository;

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) {
        if (globalSubscriptionRepository.isCurrentlyActive) {
          return '/home';
        } else {
          return '/onboarding';
        }
      },
      builder: (BuildContext context, GoRouterState state) {
        // Этот билдер будет заменен на логику перенаправления
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen(
          viewModel: HomeViewModel(globalSubscriptionRepository),
        );
      },
    ),
    GoRoute(
      path: '/onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen(viewModel: OnboardingViewModel());
      },
    ),
    GoRoute(
      path: '/paywall',
      builder: (BuildContext context, GoRouterState state) {
        return PaywallScreen(
          viewModel: PaywallViewModel(globalSubscriptionRepository),
        );
      },
    ),
  ],
);
