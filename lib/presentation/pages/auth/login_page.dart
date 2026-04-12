import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_style.dart';
import 'package:hydroponic_mobile/core/utils/string_ext.dart';
import 'package:hydroponic_mobile/presentation/controllers/auth/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sw = constraints.maxWidth;
            final sh = constraints.maxHeight;

            final hPadding = sw * 0.075;
            final imageSize = (sw * 0.35).clamp(100.0, 160.0);
            final titleSize = (sw * 0.08).clamp(24.0, 32.0);
            final subtitleSize = (sw * 0.04).clamp(13.0, 16.0);
            final logoSize = (sw * 0.07).clamp(22.0, 28.0);
            final logoTextSize = (sw * 0.05).clamp(16.0, 20.0);
            final buttonHeight = (sh * 0.07).clamp(48.0, 58.0);
            final spacingXL = sh * 0.05;
            final spacingL = sh * 0.035;
            final spacingM = sh * 0.02;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: hPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: spacingM),

                  // ── Logo Bar ──────────────────────────────────────
                  Row(
                    children: [
                      Icon(Icons.spa_outlined,
                          color: AppStyle.secondColor, size: logoSize),
                      SizedBox(width: sw * 0.02),
                      Text(
                        'PlantCare',
                        style: TextStyle(
                          color: AppStyle.textOnMain,
                          fontSize: logoTextSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spacingXL),

                  // ── Welcome Text ──────────────────────────────────
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: AppStyle.textOnMain,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sh * 0.008),
                  Text(
                    'Sign in to continue your plant journey',
                    style: TextStyle(
                      color: AppStyle.textOnMain.withOpacity(0.7),
                      fontSize: subtitleSize,
                    ),
                  ),

                  SizedBox(height: spacingL),

                  // ── Circular Image ────────────────────────────────
                  Center(
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1667509860948-46d20f127b43?q=80&w=687'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            color: AppStyle.fourtColor,
                            width: (sw * 0.007).clamp(2.0, 3.0)),
                      ),
                    ),
                  ),

                  SizedBox(height: spacingL),

                  // ── Form ──────────────────────────────────────────
                  Form(
                    key: controller.loginFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        AppStyle.buildInputField(
                          context,
                          screenWidth: sw,
                          controller: controller.emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          validator: StringExt.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: spacingM),
                        Obx(() => AppStyle.buildInputField(
                              context,
                              screenWidth: sw,
                              controller: controller.passwordController,
                              label: 'Password',
                              icon: Icons.lock_outlined,
                              validator: StringExt.validatePassword,
                              obscureText: !controller.isPasswordVisible.value,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppStyle.secondColor,
                                  size: sw * 0.055,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            )),
                      ],
                    ),
                  ),

                  SizedBox(height: sh * 0.01),

                  // ── Forgot Password ───────────────────────────────
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppStyle.secondColor.withOpacity(0.8),
                          fontSize: subtitleSize,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: spacingM),

                  // ── Login Button ──────────────────────────────────
                  Obx(() => SizedBox(
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppStyle.secondColor,
                            foregroundColor: AppStyle.textOnSecond,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sw * 0.05),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  width: sw * 0.06,
                                  height: sw * 0.06,
                                  child: const CircularProgressIndicator(
                                    color: AppStyle.textOnSecond,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: (sw * 0.04).clamp(14.0, 16.0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      )),

                  SizedBox(height: spacingL),

                  // ── Divider "or" ──────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                              color: AppStyle.textOnMain.withOpacity(0.3))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
                        child: Text('or',
                            style: TextStyle(
                              color: AppStyle.textOnMain.withOpacity(0.5),
                              fontSize: subtitleSize,
                            )),
                      ),
                      Expanded(
                          child: Divider(
                              color: AppStyle.textOnMain.withOpacity(0.3))),
                    ],
                  ),

                  SizedBox(height: spacingL),

                  // ── Register Link ─────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: AppStyle.textOnMain.withOpacity(0.7),
                          fontSize: subtitleSize,
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToRegister,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: AppStyle.secondColor,
                            fontWeight: FontWeight.bold,
                            fontSize: subtitleSize,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spacingXL),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
