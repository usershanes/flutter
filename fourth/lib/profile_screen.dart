
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildProfileImage( context ),
          _buildProfileDetails( context ),
          _buildActions( context ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: ClipOval(
        child: Image.asset(
          'assets/dog.jpg',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Wolfram Barkovch',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600 ),
            ),
            _buildDetailsRow( 'Age', '4' ),
            _buildDetailsRow( 'Status', 'Good Boy' ),
          ],
        ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIcon( Icons.restaurant, 'Feed' ),
        _buildIcon( Icons.favorite, 'Pet' ),
        _buildIcon( Icons.directions_walk, 'Walk'),
      ],
    );
  }

  Widget _buildDetailsRow(String s, String t) {
    return Row(
      children: <Widget>[
        Text(
          '$s:',
          style: TextStyle(fontWeight: FontWeight.bold ),
        ),
        Text(t),
      ],
    );
  }

  Widget _buildIcon(IconData icon, String s) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Icon( icon, size: 40 ),
            Text( s )
          ],
        ),
      );
  }

}
