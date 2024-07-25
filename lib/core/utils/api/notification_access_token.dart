// import 'dart:developer';

// import 'package:googleapis_auth/auth_io.dart';

// class NotificationAccessToken {
//   static String? _token;

//   //to generate token only once for an app run
//   static Future<String?> get getToken async =>
//       _token ?? await _getAccessToken();

//   // to get admin bearer token
//   static Future<String?> _getAccessToken() async {
//     try {
//       const fMessagingScope =
//           'https://www.googleapis.com/auth/firebase.messaging';

//       final client = await clientViaServiceAccount(
//         // To get Admin Json File: Go to Firebase > Project Settings > Service Accounts
//         // > Click on 'Generate new private key' Btn & Json file will be downloaded

//         // Paste Your Generated Json File Content
//         ServiceAccountCredentials.fromJson({
//           "type": "service_account",
//           "project_id": "graduation-project-20eda",
//           "private_key_id": "108a824e4bd01007519c99ce70b64d94a874b5c6",
//           "private_key":
//               "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCYzkBLN0uwFc0u\nHifCjhQBSNWf0j6LK5GzBlwBM5yWiC0owsCsu7YNspfjfq539uPVp7/1eGFwpA1n\n4KNr/IrkTs2ho2hpIQC0UZmxOj3fcefKFQ/raaNtNVx7wararget7jXTe7RbE72e\nSHtRy92YRcgZZUv4D5D4rvHUKfVU0B9q55bDKd9BovHlu6PaZmF+QUW10wiWQ4Dn\n734p48JXFmGpTwk8+0XjHxWMcgU4aZjZSiJ4Jn6gjiILtaWzxRpB8XFltNZX/Hxo\nhMWdtr5aWyBpFh3XvUb9p8wtj17HnEfettzS6mo9TeFdqW7pOee8hUhOtvqw8koG\nMW3lJDNzAgMBAAECggEADP3cMYjuAnaYD0e5Ea2KveE3aHMzphl6NcJgqCl/Mr05\nObH1N7pt7BQ3HbxzkPeIv22XwIMPpcgM67wJqPC7zlV03j1Kb0XDDZGyg4L0J79D\necb4p4c/wdU7m7oHkLgjJwKNyQFHgEbZZE+9TGMM4BluvdoC74BDTyFwph07Io69\nuQUvYtaHOCG4jrn5g76RMyNEjLA3ZE7mhoLtJPXPu+yHzCxt5ILn0cmvxgvD1s6/\n60fi/1euKrS03WcM1ekFC2+CiTtkjkl50ZZusZF93sYlKVx/W9QRQdX/DPdhIgSN\n00xp9uijAvgTRYTPWWhbe/spc2HzGbLRdS5nWYZNAQKBgQDKag/hSRXXPwodvl61\nlyCpRfJTVK3XE36hboP6e4KJzVXC1PaZcnV1xUmi4o2LDHRkK5PSgpzi+JDKYlt+\nC4rTjNCwXVu5SCt3YnvyRSwA47znWj8qRZcT5zABveBNJGyidWVygAVXv2qoXwVU\nV3vfCuuhJWNBpAmfhXSHHlfGoQKBgQDBQiIemH9DEFZFJ8xJtEp0VAl+azfAR9r6\nysQcOHGLhm6rSzz1iW3oKMqIi5c0ZwPIV1iqaY+acaTIOCZpOJchkFjmHww2h4uM\nJFiSSgPf0TgL3ypaSWZ4psQza4d16jrdGjEDQa8jO8UqCRzOBD+OGX7wjhBYxJjD\nIP84YFwFkwKBgQCuc1i6XoXvXEp4thDkSpsAqOMgBLRK0Gdr9FbU88vevlSytV7P\ng0FOvjknpEA/Xf2WM6SUYrOaPoZzlu+po4MDrrJRvjSGbHfhzcRrWkiBf8XYUwRr\nh0yc/7x1U9NUSRdDsRA87a8tIDFpaXOrbDa7Vasc2J9B/IG6tYdnyLP34QJ/Nxuk\nnxTdNUJzV0UB/AJtOL699k6clzfmOZ2YTnPJ7P9oj2/k8h8+N/Vpy4YCl+7IJVjC\n79UqHeBKHM3mJhr8/ZUrxHMWCHaeVFgI6a4xbKE8WiZI7XYAwmbLi94dwoIIRwQw\n9bzFNEbW8iWnERglB2A90lqwTp/A7+N445qWowKBgQCc54PwUYeORBGnXGIi5n5E\nKhPYi/4kxheAKsRNYSB9PiL8i8c/Ky+GeuSx+6ZVlAxCSJuoMaB5UeXaIYHvcIhB\nHY3tYNidV+LbxU1+9Jfb2tBf15SacygoB8g7dlmZ0yuQluCbF/6Q8ofVAxXFI8vd\nIzOc5XFLHInhRMi2i3HN/A==\n-----END PRIVATE KEY-----\n",
//           "client_email":
//               "firebase-adminsdk-83hbg@graduation-project-20eda.iam.gserviceaccount.com",
//           "client_id": "104182022058055008908",
//           "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//           "token_uri": "https://oauth2.googleapis.com/token",
//           "auth_provider_x509_cert_url":
//               "https://www.googleapis.com/oauth2/v1/certs",
//           "client_x509_cert_url":
//               "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-83hbg%40graduation-project-20eda.iam.gserviceaccount.com",
//           "universe_domain": "googleapis.com"
//         }),
//         [fMessagingScope],
//       );

//       _token = client.credentials.accessToken.data;

//       return _token;
//     } catch (e) {
//       log('$e');
//       return null;
//     }
//   }
// }
