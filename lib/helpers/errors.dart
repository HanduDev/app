String getErrorMessage(dynamic error) {
  try {
    if (error.message != null) {
      if (error.message is String) {
        return error.message;
      }

      if (error.message is Map<String, dynamic> &&
          error.message.containsKey('message')) {
        return error.message['message'];
      }
    }

    if (error is Map<String, dynamic> && error.containsKey('message')) {
      return error['message'];
    }

    return 'Ocorreu um erro inesperado. Tente novamente mais tarde.';
  } catch (e) {
    return 'Ocorreu um erro inesperado. Tente novamente mais tarde.';
  }
}
