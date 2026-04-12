import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_config.dart';
import 'package:hydroponic_mobile/core/config/app_style.dart';
import 'package:hydroponic_mobile/presentation/controllers/welcome_controller.dart'; // Make sure this path is correct

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: AppStyle.mainColor),
          ),

          // 2. MIDDLE LAYER: Animated Background for Page 2
          Positioned.fill(
            child: Obx(() {
              double t = controller.middlePageEffectIntensity.value;
              return Opacity(
                opacity: t,
                child: Transform.scale(
                  scale: 0.95 + (0.05 * t),
                  child: Transform.translate(
                    offset: Offset(0, 50 * (1.0 - t)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            AppStyle.fourtColor,
                            Color.lerp(
                                AppStyle.thirdColor, AppStyle.mainColor, 0.5)!,
                          ])),
                    ),
                  ),
                ),
              );
            }),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: [
                      _buildPage(
                        imageProvider: const NetworkImage(
                            'https://images.unsplash.com/photo-1545241047-6083a3684587?q=80&w=600'),
                        title: "Welcome to\n${AppConfig.appName}",
                        subtitle:
                            "Your personal plant companion to help you\ngrow and nurture beautiful plants",
                      ),
                      _buildPage(
                        imageProvider: const NetworkImage(
                            'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?q=80&w=600'),
                        title: "Smart Care\nReminders",
                        subtitle:
                            "Never forget to water your plants again\nwith personalized care schedules",
                        extraContent: _buildCareIcons(),
                      ),
                      _buildPage(
                        imageProvider: const NetworkImage(
                            'https://images.unsplash.com/photo-1530968464165-7a1861cbaf9f?q=80&w=600'),
                        title: "Track Your\nPlant Journey",
                        subtitle:
                            "Watch your garden flourish and share your\nprogress with a community of plant lovers",
                      ),
                    ],
                  ),
                ),
                _buildBottomControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildPage({
    required ImageProvider imageProvider,
    required String title,
    required String subtitle,
    Widget? extraContent,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;

        // Ukuran gambar: 40% dari lebar layar, max 280, min 180
        final imageSize = (screenWidth * 0.55).clamp(180.0, 280.0);

        // Font title: skala dari lebar layar
        final titleFontSize = (screenWidth * 0.07).clamp(20.0, 28.0);
        final subtitleFontSize = (screenWidth * 0.04).clamp(13.0, 16.0);

        // Spacing dinamis berdasarkan tinggi layar
        final spacingLarge = screenHeight * 0.05;
        final spacingMedium = screenHeight * 0.025;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.04,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular Image
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spacingLarge),

                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: spacingMedium),

                  // Subtitle
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: subtitleFontSize,
                      height: 1.5,
                    ),
                  ),

                  if (extraContent != null) ...[
                    SizedBox(height: spacingLarge),
                    extraContent,
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCareIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _careIconItem(Icons.water_drop_outlined, "Water"),
        const SizedBox(width: 20),
        _careIconItem(Icons.wb_sunny_outlined, "Sunlight"),
        const SizedBox(width: 20),
        _careIconItem(Icons.eco_outlined, "Fertilize"),
      ],
    );
  }

  Widget _careIconItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: AppStyle.fourtColor, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          // Page Indicators
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => _buildDot(index)),
              )),
          const SizedBox(height: 30),

          // Main Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: controller.nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyle.fourtColor,
                foregroundColor: AppStyle.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Obx(() {
                if (controller.currentPage.value == 0) {
                  return const Text("Get Started");
                }
                if (controller.currentPage.value == 1) {
                  return const Text("Continue");
                }
                return const Text("Start Growing");
              }),
            ),
          ),

          // Skip/Exit Button
          Obx(() => controller.currentPage.value == 2
              ? TextButton(
                  onPressed: controller.skip,
                  child: const Text("Exit App",
                      style: TextStyle(color: Colors.white54)),
                )
              : const SizedBox(height: 48)),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 6),
      height: 6,
      width: controller.currentPage.value == index ? 20 : 6,
      decoration: BoxDecoration(
        color: controller.currentPage.value == index
            ? AppStyle.fourtColor
            : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
