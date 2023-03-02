import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Authentication Demo',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AuthPageResourceOwnerGrant();
        break;
      case 1:
        page = AuthPageAuthorizationCodeGrant();
        break;
      default:
        throw UnimplementedError('no widget found for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth > 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.supervised_user_circle),
                      label: Text('Auth Page 1'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.supervised_user_circle_outlined),
                      label: Text('Auth page 2'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(
                      () {
                        selectedIndex = value;
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class AuthPageResourceOwnerGrant extends StatefulWidget {
  @override
  State<AuthPageResourceOwnerGrant> createState() =>
      _AuthPageResourceOwnerGrantState();
}

class _AuthPageResourceOwnerGrantState
    extends State<AuthPageResourceOwnerGrant> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var usernameTextEditingController = TextEditingController();
    var passwordTextEditingController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        const Center(
          child: Text('Testing OAuth page 1!'),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          width: 200,
          child: TextFormField(
            controller: usernameTextEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Username',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          width: 200,
          child: TextFormField(
            controller: passwordTextEditingController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              // Method 2. Resource Owner Password Grant

              var username = usernameTextEditingController.text;
              var password = passwordTextEditingController.text;

              username = username.contains('xxxxxxxxxxxxxxxx\\')
                  ? username
                  : 'xxxxxxxxxxxxxxxx\\$username';

              appState.executeResourceOwnerGrant(username, password);
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }
}

class AuthPageAuthorizationCodeGrant extends StatefulWidget {
  @override
  State<AuthPageAuthorizationCodeGrant> createState() =>
      _AuthPageAuthorizationCodeGrantState();
}

class _AuthPageAuthorizationCodeGrantState
    extends State<AuthPageAuthorizationCodeGrant> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Uri authUri;

    return Column(
      children: [
        const SizedBox(height: 10),
        const Center(
          child: Text('Testing OAuth page 2!'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            // Method 1. Authorization Code Grant
            startServer();

            authUri = appState.executeAuthorizationCodeGrant();

            if (await canLaunchUrl(authUri)) {
              await launchUrl(authUri);
            }
          },
          child: Text('Login'),
        ),
      ],
    );
  }

  startServer() async {
    // setState(() {
    //   statusText = "Starting server on Port : 8080";
    // });

    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);

    print("Server running on IP : ${server.address} On Port : ${server.port}");

    await for (var request in server) {
      Future<String> content = utf8.decodeStream(request);
      content.then(
          (value) => print('Request received to ${server.address} - \n$value'));

      var params = request.uri.queryParameters;
      var code = params['code'];
      if (code != null) {
        print('Request code - \n${code}');

        String datetime = DateTime.now().toString();
        request.response.headers.contentType =
            ContentType("text", "plain", charset: "utf-8");
        request.response.write(
            'Authentication Success at $datetime. You can close this window and return to the app!');
      } else {
        String datetime = DateTime.now().toString();
        request.response.headers.contentType =
            ContentType("text", "plain", charset: "utf-8");
        request.response
            .write('Authentication failed at $datetime. Try again!');
      }

      await request.response.close();

      // Stop the server
      await server.close();
      print('Server stopped');
      break; // Exit the loop
    }

    // setState(() {
    //   statusText =
    //       "Server running on IP : ${server.address} On Port : ${server.port}";
    // });
  }
}

class MyAppState extends ChangeNotifier {
  var accessToken;
  var refreshToken;
  var idToken;

  Uri executeAuthorizationCodeGrant() {
    var authorizationEndpoint =
        Uri.parse('https://xxxxxxxxxxxxxxxx.net/adfs/oauth2/authorize');

    var tokenEndpoint =
        Uri.parse('https://xxxxxxxxxxxxxxxx.net/adfs/oauth2/token');

    var identifier = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";

    var grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        basicAuth: false);

    var redirectUrl = Uri.parse('http://127.0.0.1:8080/');

    var authorizationUrl = grant.getAuthorizationUrl(redirectUrl);
    return (authorizationUrl);
  }

  Future<void> executeResourceOwnerGrant(
      String username, String password) async {
    var authorizationEndpoint =
        Uri.parse('https://xxxxxxxxxxxxxxxx.net/adfs/oauth2/token');

    var identifier = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';

    var client = await oauth2.resourceOwnerPasswordGrant(
      authorizationEndpoint,
      username,
      password,
      identifier: identifier,
      basicAuth: false,
      scopes: ['openid'],
    );

    accessToken = client.credentials.accessToken;
    refreshToken = client.credentials.refreshToken;
    idToken = client.credentials.idToken;
  }
}
