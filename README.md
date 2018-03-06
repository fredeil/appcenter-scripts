# 🔨 App Center build scripts for Xamarin 🔨

This repository contains shell scripts used in [App Center](http://appcenter.ms) for building Xamarin.Forms iOS and Android apps. The scripts are non-generic since they are what I actually use day to day. I might make this repository more "example" friendly in the future.

## Environment variables

As well as a list of [pre-defined](https://docs.microsoft.com/en-us/appcenter/build/custom/scripts/#app-center-variables) environment variables, [App Center](http://appcenter.ms) also allows you to declare custom environment variables. All scripts are using some sort of custom environment variable that is declared in the [App Center](http://appcenter.ms) build configuration.

## Project path

Typically, Xamarin.Forms project structure are structured like this:

* 📁MyApp
  * MyApp.sln
  * 📁MyApp
    * 📁MyApp
    * 📁MyApp.iOS
    * 📁MyApp.Droid
    * 📁MyApp.UWP

After [App Center](http://appcenter.ms) has cloned your repository upon a build request, the folder structure becomes:

* 📁MyAppsRepoName
  * 📁MyApp
    * MyApp.sln
    * 📁MyApp
      * 📁MyApp
      * 📁MyApp.iOS
      * 📁MyApp.Droid
      * 📁MyApp.UWP

Which means when using `$APPCENTER_SOURCE_DIRECTORY`, you will be at the `MyAppsRepoName` level of your repository.
So if you want to manipulate your `Info.plist` file you have to call `$APPCENTER_SOURCE_DIRECTORY/MyApp/MyApp/MyApp.iOS/Info.plist`,
and if you want to manipulate your Android manifest you have to call `$APPCENTER_SOURCE_DIRECTORY/MyApp/MyApp/MyApp.Droid/Properties/AndroidManifest.xml`.

## Contributing

This repository is open-source, help and feedback is always welcome and pull requests are accepted.