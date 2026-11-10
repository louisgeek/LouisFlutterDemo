import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:provider/provider.dart';

@Preview(name: 'HomePage')
Widget previewHomePage() {
  return const HomePage();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () => _showFontSizeDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, authVM, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('欢迎, ${authVM.user?.name}!',
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                Text('邮箱: ${authVM.user?.email}'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => authVM.logout(),
                  child: const Text('退出登录'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('字体大小'),
        content: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('当前: ${(themeProvider.fontScale * 100).toInt()}%'),
                Slider(
                  value: themeProvider.fontScale,
                  min: 0.8,
                  max: 1.5,
                  divisions: 7,
                  label: '${(themeProvider.fontScale * 100).toInt()}%',
                  onChanged: (value) => themeProvider.setFontScale(value),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
