import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2D0F5A)));
  runApp(const BStarApp());
}

class BStarApp extends StatelessWidget {
  const BStarApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'B. Star Enterprise',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFC9A227),
        secondary: Color(0xFF4A1A8A),
        surface: Color(0xFF2D0F5A)),
      useMaterial3: true,
    ),
    home: const SplashScreen(),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400));
    _a = CurvedAnimation(parent: _c, curve: Curves.easeIn);
    _c.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF2D0F5A),
    body: FadeTransition(
      opacity: _a,
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150, height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFC9A227), width: 3),
              color: const Color(0xFF4A1A8A)),
            child: const Icon(Icons.star,
              color: Color(0xFFC9A227), size: 80),
          ),
          const SizedBox(height: 30),
          const Text('B. STAR ENTERPRISE',
            style: TextStyle(
              color: Color(0xFFC9A227),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5)),
          const SizedBox(height: 12),
          const Text(
            'Empowering a Skillful Generation\nfor Global Impact',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13, height: 1.5)),
          const SizedBox(height: 40),
          const CircularProgressIndicator(
            color: Color(0xFFC9A227), strokeWidth: 2.5),
          const SizedBox(height: 40),
          const Text('CAC Reg. No. 8726066',
            style: TextStyle(
              color: Colors.white30, fontSize: 10)),
        ],
      )),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _idx = 0;
  final _pages = const [
    ServicesPage(),
    SchoolsPage(),
    ContactPage()
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF0A0614),
    appBar: AppBar(
      backgroundColor: const Color(0xFF2D0F5A),
      title: const Row(children: [
        Icon(Icons.star, color: Color(0xFFC9A227), size: 28),
        SizedBox(width: 10),
        Text('B. STAR ENTERPRISE',
          style: TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold)),
      ]),
    ),
    body: _pages[_idx],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _idx,
      onTap: (i) => setState(() => _idx = i),
      backgroundColor: const Color(0xFF2D0F5A),
      selectedItemColor: const Color(0xFFC9A227),
      unselectedItemColor: Colors.white54,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.business), label: 'Services'),
        BottomNavigationBarItem(
          icon: Icon(Icons.school), label: 'Schools'),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone), label: 'Contact'),
      ],
    ),
  );
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) =>
    ListView(padding: const EdgeInsets.all(16), children: const [
      _SCard('🍽️ Culinary & Food Production',
        'Baking · Beverages · Spices · Packaging',
        Color(0xFF0A5C36)),
      _SCard('💄 Beauty & Cosmetology',
        'Skincare · Perfume · Soap · Bead Making',
        Color(0xFF4A1A8A)),
      _SCard('🤖 AI & Digital Monetisation',
        'AI Content · Video · Digital Skills',
        Color(0xFF0D2B55)),
      _SCard('💻 ICT & Digital Systems',
        'Network · Installation · Maintenance',
        Color(0xFF0B6E6E)),
      _SCard('⚙️ Software & Web Apps',
        'Web Dev · Mobile Apps · Hosting',
        Color(0xFF7B0D1E)),
      _SCard('🛒 General Merchandise',
        'Consumer Goods · Cosmetics · Confectioneries',
        Color(0xFFB84A00)),
    ]);
}

class _SCard extends StatelessWidget {
  final String title, sub;
  final Color color;
  const _SCard(this.title, this.sub, this.color);

  @override
  Widget build(BuildContext context) => Card(
    color: color,
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(
        color: Color(0xFFC9A227), width: 1)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 15,
            fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(sub, style: const TextStyle(
            color: Colors.white70, fontSize: 13)),
        ])));
}

class SchoolsPage extends StatelessWidget {
  const SchoolsPage({super.key});
  @override
  Widget build(BuildContext context) =>
    ListView(padding: const EdgeInsets.all(16), children: const [
      _School('01', 'B. Star Culinary & Food Production School',
        ['Baking', 'Beverages Production',
         'Spices Production', 'Food Packaging'],
        Color(0xFF0A5C36)),
      _School('02', 'B. Star Beauty & Cosmetology School',
        ['Skincare Production', 'Cosmetology',
         'Perfume Making', 'Soap Making', 'Bead Making'],
        Color(0xFF4A1A8A)),
      _School('03', 'B. Star AI & Digital School',
        ['AI Content Creation', 'AI Video Creation',
         'Digital Monetisation', 'Social Media Business'],
        Color(0xFF0D2B55)),
    ]);
}

class _School extends StatelessWidget {
  final String num, name;
  final List<String> items;
  final Color c;
  const _School(this.num, this.name, this.items, this.c);

  @override
  Widget build(BuildContext context) => Card(
    color: c,
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(
        color: Color(0xFFC9A227), width: 1.5)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(num, style: const TextStyle(
            color: Color(0x44C9A227),
            fontSize: 36,
            fontWeight: FontWeight.w900)),
          Text(name, style: const TextStyle(
            color: Color(0xFFC9A227),
            fontSize: 14,
            fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...items.map((i) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(children: [
              const Icon(Icons.diamond_outlined,
                color: Color(0x88C9A227), size: 12),
              const SizedBox(width: 6),
              Text(i, style: const TextStyle(
                color: Colors.white70, fontSize: 13)),
            ]))),
        ])));
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) =>
    Center(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFC9A227), width: 3),
              color: const Color(0xFF4A1A8A)),
            child: const Icon(Icons.star,
              color: Color(0xFFC9A227), size: 60)),
          const SizedBox(height: 24),
          const Text('B. STAR ENTERPRISE',
            style: TextStyle(
              color: Color(0xFFC9A227),
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5)),
          const SizedBox(height: 8),
          const Text(
            'Empowering a Skillful Generation\nfor Global Impact',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13, height: 1.5)),
          const SizedBox(height: 24),
          _CRow(Icons.location_on,
            '6 Opp Solid Rock School, Lugbe, FCT, Abuja'),
          _CRow(Icons.badge,
            'CAC Reg. No. 8726066 · TIN: 33461291-0001'),
          _CRow(Icons.phone, 'WhatsApp: 09060394516'),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat,
              color: Color(0xFF2D0F5A)),
            label: const Text('Chat on WhatsApp',
              style: TextStyle(
                color: Color(0xFF2D0F5A),
                fontWeight: FontWeight.bold,
                fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC9A227),
              padding: const EdgeInsets.symmetric(
                horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
          ),
        ])));
}

class _CRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _CRow(this.icon, this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      Icon(icon, color: const Color(0xFFC9A227), size: 18),
      const SizedBox(width: 10),
      Expanded(child: Text(text,
        style: const TextStyle(
          color: Colors.white70, fontSize: 12))),
    ]));
}
