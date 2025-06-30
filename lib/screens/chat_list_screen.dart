import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChildProfile {
  String name;
  String age;
  String gender;
  Color avatarColor;

  ChildProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.avatarColor,
  });
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChildProfile> children = [];

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'Male';
  int _currentIndex = 0;

  final List<Color> _avatarColors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
    Colors.cyan.shade100,
    Colors.amber.shade100,
    Colors.indigo.shade100,
  ];

  Color _getRandomColor() {
    final random = Random();
    return _avatarColors[random.nextInt(_avatarColors.length)];
  }

  void _openAddChildModal({ChildProfile? child, int? indexToUpdate}) {
    if (child != null) {
      _nameController.text = child.name;
      _ageController.text = child.age;
      _selectedGender = child.gender;
    } else {
      _nameController.clear();
      _ageController.clear();
      _selectedGender = 'Male';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final mediaQuery = MediaQuery.of(ctx);
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: mediaQuery.viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                indexToUpdate != null
                    ? 'Edit Child Profile'
                    : 'Add Child Profile',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (val) => setState(() {
                  _selectedGender = val ?? 'Male';
                }),
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text.trim();
                  final age = _ageController.text.trim();
                  if (name.isNotEmpty && age.isNotEmpty) {
                    setState(() {
                      if (indexToUpdate != null) {
                        children[indexToUpdate] = ChildProfile(
                          name: name,
                          age: age,
                          gender: _selectedGender,
                          avatarColor: children[indexToUpdate].avatarColor,
                        );
                      } else {
                        children.add(
                          ChildProfile(
                            name: name,
                            age: age,
                            gender: _selectedGender,
                            avatarColor: _getRandomColor(),
                          ),
                        );
                      }
                    });
                    Navigator.pop(ctx);
                  }
                },
                child: Text(
                  indexToUpdate != null ? 'Save Changes' : 'Add Profile',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(ctx);
              _openAddChildModal(child: children[index], indexToUpdate: index);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              setState(() {
                children.removeAt(index);
              });
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    if (index == 2) {
      // Don’t change currentIndex
      Navigator.pushNamed(context, '/settings');
    } else {
      // Only update for Chat List or Direct Chat
      setState(() => _currentIndex = index);
      if (index == 1) {
        Navigator.pushNamed(context, '/chat');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true, // Important for floating effect
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Chats',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: AppColors.text,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: _openAddChildModal,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 80,
        ), // Ensures chat list scrolls above nav bar
        child: children.isEmpty
            ? Center(
                child: Text(
                  'No profiles added yet.\nTap "+" to add a child profile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.text.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                itemCount: children.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, index) {
                  final child = children[index];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.inputBorder),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: child.avatarColor,
                      child: Text(
                        child.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    title: Text(
                      child.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    subtitle: Text(
                      'Age: ${child.age}   |   Gender: ${child.gender}',
                      style: TextStyle(
                        color: AppColors.text.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => _showOptions(index),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/chat', arguments: child);
                    },
                  );
                },
              ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color.fromARGB(240, 238, 238, 238),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.text.withOpacity(0.4),
                showUnselectedLabels: true,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Chat List',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline),
                    label: 'Direct Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
