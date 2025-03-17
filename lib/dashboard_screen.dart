import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _initialPriceController = TextEditingController(text: '50,000,000');
  final TextEditingController _interestRateController = TextEditingController(text: '12');
  final TextEditingController _loanTermController = TextEditingController(text: '8');
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _initialPriceController.dispose();
    _interestRateController.dispose();
    _loanTermController.dispose();
    super.dispose();
  }
  
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }
  
  String _getCurrentTime() {
    return DateFormat('HH.mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFE8EAF6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getCurrentTime(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.wifi, size: 18),
                      const SizedBox(width: 8),
                      Icon(Icons.battery_full, size: 18),
                    ],
                  ),
                ],
              ),
            ),
            
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting and Profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello! ${_getGreeting()},',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Abimana.',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFBBDEFB), Color(0xFF90CAF9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://via.placeholder.com/40',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search service you need or any help',
                          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Tabs
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _tabController.index == 0 
                                      ? const Color(0xFFBBDEFB) 
                                      : const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Calculate Kredit',
                                  style: TextStyle(
                                    color: _tabController.index == 0 
                                        ? const Color(0xFF1A237E) 
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _tabController.animateTo(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _tabController.index == 1 
                                      ? const Color(0xFFBBDEFB) 
                                      : const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Savings',
                                  style: TextStyle(
                                    color: _tabController.index == 1 
                                        ? const Color(0xFF1A237E) 
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Tab Content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Calculate Kredit Tab
                          Column(
                            children: [
                              // Initial Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Initial Price',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: TextField(
                                      controller: _initialPriceController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Interest Rate
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Interest Rate',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _interestRateController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft: Radius.circular(4),
                                                ),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                            ),
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            ),
                                          ),
                                          child: const Text(
                                            '%',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Loan Term
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Loan Term',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _loanTermController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft: Radius.circular(4),
                                                ),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                            ),
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            ),
                                          ),
                                          child: const Text(
                                            'Month',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          // Savings Tab
                          const Center(
                            child: Text('Savings content would go here'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Navigation Bar
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home Page', true),
                  _buildNavItem(Icons.shopping_bag, 'My Order', false),
                  _buildNavItem(Icons.history, 'History Clear', false),
                  _buildNavItem(Icons.person, 'Profile', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.black : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

