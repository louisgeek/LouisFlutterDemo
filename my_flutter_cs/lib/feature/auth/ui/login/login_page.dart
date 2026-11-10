import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_view_model.dart';
import '../register/register_page.dart';
import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      body: Consumer<LoginViewModel>(
        builder: (context, vm, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: '邮箱'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v?.isEmpty ?? true ? '请输入邮箱' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: '密码'),
                    obscureText: true,
                    validator: (v) => v?.isEmpty ?? true ? '请输入密码' : null,
                  ),
                  if (vm.state.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(vm.state.errorMessage!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: vm.state.isLoading ? null : () => _login(context, vm),
                      child: vm.state.isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('登录'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                    child: const Text('没有账号？去注册'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _login(BuildContext context, LoginViewModel vm) async {
    if (!_formKey.currentState!.validate()) return;
    
    final success = await vm.login(_emailController.text, _passwordController.text);
    if (success && mounted) {
      context.read<AuthViewModel>().setUser(vm.repository.getCurrentUser()!);
      Navigator.pop(context);
    }
  }
}
