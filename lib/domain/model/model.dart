class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class User {
   String id;
   String email;
   String name;

  User(this.id, this.email, this.name);
}
class Authentication {
  User? user;

  Authentication(this.user);
}
