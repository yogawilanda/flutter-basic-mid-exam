part of 'lib_layout.dart';

class MobileScreen extends StatelessWidget {
  final Widget? useWidget; // Allow custom widget to be passed
  final bool isDefaultWidget; // Determine if the default widget should be used

  // Constructor with optional custom widget
  MobileScreen({
    super.key,
    this.useWidget,
    this.isDefaultWidget = true, // Default to true if not provided
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // Helper method to build the body
  Widget _buildBody() {
    if (isDefaultWidget || useWidget == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mobile Screen',
            ),
          ],
        ),
      );
    } else {
      return useWidget!;
    }
  }
}
