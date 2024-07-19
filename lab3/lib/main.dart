import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/*
void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;
  void incrementNumber(int count) {
    print(count);
    setState(() {
      total += count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(children: [
          Expanded(
              child: Column(children: [
            ShoppingItem(
              title: "iPad Pro",
              onIncrement: (int count) {
                incrementNumber(count);
              },
            ),
          ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                total.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              const Text(
                "Bath",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final Function(int count) onIncrement;
  ShoppingItem({required this.title, required this.onIncrement});

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 28),
              ),
              const Text("32,000฿")
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    count--;
                  });
                },
                icon: const Icon(Icons.remove)),
            const SizedBox(
              width: 10,
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                  widget.onIncrement(count);
                },
                icon: const Icon(Icons.add))
          ],
        )
      ],
    );
  }
}
*/

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;

  final GlobalKey<_ShoppingItemState> _ipadKey =
      GlobalKey<_ShoppingItemState>();
  final GlobalKey<_ShoppingItemState> _ipadMiniKey =
      GlobalKey<_ShoppingItemState>();
  final GlobalKey<_ShoppingItemState> _ipadAirKey =
      GlobalKey<_ShoppingItemState>();
  final GlobalKey<_ShoppingItemState> _ipadProKey =
      GlobalKey<_ShoppingItemState>();

  final NumberFormat currencyFormat = NumberFormat("#,##0", "en_US");

  void incrementNumber(int count, int price) {
    setState(() {
      total += count * price;
    });
  }

  void clearCart() {
    setState(() {
      total = 0;
    });
    _ipadKey.currentState?.resetCount();
    _ipadMiniKey.currentState?.resetCount();
    _ipadAirKey.currentState?.resetCount();
    _ipadProKey.currentState?.resetCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ShoppingItem(
                    key: _ipadKey,
                    title: "iPad",
                    price: 19000,
                    currencyFormat: currencyFormat,
                    onIncrement: (int count) {
                      incrementNumber(count, 19000);
                    },
                  ),
                  ShoppingItem(
                    key: _ipadMiniKey,
                    title: "iPad mini",
                    price: 23000,
                    currencyFormat: currencyFormat,
                    onIncrement: (int count) {
                      incrementNumber(count, 23000);
                    },
                  ),
                  ShoppingItem(
                    key: _ipadAirKey,
                    title: "iPad Air",
                    price: 29000,
                    currencyFormat: currencyFormat,
                    onIncrement: (int count) {
                      incrementNumber(count, 29000);
                    },
                  ),
                  ShoppingItem(
                    key: _ipadProKey,
                    title: "iPad Pro",
                    price: 39000,
                    currencyFormat: currencyFormat,
                    onIncrement: (int count) {
                      incrementNumber(count, 39000);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  currencyFormat.format(total),
                  style: const TextStyle(fontSize: 30),
                ),
                const Text(
                  "Baht",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: clearCart,
              child: const Text('Clear'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white), // เปลี่ยนสีของข้อความเป็นสีขาว
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int count) onIncrement;
  final NumberFormat currencyFormat;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onIncrement,
    required this.currencyFormat,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;

  void updateCount(int increment) {
    setState(() {
      count += increment;
      if (count < 0) {
        count = 0;
      } else {
        widget.onIncrement(increment);
      }
    });
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 28),
              ),
              Text("${widget.currencyFormat.format(widget.price)}฿")
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                updateCount(-1);
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 10),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                updateCount(1);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
