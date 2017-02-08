if [ ! -x /usr/local/bin/cmus-remote ];
then
echo "cmus is not installed."
exit
fi

ARTIST=$( cmus-remote -Q 2>/dev/null | grep artist | head -n1 | cut -c 12-100 )
TITLE=$( cmus-remote -Q 2>/dev/null | grep title | cut -d " " -f 3- )

if [ -z "$ARTIST" ];
then
echo "--:--" | tr -d '"'
else
echo "$ARTIST - $TITLE"
fi
