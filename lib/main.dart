import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isChecked450 = true;
  bool isChecked240 = false;

  // Base64 strings for the images (example strings, replace with your actual Base64 strings)
  final String firstProviderBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAOZSURBVHgB7ZdbSFRbGMf/27l45qYeLG3O4Rw9x4cDHQqDqIckrYgMH7pQT91Riq6kXZEiqUjKwArE6GYXKiwqJajoaoGWZXejHiqTxBl1nJlm9p5p9rj3aq1djezM3D7oEPR7mr3XN9/3X9/3rf2xOFAcDkeqyWSq0Ol06RzHJWAAkWUZ4XC4ShTFfLvd/o5jwePi4h6bzeYBDfwtgUDA6/P5RukNBkPpYAdnsJg0ExUcVUFsNhuiAc/z3hgKogXrt+hF/8IvAT+PANnng1BxHEQQvrvu5kOYXVKDSw0t6A96LUaS0wlP3jKEnzdCdntgK1jFWjiy7vQEsXh/HepeteNZsxtWsx7jhw/T4lpbBrzL85XgDH5fGbzrCyOZkGSC1UfuK8EZnf4QZu68har6Zi2utQnQ2ZNVz8Ez5/BhU5EiQhfDYW/uGIxOS1TZrDxUj2M1r/v03auApna/sjtG/K5i/DYxSy3ifDXceUupiACSE0w4mZ9JRQzpXhclrKl4gPIrr9BvAQ1vXJhWfBM526/DQevLmU1IKNsLU85UlZ1Ydw/uBbmQO1xItMXiwsaJyB71p8pm8+nHKKlq7J+ApfvvotUdUISsOHgPXkFURMTvLoZ51gy1iAcP4VlVAImKMBl1tBxjkTlcXbI9F1/AFwhrFyCEuiK/b79wInvrVTS18VSEGXHbimBdkgdOr1dlwjN3EaRWp5KJyrVZmJOZhq/nxGoywGj4frV1hYWFRUajUfUyZagN1562IizJyrObF1HT2IYp6X8gPt6M2IxxtP0liPX3I/+RXZ0Qa2sRmz0ZeqsVWf8PQ4fvo5LJoysz8E9Sz4lLxzE4OhKJxWLpsXiRflAWl9ci3CVH3qUOtaJyXRbSkqkz2p98WTn8JaXqHaX8jcTKE/Tk2JXn9y4Bfw3p6Z8h0FPUqwDGjWcOLD9wFy56tr/yb5IVh1dkYETK75+dHD4K/45dIF3dZdOlpiDp9jX0BRPww+/ApJF2HKHBLLHd9X7bzmPD8QYIHz8HtOQupH2xRdUTHCHQDMtAX7xs8ZL0gmqSOP8UmbD5Mmnu8PewCZw9Txz/jSTtk3NIuOkd0QKLrUkA49GbTjJvzx3S0in0ahO8dIV0OduIVljsH/bAQNNnDwwGvwREXwBtRi+iBI2NGEmSniBKhEKh6phgMLiIXRQxyNAj6KXDaLUyMdkNmU7EUnpRnT7QVzVWcpZ1tnF2Pf8Ec1xZqHjHn0IAAAAASUVORK5CYII='; // Replace with your actual Base64 string
  final String secondProviderBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAANASURBVHgB7VfbSxRRHP7OzOzY7LqulaabloqU2f1G9FIUkXQhinropaBegt4KeuolqpfoIaM/oKAeCnrpgtGFLkgUVFBoXkKz0HR187KuM+PO7Mw5naPlMl4J1H3xg112fnvOft/5zu/8zv4IOCKRSLGmabdkWV5PCMnGDIJSimQy+cC27bPhcPgnEeRZWVmf/X7/jBKPhmmasXg8vkHx+XyVs00uIDi5E7cIV8GCwSDSAV3XYxIH0gWRb+lj/4s5AXMClIm+cOvfwal9DNrnQF6xFeqOI5gVAaw3Cv3GWSjzG6GsOgaSvRDWw+tQFpuQlh/HdGOMAL3yFJTcBLTT1YAvMBykH0F/N3EBqXEN9R0wdAtl5WEQ/pwZnDcugevSofrv8ylTC3Dq3oJ11kA9cXeE3Pl0B27dS/hOPfdMrLz2AmvWFOBrXTuKihZgYMBGSUkOmpuj2LZ9Od68bkB+fghPntTg4qVDmAieJKRdjbxIM8hFG0di9ut7IEsOgmQVeiYSMF7PVbRwQk1T8aMlitqaNpRzR65eqUJfr4GvtW3YtLl4wtWPEcDMLkia8MWXIsrMR/J9NRfX6pm4ZWspNC6gYs9qdLT3IxwOwZ+ZgcIlC7B33zrk5YWwu2I1bMvFpOAXAvuHRNVFpl8o5p/oSIzqUWbeOcr08+XM/liVihsD/NXPHDM1/38huD3eSNm5IH4XzLFAlOGkIoFcaMfuwXp0Dtb9c5ALyiCFS5H88ApE00DzlnLrGFjSEpcLd0/ljwywDP5bQb6dZZMa4NkCKScfUsgBEt1jBirrDoNkmHCa3g2PDS+FXFwO2tkKaVEBEO+FvGwtF2+D9veAxWNgdAr7MeoUyCUVYHUhwPjOz5U36eDEgQzGV+UfHltYyt0JQssrBI3+grJ550hc0QJgAzFAnTelAE8ODO1t5Blzv11OBdwEcyPVLHFzJRu8fYBR22DTBcFNxFsgEPCqsvkWSBlAz1PQ7i9ghgnk7OIO7Rf/IjBdMAyeJ+MKmCUIAXPX8ZyA9AvgxzGGNEGUbMl13S9IEyzLeigNDg6eFI0iZhm8BsR4b3hmqKyJDllV1UreqB6a6VZNbLlwXSxctOd/AMnND+FivbJwAAAAAElFTkSuQmCC'; // Replace with your actual Base64 string

  // Method to convert Base64 string to Uint8List
  Uint8List _base64ToImage(String base64String) {
    return Base64Decoder().convert(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Perlu diketahui, proses verifikasi transaksi dapat memakan waktu hingga 1x24 jam.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Image.memory(
                          _base64ToImage(firstProviderBase64),
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rp450.000',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Due date on 16 Feb 2024'),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'Product details...'), // Replace with actual details
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text(
                        'See Details'), // Add this to indicate the user can see more details
                    value: isChecked450,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked450 = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Image.memory(
                          _base64ToImage(secondProviderBase64),
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rp240.000',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Due date on 20 Feb 2024'),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'Product details...'), // Replace with actual details
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text(
                        'See Details'), // Add this to indicate the user can see more details
                    value: isChecked240,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked240 = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Payment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp${(isChecked450 ? 450000 : 0) + (isChecked240 ? 240000 : 0)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle payment logic
              },
              child: Text('PAY NOW', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
