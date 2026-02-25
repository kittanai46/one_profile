#!/usr/bin/env bash

flutter gen-l10n &&
flutter clean &&
flutter pub get &&
dart format .
