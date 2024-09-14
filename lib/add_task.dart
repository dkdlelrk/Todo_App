import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/main_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({required this.updateText, super.key});
  final void Function(String text) updateText;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    final addTodoText = TextEditingController();

    return Column(
      children: [
        const Text('Add Task'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            autofocus: true,
            controller: addTodoText,
            onSubmitted: (val) {
              if (addTodoText.text.isNotEmpty) {
                widget.updateText(addTodoText.text);
              }
              addTodoText.clear();
              Navigator.of(context).pop();
            },
            decoration: InputDecoration(hintText: 'Add Task'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (addTodoText.text.isNotEmpty) {
              widget.updateText(addTodoText.text);
            }
            addTodoText.clear();
            Navigator.of(context).pop();
          },
          child: const Text('Text'),
        )
      ],
    );
  }
}
