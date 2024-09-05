import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/models/variation.dart';
import 'package:product_options/styles.dart';

class VariationSettingsPage extends StatefulWidget {
  final ProductVariation variation;
  const VariationSettingsPage({super.key, required this.variation});

  @override
  State<VariationSettingsPage> createState() => _VariationSettingsPageState();
}

class _VariationSettingsPageState extends State<VariationSettingsPage> {

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qunatityC = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
   
      _nameController.text = widget.variation.description;
      _priceController.text = widget.variation.price.toString();
      _qunatityC.text = widget.variation.quantity.toString();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Configure Product\nVariation',
                style: TextStyle(
                    color: Color.fromARGB(255, 251, 148, 159),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _nameController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Name is required';
                  }
                },
                decoration:
                    AppStyles().textFieldDecoration(label: 'Variation Name'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Price is required';
                  }
                },
                decoration:
                    AppStyles().textFieldDecoration(label: 'Variation Price'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _qunatityC,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Quantity is required';
                  }
                },
                decoration:
                    AppStyles().textFieldDecoration(label: 'Variation Quantity'),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: MaterialButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: const Color.fromARGB(255, 251, 148, 159),
                    onPressed: () {
                     
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                            context,
                            ProductVariation(selected: widget.variation!.selected, description: _nameController.value.text, price: int.parse(_priceController.value.text), quantity: int.parse(_qunatityC.value.text)));
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
