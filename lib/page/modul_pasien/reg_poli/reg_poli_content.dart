import 'package:flutter/material.dart';
import 'package:good_health/model/reg_poli.dart';
// Pastikan path ke RegisPoliList ini benar
import 'package:good_health/page/list_widget/reg_poli.dart';
import 'package:good_health/page/modul_pasien/reg_poli/create.dart'
    as RegisPoliCreate;
import 'package:good_health/util/util.dart';

class RegisPoliContent extends StatefulWidget {
  static String title = "Registrasi Poli";

  @override
  _RegisPoliContentState createState() => _RegisPoliContentState();
}

class _RegisPoliContentState extends State<RegisPoliContent> {
  late Future<List<RegisPoli>> regisPolis;

  @override
  void initState() {
    super.initState();
    regisPolis = fetchRegisPolis();
  }

  // Buat fungsi refresh terpisah agar rapi
  void _refreshData() {
    setState(() {
      regisPolis = fetchRegisPolis();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RegisPoliCreate.CreatePage(),
            ),
          );
          if (result != null) {
            dialog(context, result);
            _refreshData(); // Panggil fungsi refresh
          }
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.edit),
      ),
      body: Center(
        child: FutureBuilder(
          future: regisPolis,
          builder: (context, snapshot) {
            Widget result;
            if (snapshot.hasError) {
              result = Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              // 4. Implementasikan callback di sini
              result = RegisPoliList(
                regisPolis: snapshot.data!,
                onDataReload: _refreshData, // Panggil fungsi refresh
              );
            } else {
              result = CircularProgressIndicator();
            }
            return result;
          },
        ),
      ),
    );
  }
}
