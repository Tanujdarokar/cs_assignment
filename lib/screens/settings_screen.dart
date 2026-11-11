import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../services/api_service.dart';
import '../services/user_session.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onSelectTestList;

  const SettingsScreen({
    super.key,
    required this.onBack,
    required this.onSelectTestList,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showCallingListsModal = true;
  bool _isLoadingLists = false;
  List<dynamic> _lists = [];

  @override
  void initState() {
    super.initState();
    _fetchCallingLists();
  }

  Future<void> _fetchCallingLists() async {
    setState(() {
      _isLoadingLists = true;
    });

    try {
      final fetched = await ApiService.getCallingLists();
      if (mounted) {
        setState(() {
          _lists = fetched;
        });
      }
    } catch (e) {
      if (mounted) {
        // Fallback default list if mock server is down/unreachable
        setState(() {
          _lists = [
            {
              '_id': '68626fb697757cb741f449b9',
              'name': 'Test List',
              'count': 50,
            }
          ];
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLists = false;
        });
      }
    }
  }

  Future<void> _handleSelectList(dynamic listObj) async {
    final listId = (listObj is Map && (listObj['_id'] != null || listObj['id'] != null))
        ? (listObj['_id'] ?? listObj['id'])
        : '68626fb697757cb741f449b9';

    try {
      await ApiService.getListDetails(listId: listId.toString());
    } catch (_) {}

    widget.onSelectTestList();
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = UserSession.instance.email ?? 'swati@cstech.in';
    final userName = UserSession.instance.username ?? 'Swati';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Setting',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Settings Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlueCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0xFFFACC15),
                            child: Icon(Icons.person, color: Colors.white, size: 36),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello $userName',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                userEmail,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24, height: 1),
                      const SizedBox(height: 12),
                      const Text(
                        '9971125588',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Parent Account: NA',
                        style: TextStyle(fontSize: 13, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Current Subscription: Calley Personal',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFACC15),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PROFILE SETTINGS Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E2B4D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'PROFILE SETTINGS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Settings List Card
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.language_outlined, color: AppColors.textPrimary, size: 20),
                          ),
                          title: const Text(
                            'App Language',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.arrow_forward_rounded, size: 16),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.lock_outline, color: AppColors.textPrimary, size: 20),
                          ),
                          title: const Text(
                            'Change Password',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.arrow_forward_rounded, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dark Overlay & CALLING LISTS Modal Bottom Sheet
          if (_showCallingListsModal) ...[
            GestureDetector(
              onTap: () {
                setState(() {
                  _showCallingListsModal = false;
                });
              },
              child: Container(
                color: const Color(0x80000000),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Blue Calling Lists Header
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E2B4D),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'CALLING LISTS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Select Calling List Row with Refresh Button
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Select Calling List',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _fetchCallingLists,
                                  icon: _isLoadingLists
                                      ? const SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2, color: Colors.white),
                                        )
                                      : const Icon(Icons.refresh_rounded, size: 16),
                                  label: const Text('Refresh', style: TextStyle(fontSize: 13)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Dynamic Calling Lists from API
                          if (_isLoadingLists)
                            const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: CircularProgressIndicator(color: AppColors.primaryBlue),
                            )
                          else if (_lists.isEmpty)
                            GestureDetector(
                              onTap: () => _handleSelectList({'name': 'Test List'}),
                              child: _buildListTile('Test List'),
                            )
                          else
                            Column(
                              children: _lists.map((item) {
                                final listName = (item is Map && item['name'] != null)
                                    ? item['name']
                                    : 'Test List';
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () => _handleSelectList(item),
                                    child: _buildListTile(listName.toString()),
                                  ),
                                );
                              }).toList(),
                            ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListTile(String listName) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            listName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
