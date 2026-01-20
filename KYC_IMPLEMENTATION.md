# KYC Implementation - RideMate

## Overview
Complete KYC (Know Your Customer) verification system for RideMate car pooling app with document upload, status tracking, and validation.

## Features Implemented

### 1. KYC Data Model (`lib/data/models/kyc_model.dart`)
- User ID linking
- NIC number storage
- Document URLs (NIC front, back, selfie)
- Status tracking (pending, approved, rejected, under review)
- Submission timestamp
- Rejection reason handling

### 2. KYC Repository (`lib/data/repositories/kyc_repository.dart`)
- Image upload API integration
- KYC submission to backend
- Status retrieval functionality
- Error handling for API calls

### 3. KYC Provider (`lib/presentation/auth/providers/kyc_provider.dart`)
- State management for KYC process
- Image file handling
- Form validation
- Loading states and error handling
- Status updates

### 4. KYC Verification Screen (`lib/presentation/auth/screens/kyc_verification_screen.dart`)
- NIC number input with validation
- Image capture/upload for:
  - NIC front side
  - NIC back side
  - Live selfie
- Real-time validation feedback
- Progress indicators
- Skip option with confirmation

### 5. KYC Status Screen (`lib/presentation/auth/screens/kyc_status_screen.dart`)
- Current verification status display
- Submission details
- Rejection reason display
- Resubmission option for rejected KYC
- Status-based UI indicators

### 6. Profile Integration (`lib/presentation/profile/screens/profile_screen.dart`)
- KYC status in user profile
- Color-coded status indicators
- Navigation to KYC status screen
- Real-time status updates

### 7. Validation Utilities (`lib/core/utils/kyc_validator.dart`)
- Sri Lankan NIC validation (old and new formats)
- Image format validation
- File size validation
- Input formatting

## KYC Process Flow

1. **Registration** → User can skip KYC initially
2. **KYC Submission** → Upload documents and submit
3. **Review Process** → Backend verification
4. **Status Updates** → User receives status updates
5. **Resubmission** → If rejected, user can resubmit

## Status Types

- **Pending**: Submitted, waiting for review
- **Under Review**: Currently being processed
- **Approved**: Verification successful
- **Rejected**: Verification failed, resubmission required

## Validation Rules

### NIC Number
- Old format: 9 digits + 'V' (e.g., 123456789V)
- New format: 12 digits (e.g., 123456789012)
- Automatic formatting and validation

### Images
- Supported formats: JPG, JPEG, PNG
- Maximum size: 5MB per image
- Required: NIC front, NIC back, live selfie

## Integration Points

### Backend API Endpoints Required
```
POST /kyc/upload - Image upload
POST /kyc/submit - KYC submission
GET /kyc/status/:userId - Status retrieval
```

### Provider Setup
KYC provider is registered in `main.dart` and available app-wide.

## Usage

### Navigate to KYC
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const KycVerificationScreen()),
);
```

### Check KYC Status
```dart
final kycProvider = Provider.of<KycProvider>(context);
await kycProvider.loadKycStatus(userId);
```

### Submit KYC
```dart
final success = await kycProvider.submitKyc(userId);
```

## Security Features

- Image compression and optimization
- File type validation
- Size restrictions
- Secure API communication
- Token-based authentication

## Future Enhancements

- OCR for automatic NIC data extraction
- Face matching between selfie and NIC
- Document authenticity verification
- Push notifications for status updates
- Admin panel for manual review