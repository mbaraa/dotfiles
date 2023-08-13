#Lock Script By Luke Smith

#Remove Existing pics:
rm /tmp/screen*

# Take a screenshot:
scrot /tmp/screen.png

# Create a blur on the shot:
convert /tmp/screen.png -paint 1 -swirl 360 /tmp/screen.png

# Add the lock to the blurred image:
[[ -f ~/.config/i3/lock.png ]] && convert /tmp/screen.png  ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png

# Lock it up!
i3lock -e -f -c 000000 -i /tmp/screen.png

