import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/state/options_state.dart';
import 'package:product_options/styles.dart';
import 'package:provider/provider.dart';

class OptionSettingsPage extends StatefulWidget {
  final ProductOption? option;
  const OptionSettingsPage({super.key, this.option});

  @override
  State<OptionSettingsPage> createState() => _OptionSettingsPageState();
}

class _OptionSettingsPageState extends State<OptionSettingsPage> {
  List<String> values = [];
  TextEditingController _valuesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    if (widget.option != null) {
      _nameController.text = widget.option!.name;
      values = widget.option!.values;
    }
  }

  @override
  Widget build(BuildContext context) {
    OptionState state = Provider.of<OptionState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: widget.option!=null? (){
            state.removeOption(widget.option!);
            Navigator.pop(context);
          }:null, icon: Icon(Icons.delete_outline))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Configure Product\nOption',
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
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Name is required';
                  }
                },
                decoration:
                    AppStyles().textFieldDecoration(label: 'Option Name'),
              ),
              SizedBox(
                height: 50,
              ),
              Flexible(
                  child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: values.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text((index + 1).toString()),
                        title: Text(values[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outlined),
                          onPressed: () {},
                        ),
                      );
                    }),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        controller: _valuesController,
                        decoration:
                            AppStyles().textFieldDecoration(label: 'Value'),
                      ),
                    ),
                    MaterialButton(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color.fromARGB(255, 251, 148, 159),
                        onPressed: () {
                          setState(() {
                            values.add(_valuesController.value.text);
                            _valuesController.clear();
                          });
                        })
                  ],
                ),
              ),
              MaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Color.fromARGB(255, 251, 148, 159),
                  onPressed: () {
                    if (values.length < 1) {
                      showToast('Please add values to continue');
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(
                          context,
                          ProductOption(
                              name: _nameController.value.text,
                              values: values));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
