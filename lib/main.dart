623
624
625
626
627
628
629
630
631
632
633
634
635
636
637
638
639
640
641
642
643
644
645
646
647
648
649
650
651
652
653
654
655
656
657
658
659
660
661
662
663
664
665
666
667
668
669
670
671
672
673
674
675
676
677
678
679
680
681
682
683
684
685
686
687
688
689
690
691
692
693
694
695
696
// Datalogger 9 assi - app Flutter (Android)
          ),
          Expanded(child: TabBarView(children: [sensorTab(), wtTab(1), wtTab(2), toolsTab()])),
        ]),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final List<List<double>> data;
  final List<int> idx;
  final double off;
  final Color grid;
  final Color textColor;
  static const List<Color> cols = [Color(0xFFE5484D), Color(0xFF30A46C), Color(0xFF3E63DD)];

  LinePainter(this.data, this.idx, this.off, this.grid, this.textColor);

  @override
  void paint(Canvas c, Size s) {
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..color = grid
      ..strokeWidth = 0.5;
    c.drawRect(Offset.zero & s, border);
    if (data.length < 2) return;
    double lo = double.infinity, hi = -double.infinity;
    for (final r in data) {
      for (final k in idx) {
        final v = r[k] - off;
        lo = math.min(lo, v);
        hi = math.max(hi, v);
      }
    }
    if (hi - lo < 1e-6) {
      hi += 0.5;
      lo -= 0.5;
    }
    final pad = (hi - lo) * 0.1;
    lo -= pad;
    hi += pad;
    for (int j = 0; j < idx.length; j++) {
      final p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = cols[idx.length > 1 ? j : 2];
      final path = Path();
      for (int i = 0; i < data.length; i++) {
        final x = s.width * (i / (data.length - 1));
        final y = s.height - (data[i][idx[j]] - off - lo) / (hi - lo) * s.height;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      c.drawPath(path, p);
    }
    label(c, hi.toStringAsFixed(1), const Offset(3, 2));
    label(c, lo.toStringAsFixed(1), Offset(3, s.height - 14));
  }

  void label(Canvas c, String t, Offset o) {
    final tp = TextPainter(
      text: TextSpan(text: t, style: TextStyle(fontSize: 10, color: textColor)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(c, o);
  }

  @override
  bool shouldRepaint(covariant LinePainter old) => true;
}

Use Control + Shift + m to toggle the tab key moving focus. Alternatively, use esc then tab to move to the next interactive element on the pa
