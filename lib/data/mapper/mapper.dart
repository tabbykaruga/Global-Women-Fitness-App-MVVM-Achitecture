//convert response into a non-nullable object (model)
import 'package:learning_mvvm_architecture/app/extension.dart';
import 'package:learning_mvvm_architecture/data/responses/responses.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(this?.id?.orEmpty() ?? EMPTY, this?.email?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.user?.toDomain());
  }
}

extension ForgottenPasswordMapper on ForgottenPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension ExerciseResponseMapper on ExerciseResponse? {
  Exercise toDomain() {
    return Exercise(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY,this?.link?.orEmpty() ?? EMPTY);
  }
}

extension HomeRepsonseMapper on HomeResponse? {
  HomeObject toDomain() {
    List <Service> mappedServices =(this?.data?.services?.map((service) => service.toDomain()) ?? const Iterable.empty().cast<Service>()).toList();
    List <Exercise> mappedExercises =(this?.data?.exercises?.map((exercise) => exercise.toDomain()) ??  const Iterable.empty().cast<Exercise>()).toList();
    List <BannerAd> mappedBanners =(this?.data?.banners?.map((banner) => banner.toDomain()) ??  const Iterable.empty().cast<BannerAd>()).toList();

    var data =HomeData(mappedServices,mappedExercises,mappedBanners);
    return HomeObject(data);
  }
}