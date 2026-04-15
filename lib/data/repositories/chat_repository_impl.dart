import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/chat_repository.dart';
import '../sources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remote;
  ChatRepositoryImpl(this.remote);

  @override
  Stream<QuerySnapshot> getCommunityMessages() {
    return remote.getCommunityMessages();
  }

  @override
  Future<void> sendCommunityMessage(String message) {
    return remote.sendCommunityMessage(message);
  }

  @override
  Future<void> deleteMessage(String messageId, String receiveId) {
    return remote.deleteMessage(messageId, receiveId);
  }

  @override
  Future<void> deleteCommunityMessage(String messageId) {
    return remote.deleteCommunityMessage(messageId);
  }
}