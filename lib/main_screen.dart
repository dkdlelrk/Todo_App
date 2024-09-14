import 'package:flutter/material.dart';
import 'package:todo/add_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];
  late SharedPreferences prefs;
  int delIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData(); // 앱 시작 시 데이터 로드
  }

  // SharedPreferences에 저장된 데이터 불러오기
  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('data') ?? [];
    });
  }

  // 할 일 목록 추가 및 저장
  void updateText(String val) async {
    if (todoList.contains(val)) {
      return;
    }
    setState(() {
      todoList.insert(0, val);
    });
    prefs.setStringList('data', todoList); // 데이터 저장
  }

  // 할 일 목록 삭제 및 저장
  void ShowDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: 100,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Delete Data?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          todoList.removeAt(index);
                          delIndex = index; // 인자로 받은 index로 삭제
                          Navigator.of(context).pop();
                        });
                        prefs.setStringList('data', todoList); // 삭제 후 데이터 저장
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Text('Drawer'),
      ),
      appBar: AppBar(
        title: const Text('ToDo App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: AddTask(
                        updateText: updateText, // 새로운 할 일 추가
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                  delIndex = index; // 인자로 받은 index로 삭제
                });
                prefs.setStringList('data', todoList);
              },
              child: ListTile(
                title: Text(todoList[index].toString()),
                trailing: IconButton(
                  onPressed: () {
                    ShowDialog(index); // 삭제 다이얼로그 호출 시 index 전달
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: AddTask(
                    updateText: updateText, // 새로운 할 일 추가
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
