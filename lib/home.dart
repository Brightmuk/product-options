import 'package:flutter/material.dart';
import 'package:product_options/pages/options_page.dart';
import 'package:product_options/styles.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          'Nike Nero',
          style: TextStyle(
              color: Color.fromARGB(255, 251, 148, 159),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size(0, 0),
          child: Text('Ksh. 3,500',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/shoe.png',
              height: 300,
            ),
            SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Enable product options'),
                value: optionsEnabled,
                onChanged: (val) {
                  setState(() {
                    optionsEnabled = val;
                  });
                }),
            optionsEnabled
                ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Setup Options'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => OptionsPage()));
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
