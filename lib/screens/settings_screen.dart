import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerv2/bloc/bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const String ID = 'THEME_SCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: <Widget>[
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return ListTile(
              title: Text(
                'Light Theme',
              ),
              isThreeLine: true,
              subtitle: Text('Switch between light and dark theme'),
              trailing: Switch(
                value: state.theme == ThemeData.light(),
                onChanged: (_) =>
                    BlocProvider.of<ThemeBloc>(context).add(ThemeToggled()),
              ),
            );
          }),
        ],
      ),
    );
  }
}
