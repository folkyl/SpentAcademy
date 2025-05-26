import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() {
    // TODO: Implement actual save logic, for now just pop and show a snackbar
    if (_titleController.text.trim().isEmpty && _contentController.text.trim().isEmpty) {
      Get.snackbar("Note Empty", "Please add a title or content before saving.",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    // Simulate saving and go back
    Get.back(result: {
      "title": _titleController.text,
      "content": _contentController.text,
    });
    Get.snackbar("Note Saved", "Your note has been added.",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFAED5FC);
    const navColor = Color(0xFF0D47A1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: navColor),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Add Note",
          style: TextStyle(
            color: navColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title input
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: const TextStyle(color: navColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              // Content input
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    labelText: "Write your note here...",
                    labelStyle: const TextStyle(color: navColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.newline,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: navColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Save Note",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}