import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  final String loadingMessage;

  const LoadingData({Key? key, this.loadingMessage = 'Loading....'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              loadingMessage,
              style: TextStyle(
                fontSize: 24.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}