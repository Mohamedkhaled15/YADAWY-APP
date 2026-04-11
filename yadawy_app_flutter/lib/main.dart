import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:yadawy_app_client/yadawy_app_client.dart';

import 'screens/greetings_screen.dart';
import 'screens/sign_in_screen.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
late final Client client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // The server URL is fetched from the assets/config.json file or
  // defaults to http://10.0.2.2:8080/ (standard for Android emulator).
  const serverUrl = 'http://10.0.2.2:8080/';

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  await client.auth.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abokhaled Chat Boot AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: SignInScreen(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Abokhaled Chat Boot AI'),
            elevation: 2,
          ),
          body: GreetingsScreen(
            onSignOut: () async {
              await client.auth.signOutDevice();
            },
          ),
        ),
      ),
    );
  }
}
