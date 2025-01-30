import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/home_page.dart';

class VerificationPage extends StatefulWidget {
  final TextEditingController contoller;
  final String verificationid;
  const VerificationPage({
    super.key,
    required this.contoller, required this.verificationid,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final border = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 4,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(20),
  );
  final TextEditingController controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter the 6 digit Number Send to your number ${widget.contoller.text}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Enter the phone number',
              filled: true,
              fillColor: Colors.grey,
              focusedBorder: border,
              enabledBorder: border,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationid,
                smsCode: controller.text,
              );

              // Sign the user in (or link) with the credential
              await auth.signInWithCredential(credential);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Sign in',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    ));
  }
}
