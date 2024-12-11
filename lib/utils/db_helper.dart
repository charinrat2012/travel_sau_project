//db_helper.dart
//เป็นไฟล์ที่ทำงานกับ DB:insert, update, delete, select
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_sau_project/models/travel.dart';
import 'package:travel_sau_project/models/user.dart';

class DBHelper {
  //method สร้างฐานข้อมูลที่จะใช้คู่กับการสร้างตาราง
  static Future<Database> db() async {
    return openDatabase('travelrecord.db',
        version:
            1, //สำคัญหากมีการปรับเปลี่ยน DB ต้องมาปรับเปลี่ยนหมายเลขเวอร์ชัน
        onCreate: (Database database, int version) async {
      //สร้างตารางต่างๆ เพื่อความสะดวกกรณีมีหลายตาราง
      //ให้ไปสร้างเป็น method ต่างหาก แล้วเรียกใช้
      await createUserTable(database);
      await createTravelTable(database);
    });
  }

  //method สร้างตาราง User
  static Future<void> createUserTable(Database database) async {
    await database.execute('''
create table usertb (
  id integer primary key autoincrement not null,
  fullname text,
  email text,
  phone text,
  username text,
  password text,
  picture text
)
''');
  }

  //method สร้างตาราง Travel
  static Future<void> createTravelTable(Database database) async {
    await database.execute('''
create table traveltb (
  id integer primary key autoincrement not null,
  pictureTravel text,
  placeTravel text,
  costTravel text,
  dateTravel text,
  dayTravel text,
  locationTravel text
)
''');
  }

  //method บันทึกข้อมูล User จากหน้า RegisterUI
  static Future<int> insertUser(User user) async{
    final db = await DBHelper.db();

    final id = await db.insert(
      'usertb', //ชื่อตารางที่สร้างไว้
      user.toMap(), //นำข้อมูลใส่ลงในตารางให้ตรงกับ column ในตาราง
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  //method บันทึกข้อมูล Travel จากหน้า RegisterUI
  static Future<int> insertTravel(Travel travel) async{
    final db = await DBHelper.db();

    final id = await db.insert(
      'traveltb', //ชื่อตารางที่สร้างไว้
      travel.toMap(), //นำข้อมูลใส่ลงในตารางให้ตรงกับ column ในตาราง
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  //method ตรวจสอบการเข้าใช้งาน (Sign In)
  static Future<User?> checkSignin(String username, String password) async{
    final db = await DBHelper.db();

    List<Map<String, dynamic>> result = await db.query(
      'usertb',
      where: 'username = ? and password = ?',
      whereArgs: [username, password],
    );

    //ตรวจสอบการ Query
    if(result.length > 0){
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }

  //method ดึงข้อมูลทั้งหมดจาก traveltb
  static Future<List<Travel>> getAllTravel() async{
    //ติดต่อฐานข้อมูล
    final db = await DBHelper.db();

    //ดึงข้อมูลเก็บในตัวแปร
    final result = await db.query(
      'traveltb',
      orderBy: 'id DESC',
    );

    //ส่งข้อมูลที่ดึงมาไปใช้งาน
    return result.map((data) => Travel.fromMap(data)).toList();
  }
}
