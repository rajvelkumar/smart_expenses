import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_expenses/presentation/expense_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  final widgetOptions = [
    const Text('Home'),
    const ExpenseScreen(),
    const Text('Portfolio'),
    const Text('Accounts'),
    const Text('More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: "Expenses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: "Portfolio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "Accounts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined), label: "More"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: onItemTapped,
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
