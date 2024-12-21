import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Thông báo thay đổi
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Listen: false Example')),
          body: CounterPage(),
        ),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ở đây, chúng ta không muốn widget tự động cập nhật lại, chỉ lấy giá trị hiện tại
    final count = Provider.of<Counter>(context, listen: false).count;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current Count: $count', style: TextStyle(fontSize: 30)),
          ElevatedButton(
            onPressed: () {
              // Dùng 'listen: false' để không tự động rebuild khi gọi phương thức increment
              Provider.of<Counter>(context, listen: false).increment();
            },
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
