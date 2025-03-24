import 'package:flutter/material.dart';

class KeepAliveWraper extends StatefulWidget {

  final Widget child;
  final bool keepAlive;

  const KeepAliveWraper({super.key, required this.child,  this.keepAlive = true});

  @override
  State<KeepAliveWraper> createState() => _KeepAliveWraperState();
}

class _KeepAliveWraperState extends State<KeepAliveWraper> with AutomaticKeepAliveClientMixin {
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  
  @override
  bool get wantKeepAlive => widget.keepAlive;
}