import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/themes/app_theme.dart';
import 'presentation/auth/providers/auth_provider.dart';
import 'presentation/auth/providers/kyc_provider.dart';
import 'presentation/rides/providers/ride_provider.dart';
import 'presentation/auth/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RideMateApp());
}

class RideMateApp extends StatelessWidget {
  const RideMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => KycProvider()),
        ChangeNotifierProvider(create: (_) => RideProvider()),
      ],
      child: MaterialApp(
        title: 'RideMate',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
