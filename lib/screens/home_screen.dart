import 'package:antojos_app/services/constants.dart';
import 'package:antojos_app/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/auth/auth_bloc.dart';
import '../models/user.dart';
import '../widgets/card_view.dart';
import '../widgets/skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late AuthBloc authBloc;
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        drawer: BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
          return state.existsUser
              ? SideMenu(
                  name: state.user!.name,
                  colorHome: const Color.fromARGB(221, 241, 13, 13))
              : const Text('');
        }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(221, 241, 13, 13),
          title: Text('Antojos',
              style: GoogleFonts.lobster(
                textStyle: const TextStyle(
                  letterSpacing: 3,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'routes');
                    },
                    icon: const Icon(Icons.search_sharp),
                    iconSize: 30),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'trolley');
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    iconSize: 30)
              ],
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: _isLoading
              ? ListView.separated(
                  itemCount: 8,
                  itemBuilder: (context, index) => const Skeleton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: defaultPadding),
                )
              : ListView.separated(
                  itemCount: 8,
                  itemBuilder: (context, index) => CardView(
                    image: "assets/images/Image_$index.png",
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: defaultPadding),
                ),
        ));
  }
}

class InformationUser extends StatelessWidget {
  final User user;

  const InformationUser({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('General',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          ListTile(title: Text('Name : ${user.name}')),
          const Divider(),
        ],
      ),
    );
  }
}
