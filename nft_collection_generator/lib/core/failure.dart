abstract class Failure {
  final String message;

  Failure(this.message);
}

class UnhandledFailure extends Failure {
  UnhandledFailure(String message) : super(message);
}
