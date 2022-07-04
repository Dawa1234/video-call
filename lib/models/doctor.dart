class Doctor {
  final String id;
  final String name;
  final String image;
  final String orgName;
  final String qualification;
  final String schedule;
  final String description;

  Doctor(this.id, this.name, this.image, this.orgName, this.qualification,
      this.schedule, this.description);
}

class DoctorWidgets {
  final String id;
  final String image;
  final String name;
  final String time;

  DoctorWidgets(this.id, this.image, this.name, this.time);
}

class DoctorHistoryModel {
  String? id;
  String? name;
  String? image;
  String? orgName;
  String? qualification;
  String? schedule;
  String? description;

  DoctorHistoryModel(
      {this.id,
      this.name,
      this.image,
      this.orgName,
      this.qualification,
      this.schedule,
      this.description});

  // Receiving Data from Server
  factory DoctorHistoryModel.fromMap(map) {
    return DoctorHistoryModel(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        orgName: map['orgName'],
        qualification: map['qualification'],
        schedule: map['schedule'],
        description: map['description']);
  }

// Sending data to the server in JSON format.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'orgName': orgName,
      'qualification': qualification,
      'schedule': schedule,
      'description': description,
    };
  }
}
