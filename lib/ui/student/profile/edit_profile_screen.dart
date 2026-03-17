import 'package:flutter/material.dart';
import '../../widgets/animated_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullNameController = TextEditingController(text: 'Harsha');
  final _nickNameController = TextEditingController(text: 'Harsha');
  final _emailController =
      TextEditingController(text: 'HarshaKumara98@gmail.com');
  final _dobController = TextEditingController(text: '12/05/1998');

  String _selectedGender = 'Male';

  // Professional Color Palette
  static const Color bgColor = Color(0xFF030712); // Deep Space Navy
  static const Color surfaceColor = Color(0xFF0F172A); // Slate 900
  static const Color accentBlue = Color(0xFF3B82F6); // Vibrant Blue
  static const Color textBody = Color(0xFF94A3B8); // Slate 400
  static const Color fieldBorder = Color(0xFF1E293B); // Slate 800

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildAvatarSection(),
                    const SizedBox(height: 48),
                    _buildSectionHeader('Personal Information'),
                    const SizedBox(height: 16),
                    _buildField(
                      label: 'Full Name',
                      controller: _fullNameController,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),
                    _buildField(
                      label: 'Nick Name',
                      controller: _nickNameController,
                      icon: Icons.alternate_email_outlined,
                    ),
                    const SizedBox(height: 20),
                    _buildField(
                      label: 'Email Address',
                      controller: _emailController,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                    _buildSectionHeader('Additional Details'),
                    const SizedBox(height: 16),
                    _buildDateField(),
                    const SizedBox(height: 20),
                    _buildPhoneField(),
                    const SizedBox(height: 20),
                    _buildGenderField(),
                    const SizedBox(height: 20),
                    _buildField(
                      label: 'User Role',
                      controller: TextEditingController(text: 'Student'),
                      icon: Icons.school_outlined,
                      enabled: false,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            _buildStickyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: surfaceColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(12),
            ),
          ),
          const Expanded(
            child: Text(
              'Edit Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Glow
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: accentBlue.withOpacity(0.2), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: accentBlue.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            // Avatar
            Container(
              height: 104,
              width: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accentBlue, width: 2),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Edit Icon
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: accentBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt_rounded,
                    size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Change Profile Picture',
          style: TextStyle(
            color: accentBlue.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
                color: textBody, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: fieldBorder),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              prefixIcon:
                  Icon(icon, color: accentBlue.withOpacity(0.7), size: 20),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintText: 'Enter your $label',
              hintStyle: TextStyle(color: textBody.withOpacity(0.5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Date of Birth',
            style: TextStyle(
                color: textBody, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: fieldBorder),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_month_rounded,
                  color: accentBlue.withOpacity(0.7), size: 20),
              const SizedBox(width: 12),
              Text(
                _dobController.text,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const Spacer(),
              Icon(Icons.keyboard_arrow_down_rounded,
                  color: textBody.withOpacity(0.5)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Phone Number',
            style: TextStyle(
                color: textBody, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: fieldBorder),
          ),
          child: Row(
            children: [
              Image.network('https://img.icons8.com/color/48/india.png',
                  height: 18),
              const SizedBox(width: 8),
              const Text('+91',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              Icon(Icons.keyboard_arrow_down_rounded,
                  color: textBody.withOpacity(0.5), size: 18),
              const SizedBox(width: 12),
              Container(width: 1, height: 20, color: fieldBorder),
              const SizedBox(width: 12),
              const Text('987-848-1225',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Gender',
            style: TextStyle(
                color: textBody, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: fieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              dropdownColor: surfaceColor,
              isExpanded: true,
              icon: Icon(Icons.unfold_more_rounded,
                  color: textBody.withOpacity(0.5)),
              style: const TextStyle(color: Colors.white, fontSize: 15),
              items: ['Male', 'Female', 'Other']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedGender = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: AnimatedButton(
        text: 'Save Changes',
        fullWidth: true,
        type: AnimatedButtonType.gradient,
        gradient: LinearGradient(
          colors: [accentBlue, accentBlue.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
