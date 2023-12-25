# Assume we are in the root directory

cd neofetch
rm *.zip
rm -rf neofetch-*

# Fetch and unzip neofetch
wget https://github.com/dylanaraps/neofetch/archive/refs/tags/7.1.0.zip .
unzip 7.1.0.zip
cd neofetch-7.1.0

# Make neofetch
make install DESTDIR="../argon-out"
cd ..
rm -rf argon-out/neofetch
zip neofetch.zip argon-out/*

mv neofetch.zip ../bin-pkgs/
cd ..
