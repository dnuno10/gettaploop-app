/// Clase con validadores y constantes de límites para campos
class FieldValidators {
  FieldValidators._();

  // ─── Límites de caracteres ───────────────────────────────────────────────
  static const int nameMaxLength = 50;
  static const int jobTitleMaxLength = 50;
  static const int bioMaxLength = 100;
  
  // Contacto y Redes
  static const int contactPrimaryMaxLength = 200;    // valor (teléfono, email, etc)
  static const int contactSecondaryMaxLength = 100;  // etiqueta
  static const int socialUrlMaxLength = 200;
  static const int socialLabelMaxLength = 100;
  static const int calendarUrlMaxLength = 200;
  
  // Formularios dinámicos
  static const int dynamicFieldMaxLength = 200;

  // ─── Validadores de formato ──────────────────────────────────────────────

  /// Valida que sea un teléfono (solo dígitos, +, -, espacios)
  static ValidationResult validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return ValidationResult.valid();
    }
    
    final cleanedValue = value.replaceAll(RegExp(r'[^\d+\-\s]'), '');
    if (cleanedValue.isEmpty) {
      return ValidationResult.invalid('Invalid phone number. Only numbers, +, -, and spaces are allowed.');
    }
    
    // Debe tener al menos 7 dígitos
    final digitsOnly = cleanedValue.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length < 7) {
      return ValidationResult.invalid('The phone number must have at least 7 digits.');
    }
    
    return ValidationResult.valid();
  }

  /// Valida que sea un email válido
  static ValidationResult validateEmail(String value) {
    if (value.isEmpty) {
      return ValidationResult.valid();
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (!emailRegex.hasMatch(value)) {
      return ValidationResult.invalid('Enter a valid email.');
    }

    return ValidationResult.valid();
  }

  /// Valida que sea una URL válida (http/https)
  static ValidationResult validateUrl(String value) {
    if (value.isEmpty) {
      return ValidationResult.valid();
    }

    try {
      final uri = Uri.parse(value);
      
      // Debe tener esquema http o https
      if (uri.scheme != 'http' && uri.scheme != 'https') {
        return ValidationResult.invalid(
          'The URL must start with http:// or https://',
        );
      }

      // Debe tener host
      if (uri.host.isEmpty) {
        return ValidationResult.invalid('The URL must be valid.');
      }

      return ValidationResult.valid();
    } catch (_) {
      return ValidationResult.invalid('The URL is not valid.');
    }
  }

  /// Valida que solo contenga números (para campos numéricos)
  static ValidationResult validateNumericOnly(String value) {
    if (value.isEmpty) {
      return ValidationResult.valid();
    }

    if (!RegExp(r'^[0-9]+([.,][0-9]+)?$').hasMatch(value)) {
      return ValidationResult.invalid('Only numbers are allowed.');
    }

    return ValidationResult.valid();
  }

  /// Valida que sea texto (letras, números, espacios, puntuación básica)
  static ValidationResult validateTextOnly(String value) {
    if (value.isEmpty) {
      return ValidationResult.valid();
    }

    // Permite letras, números, espacios y puntuación común
    final allowedChars = RegExp(r'^[a-zA-Z0-9áéíóúñÁÉÍÓÚÑ\s.,;:!?()\-@]+$');
    if (!allowedChars.hasMatch(value)) {
      return ValidationResult.invalid(
        'Only letters, numbers, and basic punctuation are allowed.',
      );
    }

    return ValidationResult.valid();
  }

  // ─── Validadores de longitud ─────────────────────────────────────────────

  /// Valida longitud máxima
  static ValidationResult validateMaxLength(String value, int maxLength, String fieldName) {
    if (value.length > maxLength) {
      return ValidationResult.invalid(
        '$fieldName cannot exceed $maxLength characters.',
      );
    }
    return ValidationResult.valid();
  }

  /// Valida que el campo no esté vacío
  static ValidationResult validateRequired(String value, String fieldName) {
    if (value.trim().isEmpty) {
      return ValidationResult.invalid('$fieldName is required.');
    }
    return ValidationResult.valid();
  }

  // ─── Validadores combinados ──────────────────────────────────────────────

  /// Valida contacto (teléfono/whatsapp)
  static ValidationResult validateContactPhone(String value) {
    if (value.trim().isEmpty) {
      return ValidationResult.valid(); // Opcional
    }
    
    if (value.length > contactPrimaryMaxLength) {
      return ValidationResult.invalid(
        'The phone number cannot exceed $contactPrimaryMaxLength characters.',
      );
    }

    return validatePhoneNumber(value);
  }

  /// Valida contacto (email)
  static ValidationResult validateContactEmail(String value) {
    if (value.trim().isEmpty) {
      return ValidationResult.valid(); // Opcional
    }

    if (value.length > contactPrimaryMaxLength) {
      return ValidationResult.invalid(
        'The email cannot exceed $contactPrimaryMaxLength characters.',
      );
    }

    return validateEmail(value);
  }

  /// Valida contacto (website/address)
  static ValidationResult validateContactText(String value) {
    if (value.trim().isEmpty) {
      return ValidationResult.valid(); // Opcional
    }

    if (value.length > contactPrimaryMaxLength) {
      return ValidationResult.invalid(
        'This field cannot exceed $contactPrimaryMaxLength characters.',
      );
    }

    return ValidationResult.valid();
  }

  /// Valida URL de redes sociales
  static ValidationResult validateSocialUrl(String value) {
    if (value.trim().isEmpty) {
      return ValidationResult.valid(); // Opcional
    }

    if (value.length > socialUrlMaxLength) {
      return ValidationResult.invalid(
        'The URL cannot exceed $socialUrlMaxLength characters.',
      );
    }

    return validateUrl(value);
  }

  /// Valida etiqueta de redes sociales
  static ValidationResult validateSocialLabel(String value) {
    if (value.trim().isEmpty) {
      return ValidationResult.valid(); // Opcional
    }

    if (value.length > socialLabelMaxLength) {
      return ValidationResult.invalid(
        'The label cannot exceed $socialLabelMaxLength characters.',
      );
    }

    return ValidationResult.valid();
  }

  /// Valida URL de calendario
  static ValidationResult validateCalendarUrl(String value) {
    if (value.trim().isEmpty) {
      return ValidationResult.valid(); // Opcional
    }

    if (value.length > calendarUrlMaxLength) {
      return ValidationResult.invalid(
        'The URL cannot exceed $calendarUrlMaxLength characters.',
      );
    }

    return validateUrl(value);
  }
}

/// Clase que representa el resultado de una validación
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult.valid()
      : isValid = true,
        errorMessage = null;

  ValidationResult.invalid(this.errorMessage) : isValid = false;

  // Para compatibilidad con forma más corta
  factory ValidationResult(bool valid, {String? error}) {
    return valid ? ValidationResult.valid() : ValidationResult.invalid(error ?? 'Error');
  }
}
