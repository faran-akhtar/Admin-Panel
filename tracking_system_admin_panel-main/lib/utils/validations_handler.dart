import 'package:form_field_validator/form_field_validator.dart';

final requiredValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
]);
final numberValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(5,
      errorText: 'Phone Number Must be at least 7 characters'),
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  MinLengthValidator(6, errorText: 'Password must be at least 6 digit long.'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required.'),
  EmailValidator(errorText: "Email is invalid."),
]);