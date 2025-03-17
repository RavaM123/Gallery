import 'package:awokwokwao/style/appcolor.dart';
import 'package:awokwokwao/style/auth_gate.dart';
import 'package:awokwokwao/style/handle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://fokksfzoixgzpnjfzdso.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZva2tzZnpvaXhnenBuamZ6ZHNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4NDkxNTksImV4cCI6MjA1NTQyNTE1OX0.O9gcWYK_wvP-ddM2T9nSdt_t1tpFFBbKKiSoJmQSezA',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil ThemeNotifier dari Provider
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeNotifier.themeMode, // Mode tema sesuai dengan ThemeNotifier
      home: const AuthGate(), // Halaman utama aplikasi
    );
  }
}
