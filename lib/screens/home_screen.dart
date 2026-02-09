import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/app_theme.dart';
import 'package:student_app/core/lesson_provider.dart';
import 'package:student_app/screens/lesson_details_screen.dart';
import 'package:student_app/widgets/add_lesson_modal.dart';
import 'package:student_app/widgets/analytics_dashboard.dart';
import 'package:student_app/widgets/lesson_card.dart';
import 'package:student_app/widgets/navy_header.dart';
import 'package:animations/animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddLessonModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddLessonModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const NavyHeader(),
          Expanded(
            child: Consumer<LessonProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: AnalyticsDashboard(
                          totalLessons: provider.totalLessons,
                          attendanceRate: provider.attendanceRate,
                          consistencyStreak: provider.consistencyStreak,
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SearchBarDelegate(
                        searchController: _searchController,
                        onChanged: (val) => provider.setSearchQuery(val),
                        onFilterChanged: (filter) => provider.setStatusFilter(filter),
                        currentFilter: provider.statusFilter,
                      ),
                    ),
                    if (provider.lessons.isEmpty)
                      SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.library_books, size: 64, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              const Text(
                                'لا توجد دروس مطابقة',
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final lesson = provider.lessons[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: OpenContainer(
                                closedElevation: 0,
                                openElevation: 0,
                                closedColor: Colors.transparent,
                                openColor: Colors.transparent,
                                transitionDuration: const Duration(milliseconds: 500),
                                closedBuilder: (context, action) => LessonCard(
                                  lesson: lesson,
                                  onTap: action,
                                ),
                                openBuilder: (context, action) {
                                  return LessonDetailsScreen(lesson: lesson);
                                },
                              ),
                            );
                          },
                          childCount: provider.lessons.length,
                        ),
                      ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLessonModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final Function(String) onChanged;
  final Function(String?) onFilterChanged;
  final String? currentFilter;

  _SearchBarDelegate({
    required this.searchController,
    required this.onChanged,
    required this.onFilterChanged,
    required this.currentFilter,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.pureWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: searchController,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'ابحث باسم الكتاب أو الشيخ...',
              prefixIcon: const Icon(Icons.search, color: AppColors.navyBlue),
              filled: true,
              fillColor: AppColors.lightGray.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(null, 'الكل'),
                const SizedBox(width: 8),
                _buildFilterChip('attended', 'المحضور'),
                const SizedBox(width: 8),
                _buildFilterChip('missed', 'الفائت'),
                const SizedBox(width: 8),
                _buildFilterChip('excused', 'معذور'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String? value, String label) {
    final isSelected = currentFilter == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.navyBlue,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onFilterChanged(value),
      backgroundColor: Colors.white,
      selectedColor: AppColors.navyBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.navyBlue.withValues(alpha: 0.2)),
      ),
      showCheckmark: false,
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) {
    return oldDelegate.currentFilter != currentFilter;
  }
}
