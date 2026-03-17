import 'package:flutter/material.dart';
import 'package:my_draggable_scrollable_sheet/rounded_text_field.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      //true 使其能全屏
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // barrierColor: Colors.red,
      builder: (context) => DraggableScrollableSheet(
        // 初始占屏幕 60% 初始高度：屏幕占比
        initialChildSize: 0.6,
        // 最小 40%（往下拖的极限） 最小可收起到的高度
        minChildSize: 0.4,
        // 最大 100%（全屏） 最大：全屏
        maxChildSize: 1.0,
        // 必须 false
        expand: false,
        // 拖动松手后自动吸附
        snap: true,
        // 吸附到半屏 or 全屏
        snapSizes: const [0.6, 1.0],
        builder: (context, scrollController) {
          return _buildSheetBody(context, scrollController);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSheet(context),
          child: const Text('Show Sheet'),
        ),
      ),
    );
  }
}

// 弹窗主体 UI
Widget _buildSheetBody(
  BuildContext context,
  ScrollController scrollController,
) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    child: ListView(
      //联动拖拽与内部滚动
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        //拖拽条
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 24),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 12),
        //邮箱
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFB8860B),
              child: const Text(
                'U',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'usernamegoogle@gmail.com',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 20),
        //标题
        const Text(
          'Set a password',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text(
          'You signed in with Google.\nEmail sign-in is only available after you set a password.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 28),
        // ── 密码输入框 ──
        RoundedTextField(hintText: 'Password', obscureText: true),
        const SizedBox(height: 12),
        // ── 确认密码输入框 ──
        RoundedTextField(hintText: 'Confirm password', obscureText: true),
        const SizedBox(height: 20),
        // ── Save 按钮 ──
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8F5A3), // 黄绿色
              foregroundColor: Colors.black,
              elevation: 0,
              shape: StadiumBorder(), // 全圆角
            ),
            child: const Text('Save', style: TextStyle(fontSize: 16)),
          ),
        ),

        // 底部安全区域
        SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
      ],
    ),
  );
}
