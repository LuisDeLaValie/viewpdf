import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:viewpdf/UI/shared/layout/layout_home.dart';
import 'package:viewpdf/UI/shared/theme/Colors/ColorA.dart';
import 'package:viewpdf/model/libros_model.dart';

import 'view/view_formulario.dart';

class CrearScreenWeb extends StatelessWidget {
  const CrearScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutHome(
      titulo: "Agregar Libro",
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ViewFormulario(),
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorA.burntSienna,
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          var libros =
                              LibrosModel.importar(result.files.single.path!);
                        }
                      },
                      child: Text("Importar Libor"),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorA.burntSienna,
                ),
                onPressed: () {},
                child: Text("Agregar Libro"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
