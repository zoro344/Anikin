
import 'dart:math' as math;
import 'package:flutter/material.dart';

class VaderLogo extends StatelessWidget {
  const VaderLogo({
    super.key,
    this.size = 120,
    this.glow = true,
  });

  final double size;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF9B5CFF);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF08060D),
        borderRadius: BorderRadius.circular(size * 0.24),
        border: Border.all(
          color: purple.withValues(alpha: 0.75),
          width: size * 0.012,
        ),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: purple.withValues(alpha: 0.22),
                  blurRadius: size * 0.22,
                  spreadRadius: size * 0.015,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.08),
        child: CustomPaint(
          painter: _VaderHelmetPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _VaderHelmetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const purple = Color(0xFFAB70FF);
    const brightPurple = Color(0xFFD8B5FF);
    const armor = Color(0xFF171321);
    const black = Color(0xFF050409);

    Path polygon(List<Offset> points) {
      return Path()
        ..moveTo(points.first.dx * w, points.first.dy * h)
        ..addPolygon(
          points.skip(1).map((p) => Offset(p.dx * w, p.dy * h)).toList(),
          true,
        );
    }

    void drawShape(
      List<Offset> points,
      Color color, {
      Color? stroke,
      double strokeWidth = 1,
    }) {
      final path = polygon(points);
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );

      if (stroke != null) {
        canvas.drawPath(
          path,
          Paint()
            ..color = stroke
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth * w
            ..strokeJoin = StrokeJoin.round,
        );
      }
    }

    // Helmet silhouette.
    drawShape(
      const [
        Offset(.50, .035),
        Offset(.76, .12),
        Offset(.91, .34),
        Offset(.86, .64),
        Offset(.70, .86),
        Offset(.50, .96),
        Offset(.30, .86),
        Offset(.14, .64),
        Offset(.09, .34),
        Offset(.24, .12),
      ],
      black,
      stroke: purple,
      strokeWidth: .012,
    );

    // Forehead armor plates.
    drawShape(
      const [
        Offset(.25, .19),
        Offset(.50, .09),
        Offset(.75, .19),
        Offset(.66, .39),
        Offset(.50, .43),
        Offset(.34, .39),
      ],
      armor,
      stroke: const Color(0xFF5A3A82),
      strokeWidth: .008,
    );

    // Central forehead ridge.
    drawShape(
      const [
        Offset(.46, .13),
        Offset(.50, .105),
        Offset(.54, .13),
        Offset(.57, .36),
        Offset(.50, .41),
        Offset(.43, .36),
      ],
      const Color(0xFF282035),
      stroke: purple,
      strokeWidth: .006,
    );

    // Left and right eye armor.
    drawShape(
      const [
        Offset(.18, .40),
        Offset(.38, .34),
        Offset(.47, .43),
        Offset(.40, .51),
        Offset(.23, .49),
      ],
      const Color(0xFF302044),
      stroke: purple,
      strokeWidth: .007,
    );

    drawShape(
      const [
        Offset(.82, .40),
        Offset(.62, .34),
        Offset(.53, .43),
        Offset(.60, .51),
        Offset(.77, .49),
      ],
      const Color(0xFF302044),
      stroke: purple,
      strokeWidth: .007,
    );

    // Eye slits.
    drawShape(
      const [
        Offset(.22, .421),
        Offset(.38, .375),
        Offset(.43, .423),
        Offset(.38, .451),
        Offset(.24, .455),
      ],
      brightPurple,
    );

    drawShape(
      const [
        Offset(.78, .421),
        Offset(.62, .375),
        Offset(.57, .423),
        Offset(.62, .451),
        Offset(.76, .455),
      ],
      brightPurple,
    );

    // Lower face mask.
    drawShape(
      const [
        Offset(.32, .49),
        Offset(.50, .45),
        Offset(.68, .49),
        Offset(.73, .69),
        Offset(.60, .84),
        Offset(.50, .88),
        Offset(.40, .84),
        Offset(.27, .69),
      ],
      const Color(0xFF211A2D),
      stroke: purple,
      strokeWidth: .009,
    );

    // Nose bridge.
    drawShape(
      const [
        Offset(.50, .45),
        Offset(.57, .57),
        Offset(.53, .66),
        Offset(.50, .69),
        Offset(.47, .66),
        Offset(.43, .57),
      ],
      black,
      stroke: const Color(0xFF7950A9),
      strokeWidth: .007,
    );

    // Breathing grille.
    drawShape(
      const [
        Offset(.36, .66),
        Offset(.64, .66),
        Offset(.61, .79),
        Offset(.50, .83),
        Offset(.39, .79),
      ],
      black,
      stroke: purple,
      strokeWidth: .007,
    );

    for (int i = 0; i < 4; i++) {
      final x = (.405 + i * .063) * w;
      canvas.drawLine(
        Offset(x, .695 * h),
        Offset(x, .775 * h),
        Paint()
          ..color = i.isEven ? brightPurple : purple
          ..strokeWidth = w * .012
          ..strokeCap = StrokeCap.round,
      );
    }

    // Cheek armor highlights.
    canvas.drawLine(
      Offset(.20 * w, .56 * h),
      Offset(.31 * w, .70 * h),
      Paint()
        ..color = purple.withValues(alpha: .75)
        ..strokeWidth = w * .012
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawLine(
      Offset(.80 * w, .56 * h),
      Offset(.69 * w, .70 * h),
      Paint()
        ..color = purple.withValues(alpha: .75)
        ..strokeWidth = w * .012
        ..strokeCap = StrokeCap.round,
    );

    // Tiny forehead glint.
    canvas.drawCircle(
      Offset(.50 * w, .16 * h),
      w * .018,
      Paint()
        ..color = brightPurple
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );

    // Small orbit-like accent.
    final orbitRect = Rect.fromCenter(
      center: Offset(.50 * w, .50 * h),
      width: w * 1.02,
      height: h * .40,
    );

    canvas.save();
    canvas.rotate(-math.pi / 5);
    canvas.drawArc(
      orbitRect,
      math.pi * .08,
      math.pi * .43,
      false,
      Paint()
        ..color = purple.withValues(alpha: .8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * .009,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _VaderHelmetPainter oldDelegate) => false;
}
