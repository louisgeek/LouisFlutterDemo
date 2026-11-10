import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showEmailClear = false;
  bool _showPasswordClear = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() => _showEmailClear = _emailController.text.isNotEmpty);
    });
    _passwordController.addListener(() {
      setState(() => _showPasswordClear = _passwordController.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(
          builder: (context, authVM, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '邮箱',
                    prefixIcon: const Icon(Icons.email_outlined),
                    suffixIcon: _showEmailClear
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _emailController.clear(),
                    )
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '密码',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: _showPasswordClear
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _passwordController.clear(),
                    )
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                if (authVM.errorMessage != null)
                  Text(authVM.errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                authVM.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => authVM.login(
                      _emailController.text,
                      _passwordController.text,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('登录', style: TextStyle(fontSize: 16)),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  ),
                  child: const Text('没有账号？去注册'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
