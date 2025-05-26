import 'package:flutter/material.dart';
import 'package:spentacademy/pages/material/material_view.dart'; // Pastikan path ini sesuai dengan lokasi NoteItem

// ===== Color Palette (ambil dari material_view.dart, pastikan sama) =====
const Color kBluePale = Color(0xFFE3F2FD);
const Color kPurplePale = Color(0xFFF3E5F5);
const Color kGreenPale = Color(0xFFE8F5E9);

const List<Color> kNoteColors = [
  kBluePale,
  kPurplePale,
  kGreenPale,
];
// ======================================================================

class EditNotePage extends StatefulWidget {
  final NoteItem note;
  final int index;
  final bool isEdit;

  const EditNotePage({
    Key? key,
    required this.note,
    required this.index,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _subjectController;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _subjectController = TextEditingController(text: widget.note.subject);
    _selectedColor = widget.note.color;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  void _saveEdit() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedNote = NoteItem(
        id: widget.note.id,
        title: _titleController.text,
        content: _contentController.text,
        subject: _subjectController.text,
        createdAt: widget.note.createdAt,
        color: _selectedColor,
      );
      Navigator.pop(context, {
        'note': updatedNote,
        'index': widget.index,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Note" : "Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (v) => v == null || v.isEmpty ? "Title required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: "Subject"),
                validator: (v) => v == null || v.isEmpty ? "Subject required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: "Content"),
                maxLines: 6,
                validator: (v) => v == null || v.isEmpty ? "Content required" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Color: "),
                  ...kNoteColors.map((color) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedColor = color),
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 12,
                            child: _selectedColor == color
                                ? const Icon(Icons.check, size: 18)
                                : null,
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveEdit,
                child: Text(widget.isEdit ? "Save Changes" : "Add Note"),
              )
            ],
          ),
        ),
      ),
    );
  }
}