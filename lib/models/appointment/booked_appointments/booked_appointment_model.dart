import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rrt_client_web_app/models/appointment/schedule.dart';

class BookedAppointmentModel {
  String? docId;
  String? appId;
  String? clientId;
  Timestamp? createdAt;
  Timestamp? appCreatedAt;
  String? nurseId;
  Schedule? schedule;
  String? status;

  BookedAppointmentModel(
      {this.docId,
      this.appId,
      this.clientId,
      this.createdAt,
      this.appCreatedAt,
      this.nurseId,
      this.schedule,
      this.status});

  BookedAppointmentModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    docId = doc.id;
    appId = doc['appId'];
    clientId = doc['clientId'];
    createdAt = doc['createdAt'];
    appCreatedAt = doc['appCreatedAt'];
    nurseId = doc['nurseId'];
    schedule = Schedule.fromDocumentSnapshot(doc['schedule']);
    status = doc['status'];
  }

  Map<String, dynamic> toJson() => {'appId': appId, 'clientId': clientId ,'createdAt': createdAt, 'appCreatedAt': appCreatedAt, 'nurseId': nurseId, 'schedule': schedule?.toJson(), 'status': status};
}
