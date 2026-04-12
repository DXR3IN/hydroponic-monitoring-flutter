import 'package:flutter/material.dart';
import 'package:hydroponic_mobile/core/config/app_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://api.dicebear.com/7.x/avataaars/png?seed=Felix'),
                    backgroundColor: Colors.orangeAccent,
                  ),
                  const Text(
                    "ATRIUM",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.search, color: Colors.grey.shade400, size: 28),
                ],
              ),
            ),
          ),

          // Body Content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  "HIGHLIGHTS",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                const SizedBox(height: 16),
                _buildHighlightCard(),
                const SizedBox(height: 24),
                _buildCategoryChips(),
                const SizedBox(height: 24),
                _buildDeviceCard(
                  icon: Icons.lightbulb_outline,
                  name: "Floor Lamp",
                  status: "80% Brightness",
                  tag: "ACTIVE",
                  tagColor: Colors.white,
                  trailing: _buildSliderIndicator(),
                ),
                const SizedBox(height: 16),
                _buildDeviceCard(
                  icon: Icons.lock_outline,
                  name: "Front Door",
                  status: "Last activity 2h ago",
                  tag: "LOCKED",
                  tagColor: Colors.grey.shade600,
                  trailing: _buildActionToggle("MANAGE KEYS", false),
                ),
                const SizedBox(height: 16),
                _buildDeviceCard(
                  icon: Icons.thermostat,
                  name: "Living Room",
                  status: "Target: 22°C",
                  tag: "HEATING",
                  tagColor: Colors.white,
                  trailing: _buildTempControl(),
                ),
                const SizedBox(height: 100), // Spasi bawah untuk FAB
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard() {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A3A3A), Color(0xFF0D2525)],
        ),
        border: Border.all(color: Colors.white10),
      ),
      child: Stack(
        children: [
          // Faded Background Icon
          Positioned(
            right: -20,
            top: 40,
            child: Icon(Icons.lightbulb,
                size: 250, color: Colors.white.withOpacity(0.05)),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text("LIVING ROOM",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70)),
                ),
                const SizedBox(height: 16),
                const Text("Aura\nAmbient",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        height: 1.2)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Brightness",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 12)),
                        Text("84%",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w300)),
                      ],
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9BD1D1).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Icon(Icons.power_settings_new,
                          color: Color(0xFF9BD1D1), size: 32),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip("All Devices", isActive: true),
          const SizedBox(width: 12),
          _chip("Living Room", isActive: false),
          const SizedBox(width: 12),
          _chip("Kitchen", isActive: false),
        ],
      ),
    );
  }

  Widget _chip(String label, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF9BD1D1) : const Color(0xFF0F2B2B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFF041616) : Colors.grey.shade400,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDeviceCard({
    required IconData icon,
    required String name,
    required String status,
    required String tag,
    required Color tagColor,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2B2B),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white10),
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
                    borderRadius: BorderRadius.circular(16)),
                child: Icon(icon, color: const Color(0xFF9BD1D1), size: 24),
              ),
              Row(
                children: [
                  CircleAvatar(radius: 4, backgroundColor: tagColor),
                  const SizedBox(width: 8),
                  Text(tag,
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          Text(name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(status,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
          const SizedBox(height: 20),
          trailing, // Widget kontrol spesifik dimasukkan di sini
        ],
      ),
    );
  }

  // Komponen Kontrol Bawah Kartu
  Widget _buildSliderIndicator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(2)),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF9BD1D1).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2))),
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildCustomSwitch(true),
      ],
    );
  }

  Widget _buildActionToggle(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          _buildCustomSwitch(isActive),
        ],
      ),
    );
  }

  Widget _buildTempControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _iconButton(Icons.remove),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("21.5°",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
            ),
            _iconButton(Icons.add),
          ],
        ),
        _buildCustomSwitch(true),
      ],
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: Colors.grey.shade400, size: 20),
    );
  }

  Widget _buildCustomSwitch(bool isActive) {
    return Container(
      width: 44,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF9BD1D1) : Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF041616) : Colors.grey.shade500,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
