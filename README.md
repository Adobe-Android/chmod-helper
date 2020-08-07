# chmod-helper
:shell: More than just a cheat sheet - An interactive helper for [chmod(1)](https://www.freebsd.org/cgi/man.cgi?chmod(1)).

Written in [shellcheck](https://www.shellcheck.net) compliant POSIX sh.

## OS support
* :penguin: Linux
* :smiling_imp: FreeBSD
* :dragon: DragonFly BSD
* :blowfish: OpenBSD
* :triangular_flag_on_post: NetBSD
* :sunny: Solaris/illumos
* :wine_glass: Windows via WSL (Windows subsystem for Linux)
* :apple: macOS

## How to - Download and run (without installation)

via wget
```sh
wget https://raw.githubusercontent.com/Adobe-Android/chmod-helper/master/ch
chmod +x ch
./ch
```

via curl
```sh
curl -O https://raw.githubusercontent.com/Adobe-Android/chmod-helper/master/ch
chmod +x ch
./ch
```

via git
```sh
git clone https://github.com/Adobe-Android/chmod-helper.git
cd chmod-helper
chmod +x ch
./ch
```

## How to - Download, install, and run

via wget
```sh
wget https://raw.githubusercontent.com/Adobe-Android/chmod-helper/master/ch
wget https://raw.githubusercontent.com/Adobe-Android/chmod-helper/master/Makefile
make install
ch
```

via curl
```sh
curl -O https://raw.githubusercontent.com/Adobe-Android/chmod-helper/master/ch
curl -O https://raw.githubusercontent.com/Adobe-Android/chmod-helper/master/Makefile
make install
ch
```

via git
```sh
git clone https://github.com/Adobe-Android/chmod-helper.git
cd chmod-helper
make install
ch
```

:heavy_exclamation_mark: Potential errors:
```sh
install: cannot create regular file '/usr/local/bin/ch': Permission denied
make: *** [Makefile:7: install] Error 1
```

:heavy_check_mark: Solution:
```sh
sudo make install
```

## Author

**David Brown** - [Adobe-Android](https://github.com/Adobe-Android)

## License

[MIT](https://choosealicense.com/licenses/mit/)
