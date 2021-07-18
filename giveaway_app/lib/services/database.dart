import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giveaway_app/models/conferenceNO.dart';
import 'package:giveaway_app/models/donation.dart';
import 'package:giveaway_app/models/sessionNO.dart';
import 'package:giveaway_app/models/user.dart';

class DatabaseService {
  final String uid; // User Id
  DatabaseService({this.uid});

  // COLLECTIONS
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection("profiles");
  final CollectionReference conferencesCollection =
      FirebaseFirestore.instance.collection("conferences");
  final CollectionReference sessionSuggestions =
      FirebaseFirestore.instance.collection("sessionSuggestions");

  // SESSION SUGGESTIONS DATA

  List<SessionQuestion> _conferenceQuizFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SessionQuestion(
        sessionId: doc.id,
        question: doc.data()['question'],
        options: List.from(doc.data()['options']),
        required: doc.data()['required'],
        type: doc.data()['questionType'],
        answer: doc.data()['answer'],
      );
    }).toList();
  }

  Stream<List<SessionQuestion>> getQuizQuestions(String conferenceId) {
    return conferencesCollection
        .doc(conferenceId)
        .collection('sessions')
        .snapshots()
        .map(_conferenceQuizFromSnapshot);
  }

  List<Session> _conferenceSessionsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Session(
          sessionId: doc.id,
          name: doc.data()['name'],
          topics: List.from(doc.data()['topics']),
          speakers: List.from(doc.data()['speakers']),
          begin: doc.data()['begin'].toDate().toUtc().add(Duration(hours: 1)),
          end: doc.data()['end'].toDate().toUtc().add(Duration(hours: 1)),
          website: doc.data()['website'],
          description: doc.data()['description']);
    }).toList();
  }

  Stream<List<Session>> getConferenceSessions(String conferenceId) {
    return conferencesCollection
        .doc(conferenceId)
        .collection('sessions')
        .snapshots()
        .map(_conferenceSessionsFromSnapshot);
  }

  // Add User Document to Conference Suggestions Collection
  Future<void> addUserToSessionSuggestions() async {
    return await sessionSuggestions.doc(uid).set({});
  }

  // Save the Session Suggestion te User got for a certain Conference
  Future<void> addSessionSuggestion(
      String conferenceId, String sessionId) async {
    return await sessionSuggestions
        .doc(uid)
        .collection(conferenceId)
        .doc(sessionId)
        .set({});
  }

  // Get Sessions that were suggested to the user for a certain Conference
  Future<List<String>> getSuggestedSessions(String conferenceId) async {
    return await sessionSuggestions
        .doc(uid)
        .collection(conferenceId)
        .get()
        .then((value) => value.docs.map((doc) {
              return doc.id.toString();
            }).toList());
  }

  // PROFILE DATA

  // Update User Profile - Interests and District
  Future<void> updateProfile(String district, List<String> interests) async {
    return await profiles
        .doc(uid)
        .set({"district": district, "interests": interests});
  }

  // Transform database user profile info into a instance of UserData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        district: snapshot.data()['district'],
        interests: List.from(snapshot.data()['interests']));
  }

  // Get UserData stream
  Stream<UserData> get userData {
    return profiles.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Categories Stream
  Stream<List<String>> get categories {
    return conferencesCollection.snapshots().map(_categoryListFromSnapshot);
  }

  // Transform database Conference Categories into a List of category names
  List<String> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) {
          return doc.data()['category'].toString();
        })
        .toSet()
        .toList();
  }

  // CONFERENCES DATA

  // Transform database conference info into a list of Conference
  List<Donation> _conferenceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((don) {
      return Donation(
        donId: don.id,
      );
    }).toList();
  }

  // Get Conferences stream
  Stream<List<Donation>> get donations {
    return conferencesCollection.snapshots().map(_conferenceListFromSnapshot);
  }

  // Insert Conference into Database
  addConference(Conference conference) async {
    var newConference = await conferencesCollection.doc();

    newConference.set({
      'name': conference.name,
      'category': conference.category,
      'district': conference.district,
      'website': conference.website,
      'description': conference.description,
      'beginDate': conference.beginDate,
      'endDate': conference.endDate,
      'rating': conference.rating,
    });

    return newConference.id;
  }

  // Sessions

  // Insert Session into Database
  Future<void> addSession(String conferenceId, Session session) async {
    return await conferencesCollection
        .doc(conferenceId)
        .collection('sessions')
        .doc()
        .set({
      'name': session.name,
      'speakers': session.speakers,
      'topics': session.topics,
      'website': session.website,
      'description': session.description,
      'begin': session.begin,
      'end': session.end,
      'question': session.question.question,
      'answer': session.question.answer,
      'options': session.question.options,
      'questionType': session.question.type,
      'required': session.question.required
    });
  }
}
