import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatName;

  const ChatScreen({super.key, required this.chatId, required this.chatName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const _blue = Color(0xFF527DA3);
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<_Message> _messages = [];
  final List<_Attachment> _pendingFiles = [];
  bool _pickingFiles = false;
  bool _blocked = false;
  bool _showEmoji = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if ((text.isEmpty && _pendingFiles.isEmpty) || _blocked || _pickingFiles) {
      return;
    }
    setState(() {
      _messages.insert(
        0,
        _Message(text, DateTime.now(), files: List.of(_pendingFiles)),
      );
      _pendingFiles.clear();
      _messageController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _pickFiles() async {
    if (_pickingFiles || _blocked) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _pickingFiles = true;
      _showEmoji = false;
    });
    try {
      final files = await FilePicker.pickFiles();
      final attachments = <_Attachment>[];
      for (final file in files) {
        final size = file.lengthSync() ?? await file.length();
        attachments.add(_Attachment(file, size));
      }
      if (!mounted || _blocked) return;
      setState(() => _pendingFiles.addAll(attachments));
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not attach files. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _pickingFiles = false);
    }
  }

  void _toggleReaction(_Message message, String emoji) {
    if (!_messages.contains(message)) return;
    setState(() => message.reaction = message.reaction == emoji ? null : emoji);
  }

  Future<void> _showMessageActions(_Message message) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'React to message',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final emoji in ['👍', '❤️', '😂', '🔥', '🎉', '👎'])
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: message.reaction == emoji
                              ? const Color(0xFFE0EDF7)
                              : null,
                        ),
                        onPressed: () => Navigator.pop(context, emoji),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.copy_outlined),
                  title: Text(
                    message.text.isEmpty ? 'Copy file names' : 'Copy message',
                  ),
                  onTap: () => Navigator.pop(context, 'copy'),
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text(
                    'Delete message',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => Navigator.pop(context, 'delete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (!mounted || action == null || !_messages.contains(message)) return;
    if (action == 'copy') {
      await Clipboard.setData(
        ClipboardData(
          text: message.text.isEmpty
              ? message.files.map((file) => file.file.name).join('\n')
              : message.text,
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied'), duration: Duration(seconds: 1)),
      );
    } else if (action == 'delete') {
      setState(() => _messages.remove(message));
    } else {
      _toggleReaction(message, action);
    }
  }

  Widget _attachmentCard(_Attachment attachment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            backgroundColor: _blue,
            foregroundColor: Colors.white,
            child: Icon(Icons.insert_drive_file_outlined),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.file.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF17212B),
                  ),
                ),
                Text(
                  '${attachment.sizeLabel} · Local attachment',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6A895C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAction({required bool block}) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(block ? 'Block user?' : 'Clear history?'),
        content: Text(
          block
              ? 'Sending messages will be disabled for this session. You can unblock the user at any time.'
              : 'All messages in this local session will be removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              block ? 'Block' : 'Clear',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    setState(() {
      if (block) {
        _blocked = true;
        _showEmoji = false;
        FocusScope.of(context).unfocus();
      } else {
        _messages.clear();
      }
    });
  }

  void _insertEmoji(String emoji) {
    final value = _messageController.value;
    final selection = value.selection;
    final start = selection.isValid ? selection.start : value.text.length;
    final end = selection.isValid ? selection.end : value.text.length;
    _messageController.value = TextEditingValue(
      text: value.text.replaceRange(start, end, emoji),
      selection: TextSelection.collapsed(offset: start + emoji.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saved = widget.chatId == 'saved';
    final name = widget.chatName.trim();
    return Scaffold(
      backgroundColor: const Color(0xFFDCE5D7),
      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF85B4D7),
              foregroundColor: Colors.white,
              child: saved
                  ? const Icon(Icons.bookmark_border)
                  : Text(
                      name.isEmpty ? '?' : name.characters.first.toUpperCase(),
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _blocked
                        ? 'Blocked in this session'
                        : saved
                        ? 'Your personal space'
                        : 'Local chat · offline',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Chat options',
            onSelected: (value) {
              if (value == 'clear') _confirmAction(block: false);
              if (value == 'block') {
                if (_blocked) {
                  setState(() => _blocked = false);
                } else {
                  _confirmAction(block: true);
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'clear',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.delete_outline),
                  title: Text('Clear history'),
                ),
              ),
              if (!saved)
                PopupMenuItem(
                  value: 'block',
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_blocked ? Icons.lock_open : Icons.block),
                    title: Text(_blocked ? 'Unblock user' : 'Block user'),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 280),
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              saved
                                  ? Icons.bookmark_border
                                  : Icons.waving_hand_outlined,
                              size: 40,
                              color: _blue,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              saved
                                  ? 'Your saved messages'
                                  : 'Start a conversation',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Messages are kept only while this screen is open.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF667568),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                      itemCount: _messages.length,
                      itemBuilder: (_, index) {
                        final message = _messages[index];
                        final previous = index + 1 < _messages.length
                            ? _messages[index + 1]
                            : null;
                        final startsDay =
                            previous == null ||
                            DateUtils.dateOnly(previous.time) !=
                                DateUtils.dateOnly(message.time);
                        return Column(
                          children: [
                            if (startsDay)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8EAA8C),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      DateUtils.isSameDay(
                                            message.time,
                                            DateTime.now(),
                                          )
                                          ? 'Today'
                                          : '${message.time.day}/${message.time.month}/${message.time.year}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onLongPress: () => _showMessageActions(message),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width * 0.82,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 3,
                                  ),
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    8,
                                    10,
                                    6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE3FFC7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(4),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x10000000),
                                        offset: Offset(0, 1),
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (final attachment in message.files)
                                        _attachmentCard(attachment),
                                      if (message.text.isNotEmpty)
                                        Text(
                                          message.text,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF17212B),
                                            height: 1.35,
                                          ),
                                        ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')} · local',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF6A895C),
                                        ),
                                      ),
                                      if (message.reaction != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 6,
                                          ),
                                          child: ActionChip(
                                            label: Text(
                                              '${message.reaction} 1',
                                            ),
                                            tooltip: 'Remove reaction',
                                            backgroundColor: const Color(
                                              0xFFD0E7BF,
                                            ),
                                            side: BorderSide.none,
                                            onPressed: () => _toggleReaction(
                                              message,
                                              message.reaction!,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            if (_pendingFiles.isNotEmpty && !_blocked)
              Container(
                width: double.infinity,
                color: const Color(0xFFF2F5F7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 110),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 6,
                      children: [
                        for (final attachment in _pendingFiles)
                          InputChip(
                            avatar: const Icon(
                              Icons.insert_drive_file_outlined,
                              size: 18,
                            ),
                            label: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 180),
                              child: Text(
                                attachment.file.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            tooltip:
                                '${attachment.file.name} · ${attachment.sizeLabel}',
                            onDeleted: () => setState(
                              () => _pendingFiles.remove(attachment),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            if (_blocked)
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () => setState(() => _blocked = false),
                  child: const Text('Unblock user'),
                ),
              )
            else
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(2, 4, 8, 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: _showEmoji ? 'Close emoji' : 'Emoji',
                      icon: Icon(
                        _showEmoji
                            ? Icons.close
                            : Icons.sentiment_satisfied_alt_outlined,
                        color: const Color(0xFF8A939B),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        minLines: 1,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        onTap: () {
                          if (_showEmoji) setState(() => _showEmoji = false);
                        },
                      ),
                    ),
                    IconButton(
                      tooltip: 'Attach files',
                      onPressed: _pickingFiles ? null : _pickFiles,
                      icon: _pickingFiles
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(
                              Icons.attach_file,
                              color: Color(0xFF8A939B),
                            ),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _messageController,
                      builder: (_, value, _) => IconButton.filled(
                        tooltip: 'Send message',
                        style: IconButton.styleFrom(
                          backgroundColor: _blue,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFFE9EEF2),
                        ),
                        onPressed:
                            _pickingFiles ||
                                (value.text.trim().isEmpty &&
                                    _pendingFiles.isEmpty)
                            ? null
                            : _sendMessage,
                        icon: const Icon(Icons.send_rounded, size: 23),
                      ),
                    ),
                  ],
                ),
              ),
            if (_showEmoji && !_blocked)
              Container(
                width: double.infinity,
                color: const Color(0xFFF2F5F7),
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final emoji in [
                      '😀',
                      '😊',
                      '😂',
                      '❤️',
                      '👍',
                      '🎉',
                      '👋',
                      '🔥',
                    ])
                      TextButton(
                        onPressed: () => _insertEmoji(emoji),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 26),
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

class _Message {
  _Message(this.text, this.time, {this.files = const []});
  final String text;
  final DateTime time;
  final List<_Attachment> files;
  String? reaction;
}

class _Attachment {
  const _Attachment(this.file, this.size);
  // Keep the actual file handle available for a future streamed upload.
  final PlatformFile file;
  final int? size;

  String get sizeLabel {
    final bytes = size;
    if (bytes == null) return 'Unknown size';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
