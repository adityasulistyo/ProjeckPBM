import 'package:flutter/material.dart';
import 'package:puasa/home_page.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('About'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              'copyright©️2023',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: NavigationSection(),
    );
  }
}





// // class navigationss extends StatelessWidget {
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: Container(
// //       margin: EdgeInsets.only(top: 100),
// //       child: Column(children: [
// //         NavigationSection(),
// //       ]),
// //     ));
// //   }
// // }

// class AboutPage extends StatelessWidget {
//   static const route = "/home";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('About'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           },
//         ),
//       ),
//       body: Center(
//         child: 
//         color: Colors.yellow,
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 16),
//             Text(
//               'copyright©️2023',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
        
//       ),
//     );
//   }
// }

// // class nav extends StatelessWidget {
// //   static const route = "/home";

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context).copyWith(
// //       primaryColor: Colors.green, // Warna hijau untuk primary color
// //       hintColor: Colors.greenAccent, // Warna hijau untuk accent color
// //       // Atur warna lainnya sesuai kebutuhan
// //     );

// //     return Theme(
// //       data: theme,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text(
// //             'Aplikasi Buka Puasa',
// //             style: TextStyle(fontFamily: 'Exo2'),
// //           ),
// //         ),
// //         body: Container(
// //           padding: EdgeInsets.only(
// //               top: 0), // Sesuaikan padding atas sesuai kebutuhan
// //           child: Column(
// //             children: [
// //               NavigationSection(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
