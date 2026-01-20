class KycValidator {
  static bool isValidNicNumber(String nic) {
    if (nic.isEmpty) return false;
    
    // Remove spaces and convert to uppercase
    nic = nic.replaceAll(' ', '').toUpperCase();
    
    // Old NIC format (9 digits + V)
    if (nic.length == 10 && nic.endsWith('V')) {
      final digits = nic.substring(0, 9);
      return RegExp(r'^\d{9}$').hasMatch(digits);
    }
    
    // New NIC format (12 digits)
    if (nic.length == 12) {
      return RegExp(r'^\d{12}$').hasMatch(nic);
    }
    
    return false;
  }
  
  static String? validateNicNumber(String? nic) {
    if (nic == null || nic.isEmpty) {
      return 'NIC number is required';
    }
    
    if (!isValidNicNumber(nic)) {
      return 'Please enter a valid NIC number';
    }
    
    return null;
  }
  
  static String formatNicNumber(String nic) {
    nic = nic.replaceAll(' ', '').toUpperCase();
    
    if (nic.length == 10) {
      // Format: 123456789V
      return '${nic.substring(0, 9)}${nic.substring(9)}';
    } else if (nic.length == 12) {
      // Format: 123456789012
      return nic;
    }
    
    return nic;
  }
  
  static bool isImageSizeValid(int fileSizeInBytes) {
    // Max 5MB
    const maxSizeInBytes = 5 * 1024 * 1024;
    return fileSizeInBytes <= maxSizeInBytes;
  }
  
  static List<String> getSupportedImageFormats() {
    return ['jpg', 'jpeg', 'png'];
  }
  
  static bool isImageFormatSupported(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return getSupportedImageFormats().contains(extension);
  }
}