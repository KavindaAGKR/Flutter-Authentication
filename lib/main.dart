import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //prepares Flutter for asynchronous initialization.
  await Firebase.initializeApp(); //initializes Firebase for use in the app.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is signed in, show the HomeScreen
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user != null) {
            return const HomeScreen(); // User is signed in
          } else {
            return LoginScreen(); // User is not signed in
          }
        }
        // Show a loading spinner while checking authentication status
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
