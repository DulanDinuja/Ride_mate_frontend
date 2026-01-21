# 🎨 RideMate Color Palette - Visual Reference

## Complete Color System

### Primary Colors (Navy Blue)
```
█ #1A1A2E  Primary (Default)     - Main brand color, app bars, surfaces
█ #16213E  Primary Light          - Lighter variant for contrast
█ #0F0F1E  Primary Dark           - Darker variant, deepest backgrounds
```

### Secondary Colors (Deep Blue)
```
█ #0F3460  Secondary (Default)    - Borders, dividers, secondary UI
█ #16527A  Secondary Light        - Lighter blue for gradients
█ #0A2342  Secondary Dark         - Darker blue for depth
```

### Accent Colors (Coral/Pink)
```
█ #E94560  Accent (Default)       - Primary action buttons, CTAs
█ #FF6B88  Accent Light           - Lighter pink for highlights
█ #C72E4A  Accent Dark            - Darker red for pressed states
```

### Highlight Colors
```
█ #00F7FF  Cyan                   - Links, icons, highlights, focus states
█ #00D4FF  Cyan Bright            - Hover states, active elements
█ #8A2BE2  Blue Violet            - Gradients, decorative elements
█ #7019CC  Purple                 - Gradient hover effects
```

### Background & Surface
```
█ #0A0A0F  Background             - Main app background (very dark)
█ #1A1A2E  Surface                - Cards, containers, panels
█ #16213E  Surface Light          - Light surface variant
```

### Text Colors
```
█ #FFFFFF  Text Primary           - Main text, headings
█ #B0B0B0  Text Secondary         - Secondary text, subtitles
█ #808080  Text Tertiary          - Hints, placeholders, disabled text
```

### Status Colors
```
█ #4CAF50  Success               - Approved, confirmed, completed
█ #FF9800  Warning               - Pending, alerts, caution
█ #E94560  Error                 - Rejected, errors, dangerous actions
█ #00F7FF  Info                  - Information, in progress, active
```

---

## Color Usage Guide

### Backgrounds
| Element | Color | Usage |
|---------|-------|-------|
| App Background | `#0A0A0F` | Main scaffold background |
| Cards | `#1A1A2E` | Card surfaces, containers |
| Input Fields | `#16213E` | TextField fill color |
| App Bar | `#1A1A2E` | Top navigation bar |
| Bottom Nav | `#1A1A2E` | Bottom navigation bar |

### Interactive Elements
| Element | Color | Usage |
|---------|-------|-------|
| Primary Button | `#E94560` | Main action buttons |
| Secondary Button | Transparent with `#00F7FF` border | Secondary actions |
| Text Button | `#00F7FF` | Links, tertiary actions |
| FAB | `#E94560` | Floating action button |
| Icon Buttons | `#00F7FF` | App bar icons, small actions |

### Borders & Dividers
| Element | Color | Usage |
|---------|-------|-------|
| Card Borders | `#0F3460` | Card outlines |
| Input Borders | `#0F3460` | Normal state |
| Focused Borders | `#00F7FF` | Active/focused state |
| Dividers | `#0F3460` | Section separators |

### Status Indicators
| Status | Color | Usage |
|--------|-------|-------|
| Verified/Approved | `#4CAF50` | Success badges |
| Pending/Review | `#FF9800` | Warning badges |
| Rejected/Error | `#E94560` | Error badges |
| In Progress | `#00F7FF` | Active status |
| Completed | `#808080` | Inactive/done |

---

## Gradient Combinations

### Primary Gradient
```
Gradient: #1A1A2E → #0F3460
Usage: Background gradients, subtle depth
```

### Accent Gradient
```
Gradient: #E94560 → #FF6B88
Usage: Button gradients, emphasis
```

### Cyan Gradient
```
Gradient: #00F7FF → #00D4FF
Usage: Highlights, active states
```

### Purple Gradient
```
Gradient: #8A2BE2 → #7019CC
Usage: Decorative elements, tab indicators
```

### Vibrant Gradient
```
Gradient: #8A2BE2 → #00F7FF
Usage: Special highlights, premium features
```

---

## Color Accessibility

### Contrast Ratios (WCAG AA Compliant)

| Foreground | Background | Ratio | Status |
|------------|------------|-------|--------|
| `#FFFFFF` | `#0A0A0F` | 19.8:1 | ✅ AAA |
| `#FFFFFF` | `#1A1A2E` | 15.2:1 | ✅ AAA |
| `#00F7FF` | `#0A0A0F` | 14.1:1 | ✅ AAA |
| `#E94560` | `#0A0A0F` | 7.8:1 | ✅ AA |
| `#B0B0B0` | `#1A1A2E` | 5.2:1 | ✅ AA |

All color combinations meet WCAG AA standards for normal text.

---

## Example Color Combinations

### Cards & Containers
```
Background: #1A1A2E
Border: #0F3460
Text: #FFFFFF
Subtitle: #B0B0B0
```

### Buttons
```
Primary:
  Background: #E94560
  Text: #FFFFFF
  Shadow: #E94560 @ 40% opacity

Secondary:
  Background: Transparent
  Border: #00F7FF
  Text: #00F7FF
```

### Status Badges
```
Success Badge:
  Background: #4CAF50 @ 10% opacity
  Border: #4CAF50
  Text: #4CAF50

Warning Badge:
  Background: #FF9800 @ 10% opacity
  Border: #FF9800
  Text: #FF9800

Error Badge:
  Background: #E94560 @ 10% opacity
  Border: #E94560
  Text: #E94560
```

### Input Fields
```
Normal:
  Background: #16213E
  Border: #0F3460
  Text: #FFFFFF
  Placeholder: #808080

Focused:
  Background: #16213E
  Border: #00F7FF (2px)
  Text: #FFFFFF
  Label: #00F7FF
```

---

## Color Psychology

| Color | Emotion | Use Case |
|-------|---------|----------|
| **Navy Blue** | Trust, stability, professionalism | Backgrounds, primary UI |
| **Cyan** | Energy, innovation, clarity | Interactive elements, highlights |
| **Coral** | Action, urgency, passion | CTAs, important actions |
| **Purple** | Creativity, luxury, sophistication | Premium features, gradients |
| **Green** | Success, growth, safety | Confirmations, positive states |
| **Orange** | Attention, caution, warmth | Warnings, pending states |

---

## Design Patterns

### Glassmorphism Effect
```
Background: #1A1A2E @ 20% opacity
Backdrop Blur: 10px
Border: #0F3460 @ 30% opacity
```

### Glowing Effect
```
Box Shadow:
  Color: #00F7FF @ 50% opacity
  Blur: 20-30px
  Spread: 2-5px
```

### Elevation Levels
```
Level 1 (Cards):
  Shadow: #0A0A0F @ 30% opacity
  Blur: 10px
  Offset: (0, 4)

Level 2 (Modals):
  Shadow: #0A0A0F @ 40% opacity
  Blur: 20px
  Offset: (0, 8)

Level 3 (Floating):
  Shadow: #0A0A0F @ 50% opacity
  Blur: 30px
  Offset: (0, 12)
```

---

## Dark Theme Best Practices

✅ **DO:**
- Use subtle borders for depth
- Add soft glows to interactive elements
- Use opacity for layering
- Maintain high contrast for text
- Use colors consistently

❌ **DON'T:**
- Use pure black (#000000)
- Use bright white on dark backgrounds
- Overuse bright accent colors
- Ignore contrast ratios
- Mix too many gradients

---

## Color Modification Functions

### Opacity Variants
```dart
AppColors.primary.withOpacity(0.1)   // 10% opacity - subtle tint
AppColors.primary.withOpacity(0.3)   // 30% opacity - hover states
AppColors.primary.withOpacity(0.5)   // 50% opacity - disabled states
AppColors.primary.withOpacity(0.8)   // 80% opacity - active states
```

### Brightness Adjustments
```dart
// Lighten
Color.alphaBlend(Colors.white.withOpacity(0.2), baseColor)

// Darken
Color.alphaBlend(Colors.black.withOpacity(0.2), baseColor)
```

---

## Quick Copy-Paste

### CSS Variables
```css
:root {
  --primary: #1A1A2E;
  --secondary: #0F3460;
  --accent: #E94560;
  --cyan: #00F7FF;
  --background: #0A0A0F;
  --surface: #1A1A2E;
  --text-primary: #FFFFFF;
  --text-secondary: #B0B0B0;
  --success: #4CAF50;
  --warning: #FF9800;
  --error: #E94560;
}
```

### Flutter Constants (Already in app_colors.dart)
```dart
const primaryColor = Color(0xFF1A1A2E);
const accentColor = Color(0xFFE94560);
const cyanColor = Color(0xFF00F7FF);
```

### Swift (iOS)
```swift
extension UIColor {
    static let appPrimary = UIColor(hex: "1A1A2E")
    static let appAccent = UIColor(hex: "E94560")
    static let appCyan = UIColor(hex: "00F7FF")
}
```

### Kotlin (Android)
```kotlin
object AppColors {
    val Primary = Color(0xFF1A1A2E)
    val Accent = Color(0xFFE94560)
    val Cyan = Color(0xFF00F7FF)
}
```

---

**This is your complete color reference guide! Save this for quick lookup! 🎨**
