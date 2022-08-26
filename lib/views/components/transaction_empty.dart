import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TransictionEmpty extends StatelessWidget {
  const TransictionEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Nenhuma movimentação cadastrada',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: LottieBuilder.network(
              'https://assets7.lottiefiles.com/packages/lf20_i4mgmksv.json'),
        )
      ],
    );
  }
}
