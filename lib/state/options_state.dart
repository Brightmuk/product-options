import 'package:flutter/cupertino.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/models/variation.dart';

class OptionState extends ChangeNotifier {
  List<ProductOption> options = [];
  void modifyOption(int? index, ProductOption option) {
    if(index!=null){
      options.removeAt(index);
    }
    options.add(option);
    variations=generateCombinations();
    notifyListeners();
  }

  void removeOption(ProductOption option) {
    options.remove(option);
    variations.clear();
     variations=generateCombinations();
    notifyListeners();
  }

  List<ProductVariation> variations = [];
  List<String> selectedVariation = [];

  void modifyVariation(
    ProductVariation variation,
    int index,
  ) {
    variations.replaceRange(index, index + 1, [variation]);
    notifyListeners();
  }

  void selectVariation(ProductVariation variation) {
    selectedVariation.add(variation.description);
    notifyListeners();
  }

  void unselectVariation(ProductVariation variation) {
    selectedVariation.remove(variation.description);
    notifyListeners();
  }

  void removeVariation(ProductVariation variation) {
    variations.remove(variation);
    notifyListeners();
  }

  List<ProductVariation> generateCombinations() {
    print('got here');
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
    print('Finished');
    return combinations;
  }
}
