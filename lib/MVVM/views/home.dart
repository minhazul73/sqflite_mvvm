import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../viewModels/userController.dart';

class SqfliteExample extends StatelessWidget {
  SqfliteExample({super.key});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Enter name"),
              onSubmitted: (value) {
                userController.insertUser(User(name: value, age: 25));
                nameController.clear();
              },
            ),
            const SizedBox(height: 20),
            Obx(
                  () => userController.users.isNotEmpty
                  ? Expanded(
                child: ListView.builder(
                  itemCount: userController.users.length,
                  itemBuilder: (context, index) {
                    final user = userController.users[index];
                    return Obx(() => ListTile(
                      title: Text('Name: ${user.name.value}'),
                      subtitle: Text('Age: ${user.age.value}'),
                    ));
                  },
                ),
              )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
