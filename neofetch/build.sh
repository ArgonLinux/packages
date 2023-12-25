# Assume we are in the root directory

cd neofetch
rm *.zip
rm -rf neofetch-*


# Fetch and unzip neofetch
wget https://github.com/dylanaraps/neofetch/archive/refs/tags/7.1.0.zip

zip_hash=$(../hacky_sha 7.1.0.zip)
echo $ARGON_ZIP_SHA
echo $zip_hash

if [[ $zip_hash = $ARGON_ZIP_SHA ]]
then
	echo "Checksums match. Continuing build."
	unzip 7.1.0.zip
	cd neofetch-7.1.0

	# Make neofetch
	make install DESTDIR="../argon-out"
	cd ..
	rm -rf argon-out/neofetch
	zip neofetch.zip argon-out/*

	mv neofetch.zip ../bin-pkgs/
	cd ..
else
	echo "Checksums DON'T match!"
fi


