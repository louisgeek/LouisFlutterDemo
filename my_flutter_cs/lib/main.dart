import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/api_client.dart';
import 'feature/auth/data/local/local_data_source.dart';
import 'feature/auth/data/remote/auth_api.dart';
import 'feature/auth/data/repository/auth_repository_impl.dart';
import 'feature/auth/domain/repository/auth_repository.dart';
import 'feature/auth/ui/auth_view_model.dart';
import 'feature/auth/ui/login/login_page.dart';
import 'feature/auth/ui/login/login_view_model.dart';
import 'feature/auth/ui/register/register_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final apiClient = ApiClient();
  final localDataSource = LocalDataSource(prefs);
  final authApi = AuthApi(apiClient.dio);
  final authRepository = AuthRepositoryImpl(authApi, localDataSource);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository)),
        ChangeNotifierProvider(create: (_) => LoginViewModel(authRepository)),
        ChangeNotifierProvider(create: (_) => RegisterViewModel(authRepository)),
      ],
      child: MaterialApp(
        title: 'Flutter Auth Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页')),
      body: Consumer<AuthViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoggedIn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('欢迎, ${vm.user!.name}', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  Text('邮箱: ${vm.user!.email}'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: vm.logout,
                    child: const Text('退出登录'),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
              child: const Text('登录'),
            ),
          );
        },
      ),
    );
  }
}
