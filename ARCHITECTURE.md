# RideMate - Complete Architecture & Implementation Guide

## Overview
RideMate is a professional ride-sharing and cost-splitting platform built with Flutter, focusing on trust, planning, and community rather than on-demand transportation. The system uses a unified user role where all users can join rides, but only KYC-verified users with vehicles can start rides.

## Architecture Overview

### Clean Architecture Layers

#### 1. Data Layer (`lib/data/`)
- **Models**: Complete data structures for users, rides, vehicles, reviews, and KYC
- **Repositories**: API integration and data management
- **Services**: External service integrations (maps, payments, notifications)

#### 2. Presentation Layer (`lib/presentation/`)
- **Providers**: State management using Provider pattern
- **Screens**: UI components and user interfaces
- **Widgets**: Reusable UI components

#### 3. Core Layer (`lib/core/`)
- **Constants**: App-wide configuration and constants
- **Themes**: Material 3 design system implementation
- **Utils**: Utility functions and validators

## Key Features Implemented

### 1. Unified User System
- Single user role with optional ride starter capabilities
- KYC verification required only for starting rides
- Comprehensive user profiles with ratings and reviews
- Trust indicators and verification badges

### 2. Complete KYC Process
- NIC document upload and verification
- Live selfie capture for identity verification
- Driving license verification for ride starters
- Vehicle registration and verification
- Status tracking (not submitted, pending, approved, rejected)

### 3. Ride Management System
- **Ride Creation**: Location selection, scheduling, cost calculation
- **Ride Discovery**: Search, filters, nearby rides
- **Join Requests**: Message-based request system
- **Lifecycle Management**: Open → Full → Started → Completed
- **Cost Splitting**: Automatic cost distribution among participants

### 4. Trust & Safety Features
- Mandatory KYC for ride starters
- User ratings and review system
- Report and moderation system
- Transparent ride history
- Profile verification indicators

## Data Models

### UserModel
```dart
class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final String? profession;
  final String? bio;
  final bool canStartRides;
  final KycStatus kycStatus;
  final VehicleModel? vehicle;
  final DrivingLicenseModel? drivingLicense;
  final UserStats stats;
  final List<ReviewModel> reviews;
  // ... additional fields
}
```

### RideModel
```dart
class RideModel {
  final String id;
  final String starterId;
  final LocationModel origin;
  final LocationModel destination;
  final DateTime scheduledDateTime;
  final int totalSeats;
  final int availableSeats;
  final double totalCost;
  final double costPerSeat;
  final RideStatus status;
  final VehicleInfo vehicle;
  final List<RideParticipant> participants;
  final List<JoinRequest> joinRequests;
  final RidePreferences preferences;
  // ... additional fields
}
```

## User Flows

### 1. Registration & Onboarding
1. User registers with email/password
2. User selects if they want to start rides
3. If yes → KYC verification process
4. Vehicle and license information collection
5. Profile completion

### 2. Ride Creation Flow (Verified Users Only)
1. Select origin and destination
2. Set date, time, and available seats
3. Enter total trip cost (auto-calculates per-seat cost)
4. Set preferences (gender, smoking, pets, etc.)
5. Add optional notes
6. Create ride

### 3. Ride Discovery & Joining
1. Search rides by route and date
2. Apply filters (price, gender, seats)
3. View ride details and starter profile
4. Send join request with optional message
5. Wait for starter approval
6. Receive confirmation and ride details

### 4. Ride Lifecycle Management
1. **Open**: Accepting join requests
2. **Full**: All seats taken, no more requests
3. **Started**: Ride in progress
4. **Completed**: Trip finished, ratings exchanged
5. **Canceled**: Ride cancelled with reason

## State Management

### Provider Pattern Implementation
- **UserProvider**: Authentication, profile management, reviews
- **RideProvider**: Ride CRUD, search, join requests, lifecycle
- **KycProvider**: KYC document upload, status tracking
- **AuthProvider**: Login/logout, session management

### Key Provider Methods
```dart
// UserProvider
Future<bool> login(String email, String password)
Future<bool> register({...})
Future<bool> updateProfile(Map<String, dynamic> updates)
Future<bool> addVehicle(VehicleModel vehicle)

// RideProvider
Future<bool> createRide(RideModel ride)
Future<void> searchRides({...})
Future<bool> submitJoinRequest(String rideId, String userId, String message)
Future<bool> respondToJoinRequest(String requestId, bool accept, String? message)
```

## Screen Architecture

### 1. Authentication Screens
- **SplashScreen**: App initialization and routing
- **LoginScreen**: Email/password authentication
- **RegisterScreen**: User registration with ride starter option
- **KycVerificationScreen**: Document upload and verification

### 2. Main Application Screens
- **MainDashboard**: Bottom navigation with home, rides, profile
- **HomeScreen**: Quick actions, nearby rides, statistics
- **RideDiscoveryScreen**: Search, filters, ride listings
- **CreateRideScreen**: Ride creation form with preferences
- **RideDetailsScreen**: Complete ride information and actions
- **ProfileScreen**: User profile with KYC status and settings

### 3. Specialized Screens
- **KycStatusScreen**: Verification status and resubmission
- **MyRidesScreen**: User's started and joined rides
- **ReviewScreen**: Rating and review system
- **NotificationsScreen**: Ride updates and system notifications

## API Integration

### Repository Pattern
```dart
class UserRepository {
  Future<UserModel> login(String email, String password)
  Future<UserModel> register({...})
  Future<UserModel> updateProfile(String userId, Map<String, dynamic> updates)
  Future<VehicleModel> addVehicle(String userId, VehicleModel vehicle)
  Future<List<ReviewModel>> getUserReviews(String userId)
}

class RideRepository {
  Future<RideModel> createRide(RideModel ride)
  Future<List<RideModel>> searchRides({...})
  Future<JoinRequest> submitJoinRequest(String rideId, String userId, String message)
  Future<RideModel> startRide(String rideId)
  Future<RideModel> completeRide(String rideId, {...})
}
```

## Security & Trust Features

### 1. KYC Verification
- NIC document verification
- Live selfie matching
- Driving license validation
- Vehicle registration verification

### 2. User Trust System
- Rating system (1-5 stars)
- Written reviews
- Ride completion statistics
- Report and flag system
- Trust badges for verified users

### 3. Data Security
- Token-based authentication
- Encrypted data transmission
- Secure file upload
- Privacy controls

## Technical Specifications

### Flutter Implementation
- **Version**: Flutter 3.0+
- **State Management**: Provider pattern
- **HTTP Client**: Dio for API calls
- **Local Storage**: Shared Preferences
- **Image Handling**: Image Picker with compression
- **Maps Integration**: Google Maps (ready for integration)
- **Notifications**: Firebase Cloud Messaging (ready)

### Material 3 Design
- Modern UI components
- Consistent color scheme
- Responsive layouts
- Accessibility compliance
- Dark mode support (ready)

## Cost Splitting Algorithm

### Automatic Cost Calculation
```dart
double calculateCostPerSeat(double totalCost, int participants) {
  // Total participants = confirmed passengers + driver
  return totalCost / (participants + 1);
}

Map<String, double> distributeCosts(RideModel ride) {
  final costPerPerson = ride.actualCost ?? ride.totalCost / (ride.confirmedParticipants + 1);
  // Driver pays their share, passengers pay their share
  return {
    'driverShare': costPerPerson,
    'passengerShare': costPerPerson,
  };
}
```

## Real-time Features (Ready for Implementation)

### 1. Live Ride Tracking
- GPS location sharing during rides
- Estimated arrival times
- Route optimization

### 2. Push Notifications
- Join request notifications
- Ride status updates
- Payment reminders
- Safety alerts

### 3. In-app Messaging
- Ride-specific chat groups
- Direct messaging between users
- Automated status updates

## Deployment & Scaling

### Backend Requirements
- REST API with authentication
- File upload service for documents
- Real-time messaging service
- Push notification service
- Payment processing integration

### Database Schema
- Users table with KYC status
- Rides table with lifecycle tracking
- Join requests with status
- Reviews and ratings
- Vehicles and licenses

## Future Enhancements

### Phase 2 Features
- Real-time GPS tracking
- In-app payments with PayHere
- Advanced route optimization
- Ride scheduling automation
- Social features and groups

### Phase 3 Features
- AI-powered ride matching
- Dynamic pricing based on demand
- Corporate ride programs
- Environmental impact tracking
- Loyalty and rewards system

## Testing Strategy

### Unit Tests
- Model serialization/deserialization
- Business logic validation
- Utility function testing

### Integration Tests
- API repository testing
- Provider state management
- End-to-end user flows

### UI Tests
- Screen navigation
- Form validation
- User interaction flows

This comprehensive implementation provides a solid foundation for a professional ride-sharing platform with emphasis on trust, safety, and cost-sharing rather than profit generation.