import 'package:flutter/material.dart';
import 'package:product_options/models/option.dart';
import 'package:product_options/pages/option_settings_page.dart';
import 'package:product_options/state/options_state.dart';
import 'package:product_options/styles.dart';
import 'package:provider/provider.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
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
              'Setup Product\nOptions',
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
              title: Text('Add Option'),
              onTap: () async {
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => OptionSettingsPage()));
                setState(() {
                  if (result != null) {
                    state.options.add(result);
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
                  itemCount: state.options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text((index + 1).toString()),
                      title: Text(state.options[index].name),
                      subtitle: Text(state.options[index].values.join(', ')),
                      trailing: IconButton(
                        icon: Icon(Icons.settings_outlined),
                        onPressed: () async {
                          final result = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (ctx) => OptionSettingsPage(
                                        option: state.options[index],
                                      )));
                         
                    
                            if (result != null) {
                               state.addOption(index, result);
                            }
                          
                        },
                      ),
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
