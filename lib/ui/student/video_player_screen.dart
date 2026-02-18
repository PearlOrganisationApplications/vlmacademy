import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/course_model.dart';
import '../widgets/animated_button.dart';
import '../widgets/glassmorphic_card.dart';

class VideoPlayerScreen extends StatefulWidget {
  final CourseModel course;

  const VideoPlayerScreen({
    super.key,
    required this.course,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _showNotes = false;
  double _playbackSpeed = 1.0;
  final TextEditingController _notesController = TextEditingController();

  final List<double> _speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  final List<String> _qualities = ['360p', '480p', '720p', '1080p'];
  String _selectedQuality = '720p';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    // TODO: Replace with actual video URL
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );

    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primary,
        handleColor: AppColors.primary,
        backgroundColor: Colors.grey,
        bufferedColor: AppColors.primaryLight,
      ),
      placeholder: Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      autoInitialize: true,
    );

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Video Player
            _isLoading
                ? const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(controller: _chewieController!),
                  ),

            // Controls and Content
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    // Video Info Header
                    _buildVideoInfo(),

                    // Action Buttons
                    _buildActionButtons(),

                    // Tabs or Notes Panel
                    Expanded(
                      child: _showNotes
                          ? _buildNotesPanel()
                          : _buildVideoDetails(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.course.title,
                      style: AppTextStyles.h6,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.course.teacherName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildActionChip(
            Icons.speed,
            '${_playbackSpeed}x',
            () => _showSpeedSelector(),
          ),
          const SizedBox(width: 8),
          _buildActionChip(
            Icons.hd,
            _selectedQuality,
            () => _showQualitySelector(),
          ),
          const SizedBox(width: 8),
          _buildActionChip(
            Icons.note_add_outlined,
            'Notes',
            () => setState(() => _showNotes = !_showNotes),
          ),
          const Spacer(),
          FloatingActionButton(
            mini: true,
            backgroundColor: AppColors.error,
            onPressed: () {
              // Open doubt chat
            },
            child: const Icon(Icons.chat_bubble_outline, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoDetails() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('About this video', style: AppTextStyles.h6),
        const SizedBox(height: 12),
        GlassmorphicCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(Icons.subject, 'Subject', widget.course.subject),
              const Divider(),
              _buildInfoRow(Icons.access_time, 'Duration', '${widget.course.durationMinutes} min'),
              const Divider(),
              _buildInfoRow(Icons.remove_red_eye, 'Views', '${widget.course.viewCount}'),
              const Divider(),
              _buildInfoRow(Icons.star, 'Rating', '${widget.course.rating}/5'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        Text('Description', style: AppTextStyles.h6),
        const SizedBox(height: 12),
        Text(
          widget.course.description,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildNotesPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('My Notes', style: AppTextStyles.h6),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _showNotes = false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TextField(
              controller: _notesController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: 'Take notes while watching...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedButton(
            text: 'Save Notes',
            onPressed: () {
              // Save notes
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notes saved!')),
              );
            },
            fullWidth: true,
            icon: Icons.save,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondaryLight),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const Spacer(),
          Text(value, style: AppTextStyles.labelMedium),
        ],
      ),
    );
  }

  void _showSpeedSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Playback Speed', style: AppTextStyles.h6),
            const SizedBox(height: 16),
            ..._speeds.map((speed) {
              return ListTile(
                title: Text('${speed}x'),
                trailing: _playbackSpeed == speed
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _playbackSpeed = speed);
                  _videoPlayerController.setPlaybackSpeed(speed);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showQualitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Video Quality', style: AppTextStyles.h6),
            const SizedBox(height: 16),
            ..._qualities.map((quality) {
              return ListTile(
                title: Text(quality),
                trailing: _selectedQuality == quality
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedQuality = quality);
                  // TODO: Change video quality
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
