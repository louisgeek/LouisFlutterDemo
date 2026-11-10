# Flutter 登录注册架构实现

## 架构说明

采用 Flutter 官方推荐的分层架构，使用 Provider 进行状态管理。

### 技术栈
- **provider**: 状态管理
- **dio**: 网络请求
- **json_serializable**: JSON 序列化
- **shared_preferences**: 本地存储

### 目录结构

```
lib/
├── core/                           # 核心层
│   ├── network/
│   │   ├── api_client.dart         # Dio 客户端
│   │   └── api_result.dart         # 统一结果封装
│   └── error/
│       ├── api_error.dart          # API 错误
│       └── error_mapper.dart       # 错误映射
│
└── feature/auth/                   # 认证功能
    ├── data/                       # 数据层
    │   ├── local/
    │   │   └── local_data_source.dart      # 本地数据源
    │   ├── remote/
    │   │   ├── model/                      # DTO
    │   │   │   ├── login_request.dart
    │   │   │   ├── login_response.dart
    │   │   │   └── register_request.dart
    │   │   └── auth_api.dart               # API 接口
    │   └── repository/
    │       └── auth_repository_impl.dart   # 仓库实现
    │
    ├── domain/                     # 领域层
    │   ├── model/
    │   │   └── user.dart                   # 业务模型
    │   └── repository/
    │       └── auth_repository.dart        # 仓库接口
    │
    └── ui/                         # UI 层
        ├── login/
        │   ├── login_page.dart
        │   ├── login_view_model.dart
        │   └── login_ui_state.dart
        ├── register/
        │   ├── register_page.dart
        │   ├── register_view_model.dart
        │   └── register_state.dart
        └── auth_view_model.dart            # 跨页面状态
```

## 使用说明

### 1. 安装依赖
```bash
flutter pub get
```

### 2. 生成 JSON 序列化代码
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. 配置 API 地址
在 `lib/main.dart` 中修改 API 基础地址：
```dart
final apiClient = ApiClient(baseUrl: 'https://your-api.com');
```

### 4. 运行应用
```bash
flutter run
```

## 功能特性

- ✅ 用户登录
- ✅ 用户注册
- ✅ 自动保存登录状态
- ✅ 退出登录
- ✅ 统一错误处理
- ✅ Loading 状态管理

## API 接口格式

### 登录接口
**POST** `/auth/login`
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**响应**:
```json
{
  "token": "jwt_token_here",
  "user": {
    "id": "user_id",
    "email": "user@example.com",
    "name": "User Name"
  }
}
```

### 注册接口
**POST** `/auth/register`
```json
{
  "email": "user@example.com",
  "password": "password123",
  "name": "User Name"
}
```

**响应**: 同登录接口

## 架构优势

1. **清晰的分层**: Data、Domain、UI 三层分离
2. **依赖倒置**: Domain 层定义接口，Data 层实现
3. **统一错误处理**: 通过 ErrorMapper 集中处理错误
4. **类型安全**: 使用 sealed class 实现 Result 模式
5. **状态管理**: Provider + ViewModel 模式
6. **本地持久化**: SharedPreferences 保存用户信息

## 扩展建议

- 添加表单验证逻辑
- 实现 Token 自动刷新
- 添加生物识别登录
- 实现记住密码功能
- 添加第三方登录（Google、Apple 等）
