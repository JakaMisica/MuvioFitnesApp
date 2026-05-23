import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../logic/cubit/auth/auth_cubit.dart';
import '../../../logic/cubit/auth/auth_state.dart';
import '../../widgets/foggy_background.dart';

class AuthScreen extends StatelessWidget {
  final VoidCallback onAuthComplete;

  const AuthScreen({super.key, required this.onAuthComplete});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          onAuthComplete();
        } else if (state is AuthNeedsVerification) {
          _showEmailVerificationDialog(context, state.email);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FoggyBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tech Logo Area
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.cyanAccent.withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.security_rounded,
                      color: Colors.cyanAccent,
                      size: 50,
                    ),
                  ),
                  const Gap(32),
                  const Text(
                    "MUVIO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6,
                    ),
                  ),
                  const Text(
                    "PLEASE SIGN IN TO CONTINUE",
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const Gap(64),

                  _buildAuthButton(
                    context,
                    label: "SIGN IN WITH GOOGLE",
                    iconPath: 'assets/icons/google.png',
                    icon: Icons.g_mobiledata_rounded,
                    color: Colors.white,
                    onPressed: () =>
                        context.read<AuthCubit>().signInWithGoogle(),
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Column(
                          children: [
                            Gap(12),
                            Text(
                              "please wait a minute as this proces is sometimes bit slower.",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Gap(12),
                          ],
                        );
                      }
                      return const Gap(16);
                    },
                  ),

                  // Email Login Button
                  _buildAuthButton(
                    context,
                    label: "SIGN IN WITH EMAIL",
                    icon: Icons.email_outlined,
                    color: Colors.white10,
                    textColor: Colors.white70,
                    onPressed: () => _showEmailLoginDialog(context),
                  ),
                  const Gap(32),

                  // Skip Button
                  TextButton(
                    onPressed: () => context
                        .read<AuthCubit>()
                        .signInAnonymously(persistLocally: true),
                    child: Text(
                      "CONTINUE AS OFFLINE PHENOTYPE",
                      style: TextStyle(
                        color: Colors.cyanAccent.withOpacity(0.5),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEmailVerificationDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
        ),
        title: const Text(
          "VERIFY YOUR GENETICS",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.mark_email_unread_outlined,
              color: Colors.cyanAccent,
              size: 48,
            ),
            const Gap(16),
            Text(
              "A verification link has been sent to:\n$email",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Gap(16),
            const Text(
              "Please check your inbox and click the link to activate your profile.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.read<AuthCubit>().signOut(),
            child: const Text(
              "CANCEL",
              style: TextStyle(color: Colors.white38),
            ),
          ),
          TextButton(
            onPressed: () =>
                context.read<AuthCubit>().resendVerificationEmail(),
            child: const Text(
              "RESEND",
              style: TextStyle(color: Colors.cyanAccent),
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<AuthCubit>().checkEmailVerification(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text(
              "I'VE VERIFIED",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmailLoginDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool isSignUp = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF121212),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Colors.white10),
          ),
          title: Text(
            isSignUp ? "GENETIC ENROLLMENT" : "EMAIL LOGIN",
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white24),
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.white38),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                ),
              ),
              const Gap(16),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white24),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.white38),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                ),
              ),
              const Gap(16),
              TextButton(
                onPressed: () => setDialogState(() => isSignUp = !isSignUp),
                child: Text(
                  isSignUp
                      ? "ALREADY HAVE AN ACCOUNT? LOG IN"
                      : "NO ACCOUNT? SIGN UP",
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "CANCEL",
                style: TextStyle(color: Colors.white38),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final authCubit = context.read<AuthCubit>();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }

                Navigator.pop(context);
                if (isSignUp) {
                  authCubit.signUpWithEmail(email, password);
                } else {
                  authCubit.signInWithEmail(email, password);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
              ),
              child: Text(
                isSignUp ? "SIGN UP" : "LOG IN",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButton(
    BuildContext context, {
    required String label,
    IconData? icon,
    String? iconPath,
    required Color color,
    Color textColor = Colors.black,
    required VoidCallback onPressed,
  }) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool isLoading = state is AuthLoading;
        return InkWell(
          onTap: isLoading ? null : onPressed,
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blueAccent,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null)
                          Icon(icon, color: textColor, size: 24),
                        const Gap(12),
                        Text(
                          label,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
