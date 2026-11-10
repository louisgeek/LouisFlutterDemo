import '../GlobalConfigManager.dart';

/// 应用环境
enum AppEnvironment {
  dev(
    terminalId: '8',
    accessKey: '234234',
    signSecretKey: '353453434',
  ),
  awscntest(
    terminalId: '1001755000443731056',
    accessKey: '8vmUcW',
    signSecretKey: '9f5276f21f63aa7795e239334d9a70a3',
  ),
  prod(
    terminalId: '1001753170533810666',
    accessKey: '15ftgG',
    signSecretKey: 'prod_secret_key',
  );

  final String terminalId;
  final String accessKey;
  final String signSecretKey;

  const AppEnvironment({
    required this.terminalId,
    required this.accessKey,
    required this.signSecretKey,
  });
}

class AppConfig {
  static Future<AppEnvironment> getCurrentEnvironment() async {
    final envName = await GlobalConfigManager.getEnvironment();
    return AppEnvironment.values.firstWhere(
      (e) => e.name == envName.toLowerCase(),
      orElse: () => AppEnvironment.prod,
    );
  }
}

// 使用
final env = await AppConfig.getCurrentEnvironment();

final baseUrl = env.baseUrl;
final accessKey = env.accessKey;
