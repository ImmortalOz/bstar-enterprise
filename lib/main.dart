import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const BStarApp());
}

const Color kPurple = Color(0xFF2D0F5A);
const Color kGold   = Color(0xFFC9A227);
const String kWA    = 'https://wa.me/2349060394516?text=Hello%20B.%20Star%20Enterprise';

Future<void> openWA() async {
  final uri = Uri.parse(kWA);
  if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class BStarApp extends StatelessWidget {
  const BStarApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'B. Star Enterprise',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: kPurple), useMaterial3: true),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeState();
}
class _HomeState extends State<HomeScreen> {
  int _idx = 0;
  final _pages = const [ServicesPage(), SchoolsPage(), ContactPage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF0A0614),
    appBar: AppBar(
      backgroundColor: kPurple,
      title: const Text('B. STAR ENTERPRISE',
        style: TextStyle(color: kGold, fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 1)),
    ),
    body: _pages[_idx],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _idx,
      onTap: (i) => setState(() => _idx = i),
      backgroundColor: kPurple,
      selectedItemColor: kGold,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'Services'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Schools'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Contact'),
      ],
    ),
  );
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  static const _divs = [
    ['Culinary & Food Production','Baking · Beverages · Spices · Food Packaging',0xFF0A5C36],
    ['Beauty & Cosmetology','Skincare · Perfume · Soap Making · Bead Making',0xFF4A1A8A],
    ['AI & Digital Monetisation','AI Content · AI Video · Digital Skills · Freelancing',0xFF0D2B55],
    ['ICT & Digital Systems','Network Design · Installation · Maintenance',0xFF0B6E6E],
    ['Software & Web Applications','Web Dev · Mobile Apps · Hosting · Databases',0xFF2D0F5A],
    ['General Merchandise','Consumer Goods · Cosmetics · Confectioneries',0xFF8B6914],
  ];
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(14),
    children: _divs.map((d) => Card(
      color: Color(d[2] as int),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: kGold, width: .8)),
      child: Padding(padding: const EdgeInsets.all(14), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d[0] as String, style: const TextStyle(color: kGold, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(d[1] as String, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ])),
    )).toList(),
  );
}

class SchoolsPage extends StatelessWidget {
  const SchoolsPage({super.key});
  static const _schools = [
    ['B. Star Culinary & Food Production School', 0xFF0A5C36],
    ['B. Star Beauty & Cosmetology School', 0xFF4A1A8A],
    ['B. Star AI & Digital Monetisation School', 0xFF0D2B55],
  ];
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(14),
    children: [
      ..._schools.map((s) => Card(
        color: Color(s[1] as int),
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: kGold, width: 1)),
        child: Padding(padding: const EdgeInsets.all(16),
          child: Text(s[0] as String,
            style: const TextStyle(color: kGold, fontSize: 14, fontWeight: FontWeight.bold, height: 1.4))),
      )),
      const SizedBox(height: 8),
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366),
          foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        icon: const Icon(Icons.chat_bubble),
        label: const Text('Enquire About Enrolment', style: TextStyle(fontWeight: FontWeight.w800)),
        onPressed: openWA,
      ),
    ],
  );
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(children: [
      const SizedBox(height: 20),
      const Text('B. STAR ENTERPRISE', style: TextStyle(color: kGold,
        fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      const SizedBox(height: 8),
      const Text('"Empowering a Skillful Generation for Global Impact"',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic, height: 1.5)),
      const SizedBox(height: 24),
      const _CRow(Icons.location_on, '6 Opp Solid Rock School, Police Sign Board, Lugbe, FCT Abuja'),
      const _CRow(Icons.badge, 'CAC Reg. No. 8726066 · TIN: 33461291-0001'),
      const SizedBox(height: 24),
      SizedBox(width: double.infinity, child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366),
          foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        icon: const Icon(Icons.chat_bubble, size: 20),
        label: const Text('Chat on WhatsApp: 09060394516',
          style: TextStyle(fontWeight: FontWeight.w800)),
        onPressed: openWA,
      )),
    ]),
  );
}

class _CRow extends StatelessWidget {
  final IconData icon; final String text;
  const _CRow(this.icon, this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: kGold, size: 18),
      const SizedBox(width: 10),
      Expanded(child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5))),
    ]),
  );
}
