import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:good_health/model/pesan_obat.dart';
// 1. PASTIKAN IMPORT INI TIDAK DI-COMMENT agar bisa memanggil dialog()
import 'package:good_health/util/util.dart';

class PesanObatViewPage extends StatefulWidget {
  final PesanObat pesanObat;

  PesanObatViewPage({required this.pesanObat});

  @override
  _PesanObatViewPageState createState() => _PesanObatViewPageState();
}

class _PesanObatViewPageState extends State<PesanObatViewPage> {
  late LatLng alamatLatLng;

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  static late CameraPosition _currentPosition; // Location set is Kampus PENS

  @override
  void initState() {
    super.initState();
    alamatLatLng = LatLng(
      double.parse(widget.pesanObat.lat),
      double.parse(widget.pesanObat.lng),
    );
    _currentPosition = CameraPosition(target: alamatLatLng, zoom: 14.4746);
    _addMarker(alamatLatLng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Informasi Pesanan')),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Flexible(flex: 1, child: _map()),
              Flexible(
                flex: 1,
                child: ListView(
                  children: <Widget>[
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Informasi')),
                        DataColumn(label: Text('')),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text('Nama Pemesan')),
                            DataCell(Text(widget.pesanObat.idPasien!.nama)),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('Telfon')),
                            DataCell(Text(widget.pesanObat.idPasien!.hp)),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('Alamat')),
                            DataCell(Text(widget.pesanObat.alamat)),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('Pesanan')),
                            DataCell(Text(widget.pesanObat.listPesanan)),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('Waktu')),
                            DataCell(Text(widget.pesanObat.waktu)),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('Catatan')),
                            DataCell(Text(widget.pesanObat.ket)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // --- PERBAIKAN DI MULAI DARI SINI ---
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          try {
            // 1. Panggil fungsi update dan tunggu hasilnya (pesan sukses)
            final resultMessage = await updatePesanObat(
              widget.pesanObat.idPesanObat,
            );

            // 2. Tampilkan dialog sukses dan TUNGGU (await) sampai ditutup
            await dialog(context, resultMessage);

            // 3. TUTUP halaman ini dan kirim sinyal 'true' untuk refresh
            Navigator.of(context).pop(true);
          } catch (e) {
            // Tampilkan dialog jika ada error
            dialog(context, "Gagal: ${e.toString()}");
          }
        },
        child: Text('Pesanan Selesai'),
      ),
      // --- PERBAIKAN SELESAI ---
    );
  }

  Widget _map() {
    return Container(
      height: 300,
      child: GoogleMap(
        markers: _markers,
        initialCameraPosition: _currentPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng latLng) => _addMarker(latLng),
      ),
    );
  }

  void _addMarker(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      if (_markers.length != 0) _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId("myPosition"),
          position: position,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 18),
        ),
      );
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<CameraPosition>('_currentPosition', _currentPosition),
    );
    properties.add(
      DiagnosticsProperty<CameraPosition>('_currentPosition', _currentPosition),
    );
    properties.add(
      DiagnosticsProperty<CameraPosition>('_currentPosition', _currentPosition),
    );
    properties.add(
      DiagnosticsProperty<CameraPosition>('_currentPosition', _currentPosition),
    );
  }
}
