class UserLoginDetails {
  String username;
  String password;
  UserLoginDetails({this.username, this.password});

  Map<String, String> get toLoginApiJSON {
    return {
      "emailId": this.username,
      "password": this.password,
    };
  }
}
