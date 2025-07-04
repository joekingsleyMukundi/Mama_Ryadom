import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class MilestonesScreen extends StatefulWidget {
  const MilestonesScreen({super.key});

  @override
  _MilestonesScreenState createState() => _MilestonesScreenState();
}

class _MilestonesScreenState extends State<MilestonesScreen> {
  List<String> milestones = [
    "Responds to own name",
    "Plays simple games like “peek-a-boo“",
    "Sits without support",
  ];

  List<Map<String, String>> notes = [
    {
      'date': '2025-04-12',
      'text': 'Vincent is very active and loves to explore.',
    },
    {'date': '2025-05-01', 'text': 'He smiled when hearing familiar voices.'},
    {'date': '2025-05-15', 'text': 'Loves peek-a-boo more every day.'},
  ];

  bool isMilestonesExpanded = true;
  bool isNotesExpanded = true;

  void _showAddMilestoneModal() {
    String newMilestone = "";

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add New Milestone",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Type new milestone",
                ),
                onChanged: (value) => newMilestone = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (newMilestone.trim().isNotEmpty) {
                    setState(() => milestones.add(newMilestone.trim()));
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNotesModal() {
    final TextEditingController noteController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Note", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: "Write a note..."),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("📅 ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                  const Spacer(),
                  TextButton(
                    child: const Text("Pick Date"),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newNote = noteController.text.trim();
                  if (newNote.isNotEmpty) {
                    setState(() {
                      notes.add({
                        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
                        'text': newNote,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add Note"),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, List<Map<String, String>>> _groupNotesByMonth() {
    final grouped = <String, List<Map<String, String>>>{};

    for (var note in notes) {
      final date = DateTime.tryParse(note['date'] ?? '') ?? DateTime.now();
      final key = DateFormat('MMMM yyyy').format(date);
      grouped.putIfAbsent(key, () => []).add(note);
    }

    return grouped;
  }

  Widget _buildNote(Map<String, String> note) {
    String formattedDate;
    try {
      final date = DateTime.parse(note['date']!);
      formattedDate = DateFormat('MMMM d, yyyy').format(date);
    } catch (e) {
      formattedDate = "Invalid date";
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📅 $formattedDate",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            note['text'] ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotes = _groupNotesByMonth();

    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text(
            "Milestones",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/child.png'),
                    radius: 40,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Vincent",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "10 months old",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Milestones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Milestones",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(
                      () => isMilestonesExpanded = !isMilestonesExpanded,
                    ),
                    child: Icon(
                      isMilestonesExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      size: 28,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              if (isMilestonesExpanded)
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    itemCount: milestones.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              milestones[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              /// Add Milestone Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showAddMilestoneModal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Add new",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Additional Info
              Text(
                "Additional Information",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "General Notes",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        setState(() => isNotesExpanded = !isNotesExpanded),
                    child: Icon(
                      isNotesExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 28,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (isNotesExpanded)
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 80),
                    children: groupedNotes.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                          const SizedBox(height: 6),
                          ...entry.value.map(_buildNote),
                          const SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ),
                ),

              const SizedBox(height: 10),

              /// Add Note Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showNotesModal,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Add Note",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
