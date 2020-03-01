{ callPackage
, zlib, bzip2, expat, lzma, libffi, gdbm, sqlite, readline, ncurses, openssl
}:

callPackage ../fixbin {
  name = "wakafix";
  deps = [ zlib bzip2 expat lzma libffi gdbm sqlite readline ncurses openssl ];
}
