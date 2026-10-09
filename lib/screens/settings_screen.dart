import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings State
  bool isDarkMode = false;
  bool notificationEnabled = true;
  bool vibrationEnabled = true;

  double textSize = 16;

  String selectedLanguage = 'বাংলা';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'সেটিংস',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),

                    child: const CircleAvatar(
                      radius: 32,

                      backgroundImage: AssetImage('assets/author/author.png'),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'আক্কাছ আলী বুক স্টোর',

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'আপনার পছন্দ অনুযায়ী '
                          'অ্যাপ সাজিয়ে নিন',

                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Appearance
            sectionTitle('অ্যাপের ডিজাইন', Icons.palette_outlined),

            const SizedBox(height: 12),

            settingsCard(
              children: [
                SwitchListTile(
                  secondary: const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.green,
                  ),

                  title: const Text(
                    'ডার্ক মোড',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  subtitle: const Text('অ্যাপের ডার্ক থিম চালু করুন'),

                  value: isDarkMode,

                  activeThumbColor: Colors.green,

                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),

                const Divider(height: 1),

                // Language
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.green),

                  title: const Text(
                    'অ্যাপের ভাষা',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  subtitle: const Text('আপনার পছন্দের ভাষা নির্বাচন করুন'),

                  trailing: DropdownButton<String>(
                    value: selectedLanguage,

                    underline: const SizedBox(),

                    items: const [
                      DropdownMenuItem(value: 'বাংলা', child: Text('বাংলা')),

                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                    ],

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedLanguage = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Reading Settings
            sectionTitle('বই পড়ার সেটিংস', Icons.menu_book_outlined),

            const SizedBox(height: 12),

            settingsCard(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Row(
                        children: [
                          Icon(Icons.format_size, color: Colors.green),

                          SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              'লেখার আকার',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: const [
                          Text('ছোট', style: TextStyle(color: Colors.grey)),

                          Text('বড়', style: TextStyle(color: Colors.grey)),
                        ],
                      ),

                      Slider(
                        value: textSize,
                        min: 12,
                        max: 30,
                        divisions: 9,

                        activeColor: Colors.green,

                        label: textSize.round().toString(),

                        onChanged: (value) {
                          setState(() {
                            textSize = value;
                          });
                        },
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'নমুনা লেখা',
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'বই মানুষের জ্ঞানের আলো। '
                        'বই পড়ুন, জ্ঞান অর্জন করুন।',

                        style: TextStyle(fontSize: textSize, height: 1.6),
                      ),

                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerRight,

                        child: Text(
                          '${textSize.round()} পয়েন্ট',

                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Notification Settings
            sectionTitle('নোটিফিকেশন', Icons.notifications_none),

            const SizedBox(height: 12),

            settingsCard(
              children: [
                SwitchListTile(
                  secondary: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.green,
                  ),

                  title: const Text(
                    'নোটিফিকেশন',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  subtitle: const Text('নতুন বইয়ের নোটিফিকেশন পান'),

                  value: notificationEnabled,

                  activeThumbColor: Colors.green,

                  onChanged: (value) {
                    setState(() {
                      notificationEnabled = value;
                    });
                  },
                ),

                const Divider(height: 1),

                SwitchListTile(
                  secondary: const Icon(Icons.vibration, color: Colors.green),

                  title: const Text(
                    'ভাইব্রেশন',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  subtitle: const Text('অ্যাপ ব্যবহারের সময় ভাইব্রেশন'),

                  value: vibrationEnabled,

                  activeThumbColor: Colors.green,

                  onChanged: (value) {
                    setState(() {
                      vibrationEnabled = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            // General Settings
            sectionTitle('অন্যান্য', Icons.settings_outlined),

            const SizedBox(height: 12),

            settingsCard(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.green),

                  title: const Text('অ্যাপ সম্পর্কে'),

                  subtitle: const Text('অ্যাপের বিস্তারিত তথ্য'),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  onTap: () {
                    Navigator.pop(context);

                    // AboutScreen navigation
                    // Drawer থেকে AboutScreen খুলতে পারো
                  },
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(
                    Icons.privacy_tip_outlined,
                    color: Colors.green,
                  ),

                  title: const Text('গোপনীয়তা নীতি'),

                  subtitle: const Text('Privacy Policy'),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  onTap: () {
                    showInfoDialog(
                      context,
                      'গোপনীয়তা নীতি',
                      'এখানে তোমার অ্যাপের '
                          'Privacy Policy-এর বিস্তারিত '
                          'তথ্য ও ওয়েব লিংক যুক্ত করবে।',
                    );
                  },
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(
                    Icons.contact_support_outlined,
                    color: Colors.green,
                  ),

                  title: const Text('যোগাযোগ করুন'),

                  subtitle: const Text('আমাদের সঙ্গে যোগাযোগ'),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                  onTap: () {
                    Navigator.pop(context);

                    // ContactScreen navigation
                    // Drawer থেকে ContactScreen খুলতে পারো
                  },
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.info, color: Colors.green),

                  title: const Text('অ্যাপ ভার্সন'),

                  trailing: const Text(
                    '১.০.০',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Reset Settings
            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    isDarkMode = false;
                    notificationEnabled = true;
                    vibrationEnabled = true;
                    textSize = 16;
                    selectedLanguage = 'বাংলা';
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('সেটিংস ডিফল্ট অবস্থায় ফিরিয়ে আনা হয়েছে'),
                    ),
                  );
                },

                icon: const Icon(Icons.restart_alt),

                label: const Text(
                  'সেটিংস রিসেট করুন',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green,

                  side: const BorderSide(color: Colors.green),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Footer
            const Center(
              child: Text(
                'আক্কাছ আলী বুক স্টোর',

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 6),

            const Center(
              child: Text(
                'বই হোক জ্ঞানের আলো',

                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 23),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // Settings Card
  Widget settingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: Colors.grey.shade200),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(children: children),
    );
  }

  // Information Dialog
  void showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(title),

          content: Text(message),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'ঠিক আছে',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
