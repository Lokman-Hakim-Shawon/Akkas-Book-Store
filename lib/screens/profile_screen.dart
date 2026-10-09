import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),

      appBar: AppBar(
        title: const Text(
          'আমার প্রোফাইল',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // =========================
            // Profile Header
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundColor: Color(0xFFE8F5E9),
                      // child: Icon(Icons.person, size: 55, color: Colors.green),
                      backgroundImage: AssetImage('assets/images/author.png'),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'আমার প্রোফাইল',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Akkas Book Store-এর পাঠক',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // Reading Statistics
            // =========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.menu_book,
                      title: 'পড়া বই',
                      value: '0',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.favorite,
                      title: 'পছন্দের বই',
                      value: '0',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.history,
                      title: 'ইতিহাস',
                      value: '0',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // Profile Information
            // =========================
            _buildSectionTitle('প্রোফাইল তথ্য'),

            _buildProfileTile(
              icon: Icons.person_outline,
              title: 'নাম',
              subtitle: 'আমার নাম',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.email_outlined,
              title: 'ই-মেইল',
              subtitle: 'ই-মেইল যোগ করা হয়নি',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.phone_outlined,
              title: 'মোবাইল নম্বর',
              subtitle: 'মোবাইল নম্বর যোগ করা হয়নি',
              onTap: () {},
            ),

            const SizedBox(height: 15),

            // =========================
            // Reading Section
            // =========================
            _buildSectionTitle('পাঠ কার্যক্রম'),

            _buildProfileTile(
              icon: Icons.favorite_border,
              title: 'পছন্দের বই',
              subtitle: 'আপনার পছন্দের বইগুলো দেখুন',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.bookmark_border,
              title: 'সংরক্ষিত বই',
              subtitle: 'পরে পড়ার জন্য রাখা বই',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.history,
              title: 'পাঠের ইতিহাস',
              subtitle: 'সম্প্রতি পড়া বইগুলো দেখুন',
              onTap: () {},
            ),

            const SizedBox(height: 15),

            // =========================
            // Settings
            // =========================
            _buildSectionTitle('অ্যাকাউন্ট ও সেটিংস'),

            _buildProfileTile(
              icon: Icons.notifications_none,
              title: 'নোটিফিকেশন',
              subtitle: 'নোটিফিকেশন সেটিংস পরিবর্তন করুন',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.settings_outlined,
              title: 'সেটিংস',
              subtitle: 'অ্যাপের বিভিন্ন সেটিংস',
              onTap: () {},
            ),

            _buildProfileTile(
              icon: Icons.info_outline,
              title: 'অ্যাপ সম্পর্কে',
              subtitle: 'Akkas Book Store সম্পর্কে জানুন',
              onTap: () {},
            ),

            const SizedBox(height: 25),

            // =========================
            // Logout Button
            // =========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('লগআউট করার জন্য আগে লগইন করতে হবে।'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'লগআউট',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =========================
            // Footer
            // =========================
            const Text(
              'Akkas Book Store',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'বাংলা সাহিত্য পড়ুন, সংরক্ষণ করুন',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // =========================
  // Statistics Card
  // =========================
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.green, size: 27),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // =========================
  // Section Title
  // =========================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222522),
          ),
        ),
      ),
    );
  }

  // =========================
  // Profile Tile
  // =========================
  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),

        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.green),
        ),

        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.grey,
        ),
      ),
    );
  }
}
