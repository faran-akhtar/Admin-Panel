import 'package:flutter/material.dart';
String emailPattern =
    r"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";

const String noInternetTitle = 'No Connection';
const String noInternetMessage =
    'You are in offline mode. Please check your internet connection';
const String offlineFormMessage =
    'You are in offline mode. Please check your internet connection';
const String noUploadDataMessage = 'No record found for uploading';
const String appVersion = '1.0.0';

const kErrorTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.red,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
);

// const kHintTextStyle = TextStyle(
//   fontSize: 16,
//   color: CustomColors.lightGreyColor,
//   fontWeight: FontWeight.normal,
// );