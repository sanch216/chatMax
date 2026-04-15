import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRemoteDataSource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getCommunityMessages() {
    return _firestore
        .collection('community')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> sendCommunityMessage(String message) async {
    final currentUser = _auth.currentUser!;
    await _firestore.collection('community').add({
      'senderID': currentUser.uid,
      'senderEmail': currentUser.email,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteMessage(String messageId, String receiveId) async {
    final currentUser = _auth.currentUser!;
    List<String> ids = [currentUser.uid, receiveId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('messages')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  Future<void> deleteCommunityMessage(String messageId) {
    return _firestore.collection('community').doc(messageId).delete();
  }
}
