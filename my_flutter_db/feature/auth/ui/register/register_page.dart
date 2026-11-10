import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_view_model.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(
        context.read<RegisterUsecase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Consumer<RegisterViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (viewModel.state.error != null)
                    Text(
                      viewModel.state.error!,
                      style: TextStyle(color: Colors.red),
                    ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: viewModel.state.isLoading
                        ? null
                        : () => viewModel.register(
                              _usernameController.text,
                              _emailController.text,
                              _passwordController.text,
                            ),
                    child: viewModel.state.isLoading
                        ? CircularProgressIndicator()
                        : Text('Register'),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Already have an account? Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}