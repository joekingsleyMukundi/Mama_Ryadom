import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class DiscussionDetailScreen extends StatefulWidget {
  final Map<String, Object> post;

  const DiscussionDetailScreen({super.key, required this.post});

  @override
  State<DiscussionDetailScreen> createState() => _DiscussionDetailScreenState();
}

class _DiscussionDetailScreenState extends State<DiscussionDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  final List<Color> avatarColors = [
    Color(0xFF6D5DD3),
    Color(0xFFFF9E58),
    Color(0xFF55C2C3),
    Color(0xFF4CAF50),
    Color(0xFFEF5350),
    Color(0xFFAB47BC),
    Color(0xFF26C6DA),
  ];

  List<Map<String, dynamic>> comments = [
    {
      'user': 'Martha K.',
      'comment': 'Try a consistent routine. That helped me a lot!',
      'upvotes': 3,
      'replies': [
        {
          'user': 'Anna M.',
          'comment': 'I second this. A bedtime ritual saved us!',
          'upvotes': 2,
        },
      ],
    },
    {
      'user': 'Grace T.',
      'comment': 'Maybe white noise? It worked for us with twins.',
      'upvotes': 1,
      'replies': [],
    },
  ];

  void addComment(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      comments.add({
        'user': 'You',
        'comment': text.trim(),
        'upvotes': 0,
        'replies': [],
      });
      _commentController.clear();
    });
  }

  void addReply(int commentIndex, String replyText) {
    if (replyText.trim().isEmpty) return;
    setState(() {
      comments[commentIndex]['replies'].add({
        'user': 'You',
        'comment': replyText.trim(),
        'upvotes': 0,
      });
    });
  }

  void upvoteComment(int index, [int? replyIndex]) {
    setState(() {
      if (replyIndex != null) {
        comments[index]['replies'][replyIndex]['upvotes']++;
      } else {
        comments[index]['upvotes']++;
      }
    });
  }

  Color _getAvatarColor(String name) {
    final hash = name.hashCode;
    return avatarColors[hash % avatarColors.length];
  }

  String _getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return parts[0][0] + parts[1][0];
    }
    return name.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final userName = post['user'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(post['title'] as String),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.text),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage('assets/images/profile.png'),
              radius: 18,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Original poster with avatar
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getAvatarColor(userName),
                      child: Text(
                        _getInitials(userName),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post['full'] as String,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(height: 32),
                Text(
                  "Replies",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Comments
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: _getAvatarColor(comment['user']),
                        child: Text(
                          _getInitials(comment['user']),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(comment['user']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment['comment']),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.thumb_up_alt_outlined,
                                  size: 18,
                                ),
                                onPressed: () => upvoteComment(index),
                              ),
                              Text('${comment['upvotes']}'),
                              const SizedBox(width: 10),
                              _ReplyButton(
                                onReply: (text) => addReply(index, text),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Nested replies
                    ...List.generate(comment['replies'].length, (replyIndex) {
                      final reply = comment['replies'][replyIndex];
                      return Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: _getAvatarColor(reply['user']),
                            child: Text(
                              _getInitials(reply['user']),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(reply['user']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reply['comment']),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 18,
                                    ),
                                    onPressed: () =>
                                        upvoteComment(index, replyIndex),
                                  ),
                                  Text('${reply['upvotes']}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const Divider(height: 24),
                  ],
                );
              },
            ),
          ),

          // Add comment field
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.accent),
                    onPressed: () => addComment(_commentController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReplyButton extends StatefulWidget {
  final Function(String) onReply;

  const _ReplyButton({required this.onReply});

  @override
  State<_ReplyButton> createState() => _ReplyButtonState();
}

class _ReplyButtonState extends State<_ReplyButton> {
  bool showField = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return showField
        ? Row(
            children: [
              SizedBox(
                width: 160,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'Reply...'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: AppColors.accent),
                onPressed: () {
                  widget.onReply(_controller.text);
                  _controller.clear();
                  setState(() => showField = false);
                },
              ),
            ],
          )
        : GestureDetector(
            onTap: () => setState(() => showField = true),
            child: Text(
              "Reply",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}
