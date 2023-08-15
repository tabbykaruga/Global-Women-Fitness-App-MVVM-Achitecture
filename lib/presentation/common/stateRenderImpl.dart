import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_mvvm_architecture/data/mapper/mapper.dart';
import 'package:learning_mvvm_architecture/presentation/common/stateRender.dart';
import 'package:learning_mvvm_architecture/presentation/resources/stringManager.dart';

abstract class FlowState {
  StateRenderType getStateRenderType();
  String getMessage();
}

//loading state (POPUP ,FULL SCREEN)
class LoadingState extends FlowState {
  late StateRenderType stateRenderType;
  String message;

  LoadingState({required this.stateRenderType, String? message})
      : message = message ?? AppString.loading;

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

// error state (POPUP ,FULL LOADING)
class ErrorState extends FlowState {
  late StateRenderType stateRenderType;
   String message;

  ErrorState({required this.stateRenderType, String? message}):message =message ?? AppString.retryAgain;

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

//success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.popupSuccessState;
}

//CONTENT STATE
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRenderType getStateRenderType() => StateRenderType.contentScreenState;
}

//CONTENT STATE
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => EMPTY;

  @override
  StateRenderType getStateRenderType() => StateRenderType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
      BuildContext context, Widget contentScreenWidget, Function retryAction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRenderType() == StateRenderType.popupLoadingState) {
            //showing popup dialog
            showPopup(context, getStateRenderType(), getMessage());
            //return the content ui of the screen
            return contentScreenWidget;
          } else {
            return StateRender(
                stateRenderType: getStateRenderType(),
                message: getMessage(),
                retryAction: retryAction);
            StateRenderType.fullscreenLoadingState;
          }
        }
      case ErrorState:
      {
        dismissDialog(context);
        if (getStateRenderType() == StateRenderType.popupErrorState) {
          //showing popup dialog
          showPopup(context, getStateRenderType(), getMessage());
          //return the content ui of the screen
          return contentScreenWidget;
        } else {
          return StateRender(
              stateRenderType: getStateRenderType(),
              message: getMessage(),
              retryAction: retryAction);
        }
      }
      case SuccessState:
        {
          dismissDialog(context);

          showPopup(context, StateRenderType.popupSuccessState, getMessage(),title:AppString.success);

          return contentScreenWidget;
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRender(
              stateRenderType: getStateRenderType(),
              message: getMessage(),
              retryAction: retryAction);
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup( BuildContext context, StateRenderType stateRenderType, String message,{String title = EMPTY}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRender(
              stateRenderType: stateRenderType,
              message: message,
              title: title,
              retryAction: () {},
            )));
  }

}
