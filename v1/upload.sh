if [ ! -d site ]; then
  mkdir site
fi
if [ ! -d site/globalmaps ]; then
  mkdir site/globalmaps
fi
cp index.html *js site/globalmaps
cd site
rsync -avz --progress --exclude '.DS_Store' * boscoh@boscoh.com:boscoh.com
