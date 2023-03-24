import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_desktop/firebase_core_desktop.dart';
import 'package:firebase_for_all/firebase_for_all.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat_app/firebase_options.dart';
import 'package:flutter_flash_chat_app/screens/chat_screen.dart';
import 'package:flutter_flash_chat_app/screens/login_screen.dart';
import 'package:flutter_flash_chat_app/screens/registration_screen.dart';

import 'screens/welcome_screen.dart';

const apiKey = 'AIzaSyBBn31pTgPAukqsfdRaziL3PY0CsJdWgtc';
const projectId = 'flash-chat-b7e5f';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseCoreForAll.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, firestore: true, auth: true, storage: true);

  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (cotext) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen()
      },
    );
  }
}
