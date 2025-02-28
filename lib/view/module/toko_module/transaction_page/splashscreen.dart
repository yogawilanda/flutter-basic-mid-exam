import 'package:flutter/material.dart';
import 'package:user_mortgage_app/view/module/toko_module/transaction_page/customer_shop.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Atur durasi animasi
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Total durasi animasi
    );

    // Animasi opacity (fade-in dan fade-out)
    _opacityAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn), // Fade-in di paruh pertama
      ),
    );

    // Animasi scale Icon
    _scaleAnimation = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeInOut), // Scale di paruh pertama
      ),
    );

    // Animasi slide teks
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.3), // Mulai dari bawah
      end: Offset(0.0, 0.0), // Berakhir di posisi normal
    ).animate(
      CurvedAnimation(
        parent: _controller,
        // Slide di paruh kedua
        curve: const Interval(0.1, 0.4, curve: Curves.easeOut), 
      ),
    );

    // Mulai animasi
    _controller.forward();

    // Setelah animasi selesai, navigasi ke halaman utama
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => CustomerShop()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang splash screen
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dengan animasi opacity dan scale
                Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Image.asset(
                      'assets/icon/android-chrome-512x512.png', // Ganti dengan path logo Anda
                      width: 150,
                      height: 150,
                      // filter the color to be green
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Teks dengan animasi slide
                SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    'Occupio - POS System',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}