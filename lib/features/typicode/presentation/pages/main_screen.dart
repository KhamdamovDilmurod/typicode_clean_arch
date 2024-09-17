import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:typicode_clean_arch/features/typicode/presentation/pages/main/favourite/favourited_screen.dart';
import 'package:typicode_clean_arch/features/typicode/presentation/pages/main/home/home_screen.dart';
import '../../../../core/utilities/colors.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
@override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _appBar(),
      body: _buildBody(),
      bottomNavigationBar: _navBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, kAccentColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        "Blog App",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  Widget _navBar(){
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }
}
