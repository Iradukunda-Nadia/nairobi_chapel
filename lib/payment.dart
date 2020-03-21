import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:flutter/cupertino.dart';

typedef void OnError(Exception exception);

const kUrl = "http://www.rxlabz.com/labz/audio2.mp3";
const kUrl2 = "http://www.rxlabz.com/labz/audio.mp3";
enum PlayerState { stopped, playing, paused }

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var autoValidate = false;
  bool acceptCardPayment = true;
  bool acceptAccountPayment = true;
  bool acceptMpesaPayment = false;
  bool shouldDisplayFee = true;
  bool acceptAchPayments = false;
  bool acceptGhMMPayments = false;
  bool acceptUgMMPayments = false;
  bool acceptMMFrancophonePayments = false;
  bool live = true;
  bool preAuthCharge = false;
  bool addSubAccounts = false;
  List<SubAccount> subAccounts = [];
  String email;
  double amount;
  String publicKey = "FLWPUBK-bcf45e1ed295e5423bfb73152a2be2c7-X";
  String encryptionKey = "232d152516fc43c6083cf580";
  String txRef;
  String orderRef;
  String narration;
  String currency;
  String country;
  String firstName;
  String lastName;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: GestureDetector(
            onLongPress: () {},
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.3, 0.5, 0.8],
                      tileMode: TileMode.clamp,
                      colors: [Colors.yellow[300], Colors.yellow, Colors.yellow[700], Colors.yellow[800],])),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  SizedBox(
                    height: 10.0,
                  ),
                  Image.asset(
                    "assets/giving.png",
                    fit: BoxFit.contain,
                    height: 250.0,
                    width: 350.0,
                  ),

                  Column(
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              color: Colors.white,


                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: <Widget>[

                                  buildVendorRefs(),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                    child: Form(
                                      key: formKey,
                                      autovalidate: autoValidate,
                                      child: Column(
                                        children: <Widget>[

                                          SizedBox(height: 20),
                                          TextFormField(

                                            decoration:
                                            InputDecoration(hintText: 'Enter Amount in KSH.'),
                                            onSaved: (value) => amount = double.tryParse(value),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,

                                          ),

                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Button(text: 'Give', onPressed: validateInputs),
                                ],
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget buildVendorRefs() {
    if (!addSubAccounts) {
      return SizedBox();
    }

    addSubAccount() async {
      var subAccount = await showDialog<SubAccount>(
          context: context, builder: (context) => AddVendorWidget());
      if (subAccount != null) {
        if (subAccounts == null) subAccounts = [];
        setState(() => subAccounts.add(subAccount));
      }
    }

    var buttons = <Widget>[
      Button(
        onPressed: addSubAccount,
        text: 'Add vendor',
      ),
      SizedBox(
        width: 10,
        height: 10,
      ),
      Button(
        onPressed: () => onAddAccountsChange(false),
        text: 'Clear',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your current vendor refs are: ${subAccounts.map((a) => '${a.id}(${a.transactionSplitRatio})').join(', ')}',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Platform.isIOS
                ? Column(
              children: buttons,
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttons,
            ),
          )
        ],
      ),
    );
  }

  onAddAccountsChange(bool value) {
    setState(() {
      addSubAccounts = value;
      if (!value) {
        subAccounts.clear();
      }
    });
  }

  void validateInputs() {
    var formState = formKey.currentState;
    if (!formState.validate()) {
      setState(() => autoValidate = true);
      return;
    }

    formState.save();
    startPayment();
  }

  void startPayment() async {
    var initializer = RavePayInitializer(
        amount: amount,
        publicKey: publicKey,
        encryptionKey: encryptionKey,
        subAccounts: subAccounts.isEmpty ? null : null)
      ..country =
      country = "KE"
      ..currency = "KES"
      ..email = "esththernadia70@gmail.com"
      ..fName = "Nairobi"
      ..lName = "Chapel"
      ..narration = ""
      ..txRef = "Offering"
      ..orderRef = "Offering"
      ..acceptMpesaPayments = true
      ..acceptAccountPayments = true
      ..acceptCardPayments = true
      ..acceptAchPayments = false
      ..acceptGHMobileMoneyPayments = false
      ..acceptUgMobileMoneyPayments = false
      ..acceptMobileMoneyFrancophoneAfricaPayments = false
      ..displayEmail = false
      ..displayAmount = false
      ..staging = !live
      ..isPreAuth = false
      ..displayFee = true;

    var response = await RavePayManager()
        .prompt(context: context, initializer: initializer);
    print(response);
    scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(response?.message)));
  }
}

class SwitchWidget extends StatelessWidget {
  final bool value;
  final String title;
  final ValueChanged<bool> onChanged;

  SwitchWidget(
      {@required this.value, @required this.title, @required this.onChanged});

  @override
  Widget build(BuildContext context) => SwitchListTile.adaptive(
    value: value,
    title: Text(title),
    onChanged: onChanged,
  );
}

class AddVendorWidget extends StatefulWidget {
  @override
  _AddVendorWidgetState createState() => _AddVendorWidgetState();
}

class _AddVendorWidgetState extends State<AddVendorWidget> {
  var formKey = GlobalKey<FormState>();
  var refFocusNode = FocusNode();
  var ratioFocusNode = FocusNode();
  bool autoValidate = false;
  String id;
  String ratio;

  @override
  void dispose() {
    refFocusNode.dispose();
    ratioFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        autovalidate: autoValidate,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration:
              InputDecoration(hintText: 'Your Vendor\'s Rave Reference'),
              onSaved: (value) => id = value,
              textCapitalization: TextCapitalization.words,
              focusNode: refFocusNode,
              autofocus: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                refFocusNode.unfocus();
                FocusScope.of(context).requestFocus(ratioFocusNode);
              },
              validator: (value) =>
              value.trim().isEmpty ? 'Field is required' : null,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Ratio for this vendor'),
              onSaved: (value) => ratio = value,
              keyboardType: TextInputType.number,
              focusNode: ratioFocusNode,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                ratioFocusNode.unfocus();
                validateInputs();
              },
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) =>
              value.trim().isEmpty ? 'Field is required' : null,
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('CANCEL')),
        FlatButton(onPressed: validateInputs, child: Text('ADD')),
      ],
    );
  }

  void validateInputs() {
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      Navigator.of(context).pop(SubAccount(id, ratio));
    } else {
      setState(() => autoValidate = true);
    }
  }
}

class Button extends StatelessWidget {
  final String text;
  final Widget childText;
  final VoidCallback onPressed;

  Button({@required this.onPressed, this.text, this.childText})
      : assert(childText != null || text != null);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
      child: childText == null ? Text(text) : childText,
      pressedOpacity: 0.5,
      onPressed: onPressed,
    )
        : RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      highlightColor: Colors.red,
      elevation: 16.0,
      onPressed: onPressed,
      color: Colors.purple[800],
      child: childText == null ? Text(text.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 18,),) : childText,
    );
  }
}