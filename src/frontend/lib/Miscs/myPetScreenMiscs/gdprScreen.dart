import 'package:flutter/material.dart';
import 'package:pethelper/SettingSave.dart';
import 'package:pethelper/const.dart';

class gdprScreen extends StatelessWidget {
  const gdprScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorBlindMode(colorblindMode),
      child: Scaffold(
        appBar: AppBar(
          key: const Key("gdprBack"),
          centerTitle: true,
          title: Text(
            'GDPR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.07 * fontSize,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            Container(
              color: (darkMode) ? Colors.black : Colors.white,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: Text(
                """
<GDPR> 
What data do Pet helper application collects?
Types of Data Collected:
•	Personal Data:
While using our application, we ask you to provide us with this personally identifiable information: First name, Last name, Email address
•	Usage Data:
Usage Data may include information such as Your Device's Internet Protocol address, the time and date of your visit, the time spent on those pages and unique device identifiers.
How do we collect your data?
The data we collect is provided directly by you. We collect it when you: Register / sign up, Add a pet 
Take pictures from your device's camera and photo library. You can enable or disable access his information at any time, through your device settings.
How will we use your data?
The Company may use Personal Data for the following purposes:
•	Identify you, such as your name, email address.
•	Manage your account
•	Set the correct timing in the calendar and notification.
•	Marketing - We might use some data for marketing
How do we store your data?
The security of your personal data is important to us, so our application securely stores your data at the application servers and on your device.
Our Company will keep your personal data until you decide to delete your account or 5 years passes on last sign in, the application will give the user 7 days' time limit to recover the account before it deleted completely. Once the time limit finish, we will delete your data from our servers/database.
What is your data protection rights?
Our Company would like to make sure you are fully aware of all your data protection rights. Every user is entitled to the following:
You have the right to be informed about how your data is being used, access your personal data, request incorrect personal data to be updated, have your personal data erased, request that the data that have been collect to another company, or directly to be transferred, estrict processing of your personal data (under some conditions)
What are cookies? 
Cookies store information such as login IDs, browsing history and number of visits, but as they are text files, their file size is small, and they rarely overwhelm the available space on your computer or phone. To provide appropriate information to users of this application, we use cookies to collect information on page visits. Based on the data collected, we may be able to serve content in the application. We might also use cookies for other purposes. 
How do we use cookies? 
・Keeping you signed in
・Understanding how you use our application 
・Improving our services
What types of cookies do we use? 
This application uses cookies for the following purposes 
•	Improvement - We use cookies for the purpose of studying the number of users and traffic of the Application to improve our products and services and develop new ones.
•	Functionality - If you exit and return to the app, you will not have to enter your login details again as cookies are used to keep track of your login details. For example, you do not have to re-set your language preferences or disability each time.
•	 Security - We also use cookies to obtain information such as your IP address to prevent unauthorised access. 
We use cookies in combination with your personal information for the purpose of improving our products and services. In such cases, cookie information associated with customer information will be handled in accordance with the Company's "Handling of Personal Information". 
How to manage cookies 
You can choose to allow all cookies or reject all cookies. This can be done from the settings page, see the 'Help' menu for more information on how to set cookies. You can also disable cookies through your browser settings, but please note that this application may require you to set your browser to accept cookies (first-party cookies) to manage the transfer of information between transaction screens and to confirm that you are the same person. You can also disable the collection of browsing information by disabling cookies (third party) and JavaScript on your smartphone, but please note that some functions of this website will not work in this case.
Privacy policies of other websites
Our app might contain links to other websites and apps Our privacy policy is only applicable to our app, for any other website you should follow their privacy policy 
Changes to our privacy policy
Our privacy policy is kept under regular review and any update will be applied on the app. Was last updated on 17 Mar 2022
How to contact us
If you have any questions about this Privacy Policy, you can contact us:
By email: pethelper_team60@outlook.com
Or call us at: 0121 414 3744
""",
                style: TextStyle(
                    fontSize: 15 * fontSize,
                    color: (darkMode) ? Colors.white : Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
