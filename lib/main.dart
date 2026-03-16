import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF1A083A),
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const BStarApp());
}

const Color kPurple  = Color(0xFF2D0F5A);
const Color kPurpleL = Color(0xFF4A1A8A);
const Color kNavy    = Color(0xFF0D2B55);
const Color kGold    = Color(0xFFC9A227);
const Color kGoldD   = Color(0xFF8B6914);
const Color kGoldL   = Color(0xFFFEF9E7);
const Color kBg      = Color(0xFF0A0614);
const Color kCard    = Color(0xFF13082A);
const Color kGreen   = Color(0xFF0A5C36);
const Color kTeal    = Color(0xFF0B6E6E);
const Color kWA      = Color(0xFF25D366);
const String waUrl   = 'https://wa.me/2349060394516?text=Hello%20B.%20Star%20Enterprise%2C%20I%20would%20like%20to%20enquire.';

Future<void> openWA([String? url]) async {
  final uri = Uri.parse(url ?? waUrl);
  if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class BStarApp extends StatelessWidget {
  const BStarApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'B. Star Enterprise',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: kPurple, brightness: Brightness.dark),
      useMaterial3: true,
      scaffoldBackgroundColor: kBg,
    ),
    home: const SplashScreen(),
  );
}

// ── SPLASH ────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashState();
}
class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fade, _scale, _ring;
  @override void initState() {
    super.initState();
    _fade  = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scale = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _ring  = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _fade.forward(); _scale.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, a, __) => FadeTransition(opacity: a, child: const HomeScreen()),
          transitionDuration: const Duration(milliseconds: 600),
        ));
    });
  }
  @override void dispose() { _fade.dispose(); _scale.dispose(); _ring.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color(0xFF0D070F), Color(0xFF1A083A), kPurple],
      )),
      child: Center(child: FadeTransition(
        opacity: CurvedAnimation(parent: _fade, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(parent: _scale, curve: Curves.elasticOut),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Animated ring + emblem
            AnimatedBuilder(animation: _ring, builder: (_, __) => Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: _ring.value * 6.28,
                  child: Container(width: 140, height: 140,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      border: Border.all(color: kGold.withOpacity(0.2), width: 1.5))),
                ),
                Container(width: 120, height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [kPurpleL, kNavy],
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                    border: Border.all(color: kGold, width: 2.5),
                    boxShadow: [BoxShadow(color: kGold.withOpacity(0.35), blurRadius: 30, spreadRadius: 4)],
                  ),
                  child: const Center(child: Text('B★',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: kGold))),
                ),
              ],
            )),
            const SizedBox(height: 28),
            const Text('B. STAR ENTERPRISE', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2.5)),
            const SizedBox(height: 6),
            Container(width: 200, height: 1.5,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.transparent, kGold, Colors.transparent]),
                borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 10),
            const Text('Empowering a Skillful Generation', style: TextStyle(fontSize: 12, color: Color(0xFFB09060), letterSpacing: 0.8)),
            const Text('for Global Impact', style: TextStyle(fontSize: 12, color: Color(0xFFB09060), letterSpacing: 0.8)),
            const SizedBox(height: 36),
            SizedBox(width: 160, child: LinearProgressIndicator(
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(kGold),
              borderRadius: BorderRadius.circular(4),
              minHeight: 3,
            )),
            const SizedBox(height: 20),
            const Text('CAC Reg. No. 8726066', style: TextStyle(fontSize: 10, color: Colors.white24)),
          ]),
        ),
      )),
    ),
  );
}

// ── HOME ──────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeState();
}
class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _idx = 0;
  late TabController _tc;
  @override void initState() { super.initState(); _tc = TabController(length: 3, vsync: this); }
  @override void dispose() { _tc.dispose(); super.dispose(); }

  final _pages = const [ServicesPage(), SchoolsPage(), ContactPage()];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: kBg,
    appBar: AppBar(
      backgroundColor: kPurple,
      elevation: 0,
      titleSpacing: 12,
      title: Row(children: [
        Container(width: 36, height: 36,
          decoration: BoxDecoration(shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [kPurpleL, kNavy]),
            border: Border.all(color: kGold, width: 1.5)),
          child: const Center(child: Text('B★',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: kGold)))),
        const SizedBox(width: 10),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('B. STAR ENTERPRISE', style: TextStyle(
            color: kGold, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
          Text('Empowering a Skillful Generation', style: TextStyle(
            color: Color(0xFFB09060), fontSize: 9, letterSpacing: 0.3)),
        ]),
      ]),
      actions: [
        Container(margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(color: kWA.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kWA.withOpacity(0.4))),
          child: IconButton(
            icon: const Icon(Icons.chat_bubble_rounded, color: kWA, size: 20),
            onPressed: openWA,
            tooltip: 'WhatsApp',
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            constraints: const BoxConstraints(),
          )),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(height: 2,
          decoration: const BoxDecoration(gradient: LinearGradient(
            colors: [Colors.transparent, kGold, Colors.transparent]))),
      ),
    ),
    body: _pages[_idx],
    bottomNavigationBar: Container(
      decoration: BoxDecoration(
        color: kPurple,
        boxShadow: [BoxShadow(color: kGold.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, -2))],
      ),
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _NavItem(icon: Icons.business_center_rounded, label: 'Services', idx: 0, current: _idx, onTap: (i) => setState(() => _idx = i)),
          _NavItem(icon: Icons.school_rounded, label: 'Schools', idx: 1, current: _idx, onTap: (i) => setState(() => _idx = i)),
          _NavItem(icon: Icons.contact_phone_rounded, label: 'Contact', idx: 2, current: _idx, onTap: (i) => setState(() => _idx = i)),
        ]),
      )),
    ),
  );
}

class _NavItem extends StatelessWidget {
  final IconData icon; final String label; final int idx, current;
  final ValueChanged<int> onTap;
  const _NavItem({required this.icon, required this.label, required this.idx, required this.current, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final active = idx == current;
    return GestureDetector(
      onTap: () => onTap(idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: active ? kGold.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: active ? Border.all(color: kGold.withOpacity(0.4)) : null,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: active ? kGold : Colors.white38, size: 22),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(
            fontSize: 10, fontWeight: active ? FontWeight.w700 : FontWeight.w400,
            color: active ? kGold : Colors.white38, letterSpacing: 0.3)),
        ]),
      ),
    );
  }
}

// ── SERVICES ─────────────────────────────────────────────
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  static const _divs = [
    {
      'title': 'Culinary & Food Production',
      'sub': 'Baking · Beverages · Spices · Food Packaging',
      'icon': '🍽️', 'color': 0xFF0A5C36, 'light': 0xFFD5F5E3,
      'items': ['Professional Baking & Confectioneries', 'Beverages Production', 'Spices & Seasoning Production', 'Food Packaging & Branding'],
    },
    {
      'title': 'Beauty & Cosmetology',
      'sub': 'Skincare · Perfume · Soap Making · Bead Making',
      'icon': '💄', 'color': 0xFF4A1A8A, 'light': 0xFFF3EAF8,
      'items': ['Skincare Production', 'Cosmetology & Hair Care', 'Perfume Making', 'Bar Soap Making', 'Bead Making'],
    },
    {
      'title': 'AI & Digital Monetisation',
      'sub': 'AI Content · AI Video · Digital Skills · Freelancing',
      'icon': '🤖', 'color': 0xFF0D2B55, 'light': 0xFFEBF5FB,
      'items': ['AI Content Creation', 'AI Video & Image Creation', 'Digital Skills Monetisation', 'Social Media Business', 'Freelancing & Remote Work'],
    },
    {
      'title': 'ICT & Digital Systems',
      'sub': 'Network Design · Installation · Maintenance',
      'icon': '💻', 'color': 0xFF0B6E6E, 'light': 0xFFD1F2EB,
      'items': ['Network Design & Installation', 'Telecommunications Systems', 'Electrical Systems', 'ICT Maintenance & Support'],
    },
    {
      'title': 'Software & Web Applications',
      'sub': 'Web Dev · Mobile Apps · Hosting · Databases',
      'icon': '⚙️', 'color': 0xFF2D0F5A, 'light': 0xFFEDE7F6,
      'items': ['Web Development', 'Mobile App Development', 'Hosting & Databases', 'Digital Training'],
    },
    {
      'title': 'General Merchandise',
      'sub': 'Consumer Goods · Cosmetics · Confectioneries',
      'icon': '🛒', 'color': 0xFF8B6914, 'light': 0xFFFEF9E7,
      'items': ['Consumer Goods', 'Cosmetics & Beauty Products', 'Confectioneries', 'Branded Merchandise'],
    },
  ];
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(14, 16, 14, 100),
    children: [
      _SectionHeader('Our Business Divisions', 'Six professional training & service divisions'),
      const SizedBox(height: 14),
      ..._divs.map((d) => _DivCard(d: d)),
      const SizedBox(height: 8),
      _WAButton('💬  Enquire About Any Service', waUrl),
    ],
  );
}

class _DivCard extends StatelessWidget {
  final Map d;
  const _DivCard({required this.d});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: kCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kGold.withOpacity(0.2)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(height: 4, decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        color: Color(d['color'] as int))),
      Padding(padding: const EdgeInsets.all(14), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 46, height: 46,
              decoration: BoxDecoration(
                color: Color(d['color'] as int).withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(d['color'] as int).withOpacity(0.5))),
              child: Center(child: Text(d['icon'] as String, style: const TextStyle(fontSize: 22)))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(d['title'] as String, style: const TextStyle(
                color: kGold, fontSize: 14, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(d['sub'] as String, style: TextStyle(
                color: Colors.white.withOpacity(0.5), fontSize: 11)),
            ])),
          ]),
          const SizedBox(height: 10),
          Wrap(spacing: 6, runSpacing: 6,
            children: (d['items'] as List<String>).map((item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: Color(d['color'] as int).withOpacity(0.2),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Color(d['color'] as int).withOpacity(0.4))),
              child: Text(item, style: TextStyle(fontSize: 10,
                color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500)),
            )).toList()),
        ],
      )),
    ]),
  );
}

// ── SCHOOLS ───────────────────────────────────────────────
class SchoolsPage extends StatelessWidget {
  const SchoolsPage({super.key});
  static final _schools = [
    {
      'num': '01', 'icon': '🍽️',
      'name': 'B. Star Culinary & Food Production School',
      'desc': 'Professional training in baking, beverages, spices and food production. Graduate ready for commercial production or entrepreneurship.',
      'color': kGreen,
      'courses': ['Professional Baking', 'Beverages Production', 'Spices & Seasoning', 'Food Packaging & Branding'],
      'msg': 'I%20am%20interested%20in%20the%20Culinary%20%26%20Food%20Production%20School.',
    },
    {
      'num': '02', 'icon': '💄',
      'name': 'B. Star Beauty & Cosmetology School',
      'desc': 'Hands-on beauty and cosmetology training covering skincare formulation, hair care, perfumery, soap making, and artisan jewellery.',
      'color': kPurpleL,
      'courses': ['Skincare Formulation', 'Hair Care & Styling', 'Perfume Making', 'Soap & Bead Making'],
      'msg': 'I%20am%20interested%20in%20the%20Beauty%20%26%20Cosmetology%20School.',
    },
    {
      'num': '03', 'icon': '🤖',
      'name': 'B. Star AI & Digital Monetisation School',
      'desc': 'Forward-looking training in AI tools, digital content creation, social media business, and remote income generation strategies.',
      'color': kNavy,
      'courses': ['AI Content & Video Creation', 'Social Media Business', 'Freelancing & Remote Work', 'Digital Monetisation'],
      'msg': 'I%20am%20interested%20in%20the%20AI%20%26%20Digital%20Monetisation%20School.',
    },
  ];
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(14, 16, 14, 100),
    children: [
      _SectionHeader('B. Star Schools', 'Enrol in a professional training programme'),
      const SizedBox(height: 14),
      ..._schools.map((s) => _SchoolCard(s: s)),
      const SizedBox(height: 8),
      _WAButton('📲  WhatsApp for Enrolment', waUrl),
    ],
  );
}

class _SchoolCard extends StatelessWidget {
  final Map s;
  const _SchoolCard({required this.s});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: kGold.withOpacity(0.3)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 6))],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(gradient: LinearGradient(
            colors: [(s['color'] as Color), kPurple],
            begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Row(children: [
            Text(s['icon'] as String, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('School ${s['num']}', style: TextStyle(
                color: kGold.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1)),
              const SizedBox(height: 3),
              Text(s['name'] as String, style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3)),
            ])),
          ]),
        ),
        Container(color: kCard, padding: const EdgeInsets.all(16), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['desc'] as String, style: TextStyle(
              color: Colors.white.withOpacity(0.65), fontSize: 12, height: 1.6)),
            const SizedBox(height: 12),
            const Text('COURSES', style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w800, color: kGold, letterSpacing: 1)),
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 6,
              children: (s['courses'] as List<String>).map((c) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: kGoldD.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: kGold.withOpacity(0.35))),
                child: Text(c, style: const TextStyle(
                  fontSize: 10, color: kGold, fontWeight: FontWeight.w600)),
              )).toList()),
            const SizedBox(height: 14),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: (s['color'] as Color),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
              label: const Text('Enquire About This School', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              onPressed: () => openWA('https://wa.me/2349060394516?text=${s['msg']}'),
            )),
          ],
        )),
      ]),
    ),
  );
}

// ── CONTACT ───────────────────────────────────────────────
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
    children: [
      // Hero header
      Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(gradient: LinearGradient(
          colors: [kPurple, Color(0xFF1A083A)],
          begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
        child: Column(children: [
          Container(width: 70, height: 70,
            decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [kPurpleL, kNavy]),
              border: Border.all(color: kGold, width: 2),
              boxShadow: [BoxShadow(color: kGold.withOpacity(0.3), blurRadius: 16, spreadRadius: 2)]),
            child: const Center(child: Text('B★',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: kGold)))),
          const SizedBox(height: 12),
          const Text('B. STAR ENTERPRISE', style: TextStyle(
            color: kGold, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 4),
          const Text('"Empowering a Skillful Generation for Global Impact"',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 11, fontStyle: FontStyle.italic, height: 1.5)),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: kWA, foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 4, shadowColor: kWA.withOpacity(0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            icon: const Icon(Icons.chat_bubble_rounded, size: 20),
            label: const Text('Chat on WhatsApp: 09060394516',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            onPressed: openWA,
          )),
        ]),
      ),

      // Info cards
      _InfoCard(icon: Icons.location_on_rounded, color: kGreen,
        label: 'Address',
        value: '6 Opp Solid Rock School\nPolice Sign Board, Lugbe\nFCT Abuja, Nigeria'),
      _InfoCard(icon: Icons.phone_in_talk_rounded, color: kWA,
        label: 'WhatsApp',
        value: '+234 906 039 4516',
        onTap: openWA),
      _InfoCard(icon: Icons.business_rounded, color: kPurpleL,
        label: 'CAC Registration',
        value: 'Reg. No. 8726066\nCompanies and Allied Matters Act 2020'),
      _InfoCard(icon: Icons.receipt_long_rounded, color: kNavy,
        label: 'Tax ID (TIN)',
        value: '33461291-0001\nFederal Inland Revenue Service'),

      const SizedBox(height: 16),

      // Divisions strip
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kCard, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: kGold.withOpacity(0.2))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('OUR DIVISIONS', style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w800, color: kGold, letterSpacing: 1.2)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8,
            children: ['Culinary', 'Beauty', 'AI', 'ICT', 'Software', 'Merchandise']
              .map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kPurple, borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: kGold.withOpacity(0.45))),
                child: Text(s, style: const TextStyle(
                  color: kGold, fontSize: 11, fontWeight: FontWeight.w700))))
              .toList()),
        ]),
      ),
    ],
  );
}

class _InfoCard extends StatelessWidget {
  final IconData icon; final Color color; final String label, value;
  final VoidCallback? onTap;
  const _InfoCard({required this.icon, required this.color, required this.label, required this.value, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: onTap != null ? color.withOpacity(0.4) : kGold.withOpacity(0.15))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 42, height: 42,
          decoration: BoxDecoration(color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.35))),
          child: Icon(icon, color: color, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
            color: color, letterSpacing: 0.5)),
          const SizedBox(height: 3),
          Text(value, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.5)),
        ])),
        if (onTap != null) Icon(Icons.chevron_right_rounded, color: color, size: 20),
      ]),
    ),
  );
}

// ── SHARED ────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title, sub;
  const _SectionHeader(this.title, this.sub);
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.3)),
    const SizedBox(height: 3),
    Text(sub, style: const TextStyle(fontSize: 12, color: Colors.white38)),
    const SizedBox(height: 8),
    Container(height: 2, width: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [kGold, Colors.transparent]),
        borderRadius: BorderRadius.circular(2))),
  ]);
}

class _WAButton extends StatelessWidget {
  final String label, url;
  const _WAButton(this.label, this.url);
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kWA, foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 4, shadowColor: kWA.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () => openWA(url),
      child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
    ));
}
