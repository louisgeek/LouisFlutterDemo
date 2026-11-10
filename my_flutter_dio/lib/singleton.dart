class Singleton {
  //静态私有实例
  static Singleton? _instance; //声明一个可 null 的变量，懒加载，第一次执行到 ??= 时初始化

  //对外入口，factory 工厂构造函数，确保只创建一个实例
  factory Singleton() => _instance ??= Singleton._internal(); //??= 空赋值运算符

  //私有构造函数
  Singleton._internal();

  void doSomething() {
    print('Singleton instance doing something');
  }
}

class Singleton2 {
  //静态私有实例
  static final Singleton2 _instance = Singleton2._internal(); //懒加载，第一次访问该变量时初始化

  //factory 工厂构造函数，确保只创建一个实例
  factory Singleton2() => _instance; //直接返回已存在的 _instance

  //私有构造函数
  Singleton2._internal();

  void doSomething() {
    print('Singleton2 instance doing something');
  }
}

// 使用
void main() {
  Singleton s1 = Singleton();
  Singleton s2 = Singleton();
  print(identical(s1, s2)); // true - 同一个实例

  Singleton2 s21 = Singleton2();
  Singleton2 s22 = Singleton2();
  print(identical(s21, s22)); // true - 同一个实例
}
