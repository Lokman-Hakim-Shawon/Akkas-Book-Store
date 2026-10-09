import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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
          'যোগাযোগ করুন',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    const Icon(
                      Icons.support_agent_rounded,
                      color: Colors.white,
                      size: 55,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'আমরা আপনার পাশে আছি',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'আপনার কোনো প্রশ্ন, মতামত বা '
                      'পরামর্শ থাকলে আমাদের সঙ্গে '
                      'যোগাযোগ করুন।',

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Contact Information
              sectionTitle('যোগাযোগের তথ্য'),

              const SizedBox(height: 15),

              contactCard(
                icon: Icons.email_outlined,
                title: 'ইমেইল',
                subtitle: 'আপনার ইমেইল ঠিকানা এখানে দিন',
                color: Colors.blue,
              ),

              contactCard(
                icon: Icons.phone_outlined,
                title: 'মোবাইল',
                subtitle: 'আপনার ফোন নম্বর এখানে দিন',
                color: Colors.green,
              ),

              contactCard(
                icon: Icons.language,
                title: 'ওয়েবসাইট',
                subtitle: 'আপনার ওয়েবসাইট এখানে দিন',
                color: Colors.orange,
              ),

              const SizedBox(height: 25),

              // Developer Profile
              sectionTitle('অ্যাপ নির্মাতা'),

              const SizedBox(height: 15),

              Card(
                elevation: 1,
                color: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Row(
                    children: [
                      // Developer Image
                      Container(
                        padding: const EdgeInsets.all(3),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(color: Colors.green, width: 2),
                        ),

                        child: const CircleAvatar(
                          radius: 32,

                          backgroundImage: AssetImage('assets/lokman.png'),
                        ),
                      ),

                      const SizedBox(width: 15),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'লোকমান হাকিম',

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'অ্যাপ ডেভেলপার',

                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'বাংলা বই ও প্রযুক্তির প্রতি '
                              'আগ্রহ থেকে তৈরি এই অ্যাপ।',

                              style: TextStyle(fontSize: 13, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Contact Form
              sectionTitle('আপনার মতামত জানান'),

              const SizedBox(height: 8),

              const Text(
                'নিচের ফর্মটি পূরণ করে আপনার '
                'মতামত বা বার্তা লিখুন।',

                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 18),

              Form(
                key: _formKey,

                child: Column(
                  children: [
                    // Name
                    TextFormField(
                      controller: _nameController,

                      decoration: inputDecoration(
                        label: 'আপনার নাম',
                        hint: 'আপনার নাম লিখুন',
                        icon: Icons.person_outline,
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'আপনার নাম লিখুন';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,

                      keyboardType: TextInputType.emailAddress,

                      decoration: inputDecoration(
                        label: 'ইমেইল ঠিকানা',
                        hint: 'example@email.com',
                        icon: Icons.email_outlined,
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'ইমেইল ঠিকানা লিখুন';
                        }

                        final emailRegex = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        );

                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'সঠিক ইমেইল ঠিকানা দিন';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Message
                    TextFormField(
                      controller: _messageController,

                      maxLines: 5,

                      decoration: inputDecoration(
                        label: 'আপনার বার্তা',
                        hint: 'এখানে আপনার বার্তা লিখুন',
                        icon: Icons.message_outlined,
                      ),

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'আপনার বার্তা লিখুন';
                        }

                        if (value.trim().length < 10) {
                          return 'কমপক্ষে ১০টি অক্ষর লিখুন';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    // Send Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'ফর্ম সঠিকভাবে পূরণ হয়েছে। '
                                  'বার্তা পাঠানোর জন্য '
                                  'Backend প্রয়োজন।',
                                ),
                              ),
                            );
                          }
                        },

                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),

                        label: const Text(
                          'বার্তা পাঠান',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Footer
              const Center(
                child: Text(
                  'আক্কাছ আলী বুক স্টোর',

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Center(
                child: Text(
                  'আপনার পাশে, বইয়ের সাথে',

                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Section Title
  Widget sectionTitle(String title) {
    return Text(
      title,

      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  // Contact Card
  Widget contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: color, size: 27),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,

                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Input Decoration
  InputDecoration inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,

      prefixIcon: Icon(icon, color: Colors.green),

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.green, width: 2),
      ),
    );
  }
}
