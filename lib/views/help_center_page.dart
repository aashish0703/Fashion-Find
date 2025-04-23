import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text("For any query or problem you can contact or mail us.", style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
                child: Text("Email:", style: Theme.of(context).textTheme.headlineSmall)
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                const Icon(Icons.mail_outline_rounded, color: Color.fromRGBO(213, 172, 121, 1),),
                const SizedBox(width: 10,),
                Text("fashionfind@gmail.com", style: Theme.of(context).textTheme.bodyLarge,)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Contact:", style: Theme.of(context).textTheme.headlineSmall)
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                const Icon(Icons.contact_phone_outlined,  color: Color.fromRGBO(213, 172, 121, 1)),
                const SizedBox(width: 10,),
                Text("9999999999", style: Theme.of(context).textTheme.bodyLarge,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
