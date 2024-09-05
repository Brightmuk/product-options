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
          IconButton(
              onPressed: widget.option != null
                  ? () {
                      state.removeOption(widget.option!);
                      Navigator.pop(context);
                    }
                  : null,
              icon: Icon(Icons.delete_outline))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _valuesController,
                        decoration: AppStyles()
                            .textFieldDecoration(
                              label: 'Value',
                            )
                            .copyWith(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if(_valuesController.value.text.isNotEmpty){
                                        setState(() {
                                        values.add(_valuesController.value.text);
                                      });
                                      
                                      _valuesController.clear();
                                      }
                                      
                                    },
                                    icon: Icon(Icons.add))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: List.generate(values.length, (index) {
                          return Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 47, 47, 47),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Ensures the Container wraps around its content
                              children: [
                                Text(
                                  values[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                    width:
                                        4.0), // Optional space between text and close icon
                                GestureDetector(
                                  onTap: (){
                                     setState(() {
                                    values.removeAt(index);
                                  });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                    ],
                  ),
                ),
              ),
                                    Center(
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.8,
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
                                showToast(
                                    position: StyledToastPosition.top,
                                    context: context,
                                    'Please add values to continue');
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(
                                    context,
                                    ProductOption(
                                        name: _nameController.value.text,
                                        values: values));
                              }
                            }),
                      ),
                      SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
