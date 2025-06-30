import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {'text': 'Hi there! 👋', 'isMe': true},
    {'text': 'Hello! How can I help you today?', 'isMe': false},
    {'text': 'I need some advice about feeding.', 'isMe': true},
    {'text': 'Sure! What would you like to know?', 'isMe': false},
  ];

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'text': text, 'isMe': true});
      });
      _messageController.clear();

      // Scroll to bottom after adding new message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true, // Ensures proper keyboard handling
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: AppColors.primary),
            title: Text(
              'John',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat messages area - takes remaining space
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: _getHorizontalPadding(constraints.maxWidth),
                    vertical: 16,
                  ),
                  reverse: false, // Changed to false for better UX
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _buildMessageBubble(msg, constraints.maxWidth);
                  },
                );
              },
            ),
          ),
          // Input field - fixed at bottom
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg, double screenWidth) {
    final isMe = msg['isMe'] as bool;
    final maxBubbleWidth = _getMaxBubbleWidth(screenWidth);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: maxBubbleWidth,
          minWidth: 80, // Minimum width for small messages
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary.withOpacity(0.9) : AppColors.softBlue,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: isMe
                ? const Radius.circular(18)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          msg['text'],
          style: GoogleFonts.poppins(
            color: isMe ? Colors.white : AppColors.text,
            fontSize: _getFontSize(screenWidth),
            height: 1.4, // Better line spacing
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(constraints.maxWidth),
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 44,
                        maxHeight: 120, // Allows for multiline input
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softBlue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: null, // Allows multiline input
                        textInputAction: TextInputAction.newline,
                        style: GoogleFonts.poppins(
                          fontSize: _getFontSize(constraints.maxWidth),
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: _getFontSize(constraints.maxWidth),
                            color: Colors.grey[600],
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: _sendMessage,
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Responsive helper methods
  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < 360) {
      return 12; // Small phones
    } else if (screenWidth < 600) {
      return 16; // Regular phones
    } else if (screenWidth < 900) {
      return 24; // Large phones/small tablets
    } else {
      return 32; // Tablets and larger screens
    }
  }

  double _getMaxBubbleWidth(double screenWidth) {
    if (screenWidth < 360) {
      return screenWidth * 0.8; // 80% on very small screens
    } else if (screenWidth < 600) {
      return screenWidth * 0.75; // 75% on phones
    } else if (screenWidth < 900) {
      return screenWidth * 0.65; // 65% on large phones
    } else {
      return 400; // Fixed max width on tablets
    }
  }

  double _getFontSize(double screenWidth) {
    if (screenWidth < 360) {
      return 13; // Smaller font on very small screens
    } else if (screenWidth < 600) {
      return 14; // Standard font size
    } else {
      return 15; // Slightly larger on bigger screens
    }
  }
}
