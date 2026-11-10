import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:provider/provider.dart';

@Preview(name: 'RegisterPage')
Widget previewRegisterPage() {
  return const RegisterPage();
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(
          builder: (context, authVM, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: '姓名'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: '邮箱'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: '密码'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                if (authVM.errorMessage != null)
                  Text(authVM.errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                authVM.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => authVM.register(
                          _emailController.text,
                          _passwordController.text,
                          _nameController.text,
                        ),
                        child: const Text('注册'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
