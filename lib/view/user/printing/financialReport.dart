import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

 class finacialReportPrint {
  static late Font arFont;

  static init() async {
    arFont = Font.ttf(
        (await rootBundle.load("assets/font/Alarabiya_Normal_Font.ttf")));
  }

  static createPdf() async {
    Directory? externalDir = await getExternalStorageDirectory();
    if (externalDir != null) {
      String path = externalDir.path;
      File file = File('$path/MY_PDF.pdf');

      Document pdf = Document();

      var image = MemoryImage(
          (await rootBundle.load('assets/images/logoTransparent.png'))
              .buffer
              .asUint8List());

      pdf.addPage(_createPage(image));

      Uint8List bytes = await pdf.save();

      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } else {
      print('External storage directory is null');
    }
  }

  static Page _createPage(
    var image,
  ) {
    return Page(
      margin: EdgeInsets.all(4),
      textDirection: TextDirection.rtl,
      theme: ThemeData.withFont(
        base: arFont,
      ),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        // DateTime now = DateTime.now();

        return Padding(
          padding: EdgeInsets.fromLTRB(8, 10, 8, 5),
          child: pw.Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pw.Text("بقالة إبراهيم الحبيشي",
                          style: TextStyle(fontSize: 20)),
                      pw.Text(
                        "العنوان: شارع تعز",
                      ),
                      pw.Text("رقم الهاتف: 77585279"),
                    ]),
                pw.Text("تقرير مالي", style: TextStyle(fontSize: 30)),
                pw.Image(image, width: 120, height: 120),
              ]),
              SizedBox(height: 3),
              pw.Text("صاحب الحساب: جبير محمد ناجي جبير",
                  style: TextStyle(fontSize: 20)),
              pw.Text("رقم الهاتف: 777110927", style: TextStyle(fontSize: 20)),
              SizedBox(height: 3),
              Center(
                // Center the Row horizontally
                child: Row(
                  children: [
                    SizedBox(width: 210),
                    pw.Text("من تاريخ : ", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 80),
                    pw.Text("إلى تاريخ: ", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 3),
              pw.Table(
                border: pw.TableBorder.all(), // Add borders to the table cells
                children: [
                  pw.TableRow(
                    children: [
                      // Add the headers in the first row
                      for (var header in [
                        "دائن",
                        "مدين",
                        "البيان",
                        "التاريخ",
                        "الرقم",
                      ])
                        pw.Container(
                          padding:
                              pw.EdgeInsets.all(3), // Add padding to each cell
                          alignment: pw
                              .Alignment.center, // Align content to the center
                          child: pw.Text(header,
                              style: pw.TextStyle(
                                fontSize: 10,
                              )), // Header text
                        ),
                    ],
                  ),
                  // Add remaining rows and data...
                  // Example additional row
                  pw.TableRow(
                    // Set text direction to right-to-left
                    children: [
                      // Example data in the first row
                      for (var i = 0;
                          i <
                              [
                                "",
                                "",
                                "",
                                "",
                                "1",
                              ].length;
                          i++)
                        pw.Container(
                          padding:
                              pw.EdgeInsets.all(1), // Add padding to each cell
                          alignment: pw
                              .Alignment.center, // Align content to the center
                          child: i == 0 ||
                                  i == 4 ||
                                  i ==
                                      2 // Check the index for specific data eِlements
                              ? pw.Text(
                                  [
                                    "",
                                    "",
                                    "",
                                    "",
                                    "1",
                                  ][i]
                                      .toString(),
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                    fontWeight: i == 0 || i == 4 || i == 2
                                        ? pw.FontWeight.bold
                                        : null, // Apply different font style
                                    // Add more font properties as needed
                                  ),
                                )
                              : pw.Text(
                                  [
                                    "",
                                    "",
                                    "",
                                    "",
                                    "1",
                                  ][i]
                                      .toString(),
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  ),
                                ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Page _createSecondPage(String email, var conditions) {
    return Page(
        margin: EdgeInsets.all(2),
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: PdfColors.yellow200, // Background color
                    ),
                    child: pw.Text(" * الشروط والأحكام",
                        style: pw.TextStyle(
                          fontSize: 12,
                        )),
                  ),
                  pw.SizedBox(
                    child: pw.Image(conditions),
                  ),
                  SizedBox(height: 10),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: PdfColors.yellow200, // Background color
                    ),
                    child: pw.Text(
                      " *  نماذج توقيع المفوضون",
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: PdfColors.black, width: 1),
                            left: BorderSide(color: PdfColors.black, width: 1),
                            right: BorderSide(color: PdfColors.black, width: 1),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text("المفوض الاول",
                                style: TextStyle(
                                    fontSize: 10, color: PdfColors.grey)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: PdfColors.black, width: 1),
                            left: BorderSide(color: PdfColors.black, width: 1),
                            right: BorderSide(color: PdfColors.black, width: 1),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text("المفوض الثاني",
                                style: TextStyle(
                                    fontSize: 10, color: PdfColors.grey)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: PdfColors.black, width: 1),
                            left: BorderSide(color: PdfColors.black, width: 1),
                            right: BorderSide(color: PdfColors.black, width: 1),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text("المفوض الثالث",
                                style: TextStyle(
                                    fontSize: 10, color: PdfColors.grey)),
                          ),
                        ),
                      ),
                    )
                  ]),
                  // pw.Text(
                  //   " *  انا الموقع ادناه أؤكد بأن كافة البيانات والمعلومات الواردة في هذا الطلب صحيحة واتحمل كامل المسؤولية عن ذلك.",
                  //   style: pw.TextStyle(
                  //     fontSize: 10,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: pw.Text(
                          "الاسم:..................................................................",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: pw.Text(
                          "التوقيع:...........................................................",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("البصمة/الختم",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                )),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle
                                        .dotted), // Border properties
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "الموظف المختص: ........................................",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )),
                        Text("مدير الفرع",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )),
                        Text("إدارة الامتثال",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )),
                        SizedBox(width: 2.5)
                      ])
                ],
              )
            ]),
          );
        });
  }

  static Widget _buildInformationRow(
      String label1, String value1, String label2, String value2) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ])
      ],
    );
  }

  static Widget _buildInformationRow0(String label1, String value1) {
    return pw.Row(
      children: [
        pw.Text(".1 ",
            style: pw.TextStyle(
              fontSize: 9,
            )),
        pw.Text("$label1 ",
            style: pw.TextStyle(
              fontSize: 9,
            )),
        _buildTextWithBorder(value1),
      ],
    );
  }

  static Widget _buildInformationRow2(String label1, String value1,
      String label2, String value2, String label3, String value3) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildPhoneTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        Row(children: [
          pw.Text(" $label3 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildPhoneTextWithBorder(value3),
        ]),
      ],
    );
  }

  static Widget _buildInformationRow01(String label1, String value1) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
      ],
    );
  }

  static Widget _buildPhonesRow(
      String label1, String value1, String value2, String value3) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildPhoneTextWithBorder(value1),
          SizedBox(width: 2),
          _buildPhoneTextWithBorder(value2),
          SizedBox(width: 2),
          _buildPhoneTextWithBorder(value3),
        ]),
      ],
    );
  }

  static Widget _buildInformationRow4(
      String label1,
      String value1,
      String label2,
      String value2,
      String label3,
      String value3,
      String label4,
      String value4) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        Row(children: [
          pw.Text(" $label3 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value3),
        ]),
        Row(children: [
          pw.Text("$label4 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value4),
        ])
      ],
    );
  }

  static Widget _buildInformationRow5(
      String label1,
      String value1,
      String label2,
      String value2,
      String label3,
      String value3,
      String label4,
      String value4,
      String label5,
      String value5) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        Row(children: [
          pw.Text(" $label3 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value3),
        ]),
        Row(children: [
          pw.Text("$label4 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value4),
        ]),
        Row(children: [
          pw.Text("$label5 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value5),
        ])
      ],
    );
  }

  static Widget _buildCheckedStatus(String label1, String value1) {
    return pw.Row(
      children: [
        pw.Text(".2",
            style: pw.TextStyle(
              fontSize: 10,
            )),
        if (label1 == "الاشتراك في تطبيق المجربي موبايلي" &&
            value1 == "نعم") ...[
          _buildCheckBox(true),
        ],
        pw.Text(" $label1 ",
            style: pw.TextStyle(
              fontSize: 10,
            )),
      ],
    );
  }

  static Widget _buildCompanyPermissionStatus(String label1, String value1) {
    return pw.Row(
      children: [
        if (label1 == "تفويض الشركة" && value1 == "نعم") ...[
          _buildCheckBox(true),
        ],
        pw.Text(" $label1 ",
            style: pw.TextStyle(
              fontSize: 10,
            )),
      ],
    );
  }

  static Widget _buildCheckBox(bool checked) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: pw.Container(
        width: 16,
        height: 10,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black, width: 1.5),
          borderRadius: pw.BorderRadius.circular(3),
          color: checked ? PdfColors.indigo : PdfColors.black,
        ),
      ),
    );
  }

  static Widget _buildTextWithBorder(String text) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: pw.Text(" $text",
              style: pw.TextStyle(
                fontSize: 9,
              )),
        ));
  }

  static Widget _buildPhoneTextWithBorder(String text) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 4, right: 4),
          child: pw.Text(" $text",
              style: pw.TextStyle(fontSize: 8, font: Font.timesBold())),
        ));
  }
}
