import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/booking_service.dart';
import 'services/review_service.dart';
import 'services/game_service.dart';
import 'services/user_service.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for seamless edge-to-edge feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const AlvaranApp());
}

class AlvaranApp extends StatelessWidget {
  const AlvaranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingService()),
        ChangeNotifierProvider(create: (_) => ReviewService()),
        ChangeNotifierProvider(create: (_) => GameService()),
        ChangeNotifierProvider(create: (_) => UserService()),
      ],
      child: MaterialApp(
        title: 'ALVARAN - Board Game Cafe',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavigationShell(),
      ),
    );
  }
}
