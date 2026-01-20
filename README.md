# RideMate - Car Pooling System

Sustainable commuting solution for Sri Lanka with cost-sharing, real-time tracking, and KYC verification.

## Features Implemented (Phase 1 MVP)

### Authentication & KYC
- User registration with role selection (Driver/Passenger)
- Phone number and email login
- KYC verification with NIC upload and selfie capture
- Secure token-based authentication

### Core Screens
- Splash & Onboarding
- Login & Registration
- KYC Verification
- Main Dashboard with bottom navigation
- Home screen with quick actions
- Find Rides with filters (gender, price range)
- My Rides (Active, Upcoming, History)
- Profile management

### Technical Stack
- Flutter 3.0+
- Provider for state management
- Dio for HTTP requests
- Shared Preferences for local storage
- Google Maps integration ready
- Firebase ready for push notifications
- PayHere SDK for payments

## Setup Instructions

1. Install Flutter SDK (3.0 or higher)
2. Clone the repository
3. Run `flutter pub get`
4. Configure backend API URL in `lib/core/constants/app_constants.dart`
5. Add Google Maps API key in Android/iOS configuration
6. Run `flutter run`

## Project Structure

```
lib/
├── core/
│   ├── constants/     # App-wide constants
│   └── themes/        # Theme configuration
├── data/
│   ├── models/        # Data models
│   └── repositories/  # API repositories
└── presentation/
    ├── auth/          # Authentication screens
    ├── dashboard/     # Main dashboard
    ├── rides/         # Ride management
    └── profile/       # User profile
```

## Next Steps (Phase 2)

- Implement ride creation flow
- Add Google Maps integration
- Real-time ride tracking
- Payment integration with PayHere
- Push notifications
- Rating & review system
- Admin panel

## Configuration Required

1. Backend API endpoint
2. Google Maps API key
3. Firebase configuration
4. PayHere merchant credentials
