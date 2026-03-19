import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_json_serializable/user.dart';
import 'package:my_json_serializable/user_info.dart';

import 'api_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initTest();
  }

  void _initTest() {
    //1 对象（嵌套对象、嵌套 List<Xxx>）
    UserInfo userInfo = UserInfo(nickname: "昵称001");
    List<String> names = ['张三', '李四', '王五'];

    User currentUser = User(
      id: 1,
      name: "测试用户",
      email: "test@example.com",
      members: names,
      userInfo: userInfo,
    );
    Map<String, dynamic> json = currentUser.toJson();
    print('序列化结果: $json');

    User parsedUser = User.fromJson(json);
    print('反序列化用户: ${parsedUser.name} ${parsedUser.email}');

    //2 泛型
    String jsonString =
        '{"code":200,"message":"操作成功","data":'
        '{"id":1,"name":"测试用户222","eee":"test222@example.com","members":["张三","李四","王五"],"userInfo":{"nickname":"昵称001"}}'
        '}';

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // 解析 ApiResponse<User>
    final apiResponse = ApiResponse<User>.fromJson(
      jsonMap,
      (json) => User.fromJson(json as Map<String, dynamic>),
    );

    print(
      '反序列化用户222: ${apiResponse.code} ${apiResponse.message} ${apiResponse.data?.name} ${apiResponse.data?.email}',
    );

    Map<String, dynamic> jsonMap2 = apiResponse.toJson((user) => user.toJson());

    String jsonString2 = jsonEncode(jsonMap2);
    print('序列化用户222: ${jsonString2}');

    //3 泛型列表
    String jsonString_liebiao =
        '{"code":200,"message":"操作成功","data":'
        '[{"id":1,"name":"测试用户222","eee":"test222@example.com","members":["张三","李四","王五"],"userInfo":{"nickname":"昵称001"}},'
        '{"id":2,"name":"测试用户333","eee":"test3333@example.com","members":["张三3","李四3","王五3"],"userInfo":{"nickname":"昵称003"}}]'
        '}';
    Map<String, dynamic> jsonMap_liebiao = jsonDecode(jsonString_liebiao);

    // 解析 ApiResponse<List<User>>
    final apiResponse2 = ApiResponse<List<User>>.fromJson(
      jsonMap_liebiao,
      (json) => (json as List)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

    print(
      '反序列化用户333: ${apiResponse2.code} ${apiResponse2.message} ${apiResponse2.data?.first.name} ${apiResponse2.data?.first.email} ${apiResponse2.data?.last.name} ${apiResponse2.data?.last.email}',
    );

    Map<String, dynamic> jsonMap_liebiao_3 = apiResponse2.toJson(
      (userList) => userList.map((user) => user.toJson()).toList(),
    );
    String jsonString3 = jsonEncode(jsonMap_liebiao_3);
    print('序列化用户333: $jsonString3');
  }
}
