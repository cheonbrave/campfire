import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:flutter/cupertino.dart';

/*
* 참조
*
* flutter에서 firestore사용하기 (2)
* https://medium.com/flutter-korea/flutter%EC%97%90%EC%84%9C-firestore%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-2-92d17e5925cc
*
* flutter에서 firestore사용하기 (3)
* https://medium.com/flutter-korea/flutter%EC%97%90%EC%84%9C-firestore-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-3-38c8964dc111
*
*/

class DBIO {

  /* document insert or overwrite (통째로 변경됨) */
  Future<void> upsert(String collection_name, String doc_name, Map<String, dynamic> data){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.document(doc_name).setData(data);
  }

  /* document의 일부 key에 해당하는 영역만 update */
  Future<void> update(String collection_name, String doc_name, Map<String, dynamic> data){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.document(doc_name).updateData(data);
  }

  /* document의 이름에 해당하는것 find */
  Future<DocumentSnapshot> find_useDocName(String collection_name, String doc_name){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.document(doc_name).get();
  }

  /* find - 조건필드와 같은것 */
  Stream<QuerySnapshot> find_useQueryEqual(String collection_name, String field_name, dynamic value){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.where(field_name, isEqualTo: value).snapshots();
  }

  /* find - 조건필드보다 작은것 */
  Stream<QuerySnapshot> find_useQueryLessThan(String collection_name, String field_name, dynamic value){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.where(field_name, isLessThan: value).snapshots();
  }

  /* find - 조건필드보다 작거나 같은것 */
  Stream<QuerySnapshot> find_useQueryLessThanOrEqual(String collection_name, String field_name, dynamic value){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.where(field_name, isLessThanOrEqualTo: value).snapshots();
  }

  /* find - 조건필드보다 큰것 */
  Stream<QuerySnapshot> find_useQueryGreaterThan(String collection_name, String field_name, dynamic value){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.where(field_name, isGreaterThan: value).snapshots();
  }

  /* find - 조건필드보다 크거나 같은것 */
  Stream<QuerySnapshot> find_useQueryGreaterThanOrEqual(String collection_name, String field_name, dynamic value){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.where(field_name, isGreaterThanOrEqualTo: value).snapshots();
  }

  /* 특정 document 삭제 */
  Future<void> delete_doc(String collection_name, String doc_name){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.document(doc_name).delete();
  }

  /* 특정 document에 속해있는 특정 필드만 삭제 */
  Future<void> delete_fieldFromDoc(String collection_name, String doc_name, String field_name){
    var fdb = Firestore.instance.collection(collection_name);
    Map<String, dynamic> data = {
      field_name : FieldValue.delete()
    };
    return fdb.document(doc_name).updateData(data);
  }

}

