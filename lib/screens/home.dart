import 'package:flutter/material.dart';
import '../widgets/no_internet.dart';
import '../utils/check_internet.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type in what you want to create',
            ),
          )),
      ElevatedButton(
          onPressed: () async {
            bool hasInternet = await checkInternet();
            if (hasInternet) {
              print('Your connected');
            } else {
              if (context.mounted) {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => NoInternetDialog());
              }
            }
          },
          child: Text('Generate'))
    ]));
  }
}
