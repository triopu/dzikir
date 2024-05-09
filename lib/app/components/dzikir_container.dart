import 'package:dzikir/app/data/dzikir_model.dart';
import 'package:flutter/material.dart';

class DzikirContainer extends StatelessWidget {
  final DzikirModel dzikir;
  final int index;
  final int count;
  final ScrollController controller;
  const DzikirContainer({
    super.key,
    required this.dzikir,
    required this.index,
    required this.count,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    String titleText = dzikir.title ?? "Dzikir";
    int dzikirCount = dzikir.count ?? 1;
    if (dzikirCount > 1) titleText = "$titleText ($dzikirCount x)";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFF185a9d),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Center(
              child: Text(
            titleText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          )),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF185a9d),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          itemCount: dzikir.dzikirs?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            Dzikir d = dzikir.dzikirs![index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  d.dzikir ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                const SizedBox(height: 8),
                                Visibility(
                                  visible: d.dzikirSource != null,
                                  child: Text(
                                    "(${d.dzikirSource ?? ""})",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Visibility(
                                  visible: d.text != null,
                                  child: Text(
                                    d.text ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.1,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Visibility(
                                  visible: d.translation != null,
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        height: 1.2,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(
                                          text: 'Artinya: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: d.translation ?? "",
                                          style: const TextStyle(fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 12);
                          },
                        ),
                        Visibility(
                          visible: dzikir.benefit != null,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.2,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Faedah: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: dzikir.benefit ?? "",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: dzikir.benefitSource != null,
                          child: Padding(
                            padding: EdgeInsets.only(top: dzikir.benefit == null ? 16 : 6),
                            child: Text(
                              "(${dzikir.benefitSource ?? ""})",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      height: 42,
                      width: 42,
                      color: Colors.transparent,
                      child: Center(
                          child: Text(
                        "${index + 1}/$count",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Roboto",
                        ),
                      )),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
