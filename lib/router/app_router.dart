import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:paywall_app/data/repositories/subscription_repository.dart';
import 'package:paywall_app/ui/screens/home_screen.dart';
import 'package:paywall_app/ui/screens/onboarding.dart';
import 'package:paywall_app/ui/screens/paywall.dart';
import 'package:paywall_app/viewmodels/home_viewmodel.dart';
import 'package:paywall_app/viewmodels/onboarding_viewmodel.dart';
import 'package:paywall_app/viewmodels/paywall_viewmodel.dart';

GoRouter buildRouter(SubscriptionRepository subscriptionRepository) {
  return GoRouter(
    refreshListenable: subscriptionRepository.subscriptionInfo,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        redirect: (BuildContext context, GoRouterState state) {
          if (subscriptionRepository.isCurrentlyActive) {
            return '/home';
          } else {
            return '/onboarding';
          }
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen(viewModel: HomeViewModel(subscriptionRepository));
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
            viewModel: PaywallViewModel(subscriptionRepository),
          );
        },
      ),
    ],
  );
}
