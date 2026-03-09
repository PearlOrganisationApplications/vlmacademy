import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class InterviewSchedulingStep extends StatefulWidget {
  final VoidCallback onNext;

  const InterviewSchedulingStep({super.key, required this.onNext});

  @override
  State<InterviewSchedulingStep> createState() =>
      _InterviewSchedulingStepState();
}

class _InterviewSchedulingStepState extends State<InterviewSchedulingStep> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedTime;
  bool _showFullCalendar = false;

  final List<String> _slots = [
    '10:30 AM',
    '12:00 PM',
    '02:30 PM',
    '04:00 PM',
    '06:30 PM',
    '08:00 PM',
  ];

  // Generate the next 10 days for the horizontal list
  List<DateTime> get _availableDates {
    return List.generate(
        10, (index) => DateTime.now().add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user, color: AppColors.primary, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'FINAL VERIFICATION',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Schedule Your Demo',
            style: AppTextStyles.h4.copyWith(
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Pick a 15-minute slot for a brief video interaction with our academic panel.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SELECT DATE',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textSecondaryDark)),
              GestureDetector(
                onTap: () =>
                    setState(() => _showFullCalendar = !_showFullCalendar),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: _showFullCalendar
                        ? AppColors.primary.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                      _showFullCalendar
                          ? Icons.calendar_view_day
                          : Icons.calendar_month_outlined,
                      size: 20.sp,
                      color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (_showFullCalendar)
            // Full Calendar View
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: AppColors.surfaceDark,
                    onSurface: AppColors.textPrimaryDark,
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  onDateChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                      _showFullCalendar = false;
                    });
                  },
                ),
              ),
            )
          else
            // Horizontal List View (One-week-ish)
            SizedBox(
              height: 80.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _availableDates.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final date = _availableDates[index];
                  final isSelected = DateUtils.isSameDay(_selectedDate, date);
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDate = date),
                    child: Container(
                      width: 64.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date).toUpperCase(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textSecondaryDark,
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            date.day.toString(),
                            style: AppTextStyles.labelLarge.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AVAILABLE SLOTS (IST)',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textSecondaryDark)),
              Icon(Icons.access_time_outlined,
                  size: 16.sp, color: AppColors.textSecondaryDark),
            ],
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _slots.length,
            itemBuilder: (context, index) {
              final slot = _slots[index];
              final isSelected = _selectedTime == slot;
              return GestureDetector(
                onTap: () => setState(() => _selectedTime = slot),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.1)
                        : AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.white.withOpacity(0.05),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      slot,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimaryDark,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          _buildVirtualInteractionBox(),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _selectedTime == null ? null : widget.onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                disabledBackgroundColor:
                    const Color(0xFF1E293B).withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _selectedTime == null
                        ? 'SELECT A SLOT'
                        : 'CONFIRM ${DateFormat('MMM d').format(_selectedDate)} @ $_selectedTime',
                    style: AppTextStyles.labelLarge.copyWith(
                      color:
                          _selectedTime == null ? Colors.white30 : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Icon(Icons.arrow_forward_rounded,
                      color: _selectedTime == null
                          ? Colors.white30
                          : Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildVirtualInteractionBox() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.videocam_outlined,
                color: AppColors.primary, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VIRTUAL INTERACTION',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'A link to Google Meet will be shared via email and WhatsApp 30 minutes before your slot.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.primary, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'PREPARE A 5-MIN DEMO',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
