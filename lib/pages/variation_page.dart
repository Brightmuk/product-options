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
  List<String> filters = ['All','Selected'];
  String selectedFilter = 'All';

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
                    itemCount: filters.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedFilter=filters[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedFilter==filters[index]?Color.fromARGB(255, 94, 80, 80): Color.fromARGB(255, 225, 194, 194),),
                          child: Text(
                            filters[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey[100],
            ),
            selectedFilter=='All'? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.variations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      onChanged: (val) {
                        state.selectVariation(index, state.variations[index]);
                      },
                      value: state.variations[index].selected,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(state.variations[index].description),
                    subtitle: Text(
                        '${state.variations[index].quantity} pcs @Ksh.${state.variations[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.settings_outlined),
                      onPressed: () async {
                        final result =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => VariationSettingsPage(
                                      variation: state.variations[index],
                                    )));
                        if (result != null) {
                          state.modifyVariation(result, index);
                        }
                      },
                    ),
                  );
                }): ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.selectedVariations.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      onChanged: (val) {
                        int i = state.variations.indexOf(state.selectedVariations[index]);
                         state.selectVariation(i, state.selectedVariations[index]);
                      },
                      value: state.selectedVariations[index].selected,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(state.selectedVariations[index].description),
                    subtitle: Text(
                        '${state.selectedVariations[index].quantity} pcs @Ksh.${state.selectedVariations[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.settings_outlined),
                      onPressed: () async {
                        final result =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => VariationSettingsPage(
                                      variation: state.selectedVariations[index],
                                    )));
                        if (result != null) {
                          state.modifyVariation(result, index);
                        }
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
