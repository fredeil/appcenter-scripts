# 🔨 App Center build scripts for Xamarin 

This repository contains shell scripts used in [App Center](http://appcenter.ms) for building Xamarin.Forms iOS and Android apps. The scripts are non-generic since they are what I actually use day to day. I might make this repository more "example" friendly in the future.

## Environment variables

As well as a list of [pre-defined](https://docs.microsoft.com/en-us/appcenter/build/custom/scripts/#app-center-variables) environment variables, [App Center](http://appcenter.ms) also allows you to declare custom environment variables. All scripts are using some sort of custom environment variable that is declared in the [App Center](http://appcenter.ms) build configuration.

## Project path

Typically, Xamarin.Forms projects are structured like this:

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
So if you want to manipulate your `Info.plist` file you have to call `$APPCENTER_SOURCE_DIRECTORY/MyApp/MyApp.iOS/Info.plist`,
and if you want to manipulate your Android manifest you have to call `$APPCENTER_SOURCE_DIRECTORY/MyApp/MyApp.Droid/Properties/AndroidManifest.xml`.

## App Center Webhooks

I found that there is no documentation on the payload of the "New Release Webhook", so here it is (Android):
```json
{
  "app_name": "my-app-droid",
  "app_display_name": "My App",
  "release_id": "13",
  "platform": "Android",
  "uploaded_at": "2018-04-06T10:39:00Z",
  "fingerprint": "9126224********",
  "release_notes": "<p>Merge pull request #272 from Development</p>\n",
  "version": "69", 
  "short_version": "2.0.0",
  "min_os": "4.1",
  "mandatory_update": true,
  "size": 74478134,
  "provisioning_profile_name": null,
  "provisioning_profile_type": null,
  "bundle_identifier": "com.mycompany.myapp",
  "install_link": "https://install.appcenter.ms/orgs/myorg/apps/my-app-droid/releases/1337?source=email",
  "icon_link": "https://ad45agfg56.cloudfront.net/production/apps/icons/000/693/329/original/myapp.png",
  "distribution_group_id": "66164890-e696-486d-bdb2-1234556678",
  "sent_at": "2018-04-06T10:39:02.8617434Z",
  "app_id": "571410f0-62da-4daf-ab38-1234sg4hn"
}

```
And for for iOS:
```json
{
  "app_name": "my-app-ios",
  "app_display_name": "My App",
  "release_id": "15",
  "platform": "iOS",
  "uploaded_at": "2018-04-06T10:47:42Z",
  "fingerprint": "aa2fbf9ec3d9b2********",
  "release_notes": "<p>Merge pull request #272 from Development</p>\n",
  "version": "69",
  "short_version": "2.0",
  "min_os": "8.0",
  "mandatory_update": true,
  "size": 44171324,
  "provisioning_profile_name": "MyTeamsProvisioningProfile",
  "provisioning_profile_type": "adhoc",
  "bundle_identifier": "com.mycompany.myapp",
  "install_link": "https://install.appcenter.ms/orgs/myorg/apps/my-app-ios/releases/1337?source=email",
  "icon_link": "https://ad45agfg56.cloudfront.net/production/apps/icons/000/693/329/original/myapp.png",
  "distribution_group_id": "73c37275-0f5d-4b74-bacb-1234556678",
  "sent_at": "2018-04-06T10:47:46.1383449Z",
  "app_id": "571410f0-62da-4daf-ab38-1234sg4hn"
}

```

## Contributing

This repository is open-source, help and feedback is always welcome and pull requests are accepted.
