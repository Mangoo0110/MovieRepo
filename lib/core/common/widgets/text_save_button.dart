

import 'package:flutter_animate/flutter_animate.dart';

import '../notifiers/save_status_provider.dart';
import 'package:flutter/material.dart';

import '../enums/common_enums.dart';
import 'ui_button.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';


class TextSaveButton extends StatefulWidget {
  final SaveStatusNotifier saveStatusNotifier;
  final String saveText;
  /// If not provided, circular progress indicator is shown.
  final String? savingText;

  final String savedText;
  
  // Callback when user tap on the save button.
  final VoidCallback onSave;

  // Callback when notifier notifies a successful save.
  final VoidCallback onSuccess;

  final VoidCallback? onFailed;

  const TextSaveButton({super.key, required this.saveStatusNotifier, required this.onSave, required this.onSuccess, required this.saveText, this.savingText, this.onFailed, required this.savedText});

  @override
  State<TextSaveButton> createState() => _TextSaveButtonState();
}

class _TextSaveButtonState extends State<TextSaveButton> {

  SaveStatus saveStatus = SaveStatus.canNotSave;


  Color _buttonContainerColor() {
    return saveStatus == SaveStatus.canNotSave ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.failed ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.success ?
      Colors.greenAccent.shade400
      :
      AppColors.context(context).accentColor;
  }

  // Color _buttonBorderColor() {
  //   return saveStatus == SaveStatus.canNotSave ?
  //     AppColors.context(context).contentBoxGreyColor
  //     :
  //     saveStatus == SaveStatus.failed ?
  //     AppColors.context(context).errorColor
  //     :
  //     AppColors.context(context).accentColor;
  // }

  void _notify() {
    if(saveStatus == SaveStatus.success) {
      Future.delayed(Duration(milliseconds: 600)).then((_){
        widget.onSuccess();
      });
    }

    if(saveStatus == SaveStatus.failed && widget.onFailed != null) {
      Future.delayed(Duration(milliseconds: 600)).then((_){
        widget.onFailed!();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    
    //saveStatus =  context.watch<UserProfileWriteProvider>().saveStatus;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListenableBuilder(
          listenable: widget.saveStatusNotifier,
          builder: (context, child) {

            saveStatus = widget.saveStatusNotifier.saveStatus;

            _notify();
            
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // height: 50,
              // width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: _buttonContainerColor(),
                borderRadius: AppSizes.mediumBorderRadius,
                //border: Border.all(color: _buttonBorderColor(), width: 2)
              ),
              child: UiButton(
                borderRadius: AppSizes.mediumBorderRadius,
                tappable: saveStatus == SaveStatus.canSave,
                onTap: () {
                  widget.onSave();
                },
                child: 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                    child: saveStatus == SaveStatus.canNotSave ?
                    _idle().animate().fadeIn(duration: Duration(milliseconds: 200))
                    :
                    saveStatus == SaveStatus.canSave ?
                    _saveStatus().animate().fadeIn(duration: Duration(milliseconds: 200))
                    :
                    saveStatus == SaveStatus.saving ?
                    _saving().animate().fadeIn(duration: Duration(milliseconds: 200))
                    : 
                    saveStatus == SaveStatus.failed?
                    _error().animate().fadeIn(duration: Duration(milliseconds: 200))
                    :
                    _saved().animate().fadeIn(duration: Duration(milliseconds: 200)),
                  ),
              ),
            );
          }
        );
      },
    );
  }

  Widget _saving() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.context(context).accentColor,
            borderRadius: AppSizes.mediumBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 3,)),
                if(widget.savingText != null) SizedBox(width: 5,),
                if(widget.savingText != null) Text(widget.savingText!, style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
          )
        );
      },
    );

  }

  Widget _saveStatus() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Text(widget.saveText, style: Theme.of(context).textTheme.bodyMedium);
      },
    );
  }

  Widget _idle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Text(widget.saveText, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.context(context).textGreyColor));
      },
    );
  }

  Widget _saved() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done),
            SizedBox(width: 5,),
            Text("Saved", style: Theme.of(context).textTheme.bodyMedium)
          ],
        );
      },
    );
  }

  Widget _error() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.deepOrange,),
            SizedBox(width: 5,),
            Text("Error", style: Theme.of(context).textTheme.titleMedium?.copyWith(), )
          ],
        );
      },
    );

  }

}

