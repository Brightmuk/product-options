import 'package:flutter/material.dart';
import 'package:product_options/pages/options_page.dart';
import 'package:product_options/pages/variation_page.dart';
import 'package:product_options/state/options_state.dart';
import 'package:product_options/styles.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> values = [];
  TextEditingController _controller = TextEditingController();
  bool optionsEnabled = false;

  @override
  Widget build(BuildContext context) {
    OptionState state = Provider.of<OptionState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Nike Nero',
          style: TextStyle(
              color: Color.fromARGB(255, 251, 148, 159),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size(0, 0),
          child: Text('Ksh. 3,500',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Image.asset(
              'assets/images/shoe.png',
              height: 300,
            ),
          ),
           Divider(height: 5,color: Colors.grey[100],),
          SwitchListTile(
              
              title: Text('Enable product options'),
              value: optionsEnabled,
              onChanged: (val) {
                setState(() {
                  optionsEnabled = val;
                });
              }),
             optionsEnabled? Divider(height: 5,color: Colors.grey[100],):Container(),
          optionsEnabled
              ? ListTile(
                 
                  title: const Text('Setup Options'),
                  subtitle: SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: 30,
                    child: ListView.separated(
                      separatorBuilder: (ctx,index){
                        return SizedBox(width: 5,);
                      },
                      itemCount: state.options.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx,index){
                        return Container(
                         
                          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                         margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 52, 52, 52)
                          ),
                          child: Text(state.options[index].name,style: TextStyle(color: Colors.white),),
                        );
                    }),
                  ),
                  trailing: SizedBox(
                    width: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.options.length.toString()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => OptionsPage()));
                  },
                )
              : Container(),
               Divider(height: 5,color: Colors.grey[100],),
              state.options.length>1? ListTile(
                subtitle: Text('Configure variations'),
                onTap: (){
                   Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => VariationsPage()));
                },
                title: Text('Variations'),
                trailing: SizedBox(
                    width: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.variations.length.toString()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
              ):Container(),
              state.options.length>1? Divider(height: 5,color: Colors.grey[100],):Container(),
        ],
      ),
    );
  }
}
