import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/themes/app_theme.dart';
import 'presentation/auth/providers/auth_provider.dart';
import 'presentation/auth/providers/kyc_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/ride_provider.dart';
import 'presentation/auth/screens/splash_screen.dart';
import 'presentation/dashboard/screens/main_dashboard.dart';
import 'presentation/auth/screens/login_screen.dart';
import 'presentation/auth/screens/register_screen.dart';
import 'presentation/auth/screens/kyc_verification_screen.dart';
import 'presentation/rides/screens/create_ride_screen.dart';
import 'presentation/rides/screens/ride_discovery_screen.dart';
import 'presentation/rides/screens/offer_ride_screen.dart';
import 'presentation/rides/screens/find_ride_screen.dart';
import 'presentation/rides/screens/my_rides_screen.dart';
import 'presentation/profile/screens/profile_screen.dart';

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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RideProvider()),
      ],
      child: MaterialApp(
        title: 'RideMate - Professional Ride Sharing',
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/kyc': (context) => const KycVerificationScreen(),
          '/dashboard': (context) => const MainDashboard(),
          '/create-ride': (context) => const CreateRideScreen(),
          '/discover-rides': (context) => const RideDiscoveryScreen(),
          '/offer-ride': (context) => const OfferRideScreen(),
          '/find-ride': (context) => const FindRideScreen(),
          '/my-rides': (context) => const MyRidesScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
