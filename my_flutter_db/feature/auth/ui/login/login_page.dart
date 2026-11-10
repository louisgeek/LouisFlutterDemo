import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_view_model.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
        context.read<LoginUsecase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Consumer<LoginViewModel>(
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
                        : () => viewModel.login(
                              _emailController.text,
                              _passwordController.text,
                            ),
                    child: viewModel.state.isLoading
                        ? CircularProgressIndicator()
                        : Text('Login'),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Don\'t have an account? Register'),
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