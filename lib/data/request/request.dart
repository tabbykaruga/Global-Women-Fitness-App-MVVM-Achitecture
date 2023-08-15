class LoginRequest{
  String email ;
  String password;

  LoginRequest(this.email,this.password);

}

class RegisterRequest{
  String countryCode ;
  String userName;
  String email;
  String phoneNo;
  String password;
  String profilePicture;

  RegisterRequest(this.countryCode,this.userName,this.phoneNo,this.email,this.password,this.profilePicture);

}