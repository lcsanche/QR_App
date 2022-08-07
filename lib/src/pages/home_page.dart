import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:qrapp/src/design/background_paint.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _listaEscaneados = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Recientes',
            style: TextStyle(fontSize: 30),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                if (_listaEscaneados.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (_) => _builtAlertDialog(),
                  );
                }
              },
            ),
          ],
        ),
        body: CustomPaint(
          painter: BackgroundPaint(),
          child: _listaEscaneados.isEmpty
              ? _banner()
              : _listView(_listaEscaneados),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: Colors.orange[300],
          child: const Icon(
            Icons.qr_code_scanner_outlined,
            color: Colors.white,
          ),
          onPressed: () => _scan(_listaEscaneados),
        ),
      ),
    );
  }

  Widget _banner() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Lo Sentimos...',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              thickness: 2,
              color: Colors.orange[300],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            const Text(
              'No hemos podido encontrar nada, así que es momento de comenzar a escanear QRs.',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listView(List<String> lista) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Scrollbar(
        child: ListView.builder(
          itemCount: lista.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red[300],
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 10),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: const Icon(Icons.delete, color: Colors.white70),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  lista.removeAt(index);
                });
              },
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    lista[index],
                  ),
                  onTap: () {
                    _launchUrl(Uri.parse(lista[index]));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _builtAlertDialog() {
    return AlertDialog(
      title: const Text('¿Esta seguro?'),
      content:
          const Text('Esta accion eliminará todo los registros escaneados'),
      actions: [
        MaterialButton(
          elevation: 2,
          color: Colors.cyan,
          child: const Text('Si', style: TextStyle(color: Colors.white)),
          onPressed: () {
            setState(() {
              _listaEscaneados.clear();
            });
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          elevation: 2,
          color: Colors.orange[300],
          child: const Text('No', style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }

  void _scan(List<String> lista) async {
    ScanResult resultado = await BarcodeScanner.scan();

    if (resultado.rawContent.isNotEmpty) {
      setState(() {
        lista.add(resultado.rawContent);
      });
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
