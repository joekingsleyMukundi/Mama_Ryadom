import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DirectChatScreen extends StatelessWidget {
  const DirectChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Ask AI Directly',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.text),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                // Placeholder message
                ChatBubble(
                  message: "Hi there, how can I support you today?",
                  isFromAI: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      filled: true,
                      fillColor: AppColors.softBlue.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // TODO: Send message
                  },
                  icon: const Icon(Icons.send, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isFromAI;

  const ChatBubble({super.key, required this.message, required this.isFromAI});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isFromAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isFromAI
              ? AppColors.softBlue.withOpacity(0.3)
              : AppColors.accent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(message, style: const TextStyle(color: AppColors.text)),
      ),
    );
  }
}
