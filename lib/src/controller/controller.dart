// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/state_manager.dart';
import 'package:collection/collection.dart';

import 'dart:async';

class AppController extends GetxController {
  final RxList availablePortsAddresses = SerialPort.availablePorts.obs;
  final Rx<dynamic> selectedPortAddress = (SerialPort.availablePorts.last).obs;
  final Rx<SerialPort> port = SerialPort(SerialPort.availablePorts.last).obs;
  final Rx<Uint8List> writedBytes = Uint8List.fromList([]).obs;
  final Rx<Uint8List> readedBytes = Uint8List.fromList([]).obs;

  // @override
  // void onInit() {
  //   // initApp();
  //   super.onInit();
  // }

  // Future<void> initApp() async {
  //   await portOpen();
  // }

  Function eq = const ListEquality().equals;

  Future<void> refreshPortList() async {
    /// this function refresh list of ports and selected port value if and only
    /// if the list of ports changes related to latest time.
    final newList = SerialPort.availablePorts;
    if (!eq(availablePortsAddresses, newList)) {
      availablePortsAddresses.value = newList;
      selectedPortAddress.value = newList.last;
      port.value = SerialPort(selectedPortAddress.value);
      print('port: ${port.value.name}');
    }
  }

  //
  Future<void> selectPort({dynamic selectedPort}) async {
    if (selectedPort != null) {
      selectedPortAddress.value = selectedPort;
    }
    //
    // await portClose();
    port.value = SerialPort(selectedPortAddress.value);
    // await portOpen();
    print('port: ${port.value.name}');
  }

  // Future<void> portOpen() async {
  //   print('??????????????????????');
  //   port.value.openReadWrite();
  //   port.value.config.baudRate = 460800;
  //   port.value.config.bits = 8;
  //   port.value.config.stopBits = 1;
  //   port.value.config.parity = 0;
  //   port.value.config.xonXoff = 0;
  //   port.value.config.setFlowControl(0);
  //   port.value.config.dtr = 0;
  //   port.value.config.rts = 0;
  //   //
  // }

  // Future<void> portClose() async {
  //   port.close();
  // }

  Future<void> rwTest() async {
    print('========================= START ==========================');

    writedBytes.value = Uint8List.fromList([]);
    readedBytes.value = Uint8List.fromList([]);

    List<int> d = [
      1,
      2,
      3,
      4,
      5
    ];

    final configu = SerialPortConfig();
    configu.baudRate = 460800;
    configu.bits = 8;
    configu.parity = 0;

    Uint8List bytes = Uint8List.fromList(d);

    List<int> recievedPacket = [];
    // ---------------
    StreamSubscription? subscription;

    try {
      if (!port.value.isOpen) {
        port.value.openReadWrite();
        // configuration
        port.value.config = configu;
        print('open and config port');
      }
    } catch (e) {
      print('Oppppps error when open and config port: $e ... ${port.value.config.baudRate}');
    }

    try {
      SerialPortReader reader = SerialPortReader(port.value);
      //
      subscription = reader.stream.listen((data) {
        recievedPacket.addAll(data);
        if (recievedPacket.length == 5) {
          readedBytes.value = Uint8List.fromList(recievedPacket);
          print('----- read: ${readedBytes.value}');
          // ----------------------
          subscription!.cancel();
          reader.close();
          recievedPacket.clear();
          port.value.close();
          print('========================= FINISH ==========================');
        }
      });
    } catch (e) {
      print('Oppppps when reading data : $e');
    }

    try {
      // =====================================================
      port.value.write(bytes);
      writedBytes.value = bytes;
      print('----- write: $bytes');
    } catch (e) {
      print('Oppppps when writing data : $e');
    }
  }
}
