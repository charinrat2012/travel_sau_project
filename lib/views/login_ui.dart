import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_sau_project/models/user.dart';
import 'package:travel_sau_project/utils/db_helper.dart';
import 'package:travel_sau_project/views/home_ui.dart';
import 'package:travel_sau_project/views/register_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool pwdStatus = true;

  //สร้างตัวควบคุม TextField
  TextEditingController usernameCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');

  //method แสดงข้อความเตือน
  showWarningMessage(context, msg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คำเตือน'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'บันทึกการเดินทาง',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50.0,
              right: 50.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  'เข้าใช้งานแอปพลิเคชัน',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
                Text(
                  'บันทึกการเดินทาง',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  children: [
                    Text(
                      'ชื่อผู้ใช้',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: usernameCtrl,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      'รหัสผ่าน',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: passwordCtrl,
                  obscureText: pwdStatus,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        pwdStatus = pwdStatus == true ? false : true;
                      });
                    },
                    icon: Icon(
                      pwdStatus == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.amber,
                    ),
                  )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (usernameCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนชือผู้ใช้ด้วย');
                    } else if (passwordCtrl.text.trim().isEmpty == true) {
                      showWarningMessage(context, 'ป้อนรหัสผ่านด้วย');
                    } else {
                      //เรียก method ตรวจสอบการ Signin
                      User? user = await DBHelper.checkSignin(
                          usernameCtrl.text, passwordCtrl.text);

                      //เช็คผลการเรียกใช้ method Signin
                      if (user == null) {
                        showWarningMessage(
                            context, 'ชื่อผู้ใช้ รหัสผ่านไม่ถูกต้อง');
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeUI(user: user),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'SIGN IN',
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50.0,
                    ),
                    backgroundColor: Colors.amber,
                  ),
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: false,
                  onChanged: (paramValue) {},
                  title: Text(
                    'จำค่าการเข้าใช้งานแอปฯ',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterUI(),
                      ),
                    );
                  },
                  child: Text(
                    'ลงทะเบียนเข้าใช้งาน',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
