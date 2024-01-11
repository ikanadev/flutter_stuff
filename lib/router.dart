import 'package:go_router/go_router.dart';

import 'package:flutter_stuff/samples/samples.dart';
import 'home.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/canvas/chart',
      builder: (context, state) => const Chart(),
    ),
  ],
);
