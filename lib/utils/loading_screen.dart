import 'dart:async' show StreamController;
import 'package:flutter/material.dart';
part 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInsatance();
  static final LoadingScreen _shared = LoadingScreen._sharedInsatance();

  factory LoadingScreen() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    textController.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20,),
                      StreamBuilder<Object>(
                        stream: textController.stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            return Text(snapshot.data as String, textAlign: TextAlign.center,);
                          } else {
                            return Container();
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      }
    );
    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      }
    );
  }
}