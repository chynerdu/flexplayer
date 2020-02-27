import 'package:flutter/material.dart';
import '../theme-data.dart';

class ContactItem extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('A')
      ),
        title: Text('Adekunle Adeyemi',
        style: KontactTheme.titleDarkBg
      ),
        subtitle: Text('08097898390',
        style: KontactTheme.subtitleDarkBg
      ),
    );
  }
}