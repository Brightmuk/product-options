import 'package:flutter/cupertino.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/models/variation.dart';

class OptionState extends ChangeNotifier{
  
  List<ProductOption> options = [];
  List<Variation> variations = [];

}