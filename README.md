# Flutter Android Project - README

This README provides instructions for setting up Flutter on your device and running the app through an emulator using Visual Studio Code (VSCode).

## Prerequisites

Before getting started, ensure that you have the following installed on your system:

- Flutter SDK
- Android Studio
- Visual Studio Code (VSCode)

## Setting up Flutter

Follow the steps below to set up Flutter on your device:

1. Download the Flutter SDK from the official Flutter website: [https://flutter.dev](https://flutter.dev).

2. Extract the downloaded archive to a preferred location on your system.

3. Add the Flutter SDK's `bin` directory to your system's `PATH` variable. This step allows you to run Flutter commands from the command line. 

4. Open a terminal and run the following command to verify the installation:
`flutter doctor`. The output of this command should indicate if there are any missing dependencies or if additional steps are required.

5. Install any missing dependencies or complete any additional steps suggested by the `flutter doctor` command output.

## Setting up Android Emulator

To run your Flutter app on an Android emulator, you need to set up an emulator using Android Studio. Follow these steps:

1. Open Android Studio and click on the "Configure" button.

2. Select "AVD Manager" from the dropdown menu.

3. Click on the "Create Virtual Device" button.

4. Follow the instructions to select and download an Android system image for the emulator.

5. Once the system image is downloaded, click on the "Next" button.

6. Configure the emulator settings such as device name, screen size, and orientation.

7. Click on the "Finish" button to create the emulator.

## Running the App using VSCode

To run your Flutter app through an emulator using Visual Studio Code (VSCode), follow the steps below:

1. Open your project in VSCode. (Install the Flutter extension if you haven't done so already)

2. Open the terminal in VSCode by navigating to `View -> Terminal`.

3. In the terminal, navigate to your project's root directory.

4. Run the following command to ensure that all the dependencies are up to date: `flutter pub get`

5. Once the dependencies are updated, run the following command to start the app on the emulator: `flutter run` 

This command will build the app and start it on the emulator you set up earlier. (If the app doesn't run on the emulator, change the Flutter device by bringing up the VSCode Command Pallete, typing `Flutter: Select Device` and choosing the android emulator before running `flutter run`)


6. Wait for the app to build and launch on the emulator.

## Note
This app is still in the development stage and features are yet to be implemented and thoroughly tested. You may encounter some bugs which you can try avoid by re-running  the app. 
