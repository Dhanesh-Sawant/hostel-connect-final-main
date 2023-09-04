import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  String generateOTP() {
    final random = Random();
    final otpLength = 6;
    final buffer = StringBuffer();
    for (var i = 0; i < otpLength; i++) {
      buffer.write(random.nextInt(10));
    }
    return buffer.toString();
  }

  Future<void> sendOTP() async {

    String otp = generateOTP();
    print(otp);

    String username = 'AKIA5HGMOSPDGL6UO5GA';
    String password = 'BAF2zD1+YMaMWAQTGJPVbGCkSDOahWFT/ZVkfc0T1qy+';

    final smtpServer = SmtpServer(
        "email-smtp.ap-south-1.amazonaws.com",
        port: 587,
        username: username,
        password: password
    );


    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address("sawant23122003@gmail.com", 'Dhanesh Sawant')
      ..recipients.add('dhanesh23122003@gmail.com')
      ..subject = 'smtp tesst'
      ..text = 'This is the plain text.\nThis is line 2 of the text part. $otp'
      ..html = "<h1>Test</h1>\n<p>This is your otp</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE


    // Let's send another message using a slightly different syntax:
    //
    // Addresses without a name part can be set directly.
    // For instance `..recipients.add('destination@example.com')`
    // If you want to display a name part you have to create an
    // Address object: `new Address('destination@example.com', 'Display name part')`
    // Creating and adding an Address object without a name part
    // `new Address('destination@example.com')` is equivalent to
    // adding the mail address as `String`.
    //
    //
    // final equivalentMessage = Message()
    //   ..from = Address(username, 'Your name 😀')
    //   ..recipients.add(Address('destination@example.com'))
    //   ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    //   ..bccRecipients.add('bccAddress@example.com')
    //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    // ;

    // final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    // await connection.send(equivalentMessage);

    // close the connection
    await connection.close();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send OTP Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendOTP,
          child: Text('Send OTP'),
        ),
      ),
    );
  }
}