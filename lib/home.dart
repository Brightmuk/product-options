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
          child: Text(
            'Ksh. 3,500',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset(
                'assets/images/shoe.png',
                height: 280,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              elevation: 5,
              child: SwitchListTile(
                  title: Text('Enable product options'),
                  value: optionsEnabled,
                  onChanged: (val) {
                    setState(() {
                      optionsEnabled = val;
                    });
                  }),
            ),
            optionsEnabled
                ? Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const OptionsPage()));
                          },
                          title: Text('Setup Options'),
                          subtitle: Text('Add upto 20 options'),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            child: ListView.separated(
                                separatorBuilder: (ctx, index) {
                                  return SizedBox(
                                    width: 5,
                                  );
                                },
                                itemCount: state.options.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 94, 81, 81)),
                                    child: Text(
                                      state.options[index].name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            optionsEnabled && state.options.isNotEmpty
                ? Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const VariationsPage()));
                          },
                          title: Text('Setup Variations'),
                          subtitle:
                              Text('Select and modify product variations'),
                          trailing: SizedBox(
                            width: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.selectedVariations.length.toString()),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30,
                            child: ListView.separated(
                                separatorBuilder: (ctx, index) {
                                  return SizedBox(
                                    width: 5,
                                  );
                                },
                                itemCount: state.selectedVariations.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color.fromARGB(255, 94, 81, 81)),
                                    child: Text(
                                      state.selectedVariations[index].description,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
