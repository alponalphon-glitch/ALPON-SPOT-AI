#!/usr/bin/env sh
# Convenience launcher. GitHub Actions provisions Gradle 8.9 explicitly.
if command -v gradle >/dev/null 2>&1; then
  exec gradle "$@"
fi
DIST="$HOME/.gradle/alpon-gradle-8.9"
if [ ! -x "$DIST/bin/gradle" ]; then
  mkdir -p "$HOME/.gradle"
  ARCHIVE="$HOME/.gradle/gradle-8.9-bin.zip"
  echo "Downloading Gradle 8.9..."
  curl -fL https://services.gradle.org/distributions/gradle-8.9-bin.zip -o "$ARCHIVE" || exit 1
  mkdir -p "$DIST"
  unzip -q "$ARCHIVE" -d "$HOME/.gradle/alpon-gradle-unpack" || exit 1
  mv "$HOME/.gradle/alpon-gradle-unpack/gradle-8.9" "$DIST"
  rm -rf "$HOME/.gradle/alpon-gradle-unpack" "$ARCHIVE"
fi
exec "$DIST/bin/gradle" "$@"
