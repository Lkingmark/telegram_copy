import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';
import 'contacts_screen.dart';
import 'new_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  // Demo data until conversations are loaded from the server.
  static const _chats = [
    _Chat(
      'saved',
      'Saved Messages',
      'Your notes, links and favourite messages',
      '12:42',
      '★',
      Color(0xFF5AA9E6),
      pinned: true,
      sent: true,
    ),
    _Chat(
      'study',
      'Study Group',
      'Olena: See you at the next lecture!',
      '12:35',
      'SG',
      Color(0xFF8B78C5),
      unread: 12,
      pinned: true,
      group: true,
    ),
    _Chat(
      'anna',
      'Anna',
      'Are we meeting at 3?',
      '12:28',
      'A',
      Color(0xFFDF9671),
      unread: 2,
    ),
    _Chat(
      'maksym',
      'Maksym',
      'Thanks! I’ll check it out',
      '11:54',
      'M',
      Color(0xFF6DB6A1),
      sent: true,
    ),
    _Chat(
      'flutter',
      'Flutter Community',
      'New resources for your next project',
      '11:20',
      'FC',
      Color(0xFF58A5C9),
      unread: 128,
      muted: true,
      group: true,
    ),
    _Chat('olena', 'Olena', 'Photo', '10:46', 'O', Color(0xFFC580A5)),
    _Chat(
      'project',
      'Messenger Project',
      'You: Updated the home screen',
      'Yesterday',
      'MP',
      Color(0xFF7A9AC9),
      muted: true,
      group: true,
      sent: true,
    ),
    _Chat(
      'andrii',
      'Andrii',
      'Sounds good 👍',
      'Yesterday',
      'A',
      Color(0xFFB69B65),
      sent: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _open(Widget screen, {bool fromDrawer = false}) {
    if (fromDrawer) Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final brightness = switch (AppTheme.mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    return Theme(
      data: brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
      child: Builder(builder: _buildHome),
    );
  }

  Widget _buildHome(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final query = _searchController.text.trim().toLowerCase();
    final chats = _chats
        .where(
          (chat) =>
              chat.name.toLowerCase().contains(query) ||
              chat.message.toLowerCase().contains(query),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 8,
        leading: _isSearching
            ? IconButton(
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() {
                  _isSearching = false;
                  _searchController.clear();
                }),
              )
            : null,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                cursorColor: colors.onPrimary,
                style: TextStyle(color: colors.onPrimary, fontSize: 19),
                decoration: InputDecoration(
                  hintText: 'Search chats',
                  hintStyle: TextStyle(
                    color: colors.onPrimary.withValues(alpha: 0.7),
                  ),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (_) => setState(() {}),
              )
            : const Text(
                'Telegram',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
              ),
        actions: [
          IconButton(
            tooltip: _isSearching ? 'Clear search' : 'Search',
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              if (_isSearching) {
                _searchController.clear();
              } else {
                _isSearching = true;
              }
            }),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: colors.primary),
              accountName: Text(
                'My Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colors.onPrimary,
                ),
              ),
              accountEmail: Text(
                '+380 99 123 45 67',
                style: TextStyle(color: colors.onPrimary),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: colors.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: colors.onPrimaryContainer,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('New Chat'),
              onTap: () => _open(const NewChatScreen(), fromDrawer: true),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Contacts'),
              onTap: () => _open(const ContactsScreen(), fromDrawer: true),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('Saved Messages'),
              onTap: () => _open(
                const ChatScreen(chatId: 'saved', chatName: 'Saved Messages'),
                fromDrawer: true,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => _open(const SettingsScreen(), fromDrawer: true),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: chats.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: colors.onSurfaceVariant,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No chats found',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: chats.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 88,
                  color: colors.outlineVariant,
                ),
                itemBuilder: (context, index) => _tile(context, chats[index]),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New message',
        shape: const CircleBorder(),
        elevation: 3,
        onPressed: () => _open(const NewChatScreen()),
        child: const Icon(Icons.edit, size: 25),
      ),
    );
  }

  Widget _tile(BuildContext context, _Chat chat) {
    final colors = Theme.of(context).colorScheme;
    final secondary = colors.onSurfaceVariant;
    return Material(
      color: chat.pinned ? colors.surfaceContainerLow : colors.surface,
      child: InkWell(
        onTap: () => _open(ChatScreen(chatId: chat.id, chatName: chat.name)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: chat.color,
                foregroundColor: Colors.white,
                child: chat.id == 'saved'
                    ? const Icon(Icons.bookmark_border, size: 30)
                    : Text(
                        chat.initials,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (chat.group) ...[
                          Icon(
                            Icons.group,
                            size: 17,
                            color: colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Flexible(
                          child: Text(
                            chat.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: colors.onSurface,
                            ),
                          ),
                        ),
                        if (chat.muted) ...[
                          const SizedBox(width: 5),
                          Icon(Icons.volume_off, size: 15, color: secondary),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      chat.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (chat.sent) ...[
                        const Icon(
                          Icons.done_all,
                          size: 17,
                          color: Color(0xFF6BA587),
                        ),
                        const SizedBox(width: 3),
                      ],
                      Text(
                        chat.time,
                        style: TextStyle(fontSize: 12, color: secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (chat.unread > 0)
                    Container(
                      constraints: const BoxConstraints(minWidth: 23),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: chat.muted
                            ? const Color(0xFFB6BEC5)
                            : const Color(0xFF64A5D6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${chat.unread}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 20,
                      child: chat.pinned
                          ? Icon(Icons.push_pin, size: 16, color: secondary)
                          : null,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chat {
  const _Chat(
    this.id,
    this.name,
    this.message,
    this.time,
    this.initials,
    this.color, {
    this.unread = 0,
    this.pinned = false,
    this.muted = false,
    this.group = false,
    this.sent = false,
  });
  final String id;
  final String name;
  final String message;
  final String time;
  final String initials;
  final Color color;
  final int unread;
  final bool pinned;
  final bool muted;
  final bool group;
  final bool sent;
}
