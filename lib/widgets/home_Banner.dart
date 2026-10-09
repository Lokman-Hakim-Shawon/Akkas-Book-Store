import 'dart:async';

import 'package:flutter/material.dart';
import 'package:akkas_app_store/services/json_service.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  // ==========================================
  // Page Controller
  // ==========================================

  final PageController _pageController = PageController();

  // ==========================================
  // Current Banner Index
  // ==========================================

  int currentIndex = 0;

  // ==========================================
  // Auto Slide Timer
  // ==========================================

  Timer? _timer;

  // ==========================================
  // Banner List
  // ==========================================

  List<String> banners = [];

  @override
  void initState() {
    super.initState();

    _loadBanners();
  }

  // ==========================================
  // LOAD BANNERS FROM api.json
  // ==========================================

  Future<void> _loadBanners() async {
    try {
      // Load complete api.json
      final data = await JsonService.loadJson('api');

      // api.json structure:
      //
      // data
      //   └── banners
      //
      final bannerData = data['data']['banners'] as List;

      final loadedBanners = bannerData
          .map<String>((banner) => banner['image'] as String)
          .toList();

      if (!mounted) return;

      setState(() {
        banners = loadedBanners;
      });

      // Start auto slider
      if (banners.isNotEmpty) {
        _startTimer();
      }
    } catch (error) {
      debugPrint('Banner load error: $error');
    }
  }

  // ==========================================
  // AUTO SLIDE
  // ==========================================

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients || banners.isEmpty) {
        return;
      }

      final nextIndex = (currentIndex + 1) % banners.length;

      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  // ==========================================
  // DISPOSE
  // ==========================================

  @override
  void dispose() {
    _timer?.cancel();

    _pageController.dispose();

    super.dispose();
  }

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    // ==========================================
    // Loading
    // ==========================================

    if (banners.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    return Column(
      children: [
        // ==========================================
        // BANNER SLIDER
        // ==========================================
        Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.all(16),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: PageView.builder(
              controller: _pageController,

              itemCount: banners.length,

              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              itemBuilder: (context, index) {
                return Image.asset(
                  banners[index],
                  width: double.infinity,
                  fit: BoxFit.cover,

                  // Prevent broken asset from crashing the UI
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),

        // ==========================================
        // SLIDER INDICATOR
        // ==========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: List.generate(banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),

              margin: const EdgeInsets.symmetric(horizontal: 4),

              height: 8,

              width: currentIndex == index ? 22 : 8,

              decoration: BoxDecoration(
                color: currentIndex == index
                    ? Colors.green
                    : Colors.grey.shade400,

                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
