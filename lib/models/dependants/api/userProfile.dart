class UserProfileAPIBody {
  late String sId;
  late bool firstLogin;
  late bool emailVerified;
  late bool isBlocked;
  late String firstName;
  late String lastName;
  late String emailId;
  late String phoneNumber;
  late String countryCode;
  String? initialPassword;
  late String registrationDate;

  UserProfileAPIBody({
    required this.sId,
    required this.firstLogin,
    required this.emailVerified,
    required this.isBlocked,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNumber,
    required this.countryCode,
    required this.initialPassword,
    required this.registrationDate,
  });

  UserProfileAPIBody.fromJson(Map<String, dynamic> json) {
    this.sId = json['_id'];
    this.firstLogin = json['firstLogin'];
    this.emailVerified = json['emailVerified'];
    this.isBlocked = json['isBlocked'];
    this.firstName = json['firstName'];
    this.lastName = json['lastName'];
    this.emailId = json['emailId'];
    this.phoneNumber = json['phoneNumber'];
    this.countryCode = json['countryCode'];
    this.initialPassword = json['initialPassword'];
    this.registrationDate = json['registrationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstLogin'] = this.firstLogin;
    data['emailVerified'] = this.emailVerified;
    data['isBlocked'] = this.isBlocked;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    data['initialPassword'] = this.initialPassword;
    data['registrationDate'] = this.registrationDate;
    return data;
  }
}
