# !/bin/bash

LOCAL_POSTERS_DIR=~/posters

# Get new images...
# If host is down, no sync will happen.
#
# Using ssh keys for authentication
# > ssh-keygen
# > ssh-copy-id -i ~/.ssh/id_rsa.pub <user>@<pictures sersver>
echo '------ rsync -------'
rsync --archive --verbose --delete --exclude archived -e ssh og@frame.local:living-room-frame/pictures/ $LOCAL_POSTERS_DIR

# Update image...
echo '------ update image -------'
# Pick a random image...
image_to_display="$(find $LOCAL_POSTERS_DIR -maxdepth 1 -type f -print0 | shuf -z -n 1 | xargs -0 -r echo)"
echo "Image to display $image_to_display"
/home/og/.virtualenvs/pimoroni/bin/python3 inky/examples/spectra6/image.py --file "$image_to_display"
