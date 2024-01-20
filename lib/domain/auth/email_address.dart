import 'package:meta/meta.dart';

@immutable
class EmailAddress {
  final String value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value); // 비공개 생성자: 지금은 크게 중요하지 않은 듯

  @override
  String toString() => 'EmailAddress($value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is EmailAddress && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

String validateEmailAddress(String input) {
  // Maybe not the most robust way of email validation but it's good enough
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return input;
  } else {
    throw InvalidEmailException(failedValue: input);
  }
}

class InvalidEmailException implements Exception {
  final String failedValue;

  InvalidEmailException({required this.failedValue});
}
