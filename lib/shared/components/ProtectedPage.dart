import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';

class ProtectedPage extends StatefulWidget {

  final Widget child;

  const ProtectedPage({
    super.key,
    required this.child,
  });

  @override
  State<ProtectedPage> createState() => _ProtectedPageState();
}

class _ProtectedPageState extends State<ProtectedPage> {
  late final ScreenshootprotectionService _service;

  @override
  void initState() {
    super.initState();
    _service = context.read<ScreenshootprotectionService>();
    _service.enableProtection();
  }

  @override
  void dispose() {
    _service.disableProtection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}