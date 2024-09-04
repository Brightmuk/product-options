import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/styles.dart';

class VariationSettingsPage extends StatefulWidget {
  final ProductOption? option;
  const VariationSettingsPage({super.key, this.option});

  @override
  State<VariationSettingsPage> createState() => _VariationSettingsPageState();
}

class _VariationSettingsPageState extends State<VariationSettingsPage> {
  List<String> values = [];
  TextEditingController _valuesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState(){
    super.initState();
    if(widget.option!=null){
      _nameController.text=widget.option!.name;
      values=widget.option!.values;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Configure Product\nVariation',
                style: TextStyle(
                    color: Color.fromARGB(255, 251, 148, 159),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _nameController,
                validator: (val){
                  if(val==null||val.isEmpty){
                    return 'Name is required';
                  }
                },
                decoration: AppStyles().textFieldDecoration(label: 'Variation Name'),
              ),
              SizedBox(
                height: 50,
              ),
          

              Center(
                child: MaterialButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color.fromARGB(255, 251, 148, 159),
                          onPressed: () {
                            if(values.length<1){
                              showToast('Please add values to continue');
                              return;
                            }
                           if(_formKey.currentState!.validate()){
                            Navigator.pop(context,ProductOption(name: _nameController.value.text, values: values));
                           }
                            
                          }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
