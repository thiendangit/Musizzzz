class AppFailure {
  final String message;
  AppFailure([this.message = 'Sorry, an unexpected error occured!']);

  @override
  String toString() {
    return 'AppFailure(message: $message)';
  }
}

class AppSuccess {
  final String message;
  AppSuccess([this.message = 'Success!']);

  @override
  String toString() {
    return 'AppSuccess(message: $message)';
  }
}
