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
              onPressed: () {},
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
