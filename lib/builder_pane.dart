import 'package:flutter/cupertino.dart';

class BuilderPane extends StatelessWidget {

  final int _money;

  BuilderPane(this._money);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Row(
        children: [
          Text("$_money Gold", style: TextStyle(fontSize: 30))
        ],
      ),
    );
  }
}
