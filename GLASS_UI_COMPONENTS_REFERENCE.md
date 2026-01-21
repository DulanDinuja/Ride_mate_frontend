# 🎨 Glass UI Component Reference Guide

## Core Glass Components

### 1. GlassContainer
**Purpose**: Base container with glassmorphism effect

**Visual Appearance**:
- Semi-transparent background
- Backdrop blur (frosted glass effect)
- Subtle gradient border (cyan)
- Soft shadow/glow

**Parameters**:
```dart
GlassContainer(
  child: Widget,              // Required: Your content
  width: double?,             // Optional: Container width
  height: double?,            // Optional: Container height
  padding: EdgeInsets?,       // Optional: Internal padding
  margin: EdgeInsets?,        // Optional: External margin
  borderRadius: BorderRadius?, // Optional: Corner radius
  blur: double,               // Default: 10.0 (sigma for blur)
  opacity: double,            // Default: 0.1 (0.0-1.0)
  color: Color?,              // Optional: Base color
  border: Border?,            // Optional: Custom border
  gradientColors: List<Color>?, // Optional: Custom gradient
  enableBorder: bool,         // Default: true
  shadow: BoxShadow?,         // Optional: Custom shadow
)
```

**Best Use Cases**:
- Form containers
- Card backgrounds
- Information panels
- Settings sections

---

### 2. LiquidGlassCard
**Purpose**: Interactive glass card with press animation

**Visual Appearance**:
- All GlassContainer features
- Scales to 0.95 on press
- Animated shadow intensity
- Smooth transitions

**Parameters**:
```dart
LiquidGlassCard(
  child: Widget,              // Required: Your content
  width: double?,             // Optional: Card width
  height: double?,            // Optional: Card height
  padding: EdgeInsets?,       // Optional: Internal padding
  margin: EdgeInsets?,        // Optional: External margin
  onTap: VoidCallback?,       // Optional: Tap handler
  gradientColors: List<Color>?, // Optional: Custom gradient
  animationDuration: Duration, // Default: 300ms
)
```

**Best Use Cases**:
- List items
- Action cards
- Menu options
- Clickable panels

---

### 3. GlassAppBar
**Purpose**: Transparent app bar with blur

**Visual Appearance**:
- Frosted glass background
- Gradient overlay
- Bottom border with glow
- Icons with colored backgrounds

**Parameters**:
```dart
GlassAppBar(
  title: String,              // Required: App bar title
  actions: List<Widget>?,     // Optional: Right-side actions
  leading: Widget?,           // Optional: Left-side widget
  centerTitle: bool,          // Default: true
  elevation: double,          // Default: 0
)
```

**Best Use Cases**:
- All screen headers
- Navigation bars
- Top action bars

---

### 4. GlassButton
**Purpose**: Animated button with liquid effect

**Visual Appearance**:
- Glass container base
- Gradient background
- Glow effect on press
- Scale animation
- Loading indicator support

**Parameters**:
```dart
GlassButton(
  text: String,               // Required: Button text
  onPressed: VoidCallback,    // Required: Tap handler
  icon: IconData?,            // Optional: Leading icon
  width: double?,             // Optional: Button width
  height: double?,            // Default: 56
  gradientColors: List<Color>?, // Optional: Custom gradient
  isLoading: bool,            // Default: false
)
```

**Best Use Cases**:
- Primary actions (Login, Submit)
- Secondary actions (Cancel, Back)
- Call-to-action buttons
- Form submissions

---

### 5. GlassTextField
**Purpose**: Input field with animated glow

**Visual Appearance**:
- Glass container base
- Animated border on focus
- Glowing shadow when active
- Smooth transitions

**Parameters**:
```dart
GlassTextField(
  controller: TextEditingController, // Required: Text controller
  hintText: String,           // Required: Placeholder text
  labelText: String?,         // Optional: Floating label
  prefixIcon: IconData?,      // Optional: Left icon
  suffixIcon: IconData?,      // Optional: Right icon
  onSuffixIconTap: VoidCallback?, // Optional: Icon tap handler
  obscureText: bool,          // Default: false
  keyboardType: TextInputType?, // Optional: Keyboard type
  validator: Function?,       // Optional: Validation function
)
```

**Best Use Cases**:
- Login/register forms
- Search fields
- Input fields
- Text areas

---

## Background Components

### 6. LiquidBackground
**Purpose**: Animated background with floating bubbles

**Visual Appearance**:
- Gradient background
- Animated circular bubbles
- Smooth floating motion
- Organic movement patterns

**Parameters**:
```dart
LiquidBackground(
  child: Widget,              // Required: Screen content
  colors: List<Color>?,       // Optional: Gradient colors
  bubbleCount: int,           // Default: 6
)
```

**Best Use Cases**:
- Full-screen backgrounds
- Login/register screens
- Dashboard backgrounds
- Profile screens

---

### 7. FloatingParticles
**Purpose**: Lightweight particles floating upward

**Visual Appearance**:
- Small glowing dots
- Upward motion
- Varied sizes (2-6px)
- Subtle glow effect

**Parameters**:
```dart
FloatingParticles(
  particleCount: int,         // Default: 20
  particleColor: Color,       // Default: AppColors.cyan
)
```

**Best Use Cases**:
- Overlay on backgrounds
- Splash screens
- Loading screens
- Decorative accents

---

### 8. GlassShimmer
**Purpose**: Shimmer animation for glass elements

**Visual Appearance**:
- Animated light sweep
- Gradient highlight
- Smooth motion
- Subtle effect

**Parameters**:
```dart
GlassShimmer(
  child: Widget,              // Required: Widget to shimmer
  duration: Duration,         // Default: 1500ms
  baseColor: Color,           // Default: AppColors.surface
  highlightColor: Color,      // Default: AppColors.cyan
)
```

**Best Use Cases**:
- Logo animations
- Loading states
- Highlight effects
- Attention grabbers

---

## Color Guidelines

### Glass Opacity Values
- **Light Glass**: 0.05 - 0.1 (very transparent)
- **Standard Glass**: 0.1 - 0.2 (recommended)
- **Heavy Glass**: 0.2 - 0.3 (more opaque)

### Blur Values
- **Subtle Blur**: 5-8 sigma
- **Standard Blur**: 10-15 sigma (recommended)
- **Heavy Blur**: 15-20 sigma

### Border Opacity
- **Subtle Border**: 0.2-0.3
- **Standard Border**: 0.3-0.5 (recommended)
- **Prominent Border**: 0.5-0.7

### Shadow/Glow
- **Subtle Glow**: opacity 0.1, blur 10-15
- **Standard Glow**: opacity 0.2-0.3, blur 15-25
- **Strong Glow**: opacity 0.4-0.6, blur 25-40

---

## Animation Timing Guide

### User Interactions
- **Button Press**: 200-300ms
- **Card Tap**: 250-350ms
- **Focus Effects**: 300-400ms
- **Scale Animations**: 200-300ms

### Ambient Animations
- **Particle Float**: 2000-5000ms
- **Bubble Motion**: 3000-7000ms
- **Shimmer Sweep**: 1500-2500ms
- **Pulse Effects**: 1000-2000ms

### Transitions
- **Screen Changes**: 400-600ms
- **Modal Appear**: 300-400ms
- **Fade In/Out**: 300-500ms

---

## Layout Patterns

### Form Layout Pattern
```dart
GlassContainer(
  padding: EdgeInsets.all(24),
  blur: 15,
  opacity: 0.15,
  child: Column(
    children: [
      GlassTextField(...),
      SizedBox(height: 16),
      GlassTextField(...),
      SizedBox(height: 24),
      GlassButton(...),
    ],
  ),
)
```

### Card List Pattern
```dart
ListView.builder(
  itemBuilder: (context, index) {
    return LiquidGlassCard(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      onTap: () => handleTap(),
      child: CardContent(),
    );
  },
)
```

### Screen Layout Pattern
```dart
Scaffold(
  extendBodyBehindAppBar: true,
  appBar: GlassAppBar(...),
  body: LiquidBackground(
    child: SafeArea(
      child: YourContent(),
    ),
  ),
)
```

---

## Dos and Don'ts

### ✅ Do:
- Use consistent blur values (10-15)
- Keep opacity low (0.1-0.2)
- Add subtle animations
- Use proper shadows/glows
- Layer glass effects
- Test on real devices

### ❌ Don't:
- Over-blur (>20 sigma)
- Use high opacity (>0.3)
- Animate too fast (<150ms)
- Stack too many blurs
- Use on every element
- Forget performance testing

---

## Performance Tips

1. **Limit Blur Usage**: Only blur visible elements
2. **Reduce Particles**: Lower count on slower devices
3. **Cache Gradients**: Reuse gradient definitions
4. **Dispose Controllers**: Always dispose animation controllers
5. **Use ClipRRect**: Limit blur to specific areas
6. **Optimize Rebuilds**: Use const constructors where possible

---

## Accessibility Considerations

1. **Contrast**: Ensure text is readable on glass
2. **Focus Indicators**: Make focus states obvious
3. **Touch Targets**: Minimum 44x44 points
4. **Animations**: Respect reduced motion preferences
5. **Screen Readers**: Proper semantic labels

---

**Created**: January 21, 2026
**Last Updated**: January 21, 2026
**Version**: 1.0.0
