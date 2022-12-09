import 'package:capstone_alterra_flutter/model/detail_transaction_model.dart';
import 'package:capstone_alterra_flutter/util/membership.dart';
import 'package:capstone_alterra_flutter/util/transaction_type.dart';
import 'package:capstone_alterra_flutter/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionModel{

  TransactionModel({
    required this.id,
    required this.transactionType,
    required this.title,
    required this.quantity,
    required this.price,
    required this.listDetailTransaction,
    required this.dateTime,
    this.subTitle,
    Color? subTitleColor,
  }){

    priceFormatted = Utils.currencyFormat(price);
    this.subTitleColor = (subTitleColor != null) ? subTitleColor : Colors.black;
    totalPrice = price * quantity;
    totalPriceFormatted = Utils.currencyFormat(totalPrice);
  }

  final String id;
  final TransactionType transactionType;
  final String title;
  final int quantity;
  final int price;
  final List<DetailTransactionModel> listDetailTransaction;
  final DateTime dateTime;
  final String? subTitle;
  late final Color subTitleColor;
  late final String priceFormatted;
  late final int totalPrice;
  late final String totalPriceFormatted;


  factory TransactionModel.forMembership({
    required String id,
    required MembershipClass membershipClass,
    required int monthQuantity,
  }){

    String title = 'Membership - ${membershipClass.name} $monthQuantity Bulan';
    DateTime dateTimeNow = DateTime.now();

    return TransactionModel(
      id: id,
      transactionType: TransactionType.membership,
      title: title, 
      quantity: monthQuantity, 
      price: membershipClass.price,
      dateTime: dateTimeNow,
      listDetailTransaction: [
        DetailTransactionModel(
          icon: SvgPicture.asset('assets/transaction_page/event.svg'), 
          title: 'Tanggal Beli', 
          subTitle: Utils.dateTimeFormat(dateTimeNow)
        )
      ]
    );
  }


  factory TransactionModel.forOnlineClass({
    required String id,
    required String title,
    required int price,
  }){
    DateTime dateTimeNow = DateTime.now();

    return TransactionModel(
      id: id,
      transactionType: TransactionType.onlineClass,
      title: title, 
      quantity: 1, 
      price: price,
      dateTime: dateTimeNow,
      listDetailTransaction: [
        DetailTransactionModel(
          icon: SvgPicture.asset('assets/transaction_page/event.svg'), 
          title: 'Tanggal Beli', 
          subTitle: Utils.dateTimeFormat(dateTimeNow)
        ),
        DetailTransactionModel(
          icon: SvgPicture.asset('assets/transaction_page/event.svg'), 
          title: 'Aktif Sampai', 
          subTitle: Utils.dateTimeFormat(dateTimeNow.add(const Duration(days: 5)))
        ),
      ]
    );
  }
}