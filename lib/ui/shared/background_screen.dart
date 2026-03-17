import 'package:flutter/material.dart';
import '../../core/constants/app_images.dart';

/// A professional, reusable wrapper widget that provides a consistent 
/// background image for screens throughout the VLM Academy application.
/// 
/// This widget acts as a high-level substitute for [Scaffold], providing 
/// the brand-consistent background while exposing all major [Scaffold] 
/// properties for maximum flexibility.
class BackgroundScreen extends StatelessWidget {
  /// The main content of the screen.
  final Widget body;

  /// An optional app bar to display at the top of the screen.
  final PreferredSizeWidget? appBar;

  /// A button displayed floating above [body].
  final Widget? floatingActionButton;

  /// Responsible for positioning [floatingActionButton].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// List of widgets to display in a row after the [body].
  final List<Widget>? persistentFooterButtons;

  /// A panel displayed to the side of the [body].
  final Widget? drawer;

  /// A panel displayed to the side of the [body].
  final Widget? endDrawer;

  /// A widget to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// A widget to display at the bottom of the scaffold, overlaying the [body].
  final Widget? bottomSheet;

  /// The color to use for the scaffold's background (under the image).
  final Color? backgroundColor;

  /// Whether the [appBar] should be extended over the [body].
  final bool extendBodyBehindAppBar;

  /// Whether the [body] should extend under the [bottomNavigationBar] or [persistentFooterButtons].
  final bool extendBody;

  /// If true, the [body] and other widgets will avoid the system's 
  /// status bar and bottom notch.
  final bool useSafeArea;

  /// Whether the screen should resize when the keyboard appears.
  final bool? resizeToAvoidBottomInset;

  /// The opacity of the background image (0.0 to 1.0).
  final double backgroundOpacity;

  /// The padding to apply around the [body] content.
  final EdgeInsetsGeometry? padding;

  /// Optional callback for handling back button presses.
  final Future<bool> Function()? onWillPop;

  /// Optional gradient to overlay on top of the background image.
  final Gradient? backgroundGradient;

  const BackgroundScreen({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor = Colors.transparent,
    this.extendBodyBehindAppBar = true,
    this.extendBody = false,
    this.useSafeArea = true,
    this.resizeToAvoidBottomInset,
    this.backgroundOpacity = 1.0,
    this.padding,
    this.onWillPop,
    this.backgroundGradient,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    // Wrap with PopScope if provided
    if (onWillPop != null) {
      content = PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final shouldPop = await onWillPop!();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: content,
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      persistentFooterButtons: persistentFooterButtons,
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Opacity(
              opacity: backgroundOpacity,
              child: Image.asset(
                AppImages.bgImage,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // 2. Optional Gradient Overlay
          if (backgroundGradient != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(gradient: backgroundGradient),
              ),
            ),
          
          // 3. Main Content
          content,
        ],
      ),
    );
  }
}
