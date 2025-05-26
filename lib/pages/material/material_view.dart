import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spentacademy/pages/notes/edit_note.dart';

// ===== Color Palette =====
const Color kBlueDarkest = Color(0xFF0D47A1);
const Color kBlueDark = Color(0xFF1152B6);
const Color kBlueMain = Color(0xFF225685);
const Color kBlueAccent = Color(0xFF3777C2);
const Color kBlueLight = Color(0xFF4285F4);
const Color kBlueVeryLight = Color(0xFFAED5FC);
const Color kBluePale = Color(0xFFE3F2FD);

const Color kRedMain = Color(0xFFFD6C6C);
const Color kRedAccent = Color(0xFFFF8989);
const Color kRedLight = Color(0xFFFFD5D5);

const Color kGreenMain = Color(0xFF60EF7E);
const Color kGreenAccent = Color(0xFF25C685);
const Color kGreenLight = Color(0xFFB1F5D9);

const Color kOrangeAccent = Color(0xFFFEB564);

const List<Color> kNoteColors = [
  kBluePale,
  Color(0xFFF3E5F5),
  Color(0xFFE8F5E9),
  kRedLight,
  kGreenLight,
];
// =========================

// Dummy QuizController (pakai Get)
class QuizController extends GetxController {
  final questions = List.generate(10, (_) => {});
  final score = 7.obs;
  final userAnswers = [true, false, true, true, true, false, true, true, true, false];
}

// Data model
class MaterialItem {
  final String title;
  final String subtitle;
  final String content;

  MaterialItem({
    required this.title,
    required this.subtitle,
    required this.content,
  });
}

class NoteItem {
  final String id;
  final String title;
  final String content;
  final String subject;
  final DateTime createdAt;
  final Color color;

  NoteItem({
    required this.id,
    required this.title,
    required this.content,
    required this.subject,
    required this.createdAt,
    required this.color,
  });
}

class MaterialView extends StatefulWidget {
  const MaterialView({super.key});
  @override
  State<MaterialView> createState() => _MaterialViewState();
}

class _MaterialViewState extends State<MaterialView> {
  int selectedTab = 0;
  int bottomNavIndex = 2;

  final List<MaterialItem> materials = [
    MaterialItem(
      title: "Square Root (Akar Kuadrat)",
      subtitle: "Matematika",
      content: '''
🌟 **Square Root** adalah operasi matematika yang sangat berguna dan sering dijumpai di kehidupan sehari-hari. 
Akar kuadrat dari sebuah bilangan adalah nilai yang, jika dikalikan dengan dirinya sendiri, menghasilkan bilangan tersebut.

---

**Contoh:**
- √9 = 3, karena 3 × 3 = 9
- √25 = 5, karena 5 × 5 = 25

---

**Mengapa Penting?**
- Digunakan dalam menghitung panjang sisi segitiga (Teorema Pythagoras)
- Membantu dalam sains, teknik, dan keuangan (misal, menghitung standar deviasi)

---

**Tips Mudah:**
- Angka-angka yang hasil akar kuadratnya bulat disebut *perfect square* (1, 4, 9, 16, 25, dst).
- Untuk bilangan lain, gunakan kalkulator atau metode pendekatan seperti metode Newton.

---

✨ **Fun Fact:** Lambang akar “√” pertama kali digunakan oleh matematikawan Jerman, Christoph Rudolff, pada tahun 1525!
''',
    ),
    MaterialItem(
      title: "Newton's Laws of Motion",
      subtitle: "Fisika",
      content: '''
🚀 **Hukum Newton** adalah tiga hukum fundamental yang menjelaskan bagaimana objek bergerak. Pengetahuan ini menjadi dasar dunia fisika modern!

---

1️⃣ **Hukum I - Inersia**
> “Sebuah benda akan tetap diam atau bergerak lurus beraturan kecuali ada gaya yang bekerja padanya.”

**Aplikasi:** Saat bus tiba-tiba berhenti, tubuhmu terdorong ke depan? Itu efek inersia!

---

2️⃣ **Hukum II - Percepatan**
> “Percepatan sebuah benda berbanding lurus dengan gaya total yang bekerja dan berbanding terbalik dengan massanya.”

**Rumus:** F = m × a (Gaya = massa × percepatan)

---

3️⃣ **Hukum III - Aksi Reaksi**
> “Setiap aksi selalu ada reaksi yang sama besar dan berlawanan arah.”

**Aplikasi:** Ketika kamu melompat, kakimu mendorong lantai ke bawah, lantai membalas mendorongmu ke atas.

---

🔥 **Kesimpulan:** Tanpa hukum Newton, roket tidak bisa terbang, mobil tidak bisa berjalan, dan kamu tidak bisa melompat!
''',
    ),
    MaterialItem(
      title: "Periodic Table (Tabel Periodik)",
      subtitle: "Kimia",
      content: '''
🔬 **Tabel Periodik** adalah “peta dunia” bagi para ilmuwan kimia. Di sinilah semua unsur kimia tersusun rapi berdasarkan sifat dan nomor atomnya.

---

**Bagaimana Cara Membacanya?**
- **Grup:** Kolom vertikal, unsur dalam grup yang sama punya sifat kimia mirip.
- **Periode:** Baris horizontal, menunjukkan jumlah kulit elektron.
- **Blok warna:** Menunjukkan jenis unsur (logam, non-logam, metaloid).

---

**Kelompok Istimewa:**
- 💎 **Noble Gases** (Gas Mulia): Stabil, tidak mudah bereaksi (He, Ne, Ar, dsb)
- 🔥 **Alkali**: Sangat reaktif (Li, Na, K, dsb)
- 🌱 **Halogen**: Kerap ditemukan dalam garam (F, Cl, Br, dsb)

---

✨ **Fun Fact:** Nama unsur “Helium” diambil dari kata "Helios" (Matahari), karena pertama kali ditemukan di spektrum cahaya matahari!
''',
    ),
    MaterialItem(
      title: "Climate Zones (Zona Iklim)",
      subtitle: "Geografi",
      content: '''
🌏 **Zona Iklim** membagi Bumi menjadi berbagai wilayah berdasarkan suhu, curah hujan, dan pola cuaca.

---

**Jenis-Jenis Zona Iklim:**
- 🌴 **Tropis:** Panas & lembap sepanjang tahun (Indonesia, Brasil)
- 🏜️ **Kering/Arid:** Sedikit hujan, banyak gurun (Sahara, Australia Tengah)
- 🍁 **Sedang/Temperate:** Empat musim (Jepang, Eropa)
- ❄️ **Dingin/Polar:** Sangat dingin, salju abadi (Antartika, Greenland)

---

**Mengapa Penting?**
Zona iklim mempengaruhi pertanian, perencanaan kota, bahkan budaya dan makanan lokal!

---

✨ **Tahukah kamu?** Indonesia adalah negara dengan iklim tropis, makanya kaya akan hutan hujan dan keanekaragaman hayati!
''',
    ),
  ];

  List<NoteItem> notes = [
    NoteItem(
      id: "1",
      title: "Physics Formulas",
      content: "F = ma\nKinetic Energy = 1/2mv²\nPotential Energy = mgh",
      subject: "Physics",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      color: kBluePale,
    ),
    NoteItem(
      id: "2",
      title: "Math Shortcuts",
      content: "Square root approximation methods\n- Babylonian method\n- Newton's method",
      subject: "Math",
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      color: Color(0xFFF3E5F5),
    ),
    NoteItem(
      id: "3",
      title: "Chemistry Elements",
      content: "Noble gases: He, Ne, Ar, Kr, Xe, Rn\nAlkali metals: Li, Na, K, Rb, Cs, Fr",
      subject: "Chemistry",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      color: Color(0xFFE8F5E9),
    ),
  ];

  void _navigateToAddNote() async {
    final newNote = NoteItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: "",
      content: "",
      subject: "",
      createdAt: DateTime.now(),
      color: kBluePale,
    );
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EditNotePage(
          note: newNote,
          index: 0,
          isEdit: false,
        ),
      ),
    );

    if (result != null && result['note'] != null) {
      setState(() {
        notes.insert(0, result['note'] as NoteItem);
      });
    }
  }

  void _navigateToEditNote(NoteItem note, int idx) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EditNotePage(
          note: note,
          index: idx,
          isEdit: true,
        ),
      ),
    );

    if (result != null && result['note'] != null) {
      setState(() {
        notes[result['index'] as int] = result['note'] as NoteItem;
      });
    }
  }

  void _showNoteModal(NoteItem note) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NoteDetailModal(note: note),
    );
  }

  void _showMaterialDetail(MaterialItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MaterialDetailModal(item: item),
    );
  }

  void _onNavTap(int idx) {
    setState(() => bottomNavIndex = idx);
    switch (idx) {
      case 0:
        if (Get.routing.route?.settings.name != null) {
          Get.offAllNamed('/home');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
        break;
      case 1:
        if (Get.routing.route?.settings.name != null) {
          Get.offAllNamed('/quiz');
        } else {
          Navigator.pushReplacementNamed(context, '/quiz');
        }
        break;
      case 2:
        break;
      case 3:
        if (Get.routing.route?.settings.name != null) {
          Get.offAllNamed('/profile');
        } else {
          Navigator.pushReplacementNamed(context, '/profile');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Discover",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    hintText: selectedTab == 0 ? "Search materials..." : "Search notes...",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: Icon(Icons.search, color: Colors.grey[400], size: 24),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 52, minHeight: 52),
                  ),
                  style: const TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MaterialTabCard(
                  selectedTab: selectedTab,
                  onTabChanged: (tab) => setState(() => selectedTab = tab),
                  onAddNote: _navigateToAddNote,
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.all(24),
                      itemCount: materials.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, idx) {
                        final item = materials[idx];
                        return MaterialListCard(
                          item: item,
                          onViewMaterial: () => _showMaterialDetail(item),
                        );
                      },
                    ),
                    notes.isEmpty
                        ? _buildEmptyNotesView()
                        : _buildNotesListView(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: bottomNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildEmptyNotesView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.note_add_outlined,
                size: 40,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "No notes yet",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Create your first note using the + button",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesListView() {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: notes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, idx) {
        final note = notes[idx];
        return NoteCard(
          note: note,
          onTap: () => _showNoteModal(note),
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Note'),
                content: const Text('Are you sure you want to delete this note?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  TextButton(
                    child: const Text('Delete', style: TextStyle(color: kRedMain)),
                    onPressed: () {
                      setState(() {
                        notes.removeAt(idx);
                      });
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
            );
          },
          onEdit: () => _navigateToEditNote(note, idx),
        );
      },
    );
  }
}

class NoteCard extends StatelessWidget {
  final NoteItem note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    this.onEdit,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kBlueDark.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kBlueDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    note.subject,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kBlueDark,
                    ),
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit' && onEdit != null) {
                      onEdit!();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20, color: Color(0xFF2C3E50)),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: kRedMain),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: kRedMain)),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(note.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NoteDetailModal extends StatelessWidget {
  final NoteItem note;

  const NoteDetailModal({super.key, required this.note});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kBlueDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    note.subject,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kBlueDark,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 24),
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatDate(note.createdAt),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: note.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: kBlueDark.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      note.content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2C3E50),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialTabCard extends StatelessWidget {
  final int selectedTab;
  final void Function(int) onTabChanged;
  final VoidCallback onAddNote;
  final List<Widget> children;

  const MaterialTabCard({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onAddNote,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -8,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: kBlueDark,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Row(
                  children: [
                    _TabButton(
                      label: "Material",
                      selected: selectedTab == 0,
                      onTap: () => onTabChanged(0),
                    ),
                    _TabButton(
                      label: "My Notes",
                      selected: selectedTab == 1,
                      onTap: () => onTabChanged(1),
                    ),
                    if (selectedTab == 1) ...[
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: onAddNote,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kBlueDark,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: kBlueDark.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    height: 2,
                    decoration: BoxDecoration(
                      color: selectedTab == 0 ? kBlueDark : Colors.transparent,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    height: 2,
                    decoration: BoxDecoration(
                      color: selectedTab == 1 ? kBlueDark : Colors.transparent,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: children[selectedTab],
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: selected ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? kBlueDark : Colors.grey[500],
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class MaterialListCard extends StatelessWidget {
  final MaterialItem item;
  final VoidCallback onViewMaterial;

  const MaterialListCard({super.key, required this.item, required this.onViewMaterial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kBlueDark.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kBlueDark.withOpacity(0.1),
                      kBlueDark.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: kBlueDark,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF2C3E50),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onViewMaterial,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kBlueDark),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "View Material",
                    style: TextStyle(
                      fontSize: 14,
                      color: kBlueDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: kBlueDarkest,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Material'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

// Modal untuk menampilkan detail materi
class MaterialDetailModal extends StatelessWidget {
  final MaterialItem item;
  const MaterialDetailModal({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Row(
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: kBlueDark,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 24),
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              item.subtitle,
              style: const TextStyle(
                color: kBlueAccent,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Divider(thickness: 1, height: 18),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: SelectableText(
                item.content,
                style: const TextStyle(
                  color: Color(0xFF2C3E50),
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}