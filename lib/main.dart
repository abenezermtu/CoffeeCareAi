import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoffeeCareAI());
}

// ================================================================
// APP
// ================================================================

class CoffeeCareAI extends StatelessWidget {
  const CoffeeCareAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoffeeCareAI',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFF061710),
      ),
      home: const WelcomePage(),
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
  const WelcomePage({super.key});

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
// AGRICULTURAL DASHBOARD
// ================================================================

class AgriculturalDashboard extends StatefulWidget {
  final Farmer farmer;

  const AgriculturalDashboard({
    super.key,
    required this.farmer,
  });

  @override
  State<AgriculturalDashboard> createState() =>
      _AgriculturalDashboardState();
}

class _AgriculturalDashboardState
    extends State<AgriculturalDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const WelcomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final desktop =
                    constraints.maxWidth >= 900;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: desktop ? 60 : 20,
                    vertical: 24,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(
                        maxWidth: 1250,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          _header(desktop),

                          const SizedBox(height: 35),

                          _welcomeBanner(),

                          const SizedBox(height: 25),

                          _hero(desktop),

                          const SizedBox(height: 30),

                          _quickActions(desktop),

                          const SizedBox(height: 35),

                          _features(desktop),

                          const SizedBox(height: 35),

                          _statistics(desktop),

                          const SizedBox(height: 40),

                          _footer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(bool desktop) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF35E88C),
                Color(0xFF0EA968),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF35E88C)
                    .withOpacity(0.35),
                blurRadius: 25,
              ),
            ],
          ),
          child: const Icon(
            Icons.eco_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),

        const SizedBox(width: 15),

        const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'CoffeeCareAI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'SMART AGRICULTURE',
              style: TextStyle(
                color: Color(0xFF57DFA0),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        const Spacer(),

        if (desktop)
          Row(
            children: [
              _nav('Dashboard', true),
              _nav('Disease Detection', false),
              _nav('Plant Health', false),
              _nav('About', false),
            ],
          ),

        const SizedBox(width: 20),

        PopupMenuButton<String>(
          color: const Color(0xFF10291F),
          onSelected: (value) {
            if (value == 'logout') {
              logout();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Text(
                widget.farmer.fullName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const PopupMenuItem(
              value: 'logout',
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFFFF7B7B),
                ),
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF10291F),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFF2A684D),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.person_rounded,
                  color: Color(0xFF55E7A0),
                  size: 18,
                ),
                const SizedBox(width: 7),
                Text(
                  widget.farmer.username,
                  style: const TextStyle(
                    color: Color(0xFF9AF2C5),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _nav(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected
              ? const Color(0xFF58E7A0)
              : Colors.white.withOpacity(0.6),
          fontWeight:
              selected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _welcomeBanner() {
    return _GlassCard(
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  const Color(0xFF35E88C).withOpacity(0.12),
              border: Border.all(
                color:
                    const Color(0xFF35E88C).withOpacity(0.3),
              ),
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              color: Color(0xFFFFD166),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${widget.farmer.fullName}! 👋',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your agricultural AI assistant is ready to help.',
                  style: TextStyle(
                    color:
                        Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const _PulsingDot(),
        ],
      ),
    );
  }

  Widget _hero(bool desktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        desktop ? 45 : 28,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF103D29),
            Color(0xFF092319),
            Color(0xFF071811),
          ],
        ),
        border: Border.all(
          color:
              const Color(0xFF287F5A).withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color:
                const Color(0xFF16C978).withOpacity(0.12),
            blurRadius: 60,
            spreadRadius: 5,
          ),
        ],
      ),
      child: desktop
          ? Row(
              children: [
                Expanded(child: _heroText()),
                const SizedBox(width: 40),
                Expanded(child: _plant()),
              ],
            )
          : Column(
              children: [
                _heroText(),
                const SizedBox(height: 30),
                _plant(),
              ],
            ),
    );
  }

  Widget _heroText() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1C5C40),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                color: Color(0xFF63EBA7),
                size: 16,
              ),
              SizedBox(width: 7),
              Text(
                'AI-POWERED AGRICULTURE',
                style: TextStyle(
                  color: Color(0xFF9AF2C5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Protect Your\nCoffee Plants.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            height: 1.05,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Detect diseases early, understand your plant health, '
          'and make smarter agricultural decisions with AI.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.68),
            fontSize: 16,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () {
            _showScanDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF35D981),
            foregroundColor: const Color(0xFF062015),
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.document_scanner_rounded,
              ),
              SizedBox(width: 10),
              Text(
                'Scan Coffee Plant',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_rounded,
                size: 19,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _plant() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF2AE080)
                      .withOpacity(0.25),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF25D77C)
                      .withOpacity(0.2),
                  blurRadius:
                      50 + animationController.value * 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 235,
                  height: 235,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF36D987)
                          .withOpacity(0.2),
                    ),
                  ),
                ),

                const Icon(
                  Icons.spa_rounded,
                  size: 150,
                  color: Color(0xFF55E99A),
                ),

                Positioned(
                  top: 25,
                  right: 15,
                  child: _floatingBadge(
                    Icons.psychology_rounded,
                    'AI',
                  ),
                ),

                Positioned(
                  bottom: 30,
                  left: 15,
                  child: _floatingBadge(
                    Icons.favorite_rounded,
                    'Healthy',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _floatingBadge(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2419),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF43D88A)
              .withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF61EAA4),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActions(bool desktop) {
    final cards = [
      _ActionData(
        Icons.document_scanner_rounded,
        'Disease Detection',
        'Scan plant images',
        const Color(0xFF36DB86),
      ),
      _ActionData(
        Icons.health_and_safety_rounded,
        'Plant Health',
        'Monitor plant condition',
        const Color(0xFF48C6EF),
      ),
      _ActionData(
        Icons.menu_book_rounded,
        'Knowledge Center',
        'Learn about diseases',
        const Color(0xFFB77AFF),
      ),
    ];

    if (desktop) {
      return Row(
        children: cards.map(
          (card) {
            return Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 15),
                child: _actionCard(card),
              ),
            );
          },
        ).toList(),
      );
    }

    return Column(
      children: cards.map(
        (card) {
          return Padding(
            padding:
                const EdgeInsets.only(bottom: 15),
            child: _actionCard(card),
          );
        },
      ).toList(),
    );
  }

  Widget _actionCard(_ActionData data) {
    return _GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: data.color.withOpacity(0.12),
            ),
            child: Icon(
              data.icon,
              color: data.color,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color:
                        Colors.white.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _features(bool desktop) {
    final features = [
      [
        Icons.biotech_rounded,
        'AI Diagnosis',
        'Identify common coffee plant diseases using intelligent image analysis.',
        const Color(0xFF44E39A),
      ],
      [
        Icons.camera_alt_rounded,
        'Image Analysis',
        'Upload or capture a plant image for instant analysis.',
        const Color(0xFF42C9F5),
      ],
      [
        Icons.lightbulb_rounded,
        'Smart Advice',
        'Receive practical recommendations based on the diagnosis.',
        const Color(0xFFFFC857),
      ],
    ];

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Smart Agriculture Tools',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Everything you need to understand and protect your plants.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 22),

        if (desktop)
          Row(
            children: features.map(
              (f) {
                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 18),
                    child: _featureCard(
                      f[0] as IconData,
                      f[1] as String,
                      f[2] as String,
                      f[3] as Color,
                    ),
                  ),
                );
              },
            ).toList(),
          )
        else
          Column(
            children: features.map(
              (f) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15),
                  child: _featureCard(
                    f[0] as IconData,
                    f[1] as String,
                    f[2] as String,
                    f[3] as Color,
                  ),
                );
              },
            ).toList(),
          ),
      ],
    );
  }

  Widget _featureCard(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.12),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 9),

          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statistics(bool desktop) {
    return _GlassCard(
      child: desktop
          ? Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                _stat('01', 'AI Diagnosis'),
                _divider(),
                _stat('02', 'Image Analysis'),
                _divider(),
                _stat('03', 'Smart Recommendations'),
                _divider(),
                _stat('24/7', 'Agricultural Assistant'),
              ],
            )
          : Column(
              children: [
                _stat('01', 'AI Diagnosis'),
                const SizedBox(height: 25),
                _stat('02', 'Image Analysis'),
                const SizedBox(height: 25),
                _stat('03', 'Smart Recommendations'),
                const SizedBox(height: 25),
                _stat('24/7', 'Agricultural Assistant'),
              ],
            ),
    );
  }

  Widget _stat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Color(0xFF4DE99A),
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _footer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          children: [
            const Icon(
              Icons.eco_rounded,
              color: Color(0xFF39D982),
              size: 25,
            ),
            const SizedBox(height: 8),
            const Text(
              'CoffeeCareAI',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'AI for healthier agriculture',
              style: TextStyle(
                color: Colors.white.withOpacity(0.35),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showScanDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF10291F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: const Text(
            'Plant Diagnosis',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            'The AI disease detection feature will be connected here.',
            style: TextStyle(
              color: Color(0xFF9AC4AD),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFF4DE99A),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ================================================================
// GLASS CARD
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
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color:
                const Color(0xFF10291F).withOpacity(0.65),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.07),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ================================================================
// BACKGROUND
// ================================================================

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
            child: _glow(
              350,
              const Color(0xFF12C978),
            ),
          ),
          Positioned(
            top: 350,
            right: -180,
            child: _glow(
              420,
              const Color(0xFF087DFF),
            ),
          ),
          Positioned(
            bottom: -180,
            left: 250,
            child: _glow(
              400,
              const Color(0xFF8B42FF),
            ),
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
            color: color.withOpacity(0.08),
            blurRadius: 150,
            spreadRadius: 40,
          ),
        ],
      ),
    );
  }
}

// ================================================================
// PULSING DOT
// ================================================================

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() =>
      _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final size = 8 + controller.value * 3;

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF42E796),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF42E796)
                    .withOpacity(0.5),
                blurRadius: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ================================================================
// ACTION DATA
// ================================================================

class _ActionData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  _ActionData(
    this.icon,
    this.title,
    this.subtitle,
    this.color,
  );
}