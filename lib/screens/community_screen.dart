import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'discussion_detail_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Pregnancy',
      'Nutrition',
      'Postpartum',
      'Sleep',
      'Growth',
    ];

    final posts = [
      {
        'user': 'Jane M.',
        'title': 'Struggling with Sleep Training',
        'snippet': 'Any tips for sleep training my 6-month-old?',
        'full':
            'My baby wakes up every 2 hours. I’ve tried rocking, feeding, and singing but nothing works. I’d love to hear your tips!',
        'comments': 12,
      },
      {
        'user': 'Linda K.',
        'title': 'Best Iron-rich Foods?',
        'snippet': 'What foods helped your baby gain weight?',
        'full':
            'My pediatrician recommended more iron but I’m not sure what meals to prepare. Anyone with experience on that?',
        'comments': 8,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Community Forum',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) {
              final titleController = TextEditingController();
              final bodyController = TextEditingController();
              return Padding(
                padding: const EdgeInsets.all(20).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Start a Discussion",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: bodyController,
                      maxLines: 4,
                      decoration: const InputDecoration(labelText: "Message"),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Post"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Start a Discussion'),
        backgroundColor: AppColors.accent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search discussions...',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.text.withOpacity(0.6),
                ),
                filled: true,
                fillColor: AppColors.softBlue.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tags title
            Text(
              'Tags',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),

            // Category chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Chip(
                    label: Text(categories[index]),
                    backgroundColor: AppColors.softBlue,
                    labelStyle: const TextStyle(color: AppColors.primary),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Discussions
            Expanded(
              child: ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (_, __) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      post['title'] as String,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${post['user']} · ${post['snippet']}',
                          style: TextStyle(
                            color: AppColors.text.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${post['comments']} replies',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.text.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DiscussionDetailScreen(post: post),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
