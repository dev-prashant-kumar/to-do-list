import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,

      darkTheme: ThemeData(
        brightness: Brightness.dark,

        
        scaffoldBackgroundColor: const Color(0xFF000000),

        
        cardColor: const Color(0xFF0D0D0D),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0D0D0D),
          secondary: Color(0xFFFFFFFF), 
        ),

        
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF000000),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
        ),

        
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),

        
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF101010),
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2A2A2A)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Color(0xFF111111)),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            side: const WidgetStatePropertyAll(
              BorderSide(color: Color(0xFF2A2A2A)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
