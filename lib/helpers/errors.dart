String getErrorMessage(Object error) {
  try {
    if (error is String) {
      return error;
    }

    if (error is Exception) {
      return error.toString();
    }

    if (error is List) {
      return error.join(', ');
    }

    if (error is Map<String, dynamic> && error.containsKey('message')) {
      return error['message'];
    }

    if (error is Map<String, dynamic> && error.containsKey('message')) {
      return error['message'];
    }

    return 'Ocorreu um erro inesperado. Tente novamente mais tarde.';
  } catch (e) {
    return 'Ocorreu um erro inesperado. Tente novamente mais tarde.';
  }
}
