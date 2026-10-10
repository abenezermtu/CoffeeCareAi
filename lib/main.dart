import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const CoffeeCareAI());
}

// ================================================================
// APP
// ================================================================

class CoffeeCareAI extends StatefulWidget {
  const CoffeeCareAI({super.key});

  @override
  State<CoffeeCareAI> createState() => _CoffeeCareAIState();
}

class _CoffeeCareAIState extends State<CoffeeCareAI> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoffeeCareAI',
      themeMode: _themeMode,

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1F14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF43A047),
          brightness: Brightness.dark,
        ),
      ),

      home: WelcomePage(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

// ================================================================
// FARMER MODEL
// ================================================================

class Farmer {
  final String username;
  final String password;
  final String fullName;

  Farmer({
    required this.username,
    required this.password,
    required this.fullName,
  });
}

// ================================================================
// TEMPORARY LOCAL DATABASE
// ================================================================

class FarmerDatabase {
  static final List<Farmer> farmers = [
    Farmer(
      username: 'abenezer',
      password: '1234',
      fullName: 'Abenezer',
    ),
  ];

  static Farmer? login(String username, String password) {
    for (final farmer in farmers) {
      if (farmer.username == username &&
          farmer.password == password) {
        return farmer;
      }
    }

    return null;
  }

  static bool usernameExists(String username) {
    return farmers.any(
      (farmer) => farmer.username == username,
    );
  }

  static void register(Farmer farmer) {
    farmers.add(farmer);
  }
}

// ================================================================
// WELCOME PAGE
// ================================================================

class WelcomePage extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const WelcomePage({
    super.key,
    this.onToggleTheme,
    this.isDarkMode = false,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return Container(
                            width: 145 +
                                animationController.value * 15,
                            height: 145 +
                                animationController.value * 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xFF43E69A),
                                  Color(0xFF087D4B),
                                  Color(0xFF061710),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF32E88B)
                                      .withOpacity(0.35),
                                  blurRadius: 60,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.eco_rounded,
                              size: 90,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 45),

                      const Text(
                        'CoffeeCareAI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'SMART AGRICULTURE • POWERED BY AI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF55E7A0),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        'Protect your crops.\nImprove your harvest.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 28,
                          height: 1.25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        'An AI-powered agricultural assistant designed '
                        'to help farmers detect plant diseases, monitor '
                        'plant health, and make smarter decisions.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 40),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF3DE294),
                          foregroundColor:
                              const Color(0xFF052015),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 19,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.arrow_forward_rounded,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF4DE99A),
                            size: 17,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'Built for modern farmers',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.4),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// LOGIN PAGE
// ================================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final username =
        usernameController.text.trim().toLowerCase();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showMessage(
        'Please enter your username and password.',
        false,
      );
      return;
    }

    final farmer =
        FarmerDatabase.login(username, password);

    if (farmer == null) {
      _showMessage(
        'Incorrect username or password.',
        false,
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AgriculturalDashboard(
          farmer: farmer,
        ),
      ),
    );
  }

  void _showMessage(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success
            ? const Color(0xFF168653)
            : const Color(0xFFB83D4A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 470,
                  ),
                  child: _GlassCard(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Center(
                          child: Icon(
                            Icons.eco_rounded,
                            color: Color(0xFF46E79A),
                            size: 55,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Center(
                          child: Text(
                            'Welcome Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Center(
                          child: Text(
                            'Sign in to your farmer account',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        _inputLabel('Username'),

                        const SizedBox(height: 8),

                        _textField(
                          controller: usernameController,
                          hint: 'Enter your username',
                          icon: Icons.person_outline_rounded,
                        ),

                        const SizedBox(height: 22),

                        _inputLabel('Password'),

                        const SizedBox(height: 8),

                        _textField(
                          controller: passwordController,
                          hint: 'Enter your password',
                          icon: Icons.lock_outline_rounded,
                          obscureText: obscurePassword,
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword =
                                    !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white54,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF3DE294),
                              foregroundColor:
                                  const Color(0xFF052015),
                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 17,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Create a Farmer Account',
                              style: TextStyle(
                                color: Color(0xFF54E6A0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Center(
                          child: Text(
                            'Demo account: abenezer / 1234',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.25),
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF52E69D),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFF061710)
            .withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF43E69A),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// REGISTER PAGE
// ================================================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() {
    final fullName =
        fullNameController.text.trim();
    final username =
        usernameController.text.trim().toLowerCase();
    final password =
        passwordController.text;
    final confirm =
        confirmPasswordController.text;

    if (fullName.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      _message(
        'Please complete all fields.',
        false,
      );
      return;
    }

    if (username.contains(' ')) {
      _message(
        'Username cannot contain spaces.',
        false,
      );
      return;
    }

    if (password.length < 4) {
      _message(
        'Password must be at least 4 characters.',
        false,
      );
      return;
    }

    if (password != confirm) {
      _message(
        'Passwords do not match.',
        false,
      );
      return;
    }

    if (FarmerDatabase.usernameExists(username)) {
      _message(
        'That username already exists.',
        false,
      );
      return;
    }

    final farmer = Farmer(
      username: username,
      password: password,
      fullName: fullName,
    );

    FarmerDatabase.register(farmer);

    _message(
      'Account created successfully!',
      true,
    );

    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AgriculturalDashboard(
              farmer: farmer,
            ),
          ),
        );
      },
    );
  }

  void _message(String text, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: success
            ? const Color(0xFF168653)
            : const Color(0xFFB83D4A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 470,
                  ),
                  child: _GlassCard(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Center(
                          child: Icon(
                            Icons.agriculture_rounded,
                            color: Color(0xFF49E89A),
                            size: 55,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Center(
                          child: Text(
                            'Create your personal farmer account',
                            style: TextStyle(
                              color:
                                  Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        _label('Full Name'),

                        const SizedBox(height: 8),

                        _field(
                          controller:
                              fullNameController,
                          hint: 'Your full name',
                          icon: Icons.badge_outlined,
                        ),

                        const SizedBox(height: 18),

                        _label('Username'),

                        const SizedBox(height: 8),

                        _field(
                          controller:
                              usernameController,
                          hint: 'Choose a username',
                          icon: Icons.person_outline,
                        ),

                        const SizedBox(height: 18),

                        _label('Password'),

                        const SizedBox(height: 8),

                        _field(
                          controller:
                              passwordController,
                          hint: 'Create a password',
                          icon: Icons.lock_outline,
                          obscureText:
                              obscurePassword,
                        ),

                        const SizedBox(height: 18),

                        _label('Confirm Password'),

                        const SizedBox(height: 8),

                        _field(
                          controller:
                              confirmPasswordController,
                          hint: 'Enter password again',
                          icon:
                              Icons.lock_reset_rounded,
                          obscureText:
                              obscurePassword,
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF3DE294),
                              foregroundColor:
                                  const Color(0xFF052015),
                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 17,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'CREATE FARMER ACCOUNT',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.w800,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                color:
                                    Color(0xFF54E6A0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.3),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF52E69D),
        ),
        filled: true,
        fillColor:
            const Color(0xFF061710).withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF43E69A),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// AGRICULTURAL DASHBOARD - FARMER FIRST DESIGN
// ================================================================

enum AppLanguage { english, amharic, oromo }

class AgriculturalDashboard extends StatefulWidget {
  final Farmer farmer;
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const AgriculturalDashboard({
    super.key,
    required this.farmer,
    this.onToggleTheme,
    this.isDarkMode = false,
  });

  @override
  State<AgriculturalDashboard> createState() => _AgriculturalDashboardState();
}

class _AgriculturalDashboardState extends State<AgriculturalDashboard> {
  AppLanguage language = AppLanguage.amharic;
  int selectedPage = 0;

  static const coffeeBrown = Color(0xFF2E7D32);
  static const coffeeDark = Color(0xFF1B5E20);
  static const leafGreen = Color(0xFF43A047);
  static const lightGreen = Color(0xFFE9F1E4);
  static const cream = Colors.white;
  static const orange = Color(0xFFE59A3A);

  String t(String key) {
    const data = {
      'dashboard': ['Dashboard', 'ዳሽቦርድ', 'Daashboordii'],
      'disease': ['Disease Detection', 'የበሽታ ምርመራ', 'Qorannoo Dhukkubaa'],
      'farm': ['My Farm', 'እርሻዬ', 'Qonna Koo'],
      'knowledge': ['Knowledge', 'እውቀት', 'Beekumsa'],
      'about': ['About', 'ስለ እኛ', 'Waaʼee'],
      'welcome': ['Good morning', 'እንደምን አደሩ', 'Akkam bulte'],
      'ready': ['Let’s take care of your coffee farm today.', 'ዛሬ የቡና እርሻዎን እንከባከብ።', 'Harʼa qonna bunaa keessan haa kunuunsinu.'],
      'weather': ['Today’s Weather', 'የዛሬ የአየር ሁኔታ', 'Haala Qilleensaa Harʼaa'],
      'lightRain': ['Light rain', 'ቀላል ዝናብ', 'Rooba salphaa'],
      'humidity': ['Humidity', 'እርጥበት', 'Jiidhina'],
      'checkPlant': ['Check Your Coffee Plant', 'የቡና ተክልዎን ይመርምሩ', 'Biqiltuu Bunaa Keessan Ilaalaa'],
      'scanHint': ['Take a photo to check for common coffee plant diseases.', 'ፎቶ በማንሳት የቡና ተክል በሽታዎችን ይመርምሩ።', 'Suuraa kaasuun dhukkuboota biqiltuu bunaa beekamoo ilaalaa.'],
      'scan': ['Scan Plant', 'ተክሉን ይቃኙ', 'Biqiltuu Sakki'],
      'myFarm': ['My Farm', 'እርሻዬ', 'Qonna Koo'],
      'plants': ['Plants', 'ተክሎች', 'Biqiltoota'],
      'health': ['Plant Health', 'የተክል ጤና', 'Fayyaa Biqiltuu'],
      'healthy': ['Healthy', 'ጤናማ', 'Fayya'],
      'alerts': ['Disease Alerts', 'የበሽታ ማስጠንቀቂያ', 'Akeekkachiisa Dhukkubaa'],
      'tasks': ['Tasks Today', 'የዛሬ ሥራዎች', 'Hojii Harʼaa'],
      'advice': ['Today’s Farm Advice', 'የዛሬ የእርሻ ምክር', 'Gorsa Qonnaa Harʼaa'],
      'rainAdvice': ['Rain is expected. Avoid spraying pesticides today.', 'ዝናብ ይጠበቃል። ዛሬ ፀረ-ተባይ መድኃኒት ከመርጨት ይቆጠቡ።', 'Roobni ni eegama. Harʼa qoricha ilbiisota ittisu facaasuu irraa of qusadhaa.'],
      'leafAdvice': ['Check young leaves for spots, rust, or unusual discoloration.', 'ወጣት ቅጠሎችን ለነጠብጣብ፣ ዝገት ወይም ያልተለመደ ቀለም ለውጥ ይመርምሩ።', 'Baala dargaggoo bakka, rust ykn jijjiirama halluu hin baramneef ilaalaa.'],
      'quick': ['Quick actions', 'ፈጣን እርምጃዎች', 'Tarkaanfiiwwan Saffisaa'],
      'knowledgeHint': ['Learn about coffee diseases and good farming practices.', 'ስለ የቡና በሽታዎችና ጥሩ የእርሻ ልምዶች ይማሩ።', 'Waaʼee dhukkuba bunaa fi mala qonnaa gaarii baradhaa.'],
      'logout': ['Logout', 'ውጣ', 'Baʼi'],
      'profile': ['Profile', 'መገለጫ', 'Pirofaayilii'],
      'close': ['Close', 'ዝጋ', 'Cufi'],
    };
    final values = data[key]!;
    return values[language.index];
  }

  String languageName(AppLanguage value) {
    switch (value) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.amharic:
        return 'አማርኛ';
      case AppLanguage.oromo:
        return 'Afaan Oromoo';
    }
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (_) => WelcomePage(
            onToggleTheme: widget.onToggleTheme,
            isDarkMode: widget.isDarkMode,
          ),
        ),
      (route) => false,
    );
  }

  void selectPage(int index) {
    setState(() => selectedPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 900;
            return Column(
              children: [
                _topBar(mobile),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: selectedPage == 0
                        ? _dashboardBody(mobile)
                        : _placeholderPage(mobile),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _topBar(bool mobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 12 : 34,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ============================================================
          // COFFEECAREAI LOGO
          // ============================================================
          Container(
            width: mobile ? 40 : 43,
            height: mobile ? 40 : 43,
            decoration: BoxDecoration(
              color: coffeeBrown,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.local_cafe_rounded,
              color: Colors.white,
              size: mobile ? 23 : 25,
            ),
          ),

          const SizedBox(width: 8),

          // ============================================================
          // APP NAME
          // ============================================================
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CoffeeCareAI',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: coffeeDark,
                  ),
                ),

                if (!mobile)
                  Text(
                    'SMART COFFEE FARMING',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: leafGreen,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ============================================================
          // DESKTOP NAVIGATION
          // ============================================================
          if (!mobile) ...[
            _topNav('dashboard', 0),
            _topNav('disease', 1),
            _topNav('farm', 2),
            _topNav('knowledge', 3),
            _topNav('about', 4),

            const SizedBox(width: 10),

            _languageButton(),

            const SizedBox(width: 8),

            _profileButton(false),
          ],

          // ============================================================
          // MOBILE CONTROLS
          // ============================================================
          if (mobile) ...[
            // Language
            PopupMenuButton<AppLanguage>(
              tooltip: 'Language',
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.language_rounded,
                color: coffeeBrown,
                size: 22,
              ),
              onSelected: (value) {
                setState(() {
                  language = value;
                });
              },
              itemBuilder: (_) {
                return AppLanguage.values
                    .map(
                      (value) => PopupMenuItem<AppLanguage>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(
                              value == language
                                  ? Icons.check_circle
                                  : Icons.language,
                              size: 18,
                              color: value == language
                                  ? leafGreen
                                  : coffeeBrown,
                            ),
                            const SizedBox(width: 9),
                            Text(languageName(value)),
                          ],
                        ),
                      ),
                    )
                    .toList();
              },
            ),

            const SizedBox(width: 2),

            // Profile
            _profileButton(true),

            const SizedBox(width: 2),

            // Mobile menu
            PopupMenuButton<int>(
              padding: EdgeInsets.zero,
              tooltip: 'Menu',
              icon: const Icon(
                Icons.menu_rounded,
                color: coffeeDark,
                size: 25,
              ),
              onSelected: selectPage,
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.dashboard_rounded,
                        size: 19,
                        color: coffeeBrown,
                      ),
                      const SizedBox(width: 10),
                      Text(t('dashboard')),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.biotech_rounded,
                        size: 19,
                        color: coffeeBrown,
                      ),
                      const SizedBox(width: 10),
                      Text(t('disease')),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.agriculture_rounded,
                        size: 19,
                        color: coffeeBrown,
                      ),
                      const SizedBox(width: 10),
                      Text(t('farm')),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 19,
                        color: coffeeBrown,
                      ),
                      const SizedBox(width: 10),
                      Text(t('knowledge')),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 4,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 19,
                        color: coffeeBrown,
                      ),
                      const SizedBox(width: 10),
                      Text(t('about')),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value: 5,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 19,
                        color: coffeeBrown,
                      ),
                      const SizedBox(width: 10),
                      Text(t('profile')),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _topNav(String key, int index) {
    final selected = selectedPage == index;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => selectPage(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? lightGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(t(key), style: TextStyle(color: selected ? leafGreen : coffeeDark.withValues(alpha: .72), fontSize: 12, fontWeight: selected ? FontWeight.w800 : FontWeight.w600)),
      ),
    );
  }

  Widget _languageButton() {
    return PopupMenuButton<AppLanguage>(
      tooltip: 'Language',
      color: Colors.white,
      onSelected: (value) => setState(() => language = value),
      itemBuilder: (_) => AppLanguage.values.map((value) => PopupMenuItem(
        value: value,
        child: Row(children: [
          Icon(value == language ? Icons.check_circle : Icons.language, size: 18, color: value == language ? leafGreen : coffeeBrown),
          const SizedBox(width: 9),
          Text(languageName(value)),
        ]),
      )).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD9D1C5)), borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          const Icon(Icons.language_rounded, size: 18, color: coffeeBrown),
          const SizedBox(width: 6),
          Text(languageName(language), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: coffeeDark)),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 17, color: coffeeBrown),
        ]),
      ),
    );
  }

  Widget _profileButton(bool mobile) {
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (value) {
        if (value == 'logout') logout();
        if (value == 'profile') selectPage(5);
      },
      itemBuilder: (_) => [
        PopupMenuItem(value: 'profile', child: Text('${t('profile')}: ${widget.farmer.fullName}')),
        PopupMenuItem(value: 'logout', child: Text(t('logout'), style: const TextStyle(color: Color(0xFFB4473C)))),
      ],
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: lightGreen, borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.person_rounded, color: leafGreen, size: 21),
      ),
    );
  }

  Widget _dashboardBody(bool mobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(mobile ? 16 : 34, 24, mobile ? 16 : 34, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1250),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _welcomeSection(mobile),
            const SizedBox(height: 20),
            _mainCards(mobile),
            const SizedBox(height: 28),
            _sectionTitle(t('myFarm'), 'Your farm at a glance'),
            const SizedBox(height: 14),
            _farmStats(mobile),
            const SizedBox(height: 28),
            _adviceSection(mobile),
            const SizedBox(height: 28),
            _quickSection(mobile),
          ]),
        ),
      ),
    );
  }

  Widget _welcomeSection(bool mobile) {
    return Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${t('welcome')}, ${widget.farmer.fullName} 👋', style: TextStyle(fontSize: mobile ? 25 : 31, fontWeight: FontWeight.w800, color: coffeeDark)),
        const SizedBox(height: 5),
        Text(t('ready'), style: TextStyle(fontSize: 14, color: coffeeDark.withValues(alpha: .62))),
      ])),
      if (!mobile) Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2DACF))),
        child: const Row(children: [Icon(Icons.location_on_outlined, size: 17, color: coffeeBrown), SizedBox(width: 5), Text('Ethiopia', style: TextStyle(fontWeight: FontWeight.w700, color: coffeeDark))]),
      ),
    ]);
  }

  Widget _mainCards(bool mobile) {
    final weather = _weatherCard();
    final scan = _scanCard();
    if (mobile) return Column(children: [weather, const SizedBox(height: 14), scan]);
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(flex: 2, child: weather), const SizedBox(width: 16), Expanded(flex: 5, child: scan)]);
  }

  Widget _weatherCard() {
    return _CardSurface(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Icon(Icons.wb_sunny_outlined, color: orange), const SizedBox(width: 8), Expanded(child: Text(t('weather'), style: const TextStyle(fontWeight: FontWeight.w800, color: coffeeDark))), const Text('Today', style: TextStyle(fontSize: 10, color: Colors.grey))]),
        const SizedBox(height: 15),
        const Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('24°', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: coffeeDark)), SizedBox(width: 8), Padding(padding: EdgeInsets.only(bottom: 7), child: Text('C', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)))]),
        Text(t('lightRain'), style: const TextStyle(fontWeight: FontWeight.w600, color: coffeeBrown)),
        const SizedBox(height: 13),
        Row(children: [const Icon(Icons.water_drop_outlined, size: 17, color: leafGreen), const SizedBox(width: 5), Text('${t('humidity')}: 78%', style: TextStyle(fontSize: 12, color: coffeeDark.withValues(alpha: .65)))]),
      ],),
    );
  }

  Widget _scanCard() {
    return Container(
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(color: coffeeBrown, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 18, offset: Offset(0, 7))]),
      child: Row(children: [
        Container(width: 62, height: 62, decoration: BoxDecoration(color: Colors.white.withValues(alpha: .14), borderRadius: BorderRadius.circular(17)), child: const Icon(Icons.local_florist_rounded, color: Colors.white, size: 32)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t('checkPlant'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)), const SizedBox(height: 7), Text(t('scanHint'), style: const TextStyle(color: Color(0xFFF4E9DD), fontSize: 12, height: 1.4))])),
        const SizedBox(width: 12),
        FilledButton.icon(onPressed: _showScanDialog, icon: const Icon(Icons.camera_alt_rounded, size: 18), label: Text(t('scan')), style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: coffeeBrown, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13))),
      ]),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: coffeeDark)), const SizedBox(height: 3), Text(subtitle, style: TextStyle(fontSize: 12, color: coffeeDark.withValues(alpha: .55)))]);
  }

  Widget _farmStats(bool mobile) {
    final cards = [
      _StatData(Icons.eco_rounded, '250', t('plants'), leafGreen),
      _StatData(Icons.favorite_rounded, t('healthy'), t('health'), const Color(0xFF5A8D47)),
      _StatData(Icons.bug_report_outlined, '2', t('alerts'), const Color(0xFFD16B43)),
      _StatData(Icons.task_alt_rounded, '3', t('tasks'), coffeeBrown),
    ];
    if (mobile) return GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.65, children: cards.map(_statCard).toList());
    return Row(children: cards.map((c) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: _statCard(c)))).toList());
  }

  Widget _statCard(_StatData data) {
    return _CardSurface(child: Row(children: [Container(width: 42, height: 42, decoration: BoxDecoration(color: data.color.withValues(alpha: .10), borderRadius: BorderRadius.circular(12)), child: Icon(data.icon, color: data.color, size: 21)), const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(data.value, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: coffeeDark)), const SizedBox(height: 2), Text(data.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: coffeeDark.withValues(alpha: .58), fontWeight: FontWeight.w600))]))]));
  }

  Widget _adviceSection(bool mobile) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t('advice'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: coffeeDark)),
      const SizedBox(height: 14),
      _adviceCard(Icons.umbrella_outlined, orange, t('rainAdvice')),
      const SizedBox(height: 10),
      _adviceCard(Icons.spa_outlined, leafGreen, t('leafAdvice')),
    ]);
  }

  Widget _adviceCard(IconData icon, Color color, String text) {
    return _CardSurface(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: .11), borderRadius: BorderRadius.circular(11)), child: Icon(icon, color: color, size: 21)), const SizedBox(width: 12), Expanded(child: Text(text, style: const TextStyle(fontSize: 13, height: 1.45, color: coffeeDark, fontWeight: FontWeight.w600)))]));
  }

  Widget _quickSection(bool mobile) {
    final cards = [
      _QuickData(Icons.camera_alt_rounded, t('disease'), 'AI plant diagnosis', coffeeBrown, 1),
      _QuickData(Icons.favorite_border_rounded, t('health'), 'Monitor your plants', leafGreen, 2),
      _QuickData(Icons.menu_book_rounded, t('knowledge'), t('knowledgeHint'), const Color(0xFF7D684F), 3),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t('quick'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: coffeeDark)), const SizedBox(height: 14), mobile ? Column(children: cards.map(_quickCard).toList()) : Row(children: cards.map((c) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: _quickCard(c)))).toList())]);
  }

  Widget _quickCard(_QuickData data) {
    return InkWell(onTap: () => selectPage(data.page), borderRadius: BorderRadius.circular(18), child: _CardSurface(child: Row(children: [Container(width: 45, height: 45, decoration: BoxDecoration(color: data.color.withValues(alpha: .10), borderRadius: BorderRadius.circular(12)), child: Icon(data.icon, color: data.color)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(data.title, style: const TextStyle(fontWeight: FontWeight.w800, color: coffeeDark)), const SizedBox(height: 4), Text(data.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: coffeeDark.withValues(alpha: .55)))])), const Icon(Icons.chevron_right_rounded, color: Color(0xFFB7AA9A))])));
  }

  Widget _placeholderPage(bool mobile) {
    final pageData = switch (selectedPage) {
      1 => (t('disease'), Icons.biotech_rounded,
          'The plant scanner will be connected to the AI model here.'),
      2 => (t('farm'), Icons.agriculture_rounded,
          'Your farm records, plants, tasks and health history will appear here.'),
      3 => (t('knowledge'), Icons.menu_book_rounded, t('knowledgeHint')),
      4 => (t('about'), Icons.info_outline_rounded,
          'CoffeeCareAI is designed to help coffee farmers make better decisions.'),
      5 => (t('profile'), Icons.person_outline_rounded,
          'Farmer profile and account settings.'),
      _ => (t('dashboard'), Icons.dashboard_rounded, ''),
    };

    return SingleChildScrollView(
      padding: EdgeInsets.all(mobile ? 20 : 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: _CardSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(pageData.$2, color: leafGreen, size: 28),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        pageData.$1,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: coffeeDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  pageData.$3,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: coffeeDark.withValues(alpha: .68),
                  ),
                ),
                if (selectedPage == 1) ...[
                  const SizedBox(height: 25),
                  FilledButton.icon(
                    onPressed: _showScanDialog,
                    icon: const Icon(Icons.camera_alt_rounded),
                    label: Text(t('scan')),
                    style: FilledButton.styleFrom(
                      backgroundColor: coffeeBrown,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showScanDialog() async {
  final ImagePicker picker = ImagePicker();

  final ImageSource? source = await showModalBottomSheet<ImageSource>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t('disease'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.camera_alt),
                ),
                title: const Text('Take a photo'),
                subtitle: const Text('Use your camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),

              ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.photo_library),
                ),
                title: const Text('Choose from gallery'),
                subtitle: const Text(
                  'Select an existing plant photo',
                ),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );

  if (source == null) {
    return;
  }

  final XFile? image = await picker.pickImage(
    source: source,
    imageQuality: 85,
  );

  if (image == null) {
    return;
  }

  if (!mounted) return;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(t('disease')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: SizedBox(
    width: 280,
    height: 250,
    child: Image.file(
      File(image.path),
      fit: BoxFit.contain,
    ),
  ),
),

            const SizedBox(height: 16),

            const Text(
              'Image selected successfully.\n\n'
              'Disease analysis will be connected to the AI model next.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t('close')),
          ),
        ],
      );
    },
  );
}

}
class _CardSurface extends StatelessWidget {
  final Widget child;
  const _CardSurface({required this.child});
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8E0D5)), boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4))]), child: child);
}

class _StatData {
  final IconData icon; final String value; final String label; final Color color;
  const _StatData(this.icon, this.value, this.label, this.color);
}

class _QuickData {
  final IconData icon; final String title; final String subtitle; final Color color; final int page;
  const _QuickData(this.icon, this.title, this.subtitle, this.color, this.page);
}

// ================================================================
// SHARED LEGACY UI HELPERS
// ================================================================

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(23),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: const Color(0xFF10291F).withValues(alpha: .65),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withValues(alpha: .07),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF061710),
            Color(0xFF081F16),
            Color(0xFF04100B),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            left: -120,
            child: _glow(350, const Color(0xFF12C978)),
          ),
          Positioned(
            top: 350,
            right: -180,
            child: _glow(420, const Color(0xFF087DFF)),
          ),
          Positioned(
            bottom: -180,
            left: 250,
            child: _glow(400, const Color(0xFF8B42FF)),
          ),
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .08),
            blurRadius: 150,
            spreadRadius: 40,
          ),
        ],
      ),
    );
  }
}
