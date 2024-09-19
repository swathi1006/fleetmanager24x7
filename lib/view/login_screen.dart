import 'package:fleet_manager_driver_app/utils/color.dart';
import 'package:fleet_manager_driver_app/widget/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/login_controller.dart';
import '../widget/toaster_message.dart';
import 'main_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RxBool _obscureText = true.obs;
  RxBool isloader = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logingrey,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    primary.withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                  child: Image.asset('assets/image/intro3.jpeg'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/fleet_manager.png',
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, -3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(3, 0),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(-3, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 15),
                      const Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            contentPadding: const EdgeInsets.only(left: 25),
                            labelStyle: const TextStyle(
                                color: primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: primary,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: _obscureText.value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              contentPadding: const EdgeInsets.only(left: 25),
                              labelStyle: const TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: primary,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: primary,
                                  width: 1.5,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: primary,
                                ),
                                onPressed: () => _obscureText.toggle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        // Show CircularProgressIndicator if loading, otherwise show the button
                        return isloader.value
                            ? const Center(child: Loader())
                            : SizedBox(
                                width: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(5),
                                        backgroundColor:
                                            MaterialStateProperty.all(primary),
                                      ),
                                      onPressed: () async {
                                        // Show "This takes some time" message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'This may take a moment...',
                                              
                                              style: GoogleFonts.lato(
                                                  color: secondary,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        );

                                        // Set loading state to true
                                        isloader.value = true;

                                        bool isuser = await controller.login(
                                            usernameController,
                                            passwordController);
                                        if (isuser) {
                                          if (controller.user!.pin != null) {
                                            // Wait until the loading is complete
                                            while (controller.isloading.value) {
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                            }
                                            // Navigate to MainScreen
                                            Get.offAll(() => MainScreen());
                                          } else {
                                            usernameController.clear();
                                            passwordController.clear();
                                            controller.showSetPinOverLay();
                                          }
                                        } else {
                                          createToastTop(
                                              'Invalid username or password');
                                        }

                                        // Set loading state to false after the process
                                        isloader.value = false;
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
