import 'package:flutter/material.dart';
import 'package:my_rutina/src/utils/utils.dart';

class AlertProvider {
  showErrorDialog(BuildContext context, String texto) {
    return AlertDialog(
      title: const Center(child: Text("ERROR")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text(texto)),
          const SizedBox(height: 20.0),
          const Icon(
            Icons.warning,
            color: Colors.red,
            size: 50.0,
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        ElevatedButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }

  showSuccessDialog(BuildContext context, String texto) {
    return AlertDialog(
      title: const Center(child: Text("EXITO")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text(texto)),
          const SizedBox(height: 20.0),
          Icon(
            Icons.check_circle,
            color: HexColor.fromHex("#88CF8D"),
            size: 50.0,
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        ElevatedButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }

  showConfirmAlert(BuildContext context, String texto) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text(texto)),
          const SizedBox(height: 20.0),
          const Icon(
            Icons.warning,
            color: Colors.yellow,
            size: 50.0,
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        ElevatedButton(
          child: const Text("Aceptar", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(primary: HexColor.fromHex("#88CF8D")),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        ElevatedButton(
          child: const Text("Cancelar", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }

  showGuardarNoGuardar(BuildContext context, String texto) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text(texto)),
          const SizedBox(height: 20.0),
          const Icon(
            Icons.warning,
            color: Colors.yellow,
            size: 50.0,
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        ElevatedButton(
          child: const Text("Guardar"),
          onPressed: () {
            Navigator.of(context).pop([true, true]);
          },
        ),
        ElevatedButton(
          child: const Text("No Guardar"),
          onPressed: () {
            Navigator.of(context).pop([false, true]);
          },
        ),
        ElevatedButton(
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop([false, false]);
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }

  showBasicDialog(BuildContext context, String texto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Text(texto)),
              const SizedBox(height: 20.0),
              Icon(
                Icons.check_circle,
                color: HexColor.fromHex("#88CF8D"),
                size: 50.0,
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      },
    );
  }

  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Por favor espere...",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }

  showImageDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Center(child: Text("Foto")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(image: NetworkImage(url)),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      },
    );
  }
}
