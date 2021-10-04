import 'package:baking_pro/screens/recipes/input_recipe_init_data_page.dart';
import 'package:baking_pro/screens/recipes/input_recipe_page_view_controller_page.dart';
import 'package:flutter/material.dart';

class ZiftPage extends StatefulWidget {
  const ZiftPage({Key? key}) : super(key: key);

  @override
  _ZiftPageState createState() => _ZiftPageState();
}

class _ZiftPageState extends State<ZiftPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Center(
          child: TextButton(
              child: Text('recipes'),
              onPressed: () => Navigator.of(context).push(
                      PageRouteBuilder(pageBuilder: (context, animation, _) {
                    return InputRecipePagaeViewControllerPage();
                  }))),
        ),
      ),
    );
  }
}
