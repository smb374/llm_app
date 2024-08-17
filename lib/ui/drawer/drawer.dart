import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/blocs/page.dart';
import 'package:llm_app/models.dart';

class MainDrawer extends StatelessWidget {
  final String token;
  final User? profile;
  const MainDrawer(this.token, this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final pageBloc = BlocProvider.of<PageBloc>(context);
    final scaffold = Scaffold.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            accountName: Text(
              profile != null ? profile!.name : 'Unknown',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              profile != null ? profile!.email : 'unknown',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: const FlutterLogo(),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Sessions'),
            onTap: () {
              scaffold.openEndDrawer();
              pageBloc.add(SwitchSession());
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              scaffold.openEndDrawer();
              pageBloc.add(SwitchSearch());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              scaffold.openEndDrawer();
              userBloc.add(Logout());
            },
          ),
        ],
      ),
    );
  }
}
