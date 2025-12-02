import 'package:flutter/material.dart';
import 'shared_widgets.dart';

class AuthScreen extends StatelessWidget {
  final VoidCallback onAuthenticated;

  const AuthScreen({super.key, required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  const Text(
                    'Study Buddy',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),
                  const Text(
                    'Your AI-powered study assistant',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Log In'),
                      Tab(text: 'Create Account'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: TabBarView(
                      children: [
                        LoginForm(onComplete: onAuthenticated),
                        CreateAccountForm(onComplete: onAuthenticated),
                      ],
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
}

class LoginForm extends StatelessWidget {
  final VoidCallback onComplete;

  const LoginForm({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Email'),
          const SizedBox(height: 8),
          roundedInputField(
            controller: emailController,
            hintText: 'student@example.com',
            icon: Icons.email_outlined,
          ),

          const SizedBox(height: 16),

          const Text('Password'),
          const SizedBox(height: 8),
          roundedInputField(
            controller: passwordController,
            hintText: '••••••••',
            icon: Icons.lock_outline,
            obscureText: true,
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordPage(),
                  ),
                );
              },
              child: const Text('Forgot password'),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onComplete,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Log In'),
            ),
          ),

          const Spacer(),

          const Text(
            'By clicking Log In, you accept our Terms of Use and Privacy Policy.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class CreateAccountForm extends StatelessWidget {
  final VoidCallback onComplete;

  const CreateAccountForm({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final dobController = TextEditingController();
    final phoneController = TextEditingController();
    final levelController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create an Account',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),

            const SizedBox(height: 16),

            roundedInputField(
              controller: nameController,
              hintText: 'Enter your Full Name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 12),

            roundedInputField(
              controller: dobController,
              hintText: 'Enter your Date of Birth',
              icon: Icons.cake_outlined,
            ),
            const SizedBox(height: 12),

            roundedInputField(
              controller: phoneController,
              hintText: 'Enter your Phone Number',
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 12),

            roundedInputField(
              controller: levelController,
              hintText: 'Select Level of Study',
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: 12),

            roundedInputField(
              controller: emailController,
              hintText: 'Enter your Email',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 12),

            roundedInputField(
              controller: passwordController,
              hintText: 'Enter your Password',
              icon: Icons.lock_outline,
              obscureText: true,
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onComplete,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Get started'),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'By clicking Get started, you accept our Terms of Use and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

/// =================================================================
/// FORGOT PASSWORD PAGE
/// =================================================================

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  String? errorText;

  void _submit() {
    final newPass = newPassController.text.trim();
    final confirm = confirmPassController.text.trim();

    if (newPass.isEmpty || confirm.isEmpty) {
      setState(() => errorText = "Please fill in both fields.");
      return;
    }

    if (newPass != confirm) {
      setState(() => errorText = "Passwords do not match.");
      return;
    }

    // Password reset success → go back to login screen
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter a new password below.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 24),

              const Text("New Password"),
              const SizedBox(height: 8),
              roundedInputField(
                controller: newPassController,
                hintText: "••••••••",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 16),

              const Text("Re-enter Password"),
              const SizedBox(height: 8),
              roundedInputField(
                controller: confirmPassController,
                hintText: "••••••••",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              if (errorText != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],

              const SizedBox(height: 24),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}