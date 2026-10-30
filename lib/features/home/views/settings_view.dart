import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/data/app_state.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_extensions.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/taploop_button.dart';
import '../../../core/widgets/taploop_progress_indicator.dart';
import '../../../core/widgets/taploop_text_field.dart';
import '../../../core/widgets/taploop_toast.dart';
import '../../auth/models/user_model.dart';
import '../../card/models/digital_card_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _passwordFormKey = GlobalKey<FormState>();
  final _currentPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _changingPassword = false;

  @override
  void dispose() {
    _currentPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;

    setState(() => _changingPassword = true);
    try {
      await AuthService.changePasswordWithCurrent(
        currentPassword: _currentPasswordCtrl.text,
        newPassword: _newPasswordCtrl.text,
      );
      if (!mounted) return;
      _currentPasswordCtrl.clear();
      _newPasswordCtrl.clear();
      _confirmPasswordCtrl.clear();
      TapLoopToast.show(
        context,
        'Password updated successfully.',
        TapLoopToastType.success,
      );
    } catch (error) {
      if (!mounted) return;
      TapLoopToast.show(
        context,
        _friendlyPasswordError(error),
        TapLoopToastType.error,
      );
    } finally {
      if (mounted) setState(() => _changingPassword = false);
    }
  }

  String _friendlyPasswordError(Object error) {
    final raw = error.toString();
    if (raw.contains('Invalid login credentials')) {
      return 'The current password is incorrect.';
    }
    if (raw.contains('Password should be')) {
      return 'The new password doesn\'t meet the minimum requirements.';
    }
    return 'Could not update the password. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final user = appState.currentUser;
        if (user == null) {
          return const Scaffold(
            body: Center(child: TapLoopProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
                  decoration: BoxDecoration(
                    color: context.bgCard,
                    border: Border(
                      bottom: BorderSide(color: context.borderColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Manage the active session, the selected card, and your account security.',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: context.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                    children: [
                      _ProfileCard(user: user, card: appState.currentCard),
                      const SizedBox(height: 20),
                      _SettingsSection(
                        title: 'Security',
                        child: Form(
                          key: _passwordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Change password',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: context.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Confirm your current password and set a new password for this session.',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: context.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 18),
                              TapLoopTextField(
                                label: 'Current password',
                                hint: 'Enter your current password',
                                controller: _currentPasswordCtrl,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your current password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                              TapLoopTextField(
                                label: 'New password',
                                hint: 'Minimum 8 characters',
                                controller: _newPasswordCtrl,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter a new password';
                                  }
                                  if (value.length < 8) {
                                    return 'The new password must have at least 8 characters';
                                  }
                                  if (value == _currentPasswordCtrl.text) {
                                    return 'The new password must be different from the current one';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                              TapLoopTextField(
                                label: 'Confirm new password',
                                hint: 'Repeat the new password',
                                controller: _confirmPasswordCtrl,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm the new password';
                                  }
                                  if (value != _newPasswordCtrl.text) {
                                    return 'Passwords don\'t match';
                                  }
                                  return null;
                                },
                                onSubmitted: (_) => _changePassword(),
                              ),
                              const SizedBox(height: 18),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TapLoopButton(
                                  label: 'Update password',
                                  onPressed: _changingPassword
                                      ? null
                                      : _changePassword,
                                  isLoading: _changingPassword,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _SettingsSection(
                        title: 'Session',
                        child: Column(
                          children: [
                            _SettingsRow(
                              icon: Icons.mail_outline,
                              title: user.email,
                              subtitle: 'Email for the active session.',
                            ),
                            Divider(color: context.borderColor, height: 28),
                            _SettingsRow(
                              icon: Icons.logout_rounded,
                              title: 'Sign out',
                              subtitle:
                                  'End the session on this device.',
                              onTap: () async {
                                await AuthService.signOut();
                                appState.clear();
                              },
                              titleColor: AppColors.error,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final UserModel user;
  final DigitalCardModel? card;

  const _ProfileCard({required this.user, required this.card});

  @override
  Widget build(BuildContext context) {
    final title = card?.name.trim().isNotEmpty == true ? card!.name : user.name;
    final subtitleParts = [
      if (card?.jobTitle.trim().isNotEmpty == true) card!.jobTitle,
      if (card?.company.trim().isNotEmpty == true) card!.company,
      if (card?.publicSlug.trim().isNotEmpty == true) '@${card!.publicSlug}',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Center(
              child: Text(
                _initials(title),
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitleParts.isEmpty
                      ? user.email
                      : subtitleParts.join(' · '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: context.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelpTitle(
            title: title,
            helpText: 'Groups the options related to $title.',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: context.bgSubtle,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: context.borderColor),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 20, color: context.textSecondary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: titleColor ?? context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: context.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _initials(String value) {
  final parts = value
      .trim()
      .split(' ')
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
  if (parts.isNotEmpty) return parts.first[0].toUpperCase();
  return 'TL';
}
