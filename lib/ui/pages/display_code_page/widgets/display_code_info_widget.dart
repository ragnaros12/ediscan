
import 'package:EdiScan/ui/pages/display_code_page/widgets/scrol_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'action_item_widget.dart';

class DisplayCodeInfoWidget extends StatelessWidget{
  String date, value, type;
  BarcodeType typeCode;

  DisplayCodeInfoWidget(this.date, this.value, this.type, this.typeCode, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        displayCodeValue(value, typeCode),
        const SizedBox(height: 30),
        Text("Дата скана: $date", style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 30),
        Text("Тип кода: $type", style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 15),
        Container(height: 0.7, color: Colors.black38, margin: const EdgeInsets.only(right: 30, left: 30)),
        const SizedBox(height: 15),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ActionItemWidget("Копировать", Icons.copy, () async {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Скопировано в буфер обмена"),
                ));
              }),
              ActionItemWidget("Поделиться", Icons.share, () async {
                if(Uri.parse(value).isAbsolute) {
                  await FlutterShare.share(title: "Поделитесь ссылкой", linkUrl: value, text: "ссылка");
                }
                else{
                  await FlutterShare.share(title: "Поделитесь текстом", text: value);
                }
              }
              )
            ],
          ),
          margin: const EdgeInsets.only(left: 20, right: 20),
        ),
        const SizedBox(height: 30),
      ],
    );
  }


  Widget displayCodeValue(String value, BarcodeType type){
    switch(type){
      case BarcodeType.url:
        return InkWell(child: ScrollTextWidget(value: value, isUrl: true),
            onTap: () => launch(value));
      case BarcodeType.text:
        return ScrollTextWidget(value: "Значение: $value", isUrl: false);
      case BarcodeType.email:
        return InkWell(child: ScrollTextWidget(value : value, isUrl: true),
            onTap: () => launch("mailto:$value"));
    }
    return Container();
  }

}