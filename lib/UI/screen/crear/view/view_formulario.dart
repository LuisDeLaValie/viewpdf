import 'package:flutter/material.dart';

class ViewFormulario extends StatefulWidget {
  const ViewFormulario({Key? key}) : super(key: key);

  @override
  State<ViewFormulario> createState() => _ViewFormularioState();
}

class _ViewFormularioState extends State<ViewFormulario> {
/* {
    "autores":["63514e5fdcb2c4cbccd0b0ac","63514e5fdcb2c4cbccd0b0ab"],
    
} */

  int nAutor = 1;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Titulo"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Sinopsis"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Autores"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 20,
                        splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              nAutor++;
                            });
                          },
                          icon: Icon(Icons.add)),
                      ...{
                        for (int i = 0; i < nAutor; i++)
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Autor"),
                            ),
                          ),
                      }.toList()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Editorial"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Paginas"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Origen"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Nombre"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Url"),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Path"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
