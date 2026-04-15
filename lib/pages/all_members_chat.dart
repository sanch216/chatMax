import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/chat_bubble.dart';
import '../components/my_textfield.dart';
import '../provider.dart' hide chatRepositoryProvider;
import '../services/auth/auth_service.dart';
import '../states/chat_providers.dart';

class AllMembersChat extends ConsumerStatefulWidget {
  const AllMembersChat({super.key});
  @override
  ConsumerState<AllMembersChat> createState() => _AllMembersChatState();
}

class _AllMembersChatState extends ConsumerState<AllMembersChat> {
  final TextEditingController _messageController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    checkAdmin();
  }

  Future<void> checkAdmin() async {
    isAdmin = await _authService.isAdmin();
    setState(() {});
  }

  // -----------
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityChatProvider);
    final chatRepository = ref.read(chatRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Wall"),
        actions: [
          IconButton(
            onPressed: _authService.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const Text("Error"),
              data: (docs) {
                return ListView(
                  children: docs
                      .map((doc) => _buildItem(doc, chatRepository))
                      .toList(),
                );
              },
            ),
          ),
          _buildInput(chatRepository),
        ],
      ),
    );
  }

  Widget _buildItem(QueryDocumentSnapshot doc, chatRepository) {
    final data = doc.data() as Map<String, dynamic>;

    final senderID = data['senderID'];
    final isCurrentUser = senderID == _authService.getCurrentUser()?.uid;
    return GestureDetector(
      onLongPress: () async {
        if (isAdmin || isCurrentUser) {
          await chatRepository.deleteCommunityMessage(doc.id);
        }
      },
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(data['senderEmail']),
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildInput(chatRepository) {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            hintText: "Share...",
            obscuretext: false,
            controller: _messageController,
          ),
        ),
        IconButton(
          onPressed: () async {
            if (_messageController.text.isNotEmpty) {
              await chatRepository.sendCommunityMessage(
                _messageController.text,
              );
              _messageController.clear();
            }
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
