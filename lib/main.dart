import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(),
          cardColor: Colors.white,
          colorScheme: ColorScheme.light(
            primary: Color(0xFF6200EE),
            onPrimary: Colors.white,
            secondary: Color(0xFF03DAC6),
            onSecondary: Colors.black,
            surface: Color(0xFFE0E0E0),
            onSurface: Colors.black,
            background: Color(0xFFF6F7FB),
            onBackground: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Color(0xFF1D1F33),
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
          cardColor: Color(0xFF323548),
          colorScheme: ColorScheme.dark(
            primary: Color(0xFFBB86FC),
            onPrimary: Colors.black,
            secondary: Color(0xFF03DAC6),
            onSecondary: Colors.black,
            surface: Color(0xFF121212),
            onSurface: Colors.white,
            background: Color(0xFF1D1F33),
            onBackground: Colors.white,
          ),
        ),
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: HomeScreen(),
      );
    });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Vani,',
                  style: TextStyle(fontSize: 24, color: isDarkMode ? Colors.grey : Colors.black54),
                ),
                Text(
                  'Welcome!!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: theme.colorScheme.onBackground),
                ),
                SizedBox(height: 20),
                _buildBalanceCard(context),
                SizedBox(height: 20),
                _buildAssetsSection(context),
                SizedBox(height: 20),
                _buildTrendsSection(context),
                SizedBox(height: 20),
                _buildBottomNavBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Color(0xFF8E2DE2), Color(0xFF4A00E0)]
              : [Color(0xFF6200EE), Color(0xFFB39DDB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black45 : Colors.grey.shade300,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total balance',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            '\$13450.00',
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profit',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+15%',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '\$13250.00',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text('5.7%', style: TextStyle(color: Colors.greenAccent)),
        ],
      ),
    );
  }

  Widget _buildAssetsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Assets'),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAssetCard('Bitcoin', 'BTC', '\$60120.00', '+2.17%', Icons.currency_bitcoin, Colors.orange),
            _buildAssetCard('Ethereum', 'ETH', '\$4512.00', '-1.17%', Icons.flash_on, Colors.green),
            _buildAssetCard('Ripple', 'XRP', '\$3429.00', '-2.17%', Icons.bubble_chart, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Trends'),
        SizedBox(height: 10),
        _buildTrendCard('Litecoin', 'LTC', 3457.00, Icons.trending_up),
        SizedBox(height: 10),
        _buildTrendCard('Dogecoin', 'DOGE', 4457.00, Icons.trending_up),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 70,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF1D1F33) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black45 : Colors.grey.shade300,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home, size: 28, color: Colors.grey),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF6200EE) : Colors.deepPurpleAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isDarkMode ? Colors.black26 : Colors.deepPurpleAccent.withOpacity(0.5),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Icon(Icons.add, size: 28, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.settings, size: 28, color: Colors.grey),
            onPressed: () {
              Get.to(SettingsScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'view all',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildAssetCard(String name, String symbol, String price, String change, IconData icon, Color iconColor) {
    final isDarkMode = Get.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode ? Color(0xFF323548) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black45 : Colors.grey.shade300,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 36),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
          Text(symbol, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 10),
          Text(price, style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
          Text(change, style: TextStyle(fontSize: 14, color: change.contains('+') ? Colors.green : Colors.red)),
        ],
      ),
    );
  }

  Widget _buildTrendCard(String name, String symbol, double price, IconData icon) {
    final isDarkMode = Get.isDarkMode;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode ? Color(0xFF323548) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black45 : Colors.grey.shade300,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blueAccent, size: 36),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
                  Text(symbol, style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Text(price.toString(), style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode', style: TextStyle(fontSize: 18)),
                Obx(() {
                  return Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
