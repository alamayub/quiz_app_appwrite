import 'dart:developer';

import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/apis/auth_api.dart';
import 'package:quiz_app/apis/user_api.dart';
import 'package:quiz_app/config/constants.dart';
import 'package:quiz_app/core/utils.dart';
import 'package:quiz_app/models/user_model.dart';
import 'package:quiz_app/screens/login_screen.dart';
import 'package:quiz_app/screens/quiz_app.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  ),
);

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final uid = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetail = ref.watch(userDetailsProvider(uid));
  return userDetail.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  // state = isLoading

  // start with phone number
  void loginWithMobileNumber() async {
    // try {
    //   state = true;
    //   final res = await _authAPI.signUp(
    //     name: name,
    //     email: email,
    //     password: password,
    //   );
    //   state = false;
    //   res.fold(
    //     (l) => showSnackBar(l.message),
    //     (r) async {
    //       log('New User ${r.toMap()}');
    //       UserModel userModel = UserModel(
    //         uid: r.$id,
    //         name: name,
    //         email: email,
    //         followers: const [],
    //         following: const [],
    //         profilePic: '',
    //         bannerPic: '',
    //         bio: '',
    //         isTwitterBlue: false,
    //       );

    //       final res2 = await _userAPI.saveUserData(userModel);
    //       res2.fold(
    //         (l1) => showSnackBar(l1.message),
    //         (_) {
    //           showSnackBar('Account created! Please login.');
    //           navigatorKey.currentState!.pushAndRemoveUntil(
    //             MaterialPageRoute(
    //               builder: (context) => const LoginScreen(),
    //             ),
    //             (route) => false,
    //           );
    //         },
    //       );
    //     },
    //   );
    // } catch (e) {
    //   showSnackBar(e.toString());
    // }
  }

  // register user auth controller
  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = true;
      final res = await _authAPI.signUp(
        name: name,
        email: email,
        password: password,
      );
      state = false;
      res.fold(
        (l) => showSnackBar(l.message),
        (r) async {
          log('New User ${r.toMap()}');
          UserModel userModel = UserModel(
            uid: r.$id,
            name: name,
            email: email,
            followers: const [],
            following: const [],
            profilePic: '',
            bannerPic: '',
            bio: '',
            isTwitterBlue: false,
          );

          final res2 = await _userAPI.saveUserData(userModel);
          res2.fold(
            (l1) => showSnackBar(l1.message),
            (_) {
              showSnackBar('Account created! Please login.');
              navigatorKey.currentState!.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          );
        },
      );
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // login user auth controller
  void login({
    required String email,
    required String password,
  }) async {
    try {
      state = true;
      final res = await _authAPI.login(
        email: email,
        password: password,
      );
      state = false;
      res.fold(
        (l) => showSnackBar(l.message),
        (r) {
          log('USER ${r.toMap()}');
          showSnackBar('Welcome to the stage mate...');
          navigatorKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const QuizApp(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  // get current user account
  Future<model.Account?> currentUser() async =>
      await _authAPI.currentuserAccount();

  // get current user details from dfatabase
  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getuserData(uid);
    final updateduser = UserModel.fromMap(document.data);
    return updateduser;
  }

  // logout user
  Future<void> logout() async {
    state = true;
    final res = await _authAPI.logout();
    state = false;
    res.fold(
      (l) => showSnackBar(l.message),
      (r) {
        showSnackBar('Logged out successfully!');
        navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
