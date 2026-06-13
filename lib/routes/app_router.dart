import 'package:go_router/go_router.dart';

import '../features/challenge/screens/camera_screen.dart';
import '../features/challenge/screens/home_screen.dart';
import '../features/challenge/screens/reward_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/camera', builder: (context, state) => const CameraScreen()),
    GoRoute(path: '/reward', builder: (context, state) => const RewardScreen()),
  ],
);
