import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/data/mapper/mapper.dart';
import 'package:learning_mvvm_architecture/presentation/resources/assetsManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/colorManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/fontManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/styleManager.dart';
import 'package:learning_mvvm_architecture/presentation/resources/valueManager.dart';
import 'package:lottie/lottie.dart';

import '../../data/network/failure.dart';

enum StateRenderType {
  //POPUP STATE
  popupLoadingState,
  popupErrorState,

  //FULL SCREEN STATE
  fullscreenLoadingState,
  fullscreenErrorState,
  contentScreenState,
  emptyScreenState,
}

class StateRender extends StatelessWidget {
  StateRenderType stateRenderType;
  String message, title;
  Function? retryAction;

  StateRender(
      {Key? key,
      required this.stateRenderType,
      String? message,
      String? title,
      required this.retryAction})
      : message = message ?? AppString.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){
    switch(stateRenderType){
      case StateRenderType.popupLoadingState:
        return  _getPopupDialog(context,[_getAnimatedImage(JsonAssets.loading)]);
      case StateRenderType.popupErrorState:
        return  _getPopupDialog(context,[_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton(AppString.OK,context)]);
      case StateRenderType.fullscreenLoadingState:
       return  _getItemsInColumn([_getAnimatedImage(JsonAssets.loading),_getMessage(message)]);
      case StateRenderType.fullscreenErrorState:
        return  _getItemsInColumn([_getAnimatedImage(JsonAssets.error),_getMessage(message),_getRetryButton(AppString.retryAgain,context)]);
      case StateRenderType.contentScreenState:
        return Container();
      case StateRenderType.emptyScreenState:
        return  _getItemsInColumn([_getAnimatedImage(JsonAssets.noData),_getMessage(message)]);
      default :
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14)
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(AppSize.s0,AppSize.s12))]
        ),
        child: _getDialogContent(context,children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context,List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(message,style: getMediumStyle(color: ColorManager.black,fontSize:FontSizeManager.s16),),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle ,BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(onPressed: (){
            if(stateRenderType == StateRenderType.fullscreenErrorState){
              retryAction ?.call(); //to call the API function again
            }else{
              Navigator.of(context).pop();//dismiss the pop up error dialog
            }
          },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        ],
      ),
    );
  }
}
