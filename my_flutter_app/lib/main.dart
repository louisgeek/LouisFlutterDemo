import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:provider/provider.dart';
import 'features/auth/viewmodel/auth_viewmodel.dart';
import 'features/auth/view/login_page.dart';
import 'features/auth/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

@Preview(name: 'MyApp')
Widget previewMyApp() {
  return const MyApp();
}

class ThemeProvider extends ChangeNotifier {
  double _fontScale = 1.0;

  double get fontScale => _fontScale;

  void setFontScale(double scale) {
    _fontScale = scale;
    notifyListeners();
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter 认证应用',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              textTheme: ThemeData.light().textTheme.apply(
                fontSizeFactor: themeProvider.fontScale,
              ),
            ),
            home: Consumer<AuthViewModel>(
              builder: (context, authVM, child) {
                return authVM.isAuthenticated ? const HomePage() : const LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
