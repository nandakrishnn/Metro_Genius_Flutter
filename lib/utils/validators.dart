class Validators {
  static String? validateYearsOfExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your years of experience';
    }

    final numericValue = int.tryParse(value);

    if (numericValue == null) {
      return 'Please enter a valid number';
    }
    if (numericValue < 0 || numericValue > 20) {
      return 'Please enter a value between 0 and 20';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    String pattern = r'^\d{10}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter the email';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    return null;
  }
}
