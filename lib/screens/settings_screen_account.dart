import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreenAccount extends StatefulWidget {
  const SettingsScreenAccount({super.key});

  @override
  State<SettingsScreenAccount> createState() => _SettingsScreenAccountState();
}

class _SettingsScreenAccountState extends State<SettingsScreenAccount> {
  final _focusedFields = <String>{};
  Uint8List? _avatarPhoto;
  bool _changingPhoto = false;
  bool _photoMenuOpen = false;

  Future<void> _changePhoto() async {
    if (_changingPhoto || _photoMenuOpen) return;
    FocusScope.of(context).unfocus();
    _photoMenuOpen = true;

    try {
      final choosePhoto = await showModalBottomSheet<bool>(
        context: context,
        showDragHandle: true,
        useSafeArea: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (sheetContext) {
          final colors = AppTheme.colorsOf(sheetContext);
          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Change profile photo',
                    style: Theme.of(sheetContext).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const CircleAvatar(
                      backgroundColor: AppTheme.photoAttachment,
                      foregroundColor: AppTheme.attachmentForeground,
                      child: Icon(Icons.photo_library_outlined),
                    ),
                    title: const Text('Photo'),
                    subtitle: Text(
                      'Choose a profile photo',
                      style: TextStyle(color: colors.secondaryText),
                    ),
                    onTap: () => Navigator.pop(sheetContext, true),
                  ),
                ],
              ),
            ),
          );
        },
      );
      if (!mounted || choosePhoto != true) return;

      setState(() => _changingPhoto = true);
      final photo = await FilePicker.pickFile(type: FileType.image);
      if (!mounted || photo == null) return;
      final bytes = await photo.readAsBytes();
      if (!mounted) return;

      // Check that the file can be displayed before replacing the current photo.
      final image = await decodeImageFromList(bytes);
      image.dispose();
      if (!mounted) return;
      setState(() => _avatarPhoto = bytes);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open photo. Please try again.'),
          ),
        );
      }
    } finally {
      _photoMenuOpen = false;
      if (mounted) setState(() => _changingPhoto = false);
    }
  }

  Widget _avatar(ColorScheme colors) => Center(
    child: SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: colors.primaryContainer,
                foregroundImage: _avatarPhoto == null
                    ? null
                    : MemoryImage(_avatarPhoto!),
                child: _avatarPhoto == null
                    ? Icon(
                        Icons.person_outline_rounded,
                        size: 44,
                        color: colors.onPrimaryContainer,
                      )
                    : null,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton.filled(
              tooltip: 'Change profile photo',
              style: IconButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                disabledBackgroundColor: colors.primary,
                disabledForegroundColor: colors.onPrimary,
                minimumSize: const Size(40, 40),
                shape: CircleBorder(
                  side: BorderSide(color: colors.surface, width: 3),
                ),
              ),
              onPressed: _changingPhoto ? null : _changePhoto,
              icon: _changingPhoto
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.onPrimary,
                      ),
                    )
                  : const Icon(Icons.camera_alt_outlined, size: 20),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _section(String title, ColorScheme colors) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Text(
      title,
      style: TextStyle(
        color: colors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    ),
  );

  Widget _field(
    ColorScheme colors,
    String label,
    String value,
    IconData icon, {
    TextInputType? keyboardType,
    TextCapitalization capitalization = TextCapitalization.none,
    Iterable<String>? autofillHints,
    String? helperText,
    int maxLines = 1,
    bool last = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Focus(
      onFocusChange: (focused) => setState(() {
        if (focused) {
          _focusedFields.add(label);
        } else {
          _focusedFields.remove(label);
        }
      }),
      child: TextFormField(
        keyboardType:
            keyboardType ??
            (maxLines > 1 ? TextInputType.multiline : TextInputType.text),
        textCapitalization: capitalization,
        autofillHints: autofillHints,
        minLines: 1,
        maxLines: maxLines,
        textInputAction: last
            ? TextInputAction.done
            : (maxLines > 1 ? TextInputAction.newline : TextInputAction.next),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: _focusedFields.contains(label) ? null : value,
          prefixIcon: Icon(icon, color: colors.onSurfaceVariant),
          helperText: helperText,
          helperMaxLines: 2,
          helperStyle: TextStyle(color: colors.secondaryText, fontSize: 12),
          fillColor: colors.surfaceContainerLow,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: colors.inputOutline),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        children: [
          _avatar(colors),
          const SizedBox(height: 12),
          Text(
            'Your profile',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Personal details and contact information',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
          ),
          const SizedBox(height: 28),
          _section('Personal information', colors),
          _field(
            colors,
            'Name',
            'Name',
            Icons.person_outline,
            capitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.givenName],
          ),
          _field(
            colors,
            'Surname',
            'Surname',
            Icons.badge_outlined,
            capitalization: TextCapitalization.words,
            autofillHints: const [AutofillHints.familyName],
          ),
          _field(
            colors,
            'Nickname',
            'Nickname',
            Icons.alternate_email_rounded,
            keyboardType: TextInputType.text,
            helperText: 'The name others can use to find you',
          ),
          _field(
            colors,
            'About me',
            'About me',
            Icons.info_outline,
            maxLines: 3,
            capitalization: TextCapitalization.sentences,
            helperText: 'A few words about yourself',
          ),
          _field(
            colors,
            'Date of birth',
            '01/01/2000',
            Icons.cake_outlined,
            keyboardType: TextInputType.datetime,
            helperText: 'DD/MM/YYYY',
          ),
          const SizedBox(height: 8),
          Divider(height: 24, thickness: 0.5, color: colors.outlineVariant),
          _section('Contact details', colors),
          _field(
            colors,
            'Phone number',
            '+380123456789',
            Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            autofillHints: const [AutofillHints.telephoneNumber],
            helperText: 'Include your country code',
            last: true,
          ),
        ],
      ),
    );
  }
}
