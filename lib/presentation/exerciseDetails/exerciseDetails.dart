import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/domain/model/model.dart';
import 'package:learning_mvvm_architecture/presentation/exerciseDetails/ExerciseViewModel.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import '../../app/di.dart';
import '../common/stateRenderImpl.dart';
import '../resources/colorManager.dart';
import '../resources/valueManager.dart';

class ExerciseDetailsView extends StatefulWidget {
  const ExerciseDetailsView({Key? key}) : super(key: key);

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseDetailsView> {
  final ExerciseDetailsViewModel _viewModel = instance<ExerciseDetailsViewModel>();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return Scaffold(
              body:
              snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.start();
              }) ??
                  Container(),
            );
          },
        ));
  }

  Widget _getContentWidget() {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          title: Text(AppString.exercise),
          elevation: AppSize.s0,
          iconTheme: IconThemeData(
            //back button
            color: ColorManager.white,
          ),
          backgroundColor: ColorManager.primary,
          centerTitle: true,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: StreamBuilder<ExerciseDetails>(
              stream: _viewModel.outputExerciseDetails,
              builder: (context, snapshot) {
                return _getItems(snapshot.data);
              },
            ),
          ),
        ));
  }

  Widget _getItems(ExerciseDetails? exerciseDetails) {
    if (exerciseDetails != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
                exerciseDetails.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              )),
          _getSection(AppString.details),
          _getInfoText(exerciseDetails.details),
          _getSection(AppString.services),
          _getInfoText(exerciseDetails.services),
          _getSection(AppString.about),
          _getInfoText(exerciseDetails.about)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p2),
        child: Text(title, style: Theme.of(context).textTheme.headline3));
  }

  Widget _getInfoText(String info) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s12),
      child: Text(info, style: Theme.of(context).textTheme.bodyText2),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}