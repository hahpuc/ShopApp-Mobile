import 'package:flutter/material.dart';

class PinchZoomImage extends StatefulWidget {
  final String imagePath;
  const PinchZoomImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  _PinchZoomImageState createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  final double minScale = 1;
  final double maxScale = 4;
  OverlayEntry? entry;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 200))
          ..addListener(() => _controller.value = _animation!.value)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              removeOverlay();
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    return Builder(
      builder: (context) => InteractiveViewer(
        clipBehavior: Clip.none,
        transformationController: _controller,
        panEnabled: false,
        minScale: minScale,
        maxScale: maxScale,
        onInteractionStart: (details) {
          if (details.pointerCount < 2) return;
          if (entry == null) {
            showOverlay(context);
          }
        },
        onInteractionEnd: (details) {
          resetAnimation();
        },
        child: Image.network(
          widget.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          width: size.width,
          child: buildImage(),
        );
      },
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }

  void resetAnimation() {
    _animation = Matrix4Tween(begin: _controller.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.bounceInOut));
    _animationController.forward(from: 0);
  }
}
