import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mymotorcycle/features/home/presentation/pages/home_page.dart';

/// Splash kiểu “premium HUD”: nền than, vòng công nghệ cyan, xe [sh160i.png],
/// ánh sáng quét nhẹ — bám theo style ảnh tham chiếu (không cần Lottie).
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const int minDisplayMs = 2800;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _hudLoop;
  late final AnimationController _intro;
  late final Animation<double> _introFade;
  late final Animation<double> _introScale;
  DateTime? _shownAt;
  bool _navigated = false;

  static const Color _cyan = Color(0xFF00D4FF);

  @override
  void initState() {
    super.initState();
    _shownAt = DateTime.now();

    _hudLoop = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _introFade = CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic);
    _introScale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic),
    );
    _intro.forward();

    Future<void>.delayed(
      const Duration(milliseconds: SplashPage.minDisplayMs),
      _goToHomeAfterMinimum,
    );
  }

  Future<void> _goToHomeAfterMinimum() async {
    if (_navigated || !mounted) return;
    final start = _shownAt ?? DateTime.now();
    final minEnd = start.add(
      const Duration(milliseconds: SplashPage.minDisplayMs),
    );
    final wait = minEnd.difference(DateTime.now());
    if (wait > Duration.zero) {
      await Future<void>.delayed(wait);
    }
    if (!mounted || _navigated) return;
    _navigated = true;
    await Navigator.of(context).pushReplacement<void, void>(
      PageRouteBuilder<void>(
        settings: const RouteSettings(name: 'HomePage'),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomePage(),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _hudLoop.dispose();
    _intro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFF020203),
      extendBody: true,
      extendBodyBehindAppBar: true,
      // Bỏ padding hệ thống cho lớp nền/HUD/ảnh — vẽ full từ cạnh tới cạnh.
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0A0E12),
                      Color(0xFF020203),
                      Color(0xFF000000),
                    ],
                    stops: [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _hudLoop,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _TechHudPainter(
                      t: _hudLoop.value,
                      cyan: _cyan,
                    ),
                  );
                },
              ),
            ),
            ..._streakLayer(size),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.12),
                    radius: 1.05,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.55),
                      Colors.black.withValues(alpha: 0.88),
                    ],
                    stops: const [0.35, 0.72, 1.0],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: FadeTransition(
                opacity: _introFade,
                child: ScaleTransition(
                  scale: _introScale,
                  alignment: Alignment.center,
                  child: AnimatedBuilder(
                    animation: _hudLoop,
                    builder: (context, child) {
                      final sweep = (_hudLoop.value * 2 - 1) * 1.15;
                      return ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (bounds) {
                          return ui.Gradient.linear(
                            Offset(
                              bounds.left + sweep * bounds.width * 0.4,
                              0,
                            ),
                            Offset(
                              bounds.right + sweep * bounds.width * 0.25,
                              0,
                            ),
                            [
                              Colors.white.withValues(alpha: 0),
                              Colors.white.withValues(alpha: 0.22),
                              Colors.white.withValues(alpha: 0),
                            ],
                            const [0.38, 0.5, 0.62],
                          );
                        },
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'sh160i.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: const Alignment(0, 0.08),
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: padding.bottom + 24,
              child: FadeTransition(
                opacity: _introFade,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MY MOTORCYCLE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w300,
                        color: _cyan.withValues(alpha: 0.75),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'SH 160i',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withValues(alpha: 0.92),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Vệt sáng ngang mờ (chiều sâu).
  List<Widget> _streakLayer(Size size) {
    return List<Widget>.generate(5, (i) {
      final y = size.height * (0.12 + i * 0.18);
      return Positioned(
        top: y,
        left: 0,
        right: 0,
        height: 1,
        child: AnimatedBuilder(
          animation: _hudLoop,
          builder: (context, child) {
            final o = 0.04 + 0.05 * math.sin(_hudLoop.value * math.pi * 2 + i);
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    _cyan.withValues(alpha: o),
                    Colors.transparent,
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

/// Vòng HUD / blueprint quanh tâm (xoay chậm, nét mảnh).
class _TechHudPainter extends CustomPainter {
  _TechHudPainter({required this.t, required this.cyan});

  final double t;
  final Color cyan;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.44;
    final center = Offset(cx, cy);

    void arcRing({
      required double radius,
      required double startDeg,
      required double sweepDeg,
      required double rotSpeed,
      required double opacity,
      double strokeWidth = 1.2,
    }) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final start = (startDeg * math.pi / 180) + t * math.pi * 2 * rotSpeed;
      final sweep = sweepDeg * math.pi / 180;
      final paint = Paint()
        ..color = cyan.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, start, sweep, false, paint);
    }

    // Nhiều cung lệch pha — giống blueprint HUD
    arcRing(
      radius: size.shortestSide * 0.42,
      startDeg: -95,
      sweepDeg: 115,
      rotSpeed: 0.12,
      opacity: 0.45,
    );
    arcRing(
      radius: size.shortestSide * 0.36,
      startDeg: -40,
      sweepDeg: 95,
      rotSpeed: -0.09,
      opacity: 0.35,
      strokeWidth: 1,
    );
    arcRing(
      radius: size.shortestSide * 0.52,
      startDeg: 120,
      sweepDeg: 80,
      rotSpeed: 0.07,
      opacity: 0.28,
    );
    arcRing(
      radius: size.shortestSide * 0.62,
      startDeg: -130,
      sweepDeg: 70,
      rotSpeed: -0.05,
      opacity: 0.18,
    );

    // Chấm / tick nhỏ dọc cung
    final tickPaint = Paint()
      ..color = cyan.withValues(alpha: 0.35)
      ..strokeWidth = 1;
    for (var i = 0; i < 28; i++) {
      final a = -math.pi * 0.65 + (i / 27) * math.pi * 1.1 + t * math.pi * 0.25;
      final r0 = size.shortestSide * 0.34;
      final r1 = r0 + 5 + (i % 3) * 2.0;
      final o = Offset(cx + math.cos(a) * r0, cy + math.sin(a) * r0);
      final o2 = Offset(cx + math.cos(a) * r1, cy + math.sin(a) * r1);
      canvas.drawLine(o, o2, tickPaint);
    }

    // Hạt sáng mờ (vị trí cố định theo index — tránh Random trong paint)
    for (var i = 0; i < 36; i++) {
      final px = size.width * (0.08 + 0.84 * (0.5 + 0.5 * math.sin(i * 2.17 + 1.2)));
      final py = size.height * (0.12 + 0.55 * (0.5 + 0.5 * math.cos(i * 1.73 + 0.4)));
      final pulse = 0.5 + 0.5 * math.sin(t * math.pi * 2 * 2 + i * 0.7);
      final p = Paint()
        ..color = cyan.withValues(alpha: 0.06 + 0.14 * pulse);
      canvas.drawCircle(Offset(px, py), 0.7 + pulse * 0.65, p);
    }
  }

  @override
  bool shouldRepaint(covariant _TechHudPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.cyan != cyan;
  }
}
