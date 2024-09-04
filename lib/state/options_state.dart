import 'package:flutter/cupertino.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/models/variation.dart';

class OptionState extends ChangeNotifier{
  
  List<ProductOption> options = [];
  List<Variation> variations = [];

  void addOption(int index, ProductOption option){
    options.removeAt(index);
    options.add(option);
    notifyListeners();
  }
  void removeOption(ProductOption option){
    options.remove(option);
    notifyListeners();
  }
  List<Variation> generateVariations(){
    return [];
  }

}