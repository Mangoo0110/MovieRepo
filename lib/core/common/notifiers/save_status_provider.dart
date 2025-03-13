import 'package:flutter/cupertino.dart';

import '../../utils/func/dekhao.dart';
import '../enums/common_enums.dart';

class SaveStatusNotifier extends ChangeNotifier{
  final Key _key;
  SaveStatus _saveStatus = SaveStatus.canNotSave;

  SaveStatusNotifier(this._key);

  // getter
  SaveStatus get saveStatus => _saveStatus;

  // set

  void setSaveStatus(Key key, SaveStatus newStatus) {

    if(key != _key) {
      dekhao("Key did not match!");
      return;
    }

    dekhao("Changing saveStatus from ${_saveStatus.name} to ${newStatus.name}");
    _saveStatus = newStatus; notifyListeners();
  }
}