
# Tugas 3 - 6 pada Pemrograman Perangkat Bergerak Flutter:

## Tugas 3: Layout Part 1

### Widget

**Penjelasan:** 

Widget adalah komponen dasar dari Flutter, yang merepresentasikan elemen visual. Ada dua tipe utama Widget:

- **StatelessWidget** - Tidak memiliki state yang bisa berubah (harus pakai state management jika mau, tapi belum diminta).
- **StatefulWidget** - Memiliki state yang dapat berubah.

### Container

**Penjelasan:** 

Container adalah kotak pembungkus untuk widget lain, dengan pengaturan seperti ukuran, warna, padding, margin, dan lainnya.


```dart
Container(
  height: 100,
  width: 100,
  color: Colors.blue,
  child: Center(child: Text("Container")),
);
```

### Row & Column

**Penjelasan:**

- `Row` digunakan untuk tata letak horizontal.
- `Column` digunakan untuk tata letak vertikal.

**Contoh Kode:**

```dart
Row(
  children: [
    Text("Item 1"),
    Text("Item 2"),
  ],
);
```

### ListView

**Penjelasan:** ListView memungkinkan widget digulir secara vertikal atau horizontal.

**Contoh Kode:**

```dart
ListView.builder(
  itemCount: 10,
  itemBuilder: (context, index) {
    return ListTile(title: Text("Item $index"));
  },
);
```

### GridView

**Penjelasan:** GridView menampilkan widget dalam format grid (baris dan kolom), cocok untuk tampilan galeri.

**Contoh Kode:**

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
  ],
);
```

### Stack

**Penjelasan:** Stack memungkinkan widget ditumpuk pada posisi yang sama, sehingga bisa terlihat tumpang tindih.

**Contoh Kode:**

```dart
Stack(
  alignment: Alignment.center,
  children: [
    Container(width: 200, height: 200, color: Colors.red),
    Container(width: 150, height: 150, color: Colors.green),
  ],
);
```

## Tugas 4: Layout Part 2

### Nested Row

**Penjelasan:** Nested Row berarti meletakkan Row di dalam Row atau menggabungkan Row dengan Column untuk layout yang kompleks.

**Contoh Kode:**

```dart
Row(
  children: [
    Column(children: [Text("Column 1, Row 1"), Text("Column 1, Row 2")]),
    Column(children: [Text("Column 2, Row 1"), Text("Column 2, Row 2")]),
  ],
);
```

### TabView

**Penjelasan:** TabView digunakan untuk navigasi berbasis tab.

**Contoh Kode:**

```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(tabs: [Tab(text: "Tab 1"), Tab(text: "Tab 2"), Tab(text: "Tab 3")]),
      title: Text("TabView Example"),
    ),
    body: TabBarView(children: [
      Center(child: Text("Content 1")),
      Center(child: Text("Content 2")),
      Center(child: Text("Content 3")),
    ]),
  ),
);
```

### PageView

**Penjelasan:** PageView memungkinkan tampilan halaman yang dapat digeser.

**Contoh Kode:**

```dart
PageView(
  children: [
    Container(color: Colors.red, child: Center(child: Text("Page 1"))),
    Container(color: Colors.blue, child: Center(child: Text("Page 2"))),
    Container(color: Colors.green, child: Center(child: Text("Page 3"))),
  ],
);
```

### SafeArea

**Penjelasan:** SafeArea memastikan widget tidak terpotong oleh notch atau status bar.

**Contoh Kode:**

```dart
SafeArea(
  child: Scaffold(
    appBar: AppBar(title: Text("Safe Area Example")),
    body: Center(child: Text("Content is safe from notches!")),
  ),
);
```

## Tugas 5: User Interaction

### Stateful & Stateless Widget

**Penjelasan:**

- **StatelessWidget** - Tidak memiliki state.
- **StatefulWidget** - Memiliki state yang bisa diubah.

**Contoh Kode:**

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Counter: $counter"),
        ElevatedButton(
          onPressed: () {
            setState(() {
              counter++;
            });
          },
          child: Text("Increment"),
        ),
      ],
    );
  }
}
```

### Button

**Penjelasan:** Tombol adalah widget interaktif seperti ElevatedButton, TextButton, dan OutlinedButton.

**Contoh Kode:**

```dart
ElevatedButton(
  onPressed: () => print("Button Pressed!"),
  child: Text("Click Me"),
);
```

### Snackbar

**Penjelasan:** Snackbar menampilkan pesan sementara di bawah layar.

**Contoh Kode:**

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text("Hello Snackbar!")),
);
```

### Dialog

**Penjelasan:** Dialog menampilkan pop-up untuk konfirmasi atau form singkat.

**Contoh Kode:**

```dart
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Dialog Title"),
      content: Text("This is a dialog."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("OK"),
        ),
      ],
    );
  },
);
```

### Menu (Titik 3)

**Penjelasan:** PopupMenuButton adalah menu konteks (biasanya berupa 3 titik vertikal) yang menampilkan daftar opsi.

**Contoh Kode:**

```dart
PopupMenuButton<String>(
  onSelected: (value) => print("Selected: $value"),
  itemBuilder: (context) => [
    PopupMenuItem(value: "Option 1", child: Text("Option 1")),
    PopupMenuItem(value: "Option 2", child: Text("Option 2")),
  ],
);
```

## Tugas 6: Navigasi & Notifikasi

### Package

**Penjelasan:** Package dalam Flutter adalah library eksternal untuk menambah fitur aplikasi.

**Contoh Kode:**

```dart
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  print(response.body);
}
```

### Navigation

**Penjelasan:** Navigasi memungkinkan berpindah antar halaman menggunakan `Navigator`.

**Contoh Kode:**

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);
```

### Notification

**Penjelasan:** Notifikasi memungkinkan aplikasi mengirim pesan ke pengguna.

**Contoh Kode:**

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void showNotification() {
  var android = AndroidNotificationDetails('id', 'name', 'description');
  var platform = NotificationDetails(android: android);
  flutterLocalNotificationsPlugin.show(0, 'Hello', 'This is a notification', platform);
}
```

```

```
