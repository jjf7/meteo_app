import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'shared.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final VoidCallback onSearch;

  const DialogBox(
      {super.key,
      required this.controller,
      required this.onClose,
      required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade200,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // search  weather input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Buscar una nueva ciudad"),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyCustomButton(text: 'Cancelar', onPressed: onClose),
                const SizedBox(
                  width: 10,
                ),
                MyCustomButton(text: 'Buscar', onPressed: onSearch)
              ],
            )
          ],
        ),
      ),
    );
  }
}
