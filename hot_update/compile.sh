APP_VERSION=$(cat pubspec.yaml | awk ' /(version)(.*)/ {print $2}')

dart_eval compile -o ../evc/v$APP_VERSION.evc

