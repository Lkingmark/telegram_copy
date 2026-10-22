import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreenAccount extends StatefulWidget {
  const SettingsScreenAccount({super.key});

  @override
  State<SettingsScreenAccount> createState() => _SettingsScreenAccountState();
}

class _SettingsScreenAccountState extends State<SettingsScreenAccount> {
  final _focusedFields = <String>{};

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
          CircleAvatar(
            radius: 40,
            backgroundColor: colors.primaryContainer,
            child: Icon(
              Icons.person_outline_rounded,
              size: 44,
              color: colors.onPrimaryContainer,
            ),
          ),
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
