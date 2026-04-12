import 'package:flutter/material.dart';
import 'package:hydroponic_mobile/core/config/app_style.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: CustomScrollView(
        slivers: [
          // 1. Header (Back Button & Title)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 24, left: 24, right: 24, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Add New\nDevice",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "SCANNING\nAREA",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 2. Radar / Searching Section
          SliverToBoxAdapter(
            child: _buildSearchingRadar(),
          ),

          // 3. New Devices Found Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Devices\nFound",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "3 devices responding to your\nnetwork signal",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "REFRESH\nLIST",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.refresh,
                          color: Colors.grey.shade400, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 4. Device Cards List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildFoundDeviceCard(
                  icon: Icons.lightbulb,
                  name: "Lumina Hub X1",
                  category: "Smart Lighting System",
                  status: "READY TO PAIR",
                  isReady: true,
                ),
                const SizedBox(height: 16),
                _buildFoundDeviceCard(
                  icon: Icons.videocam_rounded,
                  name: "Sentinel 4K",
                  category: "Security & Surveillance",
                  status: "CONNECTING...",
                  isReady: false,
                ),
                const SizedBox(height: 16),
                _buildFoundDeviceCard(
                  icon: Icons.speaker,
                  name: "Aura Audio Pro",
                  category: "High-Fidelity Audio",
                  status: "READY TO PAIR",
                  isReady: true,
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),

          // 5. Common Categories
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Common Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildCategoryCard(Icons.power, "Power & Plug"),
                _buildCategoryCard(Icons.thermostat, "Climate\nControl"),
                _buildCategoryCard(Icons.sensors, "Sensors"),
                _buildCategoryCard(Icons.kitchen, "Appliances"),
              ],
            ),
          ),

          // 6. Bottom Helper Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
              child: Row(
                children: [
                  Expanded(flex: 3, child: _buildHelpCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: _buildQRCard()),
                ],
              ),
            ),
          ),

          // Extra padding at bottom to account for BottomNavigationBar
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  // --- KOMPONEN WIDGET ---

  Widget _buildSearchingRadar() {
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Faded "Discover" Text in background
          Positioned(
            top: 40,
            child: Text(
              "Discover",
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.02),
                letterSpacing: -2,
              ),
            ),
          ),
          // Outer Circle
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Colors.white.withOpacity(0.05), width: 1),
            ),
          ),
          // Inner Circle
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
          ),
          // Center Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.radar, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                "Searching...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Keep your Bluetooth and Wi-Fi\nenabled",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoundDeviceCard({
    required IconData icon,
    required String name,
    required String category,
    required String status,
    required bool isReady,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(
            0xFF132F2F), // Warna card sedikit lebih terang dari background
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              Row(
                children: [
                  if (!isReady) ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: isReady ? Colors.white70 : Colors.white54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(category,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isReady ? const Color(0xFF9BD1D1) : const Color(0xFF0A1B1B),
                foregroundColor:
                    isReady ? const Color(0xFF041616) : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isReady ? "PAIR DEVICE" : "PLEASE WAIT",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, height: 1.2),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF132F2F),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Don't\nsee\nyour\ndevice?",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, height: 1.1),
          ),
          const SizedBox(height: 16),
          Text(
            "Make sure your device is in pairing mode. Most devices flash a light when they are ready to be added.",
            style: TextStyle(
                fontSize: 13, color: Colors.grey.shade400, height: 1.5),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "VIEW PAIRING GUIDE",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQRCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1B1B),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.qr_code_scanner, color: Colors.white, size: 48),
          const SizedBox(height: 24),
          const Text(
            "Fast\nsetup\nwith\nQR\nCode",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
          ),
          const SizedBox(height: 16),
          Text(
            "SCAN\nCODE",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
