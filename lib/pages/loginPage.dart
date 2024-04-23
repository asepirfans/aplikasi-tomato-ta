// views/register_view.dart
import 'package:animate_do/animate_do.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tomato_farm/controllers/login_controller.dart';
import 'package:tomato_farm/routes/route_name.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xFF86A789),
          Color(0xFF708F73),
          Color(0xFF80A083),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "TOMATO\nSMART FARM",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Welcome Back GenZ 👋",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            cursorColor: Color(0xFF86A789),
                            controller: _loginController.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color(0xFF86A789),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF86A789), width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 20.0, top: 20.0, bottom: 20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF86A789), width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              suffixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF86A789),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Obx(() => Stack(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          _loginController.passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          color: Color(0xFF86A789),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF86A789),
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 20.0,
                                            top: 20.0,
                                            bottom: 20.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF86A789),
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                      obscureText: !_loginController
                                          .showPassword
                                          .value, // Use value from controller
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    bottom: 8,
                                    child: IconButton(
                                      onPressed: () {
                                        _loginController.toggleShowPassword();
                                      },
                                      icon: Icon(
                                        color: Color(0xFF86A789),
                                        _loginController.showPassword.value
                                            ? Icons.visibility
                                            : Icons
                                                .visibility_off, // Use icon based on showPassword value
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: 24),
                          MaterialButton(
                            minWidth: Get.width,
                            height: 60,
                            color: Color(0xFF86A789),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onPressed: () {
                              _loginController.loginWithEmail();
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                Text("Does Not Have Account?"),
                                SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Get.offAllNamed(
                                      RouteName.register,
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF86A789),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
