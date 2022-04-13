
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayPage extends StatelessWidget{
  String value;
  String date;
  String type;


  DisplayPage(this.value, this.date,this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Значение")),
        body: Center(
          child: Card(
              margin: const EdgeInsets.only(left: 20, right: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Panel(date, value, type)
          )
      ),
    );
    }
}

class ScrollText extends StatelessWidget{
  String value;
  bool url = true;

  ScrollText(this.value, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(
        minHeight: 20,
        maxHeight: 200
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(value, style: TextStyle(fontSize: 17, color: (url) ? Colors.blue : Colors.black), textAlign: TextAlign.center),
      )
    );
  }

}


class Panel extends StatelessWidget{
  String date, value, type;

  Panel(this.date, this.value, this.type);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        Uri.parse(value).isAbsolute ?
            InkWell(child: ScrollText(value, true),
            onTap: () => launch(value.substring(value.indexOf("http") ))) :
        ScrollText("Значение: $value", false),
        const SizedBox(height: 30),
        Text("Дата скана: $date", style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 30),
        Text("Тип кода: $type", style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 30),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Item("Копировать", Icons.copy, () async {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Скопировано в буфер обмена"),
                ));
              }),
              Item("Поделиться", Icons.share, () async {
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


}


class Item extends StatelessWidget{

  String value;
  IconData data;
  VoidCallback function;

  Item(this.value, this.data, this.function, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(value, style: const TextStyle(fontSize: 16)),
                Icon(data),
              ],
            ),
          ),
          onTap: function,
        )
    );
  }

}