import 'package:flutter/material.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/pages/option_values_page.dart';
import 'package:product_options/styles.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  List<ProductOption> options = [];
  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Setup Product\nOptions',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 148, 159),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.add),
              title: Text('Add Option'),
              onTap: ()async{
                final result = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>OptionValuesPage()));
                setState(() {
                   if(result!=null){
                  options.add(result);
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
                itemCount: options.length,
                itemBuilder: (context, index){
                
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text((index+1).toString()),
                    title: Text(options[index].name),
                    subtitle: Text(options[index].values.join(', ')),
                    trailing: IconButton(icon: Icon(Icons.settings_outlined),onPressed: ()async{
                      
                      final result = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>OptionValuesPage(option: options[index],)));
                      options.removeAt(index);
                      setState(() {
                        
                        if(result!=null){
                        options.add(result);
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
