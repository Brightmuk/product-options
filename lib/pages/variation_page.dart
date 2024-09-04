import 'package:flutter/material.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/pages/option_settings_page.dart';
import 'package:product_options/pages/variations_settings_page.dart';
import 'package:product_options/state/options_state.dart';
import 'package:product_options/styles.dart';
import 'package:provider/provider.dart';

class VariationsPage extends StatefulWidget {
  const VariationsPage({super.key});

  @override
  State<VariationsPage> createState() => _VariationsPageState();
}

class _VariationsPageState extends State<VariationsPage> {
  
  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    OptionState state = Provider.of<OptionState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Setup Product\nVariations',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 148, 159),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.add),
              title: Text('Add Variation'),
              onTap: ()async{
                final result = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>VariationSettingsPage()));
                setState(() {
                   if(result!=null){
                  state.variations.add(result);
                }
                });
               
              },
              splashColor: AppStyles().themeColorLight,
            ),
             Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                itemCount: state.variations.length,
                itemBuilder: (context, index){
                
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text((index+1).toString()),
                    title: Text(state.variations[index].description),
                    subtitle: Text('Ksh.${state.variations[index].price}'),
                    trailing: IconButton(icon: Icon(Icons.settings_outlined),onPressed: ()async{
                      
                      final result = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>VariationSettingsPage(option: state.options[index],)));
                      state.variations.removeAt(index);
                      setState(() {
                        
                        if(result!=null){
                        state.variations.add(result);
                      }
                      });
                    },),
                  );
                }
                ),
              )),
           
          ],
        ),
      ),
    );
  }
}
