import 'package:expocity/components/custom_buttons/custom_elevated_button.dart';
import 'package:expocity/stores/page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

class CreateManifestationButton extends StatefulWidget {
  const CreateManifestationButton({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<CreateManifestationButton> createState() =>
      _CreateManifestationButtonState();
}

class _CreateManifestationButtonState extends State<CreateManifestationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    buttonAnimation = Tween<double>(begin: 0, end: 60).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.4, 0.6),
    ));

    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    final s = widget.scrollController.position;
    if (s.userScrollDirection == ScrollDirection.forward) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: buttonAnimation,
        builder: (_, __) {
          return FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: buttonAnimation.value),
                child: CustomElevatedButton(
                    onPressed: () async {
                      GetIt.I<PageStore>().setPage(2);
                    },
                    containerActionButton: Container(
                      alignment: Alignment.center,
                      child: const Text('Cadastrar Manifestação'),
                    ),
                    edgeInsets: const EdgeInsets.all(0))),
          );
        });
  }
}
