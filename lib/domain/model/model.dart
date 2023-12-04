import 'package:flutter/cupertino.dart';

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
class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}
class Exercise {
  int id;
  String title;
  String image;

  Exercise(this.id, this.title, this.image);
}
class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd(this.id, this.title, this.image,this.link);
}

class HomeData {
  List<Service> services;
  List<Exercise> exercises;
  List<BannerAd> banners;

  HomeData(this.services, this.exercises, this.banners);
}

class HomeObject{
  HomeData data;

  HomeObject(this.data);
}
class ExerciseDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  ExerciseDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}