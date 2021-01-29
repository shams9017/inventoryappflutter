Flutter Inventory App.

Description:
It is an inventory management app built with Flutter through which users can browse through different items in the inventory along with their attributes.
There are two screens (routes)- a dashboard and a products list.

The app calls a web API for data. The API is published on Azure and there is no database needed.

When the app loads, the user gets notified if there is any low items in stock.

The dashboard shows a bar chart of products and their count, one card view showing total number of items and another card view showing total value 
of inventory.

There is a button on the dashboard called 'See Products' that leads to the products screen. There is a search function the products screen to search for products by name or
their category.

How To Run:

Using Android studio:

1. Open the project (unzip folder called flutter_app) in Android Studio.
2. You will need to create configuration for this. Clicking Run will show the edit config option.
3. Add the necessary configuration setting inclduing locating the Dart SDK (its usually in the /bin/cache of the Flutter SDK folder).
Android Studio might prompt you to locate the Dart SDK.
4. Add main.dart as entrypoint and add the project for the build scripts.
5. Click apply and ok to finalize the config file.
6. After config, select Flutter emulator as virtual device. You can also run this in a virtual device from AVD manager (select API 28).
7. CLick run button or also you can use flutter run command from the terminal. The app should load now.

Using the APK file:

1. Load the APK with a cable to your android phone.
2. You may have to update your security settings to allow installation from other sources.
3. When there are no security issues, go to file manager of your phone and locate the APK.
4. You can install it by clicking it.


Known Issues with the app:

The dashboard data may not show after the app loads. The probable cause is still being determined. 
To fix this issue, click the Hot Reload button on Android Studio (the one on the top left that looks like a lightning bolt).
The dashboard should correctly display data now.
This issue may arise if you install the APK on a real device. 


Running the Web API:

1. Run the solution file (.sln) to open in Visual Studio.
2. You may have to install several packages if needed. Use Nuget package manager. Also, be sure to install the Target Framework extension 
for smooth migration.
3. You can test the web API using Postman. All the methods (GET, POST , PUT and DELETE) work without issues.
4, For automated tests, run the command 'dotnet test' from the terminal in Visual Studio.

Known Issues with testing the Web API:

The web API does not have any major issues. However, when automated tests are run, the test involving updating data may fail.
It gives the error of '405: method not allowed'.
The other tests (GET) run properly.


