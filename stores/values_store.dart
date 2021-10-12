import 'package:mobx/mobx.dart';
part 'values_store.g.dart';

class ValuesStore = _ValuesStore with _$ValuesStore;

abstract class _ValuesStore with Store{
  //Defina a lógica do seu controller aqui !
  @observable
  bool value = false;

  set values(bool newValue){
    value = newValue;
  }

  bool get values{
    return value;
  }
}