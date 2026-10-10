import 'dart:ui';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _WelcomeBackground(),

          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        _buildLogo(),

                        const SizedBox(height: 35),

                        _buildPlantAnimation(),

                        const SizedBox(height: 30),

                        const Text(
                          'Welcome to',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF9BEBC0),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'CoffeeCareAI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Smart Agriculture. Better Farming.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF56E69A),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          'Empowering farmers with artificial intelligence '
                          'to detect plant diseases, monitor crop health, '
                          'and make smarter farming decisions.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.62),
                            fontSize: 14,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 35),

                        _buildFeatureRow(),

                        const SizedBox(height: 35),

                        _buildButtons(),

                        const SizedBox(height: 25),

                        Text(
                          'AI-powered agricultural assistance',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.35),
                            fontSize: 11,
                          ),
                        ),

                        const SizedBox(height: 20),
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

  Widget _buildLogo() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF62F0A5),
            Color(0xFF0BA866),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2BE187).withOpacity(0.35),
            blurRadius: 35,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Icon(
        Icons.eco_rounded,
        color: Colors.white,
        size: 42,
      ),
    );
  }

  Widget _buildPlantAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 0.96 + (_controller.value * 0.06);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: 230,
            height: 230,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF36E995).withOpacity(0.22),
                  const Color(0xFF36E995).withOpacity(0.06),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2FE28D).withOpacity(0.18),
                  blurRadius: 80,
                  spreadRadius: 15,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4CE99B)
                          .withOpacity(0.18),
                    ),
                  ),
                ),

                Container(
                  width: 135,
                  height: 135,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4CE99B)
                          .withOpacity(0.25),
                    ),
                  ),
                ),

                const Icon(
                  Icons.spa_rounded,
                  color: Color(0xFF62EFA4),
                  size: 105,
                ),

                Positioned(
                  top: 22,
                  right: 18,
                  child: _smallBadge(
                    Icons.psychology_rounded,
                    'AI',
                  ),
                ),

                Positioned(
                  bottom: 22,
                  left: 15,
                  child: _smallBadge(
                    Icons.health_and_safety_rounded,
                    'Plant Health',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _smallBadge(IconData icon, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0A2117).withOpacity(0.85),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF55E9A0).withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: const Color(0xFF63EBA6),
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _feature(
          Icons.document_scanner_rounded,
          'Detect',
        ),
        _feature(
          Icons.monitor_heart_rounded,
          'Monitor',
        ),
        _feature(
          Icons.lightbulb_rounded,
          'Improve',
        ),
      ],
    );
  }

  Widget _feature(IconData icon, String title) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF123525),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF36D987).withOpacity(0.25),
            ),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF56E69A),
            size: 22,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.65),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _goToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3FE494),
              foregroundColor: const Color(0xFF062015),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login_rounded),
                SizedBox(width: 10),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: _goToRegister,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                color: const Color(0xFF42D88F).withOpacity(0.55),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add_alt_1_rounded),
                SizedBox(width: 10),
                Text(
                  'Create Farmer Account',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// BACKGROUND
// ============================================================

class _WelcomeBackground extends StatelessWidget {
  const _WelcomeBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF04130C),
            Color(0xFF08251A),
            Color(0xFF03100A),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            left: -120,
            child: _glow(
              400,
              const Color(0xFF16D77D),
            ),
          ),
          Positioned(
            top: 300,
            right: -200,
            child: _glow(
              450,
              const Color(0xFF087DFF),
            ),
          ),
          Positioned(
            bottom: -200,
            left: 100,
            child: _glow(
              450,
              const Color(0xFF7B3FE4),
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
            blurRadius: 160,
            spreadRadius: 50,
          ),
        ],
      ),
    );
  }
}