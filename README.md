## Overview

IndieVM is a time-saving & minimalistic approach to handling MVVM architecture in Flutter Apps. Useful to Flutter beginners and pros alike, this micro-package "just works".

## Installation

```bash
dart pub add indie_vm
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:get_it/get_it.dart';

class ProfilePageVM implements IndieVM {
    //if using https://pub.dev/packages/get_it or similar service locator package
    final appServices = GetIt.instance<AccountService>();

    //if using https://pub.dev/packages/state_beacon or similar observable reactive state management package
    final accountName = Beacon.writable("unknown"); 

    @override
    void onDispose() {
        //clean up your resources if necessary
        appServices.profilePageDismissed();
    }

    @override
    void onInit(BuildContext context) {
        appServices.profilePageEntered();
        appServices.getAccountNameAsync(
          onNameRetrieved: (String name) {
            accountName.value = name;
          },
        );
    }
}

class ProfilePage extends IndieView<ProfilePageVM> {
    ProfilePage({super.key});

    @override
    Widget builder(
    BuildContext context,
    ProfilePageVM viewModel,
    ) {
       return Container(
            child: Text(viewModel.accountName.watch(context))
        );
    }

    @override
    ProfilePageVM viewModelBuilder(BuildContext context) => ProfilePageVM();
}
```