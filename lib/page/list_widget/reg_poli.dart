import 'package:flutter/material.dart';
import 'package:good_health/model/reg_poli.dart';
import 'package:good_health/util/util.dart';

class RegisPoliList extends StatefulWidget {
  final List<RegisPoli> regisPolis;

  // 1. Tambahkan callback ini
  final VoidCallback onDataReload;

  RegisPoliList({
    required this.regisPolis,
    required this.onDataReload, // 2. Tambahkan ini ke constructor
  });

  @override
  _RegisPoliListState createState() => _RegisPoliListState();
}

class _RegisPoliListState extends State<RegisPoliList> {
  @override
  Widget build(BuildContext context) {
    return (widget.regisPolis.length != 0)
        ? ListView.builder(
            itemCount:
                // ignore: unnecessary_null_comparison
                (widget.regisPolis == null ? 0 : widget.regisPolis.length),
            itemBuilder: (context, i) {
              return Container(
                child: GestureDetector(
                  onTap: null,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.assignment),
                          isThreeLine: true,
                          title: Text("${widget.regisPolis[i].idDokter.nama}"),
                          subtitle: Text("${widget.regisPolis[i].tglBooking}"),
                          trailing: Text("${widget.regisPolis[i].poli}"),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                              onPressed: () async {
                                // Panggil delete dan tunggu hasilnya
                                final result = await deleteRegisPoli(
                                  widget.regisPolis[i].idRegisPoli,
                                );

                                // --- PERBAIKAN DI SINI ---

                                // 1. Tampilkan dialog dan TUNGGU (await) sampai ditutup
                                await dialog(context, result);

                                // 2. SETELAH dialog ditutup, BARU panggil callback
                                //    untuk me-refresh data di halaman sebelumnya.
                                widget.onDataReload();

                                // --- AKHIR PERBAIKAN ---
                              },
                              child: Text('HAPUS'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Text('Tidak ada riwayat registrasi');
  }
}
