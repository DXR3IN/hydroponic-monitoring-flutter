import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  // State sederhana menggunakan GetX untuk Switch
  final RxBool pushNotifications = true.obs;
  final RxBool nightMode = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041616),
      body: CustomScrollView(
        slivers: [
          // 1. Custom Header
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 24, left: 24, right: 24, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),

          // 2. Profile Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildProfileCard(),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // 3. Sections
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // HOME MANAGEMENT
                _buildSectionTitle("HOME MANAGEMENT"),
                _buildGroupedCard([
                  _buildListTile(
                      icon: Icons.meeting_room, title: "Manage Rooms"),
                  _buildListTile(icon: Icons.people_alt, title: "Home Members"),
                  _buildListTile(icon: Icons.wifi, title: "Wi-Fi Network"),
                ]),
                const SizedBox(height: 32),

                // PREFERENCES (Bentuknya Card terpisah)
                _buildSectionTitle("PREFERENCES"),
                _buildPreferenceCard(
                  icon: Icons.notifications_active,
                  title: "Push Notifications",
                  value: pushNotifications,
                ),
                const SizedBox(height: 16),
                _buildPreferenceCard(
                  icon: Icons.nightlight_round,
                  title: "Night Mode",
                  value: nightMode,
                ),
                const SizedBox(height: 32),

                // SECURITY
                _buildSectionTitle("SECURITY"),
                _buildGroupedCard([
                  _buildListTile(
                    icon: Icons.fingerprint,
                    title: "Biometric Lock",
                    trailing:
                        const Icon(Icons.lock, color: Colors.grey, size: 20),
                  ),
                  _buildListTile(icon: Icons.shield, title: "Privacy Center"),
                  _buildListTile(
                      icon: Icons.list_alt, title: "Device Security Logs"),
                ]),
                const SizedBox(height: 32),

                // SUPPORT & ABOUT
                _buildSectionTitle("SUPPORT & ABOUT"),
                _buildGroupedCard([
                  _buildListTile(
                    title: "Help Center",
                    trailing: const Icon(Icons.open_in_new,
                        color: Colors.grey, size: 20),
                  ),
                  _buildListTile(
                    title: "Terms of Service",
                    trailing: const Icon(Icons.verified_user,
                        color: Colors.grey, size: 20),
                  ),
                  _buildListTile(
                    title: "App Version",
                    trailing: const Text(
                      "v4.8.2-stable",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ]),
                const SizedBox(height: 40),

                // LOGOUT BUTTON
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Logika Logout
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF204848), // Warna teal gelap
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.logout, size: 20),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 120), // Spasi untuk Bottom Nav
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // --- KOMPONEN WIDGET ---

  Widget _buildProfileCard() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(
            0xFF0C2626), // Sedikit lebih terang dari background utama
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          // Faded Text Background
          Positioned(
            top: 10,
            left: 20,
            right: 0,
            child: Text(
              "ATRIUM",
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.03),
                letterSpacing: 4.0,
              ),
            ),
          ),
          // Profile Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF9BD1D1), width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                            'https://api.dicebear.com/7.x/avataaars/png?seed=Alex'), // Ganti dengan aset gambar Anda
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF9BD1D1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit,
                            color: Color(0xFF041616), size: 12),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Alex Rivera",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Premium Resident",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade400),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _buildGroupedCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1B1B), // Warna gelap untuk card setting
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
      {IconData? icon, required String title, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white70, size: 20),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          trailing ??
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildPreferenceCard(
      {required IconData icon, required String title, required RxBool value}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1B1B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              // Menggunakan Obx agar Switch merender ulang saat nilainya berubah
              Obx(() => GestureDetector(
                    onTap: () => value.value = !value.value, // Toggle value
                    child: Container(
                      width: 48,
                      height: 24,
                      decoration: BoxDecoration(
                        color: value.value
                            ? const Color(0xFF9BD1D1)
                            : Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(4),
                      alignment: value.value
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: value.value
                              ? const Color(0xFF041616)
                              : Colors.grey.shade500,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
