import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_extensions.dart';
import '../../../core/services/auth_service.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_layout.dart';
import '../../../core/widgets/taploop_button.dart';
import '../../../core/widgets/taploop_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _onSend() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.resetPassword(_emailCtrl.text.trim());
      if (mounted) {
        setState(() {
          _loading = false;
          _sent = true;
        });
      }
    } catch (_) {
      // Still show success to avoid email enumeration
      if (mounted) {
        setState(() {
          _loading = false;
          _sent = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: _sent
          ? _SuccessState(email: _emailCtrl.text.trim())
          : _FormState(
              formKey: _formKey,
              emailCtrl: _emailCtrl,
              loading: _loading,
              onSend: _onSend,
            ),
    );
  }
}

class _FormState extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final bool loading;
  final VoidCallback onSend;

  const _FormState({
    required this.formKey,
    required this.emailCtrl,
    required this.loading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: context.textPrimary,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(height: 16),
          const AuthHeader(
            title: 'Recover password',
            subtitle:
                'Enter your email and we\'ll send you a link to reset your password',
          ),
          const SizedBox(height: 32),

          TapLoopTextField(
            label: 'Email',
            hint: 'you@email.com',
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            prefixIcon: Icon(
              Icons.mail_outline,
              size: 20,
              color: context.textMuted,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Enter your email';
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(v.trim())) return 'Invalid email';
              return null;
            },
            onSubmitted: (_) => onSend(),
          ),
          const SizedBox(height: 24),

          TapLoopButton(
            label: 'Send recovery link',
            onPressed: onSend,
            variant: TapLoopButtonVariant.secondary,
            isLoading: loading,
          ),
          const SizedBox(height: 24),

          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Back to sign in',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  final String email;

  const _SuccessState({required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Check your email!',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'We sent a recovery link to\n$email',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: context.textSecondary,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        TapLoopButton(
          label: 'Back to sign in',
          onPressed: () => Navigator.pop(context),
          variant: TapLoopButtonVariant.secondary,
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Didn\'t get the email? Check your spam folder',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: context.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
