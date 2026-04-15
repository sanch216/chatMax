import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_max/data/repositories/chat_repository_impl.dart';
import 'package:chat_max/data/sources/chat_remote_data_source.dart';
import 'package:chat_max/domain/repositories/chat_repository.dart';
import 'package:chat_max/states/all_members_state_notifier.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(ChatRemoteDataSource());
});
final communityChatProvider =
    StateNotifierProvider<
      CommunityChatNotifier,
      AsyncValue<List<QueryDocumentSnapshot>>
    >((ref) {
      final repo = ref.watch(chatRepositoryProvider);
      return CommunityChatNotifier(repo);
    });
