import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/auth/auth_bloc.dart';

class SideMenu extends StatelessWidget {
  final String name;
  final Color? colorHome;
  final Color? colorSearch;
  final Color? colorFavorite;
  final Color? colorShoping;
  final Color? colorHistory;
  final Color? colorSettings;

  const SideMenu(
      {Key? key,
      required this.name,
      this.colorHome,
      this.colorSearch,
      this.colorFavorite,
      this.colorShoping,
      this.colorHistory,
      this.colorSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late AuthBloc authBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        _DrawerHeader(name: name),
        ListTile(
          leading: Icon(
            Icons.home,
            size: 30,
            color: colorHome,
          ),
          title: Text(
            'Inicio',
            style: TextStyle(fontSize: 16, color: colorHome),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.search_sharp,
            size: 30,
            color: colorSearch,
          ),
          title: Text(
            'Buscar',
            style: TextStyle(fontSize: 16, color: colorSearch),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'routes');
          },
        ),
        ListTile(
          leading: Icon(Icons.favorite, size: 30, color: colorFavorite),
          title: Text(
            'Favoritos',
            style: TextStyle(fontSize: 16, color: colorFavorite),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'favorites');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.shopify_outlined,
            size: 28,
            color: colorShoping,
          ),
          title: Text(
            'Mis Compras',
            style: TextStyle(fontSize: 16, color: colorShoping),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, 'sales');
          },
        ),
        ListTile(
          leading: Icon(Icons.timer_outlined, size: 28, color: colorHistory),
          title: Text('Historial',
              style: TextStyle(fontSize: 16, color: colorHistory)),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'history');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings_outlined,
            size: 28,
            color: colorSettings,
          ),
          title: Text(
            'Mi cuenta',
            style: TextStyle(fontSize: 16, color: colorSettings),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'settings');
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_outlined,
            size: 28,
          ),
          title: const Text(
            'Salir',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'login');
            authBloc.logout();
          },
        ),
        Divider(height: 20),
        ListTile(
          title: const Text(
            'Acerca de esta App',
            style: TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'information');
          },
        )
      ],
    ));
  }
}

class _DrawerHeader extends StatelessWidget {
  final String? name;
  const _DrawerHeader({
    Key? key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Icon(Icons.person, size: 50, color: Colors.white),
              Text('Hola $name',
                  style: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                    letterSpacing: 3,
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ))),
            ],
          ),
        ),
        decoration:
            const BoxDecoration(color: Color.fromARGB(221, 241, 13, 13)));
  }
}
