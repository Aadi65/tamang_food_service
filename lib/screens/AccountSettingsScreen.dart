import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamang_food_service/screens/signin_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool promotionalNotifications = true;

  void signOut(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SigninScreen(),
        ),
      );
    } catch (e) {
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error signing out. Please try again.")),
      );
    }
  }

  void showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout Confirmation"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop();
                signOut(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Account Settings',
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update your settings like notifications, payments, profile edit etc.',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              const SettingsItem(
                  icon: Icons.person_outline,
                  title: 'Profile Information',
                  subtitle: 'Change your account information'),
              const SettingsItem(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  subtitle: 'Change your password'),
              const SettingsItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  subtitle: 'Add your credit & debit cards'),
              const SettingsItem(
                  icon: Icons.location_on_outlined,
                  title: 'Locations',
                  subtitle: 'Add or remove your delivery locations'),
              const SettingsItem(
                  icon: Icons.link,
                  title: 'Add Social Account',
                  subtitle: 'Add Facebook, Twitter etc.'),
              const SettingsItem(
                  icon: Icons.share,
                  title: 'Refer to Friends',
                  subtitle: 'Get \$10 for referring friends'),
              const SizedBox(height: 20),
              Text(
                'NOTIFICATIONS',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              NotificationItem(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                subtitle: 'For daily updates',
                value: pushNotifications,
                onChanged: (value) => setState(() => pushNotifications = value),
              ),
              NotificationItem(
                icon: Icons.message_outlined,
                title: 'SMS Notifications',
                subtitle: 'For daily updates',
                value: smsNotifications,
                onChanged: (value) => setState(() => smsNotifications = value),
              ),
              NotificationItem(
                icon: Icons.campaign_outlined,
                title: 'Promotional Notifications',
                subtitle: 'For daily updates',
                value: promotionalNotifications,
                onChanged: (value) =>
                    setState(() => promotionalNotifications = value),
              ),
              const SizedBox(height: 20),
              Text(
                'MORE',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const SettingsItem(
                  icon: Icons.star_border_outlined,
                  title: 'Rate Us',
                  subtitle: 'Rate us on Play Store, App Store'),
              const SettingsItem(
                  icon: Icons.question_answer_outlined,
                  title: 'FAQ',
                  subtitle: 'Frequently asked questions'),
              SettingsItem(
                icon: Icons.logout,
                title: 'Logout',
                subtitle: '',
                onTap: showLogoutConfirmation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SettingsItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                Icon(icon, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(subtitle,
                            style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(subtitle),
          trailing: Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFFFBC02D),
            ),
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}
