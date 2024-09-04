import 'package:flutter/cupertino.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/models/variation.dart';

class OptionState extends ChangeNotifier {
  List<ProductOption> options = [];
  void addOption(int index, ProductOption option) {
    options.removeAt(index);
    options.add(option);
    notifyListeners();
  }

  void removeOption(ProductOption option) {
    options.remove(option);
    notifyListeners();
  }

  List<ProductVariation> variations = [];
  void addVariation(ProductVariation variation,int? index,) {
    if(index!=null){
      //Used when an edit operation is done
      variations.removeAt(index);
    }
    variations.add(variation);
    notifyListeners();
  }

  void removeVariation(ProductVariation variation) {
    variations.remove(variation);
    notifyListeners();
  }

  List<ProductVariation> generateCombinations() {
    List<ProductVariation> combinations = [];

    void generate(List<String> current, int depth) {
      if (depth == options.length) {
        combinations.add(ProductVariation(
            description: current.join(' '), price: 0, quantity: 0));
        return;
      }

      for (var value in options[depth].values) {
        generate([...current, value], depth + 1);
      }
    }

    generate([], 0);
    return combinations;
  }
}
