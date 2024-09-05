import 'package:flutter/material.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/models/variation.dart';
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

  @override
  Widget build(BuildContext context) {
    OptionState state = Provider.of<OptionState>(context);
    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: ListView(
          
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
             ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemCount: state.variations.length,
                 itemBuilder: (context, index){
                 
                   return ListTile(
                    leading: Checkbox(
                    onChanged: (val){
                      if(val!){
                        state.selectVariation(state.variations[index]);
                      }else{
                        state.unselectVariation(state.variations[index]);
                      }
                      
                    },
                    value: state.selectedVariation.contains(state.variations[index].description),
                    ),
                 
                     contentPadding: EdgeInsets.zero,
                    
                     title: Text(state.variations[index].description),
                     subtitle: Text('${state.variations[index].quantity} pcs @Ksh.${state.variations[index].price}'),
                     trailing: IconButton(icon: Icon(Icons.settings_outlined),onPressed: ()async{
                       
                       final result = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>VariationSettingsPage(variation: state.variations[index],)));
                       if(result!=null){
                        state.modifyVariation(result, index);
                       }
                 
                     },),
                   );
                 }
                 )
          
          ],
        ),
      ),
    );
  }
}
