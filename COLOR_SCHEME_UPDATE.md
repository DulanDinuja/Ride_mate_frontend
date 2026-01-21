# RideMate Color Scheme Update

## Overview
The RideMate app has been updated with a modern dark theme featuring navy blue backgrounds with cyan and coral accents.

## Color Palette

### Primary Colors (Dark Navy Blue)
- **Primary**: `#1A1A2E` - Default dark navy blue
- **Primary Light**: `#16213E` - Lighter navy
- **Primary Dark**: `#0F0F1E` - Darker navy

### Secondary Colors (Deep Blue)
- **Secondary**: `#0F3460` - Default deep blue
- **Secondary Light**: `#16527A` - Lighter blue
- **Secondary Dark**: `#0A2342` - Darker blue

### Accent Colors (Coral Red/Pink)
- **Accent**: `#E94560` - Default coral red/pink
- **Accent Light**: `#FF6B88` - Lighter pink
- **Accent Dark**: `#C72E4A` - Darker red

### Highlight Colors
- **Cyan**: `#00F7FF` - Cyan/aqua for highlights, borders, and accent elements
- **Cyan Bright**: `#00D4FF` - Bright cyan for hover states
- **Blue Violet**: `#8A2BE2` - Blue violet/purple for gradients
- **Purple**: `#7019CC` - Purple for gradient hover effects

### Background & Surface
- **Background**: `#0A0A0F` - Very dark background (main app background)
- **Surface**: `#1A1A2E` - Surface color for cards and containers
- **Surface Light**: `#16213E` - Light surface variant

### Text Colors
- **Text Primary**: `#FFFFFF` - White (main text)
- **Text Secondary**: `#B0B0B0` - Light gray (secondary text)
- **Text Tertiary**: `#808080` - Medium gray (hints, placeholders)

### Status Colors
- **Success**: `#4CAF50` - Green
- **Warning**: `#FF9800` - Orange
- **Error**: `#E94560` - Using accent color
- **Info**: `#00F7FF` - Using cyan

## Implementation

### Files Updated

#### Core Files
1. **`lib/core/constants/app_colors.dart`** (NEW)
   - Centralized color constants
   - Gradient definitions
   - Utility methods for opacity variants

2. **`lib/core/themes/app_theme.dart`**
   - Complete dark theme implementation
   - Material 3 design
   - All widget themes configured

3. **`lib/main.dart`**
   - Updated to use `darkTheme`
   - Theme mode set to dark

#### Screen Files Updated
1. **Splash Screen** - Gradient with cyan glow effect
2. **Login Screen** - Dark navy gradient with coral accents
3. **Register Screen** - Matching dark theme
4. **Main Dashboard** - Uses theme colors
5. **Home Screen** - Action cards with accent colors

### Usage in Code

#### Import the colors:
```dart
import 'package:ridemate/core/constants/app_colors.dart';
```

#### Use predefined colors:
```dart
// Backgrounds
color: AppColors.background,
color: AppColors.surface,

// Text
style: TextStyle(color: AppColors.textPrimary),

// Accents
color: AppColors.accent,
color: AppColors.cyan,

// With opacity
color: AppColors.cyanWithOpacity(0.5),
```

#### Use gradients:
```dart
// Primary gradient (navy to blue)
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: AppColors.primaryGradient,
  ),
),

// Accent gradient (coral to pink)
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: AppColors.accentGradient,
  ),
),

// Vibrant gradient (violet to cyan)
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: AppColors.vibrantGradient,
  ),
),
```

### Theme Integration

The app now uses Material 3 with a comprehensive dark theme. Most widgets will automatically use the correct colors from the theme:

- **Buttons**: Accent color with proper elevation
- **Input Fields**: Dark surface with cyan focus border
- **Cards**: Dark surface with secondary border
- **App Bar**: Primary color with cyan icons
- **Bottom Nav**: Primary background with cyan selection
- **Dialogs**: Dark surface with borders
- **Progress Indicators**: Cyan color

### Migration Guide

#### Old Code:
```dart
// Don't use these anymore
Color(0xFF2196F3)
Colors.blue
Colors.white
```

#### New Code:
```dart
// Use these instead
AppColors.cyan
AppColors.accent
AppColors.textPrimary

// Or rely on theme
Theme.of(context).colorScheme.primary
Theme.of(context).textTheme.bodyLarge
```

## Design Features

### Visual Effects
1. **Glowing Accents**: Cyan elements have subtle glow effects
2. **Gradient Backgrounds**: Multi-color gradients for depth
3. **Bordered Cards**: Subtle borders on dark surfaces
4. **Smooth Shadows**: Shadow colors match the theme
5. **Shader Masks**: Text with gradient effects for highlights

### Accessibility
- High contrast between text and backgrounds
- Multiple shades for hierarchy
- Clear focus indicators (cyan borders)
- Status colors follow conventions (red=error, green=success)

## Next Steps

### Remaining Screens to Update
The following screens still need color updates:
- KYC Verification Screen
- Offer Ride Screen
- Find Ride Screen
- My Rides Screen
- Profile Screen
- Ride Discovery Screen
- Ride Details Screen
- Active Ride Screen
- Cost Sharing Screen

### Testing Checklist
- [ ] Test all screens in dark mode
- [ ] Verify text readability
- [ ] Check button states (normal, pressed, disabled)
- [ ] Validate input field focus states
- [ ] Test error messages visibility
- [ ] Verify status indicators
- [ ] Check navigation bar appearance
- [ ] Test dialogs and overlays

## Notes

- The old `lightTheme` has been deprecated but still exists for backward compatibility
- All hardcoded colors should be replaced with `AppColors` constants
- Theme automatically handles most widget colors
- Custom widgets may need explicit color updates
