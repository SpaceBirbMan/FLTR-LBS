## Lab1 - Getting started with flutter on Windows

### Author: Sosnov K.A.

#### 1. Coding environment
First things first, you need to download Visual Studio Code that way as you comfortable (official site, microsoft store, from someone who have installer, etc.)

You can just install Android Studio, but it heavier than VSC.

So, if you choosed VSC, you need to install Flutter extension, it install all, that it needed by itself.

#### 2. Necessary additions and possible troubles
Second, you need to install git (not github or something looks kinda similar, exactly git, that wokrs in shell), and Command Line Tools, or you get somthing like that:

```powershell
> flutter doctor
[√] Flutter (Channel stable, 3.29.0, on Microsoft Windows [Version 10.0.26100.3194], locale ru-RU)
[√] Windows Version (Њ ©Єа®б®дв Windows 11 Pro 64-а §ап¤­ п, 24H2, 2009)
[X] Android toolchain - develop for Android devices
    X Unable to locate Android SDK.
      Install Android Studio from: https://developer.android.com/studio/index.html
      On first launch it will assist you in installing the Android SDK components.
      (or visit https://flutter.dev/to/windows-android-setup for detailed instructions).
      If the Android SDK has been installed to a custom location, please use
      `flutter config --android-sdk` to update to that location.

[X] Chrome - develop for the web (Cannot find Chrome executable at .\Google\Chrome\Application\chrome.exe)
    ! Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.
[√] Visual Studio - develop Windows apps (Visual Studio Community 2022 17.13.0)
[!] Android Studio (not installed)
[√] IntelliJ IDEA Community Edition (version 2024.3)
[√] VS Code (version 1.97.2)
[√] VS Code (version 1.98.0-insider)
[√] Connected device (2 available)
[√] Network resources
```


**Git** need you for saving your work on github or local, **Command line tools - for installation AndroidSDK, it is NOT ASDK!**

##### [cmdline-tools](https://developer.android.com/studio?hl=ru#command-tools)
##### [git](https://git-scm.com/downloads/win)

#### 2.1 ASDK
After downloading cmdline you need to unpack .zip something like that:
```powershell
...\Android\Sdk\cmdline-tools\latest\*zip contents*
```
Don't matter, how you unzip archive, but it need to looks like that.
Then you need to open powershell, or whatever you have in:
```powershell
\Android\Sdk\cmdline-tools\latest\bin
```
and type this:
```powershell
.\sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
```
If it give you error like this:
```Warning: Errors during XML parse:
Warning: Additionally, the fallback loader failed to parse the XML.
Warning: Failed to find package```
```
It means you have wrong ierarchy of folders in Android folder.

If you did this right, manager ask you to accept some licenses and that all. After installation you can type **flutter doctor** again and if needed **flutter doctor --android-licenses**

#### 3 Unnecessary installations
In a nutshell, install in this order:

##### [.Net 8.0](https://dotnet.microsoft.com/ru-ru/download/dotnet/8.0)
##### [kdiff3](https://kdiff3.sourceforge.net/)
##### [gitExtensions](https://gitextensions.github.io/)

It's just useful for working with git.

#### 4. Let's get this party started!
In vscode you click on upper center line - **it's command pallete** or press **F1**, start typing "Flutter: New Project", choose whatever you need next
Enjoy!

