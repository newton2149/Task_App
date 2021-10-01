import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/authenticationService.dart';
import 'package:task_app/provider/ui_provider.dart';
import 'package:task_app/screens/auth/signIn.dart';
import 'package:task_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/login-screen";

  static TextStyle customStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
  static TextStyle customStyleTitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
    ),
  );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UiProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Container(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 30,
                  top: 30,
                ),
                child: SvgPicture.asset(
                  'assets/images/lost_online2.svg',
                  alignment: Alignment.center,
                  height: 300,
                )),
            fit: BoxFit.contain,
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Login",
                      textAlign: TextAlign.left,
                      style: LoginScreen.customStyleTitle,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Provider.of<AuthenticationService>(context, listen: false)
                          .login(
                        email: emailController.text,
                        password: passwordController.text,
                      )
                          .then((value) {
                        Navigator.of(context).pushNamed(HomeScreen.routName);
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      labelText: "Email Id",
                      labelStyle: LoginScreen.customStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "PassWord",
                      labelStyle: LoginScreen.customStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Text(
            "Or",
            style: LoginScreen.customStyleTitle,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset('assets/images/icons8-google.svg'),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset('assets/images/icons8-facebook.svg'),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Dont Have an Account!!",
            style: LoginScreen.customStyle,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(RegisterScreen.routName);
            },
            child: Text(
              "SignUp",
              style: LoginScreen.customStyle,
            ),
          ),
        ],
      ),
    ));
  }
}
