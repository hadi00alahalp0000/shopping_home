import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopping_home/models/my_profile.dart';
import '../../../components/profile_pic.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProfileDetailsForm extends StatefulWidget {
  final MyProfile account;
  const ProfileDetailsForm({Key? key, required this.account}) : super(key: key);

  @override
  ProfileDetailsFormState createState() => ProfileDetailsFormState();
}

class ProfileDetailsFormState extends State<ProfileDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileImage(
            st: false,
            id: widget.account.user[0].id!,
            imgUrl: widget.account.user[0].profileImgUrl,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          ProfileDetailsMenu(
              title: "First Name",
              icon: "assets/icons/User.svg",
              color: kPrimaryColor,
              text: widget.account.user[0].firstname),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Last Name",
              icon: "assets/icons/User Icon.svg",
              color: kPrimaryColor,
              text: widget.account.user[0].lastname),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Phone Number",
              icon: "assets/icons/Phone.svg",
              color: kPrimaryColor,
              text: widget.account.contactInformations[0].phoneNumber),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
            title: "BirthDate",
            icon: "assets/icons/icons8-calendar-50.svg",
            color: kPrimaryColor,
            text: DateFormat('yyyy/MM/dd')
                .format(widget.account.user[0].birthdate),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Governorate",
              icon: "assets/icons/Location point.svg",
              color: kPrimaryColor,
              text: widget.account.address[0].governorate),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Region",
              icon: "assets/icons/Location point.svg",
              color: kPrimaryColor,
              text: widget.account.address[0].region),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Street",
              icon: "assets/icons/Location point.svg",
              color: kPrimaryColor,
              text: widget.account.address[0].street),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Contact Email",
              icon: "assets/icons/Mail.svg",
              color: kPrimaryColor,
              text: widget.account.contactInformations[0].contactEmail),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Facebook URL",
              icon: "assets/icons/facebook-2.svg",
              text: widget.account.contactInformations[0].facebookUrl),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Telegram URL",
              icon: "assets/icons/telegram-svgrepo-com.svg",
              text: widget.account.contactInformations[0].telegramUrl),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "WhatsApp Phone Number",
              icon: "assets/icons/whatsapp-svgrepo-com.svg",
              text: widget.account.contactInformations[0].whatsapp),
          SizedBox(height: getProportionateScreenHeight(15)),
          ProfileDetailsMenu(
              title: "Skype Phone Number",
              icon: "assets/icons/skype-svgrepo-com.svg",
              text: widget.account.contactInformations[0].skype),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileDetailsMenu extends StatelessWidget {
  ProfileDetailsMenu({
    Key? key,
    required this.title,
    required this.icon,
    this.text,
    this.color,
  }) : super(key: key);
  final String title;
  final String icon;
  String? text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 231, 236, 253),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.tr),
              SizedBox(height: getProportionateScreenHeight(10)),
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    fit: BoxFit.fill,
                    color: color,
                    width: getProportionateScreenWidth(30),
                    height: getProportionateScreenHeight(30),
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Text(nullcheckstring(text)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String nullcheckstring(String? s) {
    if (s == null) {
      return " ";
    } else {
      return s;
    }
  }
}
