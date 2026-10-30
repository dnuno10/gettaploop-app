import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_extensions.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/taploop_button.dart';
import '../../../core/widgets/taploop_text_field.dart';
import '../../../core/data/app_state.dart';
import '../../../core/services/auth_service.dart';
import '../models/user_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _jobCtrl;
  late final TextEditingController _companyCtrl;
  bool _saving = false;
  final bool _changingPassword = false;
  bool _edited = false;

  @override
  void initState() {
    super.initState();
    final user = appState.currentUser;
    _nameCtrl = TextEditingController(text: user?.name ?? '');
    _emailCtrl = TextEditingController(text: user?.email ?? '');
    _phoneCtrl = TextEditingController(text: user?.phone ?? '');
    _jobCtrl = TextEditingController(text: user?.jobTitle ?? '');
    _companyCtrl = TextEditingController(
      text: appState.currentCard?.company ?? '',
    );
    for (final c in [
      _nameCtrl,
      _emailCtrl,
      _phoneCtrl,
      _jobCtrl,
      _companyCtrl,
    ]) {
      c.addListener(() => setState(() => _edited = true));
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _jobCtrl.dispose();
    _companyCtrl.dispose();
    super.dispose();
  }

  void _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    final user = appState.currentUser;
    if (user == null) return;
    setState(() => _saving = true);
    try {
      final updated = user.copyWith(
        name: _nameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        jobTitle: _jobCtrl.text.trim(),
      );
      final saved = await AuthService.updateProfile(updated);
      appState.setUser(saved);
      if (mounted) {
        setState(() {
          _saving = false;
          _edited = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _onChangePassword() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ChangePasswordSheet(
        onSave: (current, next) async {
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    );
  }

  void _onDeleteAccount() {
    showDialog(context: context, builder: (_) => _DeleteAccountDialog());
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: context.bgPage,
      appBar: AppBar(
        title: const Text('My profile'),
        backgroundColor: context.bgCard,
        actions: [
          if (_edited)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                onPressed: _onSave,
                child: Text(
                  'Save',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop || isTablet ? 760 : double.infinity,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop || isTablet ? 24 : 16,
              vertical: 24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar section
                  if (appState.currentUser != null)
                    _AvatarSection(user: appState.currentUser!),
                  const SizedBox(height: 24),

                  // Personal info card
                  _SectionCard(
                    title: 'Personal information',
                    children: [
                      TapLoopTextField(
                        label: 'Full name',
                        controller: _nameCtrl,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          size: 20,
                          color: context.textMuted,
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Name required'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TapLoopTextField(
                        label: 'Phone',
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          size: 20,
                          color: context.textMuted,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TapLoopTextField(
                        label: 'Job title / Position',
                        controller: _jobCtrl,
                        prefixIcon: Icon(
                          Icons.work_outline,
                          size: 20,
                          color: context.textMuted,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TapLoopTextField(
                        label: 'Company',
                        controller: _companyCtrl,
                        prefixIcon: Icon(
                          Icons.business_outlined,
                          size: 20,
                          color: context.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Account info card
                  _SectionCard(
                    title: 'Account',
                    children: [
                      TapLoopTextField(
                        label: 'Email',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          size: 20,
                          color: context.textMuted,
                        ),
                        suffixIcon:
                            (appState.currentUser?.emailVerified ?? false)
                            ? const Tooltip(
                                message: 'Email verified',
                                child: Icon(
                                  Icons.verified,
                                  size: 20,
                                  color: AppColors.success,
                                ),
                              )
                            : const Tooltip(
                                message: 'Email not verified',
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  size: 20,
                                  color: AppColors.warning,
                                ),
                              ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Email required';
                          }
                          if (!RegExp(
                            r'^[^@]+@[^@]+\.[^@]+',
                          ).hasMatch(v.trim())) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TapLoopButton(
                        label: 'Change password',
                        onPressed: _onChangePassword,
                        variant: TapLoopButtonVariant.outline,
                        isLoading: _changingPassword,
                        icon: const Icon(
                          Icons.lock_reset_outlined,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Save button
                  TapLoopButton(
                    label: 'Save changes',
                    onPressed: _onSave,
                    variant: TapLoopButtonVariant.primary,
                    isLoading: _saving,
                  ),
                  const SizedBox(height: 24),

                  // Danger zone
                  _DangerZone(onDelete: _onDeleteAccount),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

class _AvatarSection extends StatelessWidget {
  final UserModel user;
  const _AvatarSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: user.photoUrl != null
                  ? ClipOval(
                      child: Image.network(user.photoUrl!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: Text(
                        user.initials,
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: context.textPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.bgCard, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 13,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                user.email,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: context.textSecondary,
                ),
              ),
              if (user.emailVerified) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.verified,
                      size: 14,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Email verified',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _DangerZone extends StatelessWidget {
  final VoidCallback onDelete;
  const _DangerZone({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danger zone',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'These actions are permanent and irreversible.',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: onDelete,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Delete my account',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Modals ───────────────────────────────────────────────────────────────────

class _ChangePasswordSheet extends StatefulWidget {
  final Future<void> Function(String current, String next) onSave;
  const _ChangePasswordSheet({required this.onSave});

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await widget.onSave(_currentCtrl.text, _newCtrl.text);
    if (mounted) {
      setState(() => _loading = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottom),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: context.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Change password',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            TapLoopTextField(
              label: 'Current password',
              controller: _currentCtrl,
              obscureText: true,
              validator: (v) => (v == null || v.isEmpty)
                  ? 'Enter your current password'
                  : null,
            ),
            const SizedBox(height: 16),
            TapLoopTextField(
              label: 'New password',
              controller: _newCtrl,
              obscureText: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Enter the new password';
                }
                if (v.length < 8) return 'Minimum 8 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TapLoopTextField(
              label: 'Confirm new password',
              controller: _confirmCtrl,
              obscureText: true,
              validator: (v) {
                if (v != _newCtrl.text) return 'Passwords don\'t match';
                return null;
              },
            ),
            const SizedBox(height: 24),
            TapLoopButton(
              label: 'Update password',
              onPressed: _save,
              variant: TapLoopButtonVariant.secondary,
              isLoading: _loading,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteAccountDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_forever_outlined,
                color: AppColors.error,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delete account',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This action will permanently delete your account and all your data. You will not be able to recover them.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: context.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Yes, delete my account',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
