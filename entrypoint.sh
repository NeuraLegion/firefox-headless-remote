#!/bin/sh

if [ "$(ls -A /home/firefox/.fonts/)" ]; then
  fc-cache -f -v
fi

echo "user_pref(\"marionette.port\", $MARIONETTE_PORT);"
echo "user_pref(\"marionette.port\", $MARIONETTE_PORT);" >> /home/firefox/profile/prefs.js
echo "user_pref(\"privacy.clearsitedata.cache.enabled\", true);" >> /home/firefox/profile/prefs.js

ip=$(hostname --ip-address)

socat tcp-listen:$MARIONETTE_PORT,bind="$ip",fork tcp:127.0.0.1:$MARIONETTE_PORT &

# Load eye confing and run marionette
eye l /home/firefox/firefox.eye
sleep infinity
