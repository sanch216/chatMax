import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repositories/chat_repository.dart';

class CommunityChatNotifier
    extends StateNotifier<AsyncValue<List<QueryDocumentSnapshot>>> {
  final ChatRepository repo;

  CommunityChatNotifier(this.repo) : super(const AsyncLoading()) {
    listenMessages();
  }

  void listenMessages() {
    repo.getCommunityMessages().listen((snapshot) {
      state = AsyncData(snapshot.docs);
    });
  }
}