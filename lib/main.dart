import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/authenticationService.dart';
import 'package:task_app/provider/meeting_provider.dart';
import 'package:task_app/provider/ui_provider.dart';
import 'package:task_app/screens/add_task_form.dart';
import 'package:task_app/screens/auth/login_screen.dart';
import 'package:task_app/screens/auth/signIn.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/task_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) =>
                UserMeeting(FirebaseFirestore.instance.collection('tasks'))),
        ChangeNotifierProvider(create: (ctx) => UiProvider()),
        Provider<AuthenticationService>(
            create: (ctx) =>
                AuthenticationService(firebaseAuth: FirebaseAuth.instance)),
        StreamProvider(
            create: (ctx) => ctx.read<AuthenticationService>().authChanges,
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Task Aapp',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          canvasColor: Colors.orange.shade50,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 20,
            ),
            backgroundColor: Colors.orange.shade50,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: _initialization,
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Text("Not connected");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                print("done");
                return FirebaseAuth.instance.currentUser == null
                    ? LoginScreen()
                    : HomeScreen();
                // return StreamBuilder(
                //     stream: FirebaseAuth.instance.authStateChanges(),
                //     builder: (ctx, authSnapshot) {
                //       if (snapshot.connectionState != ConnectionState.active) {
                //         return Center(child: CircularProgressIndicator());
                //       }
                //       final user = snapshot.data;
                //       if (user != null) {
                //         return HomeScreen();
                //       } else {
                //         return LoginScreen();
                //       }
                //     });
              }
              return CircularProgressIndicator();
            }),
        routes: {
          RegisterScreen.routName:(ctx)=>RegisterScreen(),
          LoginScreen.routName: (ctx) => LoginScreen(),
          NewTask.routName: (ctx) => NewTask(),
          TaskScreen.routName: (ctx) => TaskScreen(),
          HomeScreen.routName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
