class Customer {
  String? uid, first_name, last_name, email, imageURL1, imageURL2;
  bool? isCustomer;
  bool? isNormalUser;
  bool? isGoogleUser;
  bool? isFormCompleted;

  Customer({
    this.uid,
    this.first_name,
    this.last_name,
    this.email,
    this.imageURL1,
    this.imageURL2,
    this.isCustomer,
    this.isNormalUser,
    this.isGoogleUser,
    this.isFormCompleted,
  });

  // Receiving Data from Server
  factory Customer.fromMap(map) {
    return Customer(
      uid: map['uid'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      imageURL1: map['imageURL1'],
      imageURL2: map['imageURL2'],
      isCustomer: map['isCustomer'],
      isNormalUser: map['isNormalUser'],
      isGoogleUser: map['isGoogleUser'],
      isFormCompleted: map['isFormCompleted'],
    );
  }

// Sending data to the server in JSON format.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'imageURL1': imageURL1,
      'imageURL2': imageURL2,
      'isCustomer': isCustomer,
      'isNormalUser': isNormalUser,
      'isGoogleUser': isGoogleUser,
      'isFormCompleted': isFormCompleted,
    };
  }
}

class DoctorModel {
  String? uid, first_name, last_name, email, imageURL1, imageURL2;
  bool? isCustomer;
  bool? isNormalUser;
  bool? isGoogleUser;
  bool? isDoctor;
  bool? isFormCompleted;

  DoctorModel({
    this.uid,
    this.first_name,
    this.last_name,
    this.email,
    this.imageURL1,
    this.imageURL2,
    this.isCustomer,
    this.isNormalUser,
    this.isGoogleUser,
    this.isFormCompleted,
    this.isDoctor,
  });

  // Receiving Data from Server
  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      uid: map['uid'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      imageURL1: map['imageURL1'],
      imageURL2: map['imageURL2'],
      isCustomer: map['isCustomer'],
      isNormalUser: map['isNormalUser'],
      isGoogleUser: map['isGoogleUser'],
      isFormCompleted: map['isFormCompleted'],
      isDoctor: map['isDoctor'],
    );
  }

// Sending data to the server in JSON format.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'imageURL1': imageURL1,
      'imageURL2': imageURL2,
      'isCustomer': isCustomer,
      'isNormalUser': isNormalUser,
      'isGoogleUser': isGoogleUser,
      'isFormCompleted': isFormCompleted,
      'isDoctor': isDoctor,
    };
  }
}
