// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:oauth2_client/access_token_response.dart';
// import 'package:oauth2_client/oauth2_client.dart';

// import '../../../../app/app.dart';
// import '../../../../db/db.dart';
// import '../../../../utils/utils.dart';
// import '../../../sdk.dart';

// String clientId = '97d90563b7';
// String redirectUri = 'mits://oauth2redirect';
// String customUriScheme = 'mits';
// String authState = 'start';
// List<String> scopes = ['read'];

// class TokenInterceptor extends Interceptor {
//   TokenInterceptor() {
//     client = MyOAuth2Client(
//       customUriScheme: customUriScheme,
//       redirectUri: redirectUri,
//     );
//   }

//   late OAuth2Client client;

//   static List<String> blackListsEndpoints = [
//     'api/resource/User',
//   ];

//   Future<void> checkToken() async {
//     try {
//       UserTable? user = AuthService.to.user;
//       if (user?.authToken != null) {
//         AccessTokenResponse dbTokenResponse = AccessTokenResponse.fromMap(
//           jsonDecode(user!.authToken!),
//         );
//         if (dbTokenResponse.isExpired()) {
//           await refreshToken(
//             dbTokenResponse.refreshToken,
//           );
//         } else {
//           await setToken(dbTokenResponse);
//         }
//       } else {
//         await generateNewToken();
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//       return;
//     }
//   }

//   Future<void> generateNewToken() async {
//     try {
//       AccessTokenResponse tokenResponse = await client.getTokenWithAuthCodeFlow(
//         clientId: clientId,
//         state: authState,
//         scopes: scopes,
//       );

//       debugPrint('accessToken = ${jsonEncode(tokenResponse.toMap())}');

//       await updateToken(tokenResponse);
//     } catch (e) {
//       debugPrint(e.toString());
//       throw LogoutException();
//     }
//   }

//   Future<void> refreshToken(String? refreshToken) async {
//     if (refreshToken == null) {
//       throw LogoutException();
//     }
//     try {
//       AccessTokenResponse refreshTokenResponse = await client.refreshToken(
//         refreshToken,
//         clientId: clientId,
//       );

//       await updateToken(refreshTokenResponse);
//     } catch (e) {
//       debugPrint(e.toString());
//       throw LogoutException();
//     }
//   }

//   Future<void> setToken(AccessTokenResponse token) async {
//     AuthService.to.setToken(token);
//   }

//   Future<void> updateToken(AccessTokenResponse token) async {
//     try {
//       await UserDao.get().update(
//         {
//           UserTable.dbAuthToken: jsonEncode(token.toMap()),
//         },
//       );

//       await setToken(token);
//     } catch (e) {
//       debugPrint(e.toString());
//       return;
//     }
//   }

//   bool isPathInBlackList(String path) {
//     bool isBlackList = false;
//     for (String element in blackListsEndpoints) {
//       if (path.contains(element)) {
//         isBlackList = true;
//         break;
//       }
//     }
//     return isBlackList;
//   }

//   @override
//   Future onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     bool isPathInBlack = isPathInBlackList(options.path);
//     if (!isPathInBlack) {
//       await checkToken();

//       options.headers["Authorization"] =
//           "Bearer ${AuthService.to.accessTokenResponse?.accessToken}";
//     }
//     return super.onRequest(options, handler);
//   }
// }

// class MyOAuth2Client extends OAuth2Client {
//   MyOAuth2Client({
//     required String redirectUri,
//     required String customUriScheme,
//   }) : super(
//           authorizeUrl:
//               '${HTTPConfig.baseURL}api/method/frappe.integrations.oauth2.authorize',
//           tokenUrl:
//               '${HTTPConfig.baseURL}api/method/frappe.integrations.oauth2.get_token',
//           revokeUrl:
//               '${HTTPConfig.baseURL}api/method/frappe.integrations.oauth2.revoke_token',
//           redirectUri: redirectUri,
//           customUriScheme: customUriScheme,
//         );
// }
