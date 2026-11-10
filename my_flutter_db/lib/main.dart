import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'feature/auth/data/remote/auth_api.dart';
import 'feature/auth/data/local/app_database.dart';
import 'feature/auth/data/local/dao/user_dao.dart';
import 'feature/auth/data/local/local_data_source.dart';
import 'feature/auth/data/remote/remote_data_source.dart';
import 'feature/auth/data/repository/auth_repository_impl.dart';
import 'feature/auth/domain/repository/auth_repository.dart';
import 'feature/auth/domain/usecase/login_usecase.dart';
import 'feature/auth/ui/auth_view_model.dart';
import 'feature/auth/ui/login/login_page.dart';
import 'feature/auth/ui/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (context) => AuthApi(context.read<Dio>())),
        Provider(create: (_) => AppDatabase()),
        Provider(create: (context) => UserDao(context.read<AppDatabase>())),
        Provider(create: (context) => LocalDataSource(context.read<UserDao>())),
        Provider(create: (context) => RemoteDataSource(context.read<AuthApi>())),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            remoteDataSource: context.read<RemoteDataSource>(),
            localDataSource: context.read<LocalDataSource>(),
          ),
        ),
        Provider(create: (context) => LoginUsecase(context.read<AuthRepository>())),
        Provider(create: (context) => RegisterUsecase(context.read<AuthRepository>())),
        Provider(create: (context) => GetCurrentUserUsecase(context.read<AuthRepository>())),
        Provider(create: (context) => LogoutUsecase(context.read<AuthRepository>())),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            getCurrentUserUsecase: context.read<GetCurrentUserUsecase>(),
            logoutUsecase: context.read<LogoutUsecase>(),
          )..loadCurrentUser(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Auth Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        },
      ),
    );
  }
}