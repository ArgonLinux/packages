# assume we are on neofetch build dir and in neofetch build dir

make install DESTDIR="argon-out"
zip neofetch.zip argon-out/
