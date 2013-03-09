cd www
coffee -c app.coffee
stylus -c < app.styl > app.css
zip ../desktop/app.nw *
cp * ../mobile/ios/www/
cp * ../mobile/android/assets/www/
cd ..
cp desktop/app.nw desktop/mac/Todado.app/Contents/Resources/
cat desktop/win/nw.exe desktop/app.nw > desktop/win/todado.exe

