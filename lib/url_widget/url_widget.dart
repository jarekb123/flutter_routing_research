import 'package:flutter/material.dart';

class UrlWidget extends StatefulWidget {
  const UrlWidget({
    Key? key,
    required this.routerDelegate,
    required this.routeInformationParser,
    this.urlFieldBuilder = _defaultFieldBuilder,
  }) : super(key: key);

  final RouterDelegate routerDelegate;
  final RouteInformationParser routeInformationParser;
  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    VoidCallback onEditingCompleted,
  ) urlFieldBuilder;

  static Widget _defaultFieldBuilder(
    BuildContext context,
    TextEditingController controller,
    VoidCallback onEditingCompleted,
  ) =>
      _DefaultUrlField(
        controller: controller,
        onEditingComplete: onEditingCompleted,
      );

  @override
  State<UrlWidget> createState() => _UrlWidgetState();
}

class _UrlWidgetState extends State<UrlWidget> {
  RouterDelegate get _delegate => widget.routerDelegate;
  RouteInformationParser get _parser => widget.routeInformationParser;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _delegate.addListener(_routerDelegateListener);
  }

  @override
  void dispose() {
    _delegate.removeListener(_routerDelegateListener);
    _controller.dispose();
    super.dispose();
  }

  void _routerDelegateListener() {
    final configuration = _delegate.currentConfiguration;
    final routeInfo = _parser.restoreRouteInformation(configuration);
    final path = routeInfo?.location ?? '';
    if (_controller.text != path) {
      _controller.value = TextEditingValue(
        text: path,
        selection: TextSelection.collapsed(offset: path.length),
      );
    }
  }

  Future<void> _onUrlEditingComplete() async {
    final url = _controller.text;
    final configuration = await _parser.parseRouteInformation(
      RouteInformation(location: url),
    );
    _delegate.setNewRoutePath(configuration);
  }

  @override
  Widget build(BuildContext context) {
    return widget.urlFieldBuilder(
      context,
      _controller,
      () => _onUrlEditingComplete(),
    );
  }
}

class _DefaultUrlField extends StatelessWidget {
  const _DefaultUrlField({
    Key? key,
    required this.controller,
    required this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 48,
        child: Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: controller,
                  onEditingComplete: onEditingComplete,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
