import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:reso_note/domain/core/failures.dart';

@immutable
class EmailAddress {
  final Either<ValueFailure<String>, String> value;

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

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

// String validateEmailAddress(String input) {
//   // Maybe not the most robust way of email validation but it's good enough
//   const emailRegex =
//       r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
//   if (RegExp(emailRegex).hasMatch(input)) {
//     return input;
//   } else {
//     throw InvalidEmailException(failedValue: input);
//   }
// }

// class InvalidEmailException implements Exception {
//   final String failedValue;

//   InvalidEmailException({required this.failedValue});
// }
