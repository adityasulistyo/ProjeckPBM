import 'dart:io';
import 'package:flutter/material.dart';

import 'input.dart';

class Jadwal {
  final File gambar;
  final String deskripsi;
  final DateTime tanggal;

  Jadwal({
    required this.gambar,
    required this.deskripsi,
    required this.tanggal,
  });
}

class JadwalPage extends StatefulWidget {
  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<Jadwal> jadwalList = [];

  TextEditingController _controller = TextEditingController();

  void addJadwal(Jadwal jadwal) {
    setState(() {
      jadwalList.add(jadwal);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Jadwal'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Tambahkan Jadwal',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    ).then((jadwal) {
                      if (jadwal != null) {
                        addJadwal(jadwal);
                      }
                    });
                  },
                  child: Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jadwalList.length,
              itemBuilder: (context, index) {
                final jadwal = jadwalList[index];
                return ListTile(
                  title: Text(jadwal.deskripsi),
                  subtitle: Text(jadwal.tanggal.toString()),
                  leading: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.file(jadwal.gambar),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(jadwal.deskripsi),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(jadwal.tanggal.toString()),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Image.file(jadwal.gambar),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
