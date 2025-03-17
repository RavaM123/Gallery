import 'package:awokwokwao/pages/main/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../style/handle.dart';
import 'home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 1;
  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10), // 🔹 Tambahkan padding 10
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logo/logoreal.png',
                height: 45, // Sesuaikan ukuran logo
              ),
              const SizedBox(width: 5), // Jarak antara logo dan teks
              Column(
                mainAxisSize: MainAxisSize.min,
                // Pastikan kolom hanya mengambil ukuran seminimal mungkin
                mainAxisAlignment: MainAxisAlignment.end,
                // Ratakan teks ke bawah
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'GaleRava',
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            // 🔹 Tambahkan padding 10 pada ikon settings
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen()),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
