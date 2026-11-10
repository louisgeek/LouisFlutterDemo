import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth_view_model.dart';
import 'register_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      body: Consumer<RegisterViewModel>(
        builder: (context, vm, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: '姓名'),
                    validator: (v) => v?.isEmpty ?? true ? '请输入姓名' : null,
                  ),
                  const SizedBox(height: 16),
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
                    validator: (v) => (v?.length ?? 0) < 6 ? '密码至少6位' : null,
                  ),
                  if (vm.state.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(vm.state.errorMessage!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: vm.state.isLoading ? null : () => _register(context, vm),
                      child: vm.state.isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('注册'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _register(BuildContext context, RegisterViewModel vm) async {
    if (!_formKey.currentState!.validate()) return;
    
    final success = await vm.register(
      _emailController.text,
      _passwordController.text,
      _nameController.text,
    );
    if (success && mounted) {
      context.read<AuthViewModel>().setUser(vm.repository.getCurrentUser()!);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
