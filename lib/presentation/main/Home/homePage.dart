import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/app/di.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRenderImpl.dart';
import 'package:learning_mvvm_architecture/presentation/main/Home/HomeViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/resources/colorManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/routesManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/valueManager.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text( AppString.home,textAlign: TextAlign.center,),
            elevation: AppSize.s0,
            iconTheme: IconThemeData(color: ColorManager.white),
            backgroundColor: ColorManager.pink1,
          ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(context, _getHomeWidget(),
                      () {
                    _viewModel.start();
                  }) ??
                  Container();
            },
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text( AppString.home,textAlign: TextAlign.center,),
    //     elevation: AppSize.s0,
    //     iconTheme: IconThemeData(color: ColorManager.white),
    //     backgroundColor: ColorManager.pink1,
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.only(top: AppSize.s12),
    //     child: SingleChildScrollView(
    //       child: StreamBuilder<FlowState>(
    //         stream: _viewModel.outputState,
    //         builder: (context, snapshot) {
    //           return snapshot.data?.getScreenWidget(context, _getHomeWidget(),
    //                   () {
    //                 _viewModel.start();
    //               }) ??
    //               Container();
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _getHomeWidget() {
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outputHomeData,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBanners(snapshot.data?.banners),
            _getSection(AppString.services),
            _getServices(snapshot.data?.services),
            _getSection(AppString.exercise),
            _getExercise(snapshot.data?.exercise),
          ],
        );
      }
    );
  }

  Widget _getBanners(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map((banner) => SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    elevation: AppSize.s1_5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.white, width: AppSize.s1_5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(banner.image, fit: BoxFit.cover),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: AppSize.s250,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container(

      );
    }
  }

  Widget _getServices(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map(
                  (service) => Card(
                    elevation: AppSize.s4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.white, width: AppSize.s1_5)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s100,
                              height: AppSize.s100),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getExercise(List<Exercise>? exercises) {
    if (exercises != null) {
      return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(exercises.length, (index) {
                return InkWell(
                  onTap: () {
                    //navigate to exercises
                    Navigator.of(context).pushNamed(Routes.exerciseRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(AppSize.s12),
                    //     side: BorderSide(
                    //         color: ColorManager.white, width: AppSize.s1_5)),
                    child: Image.network(
                      exercises[index].image,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12, left: AppPadding.p12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
