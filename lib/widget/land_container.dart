import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';

Widget landWid(isverified, area, address, price, isForSell, makeforSellFun) =>
    Container(
      padding: EdgeInsets.all(15),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            color: Colors.lightGreenAccent,
            child: Text('Land Image'),
          ),
          // Image(
          //
          //   image: NetworkImage(
          //       'http://www.kerloguenursinghome.com/wp-content/uploads/2019/12/19038526ce9f8be4a8dba148da99ff77.jpg'),
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            isverified ? 'Verified' : 'Not Yet Verified',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            area + ' Sq.Ft',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            address,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Price:' + price,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isForSell
                  ? MaterialButton(
                      color: Colors.redAccent,
                      onPressed: null,
                      child: Text('On Sell'),
                    )
                  : MaterialButton(
                      color: Colors.redAccent,
                      onPressed: isverified ? makeforSellFun : null,
                      child: Text('Make it for Sell'),
                    ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {},
                child: Text('View Details'),
              )
            ],
          )
        ],
      ),
    );
Widget landWid2(isverified, area, address, price, isMyLand, isForSell,
        sendRequestFun) =>
    Container(
      padding: EdgeInsets.all(15),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            color: Colors.lightGreenAccent,
            child: Text('Land Image'),
          ),
          // Image(
          //
          //   image: NetworkImage(
          //       'http://www.kerloguenursinghome.com/wp-content/uploads/2019/12/19038526ce9f8be4a8dba148da99ff77.jpg'),
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            isverified ? 'Verified' : 'Not Yet Verified',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            area + ' Sq.Ft',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            address,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Price:' + price,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isMyLand
                  ? MaterialButton(
                      color: Colors.redAccent,
                      onPressed: null,
                      child: Text('Send Request To Buy'),
                    )
                  : MaterialButton(
                      color: Colors.redAccent,
                      onPressed: isForSell ? sendRequestFun : null,
                      child: Text('Send Request To Buy'),
                    ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {},
                child: Text('View Details'),
              )
            ],
          )
        ],
      ),
    );
