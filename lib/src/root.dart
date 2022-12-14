import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/app.dart';
import 'package:flutter_instagram_clone/src/controller/auth_controller.dart';
import 'package:flutter_instagram_clone/src/model/instragram_user.dart';
import 'package:flutter_instagram_clone/src/pages/login.dart';
import 'package:flutter_instagram_clone/src/pages/signup_page.dart';
import 'package:get/get.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          // firebase 유저 정보 조회

          return FutureBuilder<IUser?>(
            future: controller.loginUser(user.data!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const App();
              } else {
                return Obx(
                  () => controller.user.value.uid != null
                      ? const App()
                      : SignupPage(uid: user.data!.uid),
                );
              }
            },
          );
          // return const App();
        } else {
          return const Login();
        }
      },
    );
  }
}
